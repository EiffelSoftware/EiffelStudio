indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IServiceProvider"

deferred external class
	SYSTEM_ISERVICEPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_service (service_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Type): System.Object use System.IServiceProvider"
		alias
			"GetService"
		end

end -- class SYSTEM_ISERVICEPROVIDER
