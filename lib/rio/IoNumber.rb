module IoNumber
	def ISNUMBER(isnum)
		Io_.IoObject_hasCloneFunc_(isnum, Io_.IoNumber_rawClone)
	end
	def IONUMBER(num)
		Io_.IoState_numberWithDouble_(@ioself, num)
	end
	def CNUMBER(isnum)
		Io_.IoObject_dataDouble(isnum)
	end
end