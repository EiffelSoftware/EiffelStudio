indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.IDataBindingsAccessor"

deferred external class
	SYSTEM_WEB_UI_IDATABINDINGSACCESSOR

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_data_bindings: SYSTEM_WEB_UI_DATABINDINGCOLLECTION is
		external
			"IL deferred signature (): System.Web.UI.DataBindingCollection use System.Web.UI.IDataBindingsAccessor"
		alias
			"get_DataBindings"
		end

	get_has_data_bindings: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.UI.IDataBindingsAccessor"
		alias
			"get_HasDataBindings"
		end

end -- class SYSTEM_WEB_UI_IDATABINDINGSACCESSOR
