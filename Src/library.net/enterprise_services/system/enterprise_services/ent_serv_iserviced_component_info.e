indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.IServicedComponentInfo"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ISERVICED_COMPONENT_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_component_info (info_mask: INTEGER; info_array: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL deferred signature (System.Int32&, System.String[]&): System.Void use System.EnterpriseServices.IServicedComponentInfo"
		alias
			"GetComponentInfo"
		end

end -- class ENT_SERV_ISERVICED_COMPONENT_INFO
