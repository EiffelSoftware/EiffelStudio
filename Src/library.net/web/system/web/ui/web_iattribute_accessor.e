indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IAttributeAccessor"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IATTRIBUTE_ACCESSOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	set_attribute (key: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Web.UI.IAttributeAccessor"
		alias
			"SetAttribute"
		end

	get_attribute (key: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Web.UI.IAttributeAccessor"
		alias
			"GetAttribute"
		end

end -- class WEB_IATTRIBUTE_ACCESSOR
