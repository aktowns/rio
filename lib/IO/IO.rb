require 'ffi'

module Io
	extend FFI::Library
	ffi_lib 'iovmall'

	typedef :pointer, :IoObject
	typedef :pointer, :IoSymbol
	typedef :pointer, :IoMessage
	typedef :pointer, :IoNumber
	typedef :pointer, :IoMethodFunc
	typedef :pointer, :IoMethodTable
	typedef :pointer, :IoSeq

	class IoState < FFI::Struct
		layout	:randomGen, 					:pointer,
				:primitives, 					:pointer,
				:symbols, 						:pointer,
				:objectProto, 					:pointer,
				:mainCoroutine, 				:pointer,
				:currentCoroutine,				:pointer,
				:currentIoStack, 				:pointer,
				:activateSymbol, 				:pointer,
				:callSymbol, 					:pointer,
				:forwardSymbol,					:pointer,
				:noShufflingSymbol, 			:pointer,
				:opShuffleSymbol,   			:pointer,
				:semicolonSymbol,				:pointer,
				:selfSymbol,					:pointer,
				:setSlotSymbol, 				:pointer,
				:setSlotWithTypeSymbol, 		:pointer,
				:stackSizeSymbol,				:pointer,
				:typeSymbol,					:pointer,
				:updateSlotSymbol,				:pointer,
				:setSlotBlock,					:pointer,
				:localsUpdateSlotCFunc, 		:pointer,
				:localsProto,					:pointer,
				:asStringMessage,				:pointer,
				:collectedLinkMessage,			:pointer,
				:compareMessage, 				:pointer,
				:initMessage,					:pointer,
				:mainMessage,					:pointer,
				:nilMessage,					:pointer,
				:opShuffleMessage,				:pointer,
				:printMessage,					:pointer,
				:referenceIdForObjectMessage,	:pointer,
				:objectForReferenceIdMessage,	:pointer,
				:runMessage,					:pointer,
				:willFreeMessage, 				:pointer,
				:yieldMessage,					:pointer,
				:didFinishMessage,				:pointer,
				:cachedNumbers,					:pointer,
				:ioNil,							:pointer,
				:ioTrue, 						:pointer,
				:ioFalse,						:pointer,
				:ioNormal,						:pointer,
				:ioBreak,						:pointer,
				:ioContinue,					:pointer,
				:ioReturn,						:pointer,
				:ioEol,							:pointer,
				:collector,						:pointer,
				:lobby,							:pointer,
				:core,							:pointer,
				:recycledObjects,				:pointer,
				:maxRecycledObjects,			:size_t,
				:mainArgs,						:pointer,
				:stopStatus,					:int,
				:returnValue,					:pointer,
				:callbackContext,				:pointer,
				:bindingsInitCallback,			:pointer,
				:printCallback,					:pointer,
				:exceptionCallback,				:pointer,
				:exitCallback,					:pointer,
				:activeCoroCallback,			:pointer,
				:debugOn,						:int,
				:debugger,						:pointer,
				:vmWillSendMessage,				:pointer,
				:messageCountLimit,				:int,
				:messageCount,					:int,
				:timeLimit,						:double,
				:endTime,						:double,
				:shouldExit,					:int,
				:exitResult,					:int,
				:receivedSignal,				:int,
				:showAllMessages,				:int
	end

	# IoObject
	attach_function :IoObject_proto, [ :pointer ], :IoObject 							# IoObject_proto(void *state) 
	attach_function :IoObject_protoFinish, [ :pointer ], :IoObject 						# IoObject_protoFinish(void *state)
	attach_function :IoObject_localsProto, [ :pointer ], :IoObject 						# IoObject_localsProto(void *state)
	attach_function :IOCLONE, [ :IoObject ], :IoObject 									# IOCLONE(IoObject *self)
	attach_function :IoObject_rawClone, [ :IoObject ], :IoObject 						# IoObject_rawClone(IoObject *self)
	attach_function :IoObject_justClone, [ :IoObject ], :IoObject 						# IoObject_justClone(IoObject *self)
	attach_function :IoObject_rawClonePrimitive, [ :IoObject ], :IoObject 				# IoObject_rawClonePrimitive(IoObject *self)
	attach_function :IoObject_new, [ :pointer ], :IoObject 								# IoObject_new(void *state)
	attach_function :IoObject_addMethod_, [ :IoObject, :IoSymbol, :IoMethodFunc ], :IoObject 		# IoObject_addMethod_(IoObject *self, IoSymbol *slotName, IoMethodFunc *fp)
	attach_function :IoObject_addMethodTable_, [ :IoObject, :IoMethodTable ], :void 	# IoObject_addMethodTable_(IoObject *self, IoMethodTable *methodTable)
	attach_function :IoObject_addTaglessMethod_, [ :IoObject, :IoSymbol, :IoMethodFunc ], :IoObject # IoObject_addTaglessMethod_(IoObject *self, IoSymbol *slotName, IoMethodFunc *fp)
	attach_function :IoObject_addTaglessMethodTable_, [ :IoObject, :IoMethodTable ], :void			# IoObject_addTaglessMethodTable_(IoObject *self, IoMethodTable *methodTable)
	attach_function :IoObject_dealloc, [ :IoObject ], :void								# IoObject_dealloc(IoObject *self)
	attach_function :IoObject_willFree, [ :IoObject ], :void							# IoObject_willFree(IoObject *self)			
	attach_function	:IoObject_free, [ :IoObject ], :void								# IoObject_free(IoObject *self)
	attach_function :IoObject_hasProtos, [ :IoObject ], :int 							# IoObject_hasProtos(IoObject *self)
	attach_function :IoObject_rawProtosCount, [ :IoObject ], :int 						# IoObject_rawProtosCount(IoObject *self)
	attach_function :IoObject_rawAppendProto_, [ :IoObject, :IoObject ], :void 			# IoObject_rawAppendProto_(IoObject *self, IoObject *p)
	attach_function :IoObject_rawPrependProto_, [ :IoObject, :IoObject ], :void			# IoObject_rawPrependProto_(IoObject *self, IoObject *p)
	attach_function	:IoObject_rawRemoveProto_, [ :IoObject, :IoObject ], :void			# IoObject_rawRemoveProto_(IoObject *self, IoObject *p)
	attach_function :IoObject_rawSetProto_, [ :IoObject, :IoObject ], :void				# IoObject_rawSetProto_(IoObject *self, IoObject *proto)
	attach_function :IoObject_rawHasProto_, [ :IoObject, :IoObject ], :uint 			# IoObject_rawHasProto_(IoObject *self, IoObject *p)
	attach_function :IoObject_createSlots, [ :IoObject ], :void 						# IoObject_createSlots(IoObject *self)
	attach_function :IoObject_setSlot_to_, [ :IoObject, :IoSymbol, :IoObject], :void	# IoObject_setSlot_to_(IoObject *self, IoSymbol *slotName, IoObject *value)
	attach_function :IoObject_getSlot_, [ :IoObject, :IoSymbol ], :IoObject 			# IoObject_getSlot_(IoObject *self, IoSymbol *slotName)
	attach_function :IoObject_symbolGetSlot_, [ :IoObject, :IoSymbol ], :IoObject 		# IoObject_symbolGetSlot_(IoObject *self, IoSymbol *slotName)
	attach_function :IoObject_seqGetSlot_, [ :IoObject, :IoSymbol ], :IoObject 			# IoObject_seqGetSlot_(IoObject *self, IoSymbol *slotName)
	attach_function :IoObject_doubleGetSlot_, [ :IoObject, :IoSymbol ], :double 		# IoObject_doubleGetSlot_(IoObject *self, IoSymbol *slotName)
	attach_function :IoObject_removeSlot_, [ :IoObject, :IoSymbol ], :void 				# IoObject_removeSlot_(IoObject *self, IoSymbol *slotName)
	attach_function :IoObject_compare, [ :IoObject, :IoObject ], :int 					# IoObject_compare(IoObject *self, IoObject *v)
	attach_function :IoObject_defaultCompare, [ :IoObject, :IoObject ], :int 			# IoObject_defaultCompare(IoObject *self, IoObject *v)
	attach_function :IoObject_name, [ :IoObject ], :string 								# IoObject_name(IoObject *self)
	attach_function :IoObject_print, [ :IoObject ], :void 								# IoObject_print(IoObject *self)
	attach_function :IoObject_memorySize, [ :IoObject ], :size_t 						# IoObject_memorySize(IoObject *self)
	attach_function :IoObject_compact, [ :IoObject ], :void 							# IoObject_compact(IoObject *self)
	attach_function :IoObject_markColorName, [ :IoObject ], :string 					# IoObject_markColorName(IoObject *self)
	attach_function :IoObject_show, [ :IoObject ], :void 								# IoObject_show(IoObject *self)
	attach_function :IoObject_initClone_, [ :IoObject, :IoObject, :IoMessage, :IoObject ], :IoObject 	# IoObject_initClone_(IoObject *self, IoObject *locals, IoMessage *m, IoObject *newObject)
	attach_function :IoObject_rawCheckMemory, [ :IoObject ], :int 						# IoObject_rawCheckMemory(IoObject *self)
	attach_function :IoObject_defaultPrint, [ :IoObject ], :void 						# IoObject_defaultPrint(IoObject *self)
	attach_function :IoObject_sortCompare, [ :IoObject, :IoObject ], :int 				# IoObject_sortCompare(IoObject **self, IoObject **v)
	attach_function :IoObject_rawDoString_label_, [ :IoObject, :IoSymbol, :IoSymbol ], :IoObject 	# IoObject_rawDoString_label_(IoObject *self, IoSymbol *string, IoSymbol *label)
	# attach_function :IoObject_rawDoMessage, [ :IoObject, :IoMessage ], :IoObject 		# IoObject_rawDoMessage(IoObject *self, IoMessage *m)
	# attach_function :IoObject_eval, [ :IoObject, :IoMessage, :IoObject ], :IoObject 	# IoObject_eval(IoObject *self, IoMessage *m, IoObject *locals)
	attach_function :IoObject_rawGetUArraySlot, [ :IoObject, :IoObject, :IoMessage, :IoSymbol ], :pointer 	# IoObject_rawGetUArraySlot(IoObject *self, IoObject *locals, IoMessage *m, IoSymbol *slotName)
	attach_function :IoObject_rawGetMutableUArraySlot, [ :IoObject, :IoObject, :IoMessage, :IoSymbol ], :pointer	# IoObject_rawGetMutableUArraySlot(IoObject *self, IoObject *locals, IoMessage *m,IoSymbol *slotName)
	attach_function :IoObject_addListener_, [ :IoObject, :pointer ], :void 				# IoObject_addListener_(IoObject *self, void *listener)
	attach_function :IoObject_removeListener_, [ :IoObject, :pointer ], :void 			# IoObject_removeListener_(IoObject *self, void *listener)
	attach_function :IoObject_protoClean, [ :IoObject ], :void 							# IoObject_protoClean(IoObject *self)
	attach_function :IoObject_hasDirtySlot_, [ :IoObject, :IoMessage, :IoObject ], :IoObject 	# IoObject_hasDirtySlot_(IoObject *self, IoMessage *m, IoObject *locals)
	attach_function :IoObject_asString_, [ :IoObject, :IoMessage ], :IoSeq 				# IoObject_asString_(IoObject *self, IoMessage *m)

	# IoNumber
	attach_function :IoNumber_proto, [ :pointer ], :IoNumber 							# IoNumber_proto(void *state)
	attach_function :IoNumber_rawClone, [ :IoNumber ], :IoNumber						# IoNumber_rawClone(IoNumber *self)
	attach_function :IoNumber_newWithDouble_, [ :pointer, :double ], :IoNumber			# IoNumber_newWithDouble_(void *state, double n)
	attach_function :IoNumber_newCopyOf_, [ :IoNumber ], :IoNumber 						# IoNumber_newCopyOf_(IoNumber *number)
	attach_function	:IoNumber_copyFrom_, [ :IoNumber, :IoNumber ], :void				# IoNumber_copyFrom_(IoNumber *self, IoNumber *number)
	attach_function :IoNumber_free, [ :IoNumber ], :void								# IoNumber_free(IoNumber *self)
	attach_function :IoNumber_asStackUArray, [ :IoNumber ], :pointer					# UArray IoNumber_asStackUArray(IoNumber *self)
	attach_function :IoNumber_asInt, [ :IoNumber ], :int 								# IoNumber_asInt(IoNumber *self)
	attach_function :IoNumber_asLong, [ :IoNumber ], :long 								# IoNumber_asLong(IoNumber *self)
	attach_function :IoNumber_asDouble, [ :IoNumber ], :double 							# IoNumber_asDouble(IoNumber *self)
	attach_function :IoNumber_asFloat, [ :IoNumber ], :float 							# IoNumber_asFloat(IoNumber *self)
	attach_function :IoNumber_compare, [ :IoNumber, :IoNumber ], :int 					# IoNumber_compare(IoNumber *self, IoNumber *v)
	attach_function :IoNumber_print, [ :IoNumber ], :void								# IoNumber_print(IoNumber *self)

	# IoSeq
	attach_function :ISMUTABLESEQ, [ :IoObject], :int 									# ISMUTABLESEQ(IoObject *self)
	# attach_function :ioSeqCompareFunc, [ :pointer, :pointer ], :int 					# ioSeqCompareFunc(void *s1, void *s2)
	attach_function :ioSymbolFindFunc, [ :pointer, :pointer ], :int 					# ioSymbolFindFunc(void *s, void *ioSymbol)
	attach_function :IoObject_isStringOrBuffer, [ :IoObject ], :int 					# IoObject_isStringOrBuffer(IoObject *self)
	attach_function :IoObject_isNotStringOrBuffer, [ :IoObject ], :int 					# IoObject_isNotStringOrBuffer(IoObject *self)
	attach_function :IoSeq_proto, [ :pointer ], :IoSeq 									# IoSeq_proto(void *state)
	attach_function :IoSeq_protoFinish, [ :IoSeq ], :IoSeq 								# IoSeq_protoFinish(IoSeq *self)
	attach_function :IoSeq_rawClone, [ :IoSeq ], :IoSeq 								# IoSeq_rawClone(IoSeq *self)
	attach_function :IoSeq_new, [ :pointer ], :IoSeq 									# IoSeq_new(void *state)
	attach_function :IoSeq_newWithUArray_copy_, [ :pointer, :pointer, :int ], :IoSeq 	# IoSeq_newWithUArray_copy_(void *state, UArray *ba, int copy)
	attach_function :IoSeq_newWithData_length_, [ :pointer, :string, :size_t ], :IoSeq 	# IoSeq_newWithData_length_(void *state, const unsigned char *s, size_t length)
	attach_function :IoSeq_newWithData_length_copy_, [ :pointer, :string, :size_t, :int ], :IoSeq 	# IoSeq_newWithData_length_copy_(void *state, const unsigned char *s, size_t length, int copy)
	attach_function :IoSeq_newWithCString_length_, [ :pointer, :string, :size_t ], :IoSeq 	# IoSeq_newWithCString_length_(void *state, const char *s, size_t length)
	attach_function :IoSeq_newWithCString_, [ :pointer, :string ], :IoSeq 				# IoSeq_newWithCString_(void *state, const char *s)
	attach_function :IoSeq_newFromFilePath_, [ :pointer, :string ], :IoSeq 				# IoSeq_newFromFilePath_(void *state, const char *path)
	attach_function :IoSeq_rawMutableCopy, [ :IoSeq ], :IoSeq 							# IoSeq_rawMutableCopy(IoSeq *self)
	attach_function :IoSeq_newSymbolWithCString_, [ :pointer, :string ], :IoSymbol 		# IoSeq_newSymbolWithCString_(void *state, const char *s)
	attach_function :IoSeq_newSymbolWithData_length_, [ :pointer, :string, :size_t ], :IoSymbol 	# IoSeq_newSymbolWithData_length_(void *state, const char *s, size_t length)
	attach_function :IoSeq_newSymbolWithUArray_copy_, [ :pointer, :pointer, :int ], :IoSymbol 	# IoSeq_newSymbolWithUArray_copy_(void *state, UArray *ba, int copy)
	attach_function :IoSeq_newSymbolWithFormat_, [ :pointer, :string, :varargs ], :IoSymbol 	# IoSeq_newSymbolWithFormat_(void *state, const char *format, ...)
	attach_function :IoSeq_free, [ :IoSeq ], :void 										# IoSeq_free(IoSeq *self)
	attach_function :IoSeq_compare, [ :IoSeq, :IoSeq ], :int 							# IoSeq_compare(IoSeq *self, IoSeq *v)
	attach_function :IoSeq_asCString, [ :IoSeq ], :string 								# IoSeq_asCString(IoSeq *self)
	attach_function :IoSeq_rawBytes, [ :IoSeq ], :string 								# IoSeq_rawBytes(IoSeq *self)
	attach_function :IoSeq_rawAsUntriquotedSymbol, [ :IoSeq ], :IoSymbol 				# IoSeq_rawAsUntriquotedSymbol(IoSeq *self)
	attach_function :IoSeq_rawSize, [ :IoSeq ], :size_t 								# IoSeq_rawSize(IoSeq *self)
	attach_function :IoSeq_rawSizeInBytes, [ :IoSeq ], :size_t 							# IoSeq_rawSizeInBytes(IoSeq *self)
	attach_function :IoSeq_rawSetSize_, [ :IoSeq, :size_t ], :void 						# IoSeq_rawSetSize_(IoSeq *self, size_t size)
	attach_function :IoSeq_asDouble, [ :IoSeq ], :double 								# IoSeq_asDouble(IoSeq *self)
	attach_function :IoSeq_rawAsSymbol, [ :IoSeq ], :IoSymbol 							# IoSeq_rawAsSymbol(IoSeq *self)
	attach_function :IoSeq_rawAsUnquotedSymbol, [ :IoSeq ], :IoSymbol 					# IoSeq_rawAsUnquotedSymbol(IoSeq *self)
	attach_function :IoSeq_rawAsUnescapedSymbol, [ :IoSeq ], :IoSymbol 					# IoSeq_rawAsUnescapedSymbol(IoSeq *self)
	attach_function :IoSeq_rawEqualsCString_, [ :IoSeq, :string ], :int 				# IoSeq_rawEqualsCString_(IoSeq *self, const char *s)
	attach_function :IoSeq_rawAsDoubleFromHex, [ :IoSeq ], :double 						# IoSeq_rawAsDoubleFromHex(IoSeq *self)
	attach_function :IoSeq_rawAsDoubleFromOctal, [ :IoSeq ], :double 					# IoSeq_rawAsDoubleFromOctal(IoSeq *self)
	
	# IoState
	attach_function :IoState_new, [ ], :pointer											# IoState_new(void)
	attach_function :IoState_new_atAddress, [ :pointer ], :void 						# IoState_new_atAddress(void* address)
	attach_function :IoState_init, [ :pointer ], :void									# IoState_init(IoState *self)
	attach_function :IoState_setupQuickAccessSymbols, [ :pointer ], :void 				# IoState_setupQuickAccessSymbols(IoState *self)
	attach_function :IoState_setupCachedMessages, [ :pointer ], :void 					# IoState_setupCachedMessages(IoState *self)
	attach_function :IoState_setupSingletons, [ :pointer ], :void 						# IoState_setupSingletons
	attach_function :IoState_registerProtoWithFunc_, [ :pointer, :IoObject, :string], :void 	# IoState_registerProtoWithFunc_(IoState *self, IoObject *proto, const char *v)
	attach_function :IoState_protoWithInitFunction_, [ :pointer, :string ], :IoObject 	# IoState_protoWithInitFunction_(IoState *self, const char *v)
	attach_function :IoState_protoWithName_, [ :pointer, :string ], :IoObject 			# IoState_protoWithName_(IoState *self, const char *name)
	attach_function :IoState_done, [ :pointer ], :void 									# IoState_done(IoState *self)
	attach_function :IoState_free, [ :pointer ], :void									# IoState_free(IoState *self)
	attach_function :IoState_lobby, [ :pointer ], :IoObject 							# IoState_lobby(IoState *self)
	attach_function :IoState_setLobby_, [ :pointer, :IoObject ], :void 					# IoState_setLobby_(IoState *self, IoObject *obj)
	attach_function :IoState_argc_argv_, [ :pointer, :int, :pointer ], :void 			# IoState_argc_argv_(IoState *self, int argc, const char *argv[])
	attach_function :IoState_runCLI, [ :pointer ], :void 								# IoState_runCLI(IoState *self)
	attach_function :IoState_exitResult, [ :pointer ], :int 							# IoState_exitResult(IoState *self)

	# IoState_symbols
	attach_function :IoState_setupCachedNumbers, [ :pointer ], :void 					# IoState_setupCachedNumbers(IoState *self)
	attach_function :IoState_numberWithDouble_, [ :pointer, :double ], :IoObject 		# IoState_numberWithDouble_(IoState *self, double n)
	attach_function :IoState_symbolWithUArray_copy_, [ :pointer, :pointer, :int ], :IoSymbol 	# IoState_symbolWithUArray_copy_(IoState *self, UArray *ba, int copy)
	attach_function :IoState_symbolWithCString_, [ :pointer, :string ], :IoSymbol 		# IoState_symbolWithCString_(IoState *self, const char *s)
	attach_function :IoState_symbolWithCString_length_, [ :pointer, :string, :size_t ], :IoSymbol 	# IoState_symbolWithCString_length_(IoState *self, const char *s, size_t length)
	attach_function :IoState_addSymbol_, [ :pointer, :IoSymbol ], :IoSymbol 			# IoState_addSymbol_(IoState *self, IoSymbol *s)
	attach_function :IoState_removeSymbol_, [ :pointer, :IoSymbol ], :void 				# IoState_removeSymbol_(IoState *self, IoSymbol *aString)

	# IoState_eval
	attach_function :IoState_doCString_, [ :pointer, :string ], :IoObject

end