indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Messaging.ReturnMessage"

external class
	SYSTEM_RUNTIME_REMOTING_MESSAGING_RETURNMESSAGE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODRETURNMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODMESSAGE
	SYSTEM_RUNTIME_REMOTING_MESSAGING_IMESSAGE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (ret: ANY; outArgs2: ARRAY [ANY]; outArgsCount: INTEGER; callCtx: SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT; mcm: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE) is
		external
			"IL creator signature (System.Object, System.Object[], System.Int32, System.Runtime.Remoting.Messaging.LogicalCallContext, System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.ReturnMessage"
		end

	frozen make_1 (e: SYSTEM_EXCEPTION; mcm: SYSTEM_RUNTIME_REMOTING_MESSAGING_IMETHODCALLMESSAGE) is
		external
			"IL creator signature (System.Exception, System.Runtime.Remoting.Messaging.IMethodCallMessage) use System.Runtime.Remoting.Messaging.ReturnMessage"
		end

feature -- Access

	get_properties: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Properties"
		end

	frozen get_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_ArgCount"
		end

	frozen get_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Uri"
		end

	frozen get_has_var_args: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_HasVarArgs"
		end

	frozen get_out_arg_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_OutArgCount"
		end

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_TypeName"
		end

	frozen get_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Args"
		end

	get_return_value: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_ReturnValue"
		end

	frozen get_method_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodName"
		end

	frozen get_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_Exception"
		end

	frozen get_method_signature: ANY is
		external
			"IL signature (): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodSignature"
		end

	frozen get_out_args: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_OutArgs"
		end

	frozen get_logical_call_context: SYSTEM_RUNTIME_REMOTING_MESSAGING_LOGICALCALLCONTEXT is
		external
			"IL signature (): System.Runtime.Remoting.Messaging.LogicalCallContext use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_LogicalCallContext"
		end

	frozen get_method_base: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"get_MethodBase"
		end

feature -- Element Change

	frozen set_uri (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"set_Uri"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetHashCode"
		end

	frozen get_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetArgName"
		end

	frozen get_out_arg (argNum: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetOutArg"
		end

	frozen get_arg (argNum: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetArg"
		end

	frozen get_out_arg_name (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"GetOutArgName"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Messaging.ReturnMessage"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_MESSAGING_RETURNMESSAGE
