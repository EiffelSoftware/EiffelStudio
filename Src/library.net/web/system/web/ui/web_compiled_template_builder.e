indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.CompiledTemplateBuilder"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_COMPILED_TEMPLATE_BUILDER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_ITEMPLATE

create
	make

feature {NONE} -- Initialization

	frozen make (build_template_method: WEB_BUILD_TEMPLATE_METHOD) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.CompiledTemplateBuilder"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.CompiledTemplateBuilder"
		alias
			"Equals"
		end

	frozen instantiate_in (container: WEB_CONTROL) is
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

end -- class WEB_COMPILED_TEMPLATE_BUILDER
