indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.CompiledTemplateBuilder"

frozen external class
	SYSTEM_WEB_UI_COMPILEDTEMPLATEBUILDER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_UI_ITEMPLATE

create
	make

feature {NONE} -- Initialization

	frozen make (build_template_method: SYSTEM_WEB_UI_BUILDTEMPLATEMETHOD) is
		external
			"IL creator signature (System.Web.UI.BuildTemplateMethod) use System.Web.UI.CompiledTemplateBuilder"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.CompiledTemplateBuilder"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.CompiledTemplateBuilder"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.CompiledTemplateBuilder"
		alias
			"Equals"
		end

	frozen instantiate_in (container: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.Control): System.Void use System.Web.UI.CompiledTemplateBuilder"
		alias
			"InstantiateIn"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.CompiledTemplateBuilder"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_UI_COMPILEDTEMPLATEBUILDER
