indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Exception"

external class
	SYSTEM_EXCEPTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Exception"
		end

	frozen make is
		external
			"IL creator use System.Exception"
		end

	frozen make_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Exception"
		end

feature -- Access

	frozen get_target_site: SYSTEM_REFLECTION_METHODBASE is
		external
			"IL signature (): System.Reflection.MethodBase use System.Exception"
		alias
			"get_TargetSite"
		end

	get_stack_trace: STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_StackTrace"
		end

	get_source: STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_Source"
		end

	frozen get_inner_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Exception"
		alias
			"get_InnerException"
		end

	get_help_link: STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_HelpLink"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"get_Message"
		end

feature -- Element Change

	set_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Exception"
		alias
			"set_Source"
		end

	set_help_link (value: STRING) is
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

	get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Exception"
		alias
			"GetObjectData"
		end

	get_base_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Exception"
		alias
			"GetBaseException"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Exception"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_EXCEPTION
