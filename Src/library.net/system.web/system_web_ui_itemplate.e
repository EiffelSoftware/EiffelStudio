indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ITemplate"

deferred external class
	SYSTEM_WEB_UI_ITEMPLATE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	instantiate_in (container: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL deferred signature (System.Web.UI.Control): System.Void use System.Web.UI.ITemplate"
		alias
			"InstantiateIn"
		end

end -- class SYSTEM_WEB_UI_ITEMPLATE
