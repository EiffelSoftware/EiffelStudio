indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Exception"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	EXCEPTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERIALIZABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Exception"
		end

	frozen make is
		external
			"IL creator use System.Exception"
		end

	frozen make_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Exception"
		end

feature -- Access

	frozen get_target_site: METHOD_BASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Exception"
		alias
			"get_TargetSite"
		end

	get_stack_trace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_StackTrace"
		end

	get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_Source"
		end

	frozen get_inner_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Exception"
		alias
			"get_InnerException"
		end

	get_help_link: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_HelpLink"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_Message"
		end

feature -- Element Change

	set_source (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Exception"
		alias
			"set_Source"
		end

	set_help_link (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Exception"
		alias
			"set_HelpLink"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Exception"
		alias
			"GetHashCode"
		end

	get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Exception"
		alias
			"GetObjectData"
		end

	get_base_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Exception"
		alias
			"GetBaseException"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Exception"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen set_hresult (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Exception"
		alias
			"set_HResult"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Exception"
		alias
			"Finalize"
		end

	frozen get_hresult: INTEGER is
		external
			"IL signature (): System.Int32 use System.Exception"
		alias
			"get_HResult"
		end

end -- class EXCEPTION
