indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IServiceProvider"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISERVICE_PROVIDER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_service (service_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type): System.Object use System.IServiceProvider"
		alias
			"GetService"
		end

end -- class ISERVICE_PROVIDER
