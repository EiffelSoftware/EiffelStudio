indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ITemplate"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_ITEMPLATE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	instantiate_in (container: WEB_CONTROL) is
		external
			"IL deferred signature (System.Web.UI.Control): System.Void use System.Web.UI.ITemplate"
		alias
			"InstantiateIn"
		end

end -- class WEB_ITEMPLATE
