require File.join(File.dirname(__FILE__), "./", "IoNumber")

class RIO
	attr_reader :ioself
	attr_reader :scope
	attr_reader :state

	include IoNumber

	def initialize
		@ioself = Io.IoState_new
		@state = Io::IoState.new(@ioself)
		@scope = {}
	end

	def run (str="")
		if block_given?
			yield(self)
		else
			Io.IoState_doCString_(@ioself, str)
		end
	end

	def []= (l, r) 
		if r.class == String
			symbol = Io.IoState_symbolWithCString_(@ioself, l)
			Io.IoState_addSymbol_(@ioself, symbol)
			string = Io.IoSeq_newWithCString_(@ioself, r)
			Io.IoObject_setSlot_to_(@state[:lobby], symbol, string)
			@scope[l] = symbol
		elsif r.class == Integer

		elsif r.class == Proc

		end
	end

	def [] (l) 
		if !@scope[l].nil?
			Io.IoObject_getSlot_(@state[:lobby], @scope[l]) 
		else # TODO: Checking..
			symbol = Io.IoState_symbolWithCString_(@ioself, l)
			Io.IoSeq_asCString(Io.IoObject_getSlot_(@state[:lobby], symbol))
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
end