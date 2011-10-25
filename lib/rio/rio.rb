class RIO
	attr_reader :ioself
	attr_reader :scope
	attr_reader :state

	def initialize
		@ioself = Io.IoState_new
		@state = Io::IoState.new(@ioself)
		@scope = {}
	end

	def run (str = "")
		if block_given?
			yield(self)
		else
			result = Io.IoState_doCString_(@ioself, str)
			io_to_ruby(result)
		end
	end

	def []= (l, r) 
		if r.class == String
			symbol = Io.IoState_symbolWithCString_(@ioself, l)
			Io.IoState_addSymbol_(@ioself, symbol)
			string = Io.IoSeq_newWithCString_(@ioself, r)
			Io.IoObject_setSlot_to_(@state[:lobby], symbol, string)
			@scope[l] = symbol
		elsif r.class == Fixnum
			symbol = Io.IoState_symbolWithCString_(@ioself, l)
			Io.IoState_addSymbol_(@ioself, symbol)
			string = Io.IoNumber_newWithDouble_(@ioself, r)
			Io.IoObject_setSlot_to_(@state[:lobby], symbol, string)
			@scope[l] = symbol
		elsif r.class == Proc
			
		else
			raise NotImplementedError, "Coercion to Io for #{r.class} is currently unsupported"
		end
	end

	def [] (l) 
		if !@scope[l].nil?
			io_to_ruby(Io.IoObject_getSlot_(@state[:lobby], @scope[l])) 
		else # TODO: Checking..
			symbol = Io.IoState_symbolWithCString_(@ioself, l)
			io_to_ruby(Io.IoObject_getSlot_(@state[:lobby], symbol))
		end 
	end

	def free
		Io.IoState_free @ioself
	end

	def self.eval
		io = RIO.new
		yield(io)
		io.free
	end

	private
	def ruby_to_io(object)

	end

	def io_to_ruby(object)
		if (Io.IOOBJECT_ISTYPE(object, "Number") != 0)
			Io.IoNumber_asInt(object)
		elsif (Io.IOOBJECT_ISTYPE(object, "Seq") != 0)
			Io.IoSeq_asCString(object)
		else
			raise TypeError, "Unknown value returned, cowardly refusing to continue when evaluating: '#{str}'"
			object
		end
	end
end