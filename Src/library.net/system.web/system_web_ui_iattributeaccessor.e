indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IAttributeAccessor"

deferred external class
	SYSTEM_WEB_UI_IATTRIBUTEACCESSOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	set_attribute (key: STRING; value: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Web.UI.IAttributeAccessor"
		alias
			"SetAttribute"
		end

	get_attribute (key: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Web.UI.IAttributeAccessor"
		alias
			"GetAttribute"
		end

end -- class SYSTEM_WEB_UI_IATTRIBUTEACCESSOR
