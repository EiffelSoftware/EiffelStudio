indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ITagNameToTypeMapper"

deferred external class
	SYSTEM_WEB_UI_ITAGNAMETOTYPEMAPPER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_control_type (tag_name: STRING; attribs: SYSTEM_COLLECTIONS_IDICTIONARY): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String, System.Collections.IDictionary): System.Type use System.Web.UI.ITagNameToTypeMapper"
		alias
			"GetControlType"
		end

end -- class SYSTEM_WEB_UI_ITAGNAMETOTYPEMAPPER
