indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_METHODRETURNMESSAGEWRAPPER

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_INTERNALMESSAGEWRAPPER
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

create
	make_methodreturnmessagewrapper

feature {NONE} -- Initialization

	frozen make_methodreturnmessagewrapper (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMethodReturnMessage) use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		end

feature -- Access

	frozen get_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Uri"
		end

	get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_HasVarArgs"
		end

	get_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Exception"
		end

	get_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Args"
		end

	get_out_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_OutArgs"
		end

	get_method_base: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodBase"
		end

	get_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_TypeName"
		end

	get_method_signature: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodSignature"
		end

	get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_ArgCount"
		end

	get_out_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_OutArgCount"
		end

	get_logical_call_context: SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_LogicalCallContext"
		end

	get_method_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_MethodName"
		end

	get_return_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_ReturnValue"
		end

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"get_Properties"
		end

feature -- Element Change

	set_return_value (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_ReturnValue"
		end

	set_exception (value: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Exception"
		end

	set_args (value: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Args"
		end

	frozen set_uri (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"set_Uri"
		end

feature -- Basic Operations

	get_arg (arg_num: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetArg"
		end

	get_out_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetOutArgName"
		end

	get_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetArgName"
		end

	get_out_arg (arg_num: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodReturnMessageWrapper"
		alias
			"GetOutArg"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_METHODRETURNMESSAGEWRAPPER
