indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_METHODCALLMESSAGEWRAPPER

inherit
	SYSTEM_RUNTIME_REMOTING_MESSAGING_INTERNALMESSAGEWRAPPER
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

create
	make_methodcallmessagewrapper

feature {NONE} -- Initialization

	frozen make_methodcallmessagewrapper (msg: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE) is
		external
			"IL creator signature (System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		end

feature -- Access

	get_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Uri"
		end

	get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_HasVarArgs"
		end

	get_in_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_InArgs"
		end

	get_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Args"
		end

	get_method_base: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodBase"
		end

	get_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_TypeName"
		end

	get_method_signature: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodSignature"
		end

	get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_ArgCount"
		end

	get_in_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_InArgCount"
		end

	get_logical_call_context: SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_LogicalCallContext"
		end

	get_method_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_MethodName"
		end

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"get_Properties"
		end

feature -- Element Change

	set_uri (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"set_Uri"
		end

	set_args (value: ARRAY [ANY]) is
		external
			"IL signature (System.Object[]): System.Void use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"set_Args"
		end

feature -- Basic Operations

	get_in_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetInArgName"
		end

	get_in_arg (arg_num: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetInArg"
		end

	get_arg (arg_num: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetArg"
		end

	get_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.MethodCallMessageWrapper"
		alias
			"GetArgName"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_METHODCALLMESSAGEWRAPPER
