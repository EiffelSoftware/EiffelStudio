indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.IDataBindingsAccessor"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IDATA_BINDINGS_ACCESSOR

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_data_bindings: WEB_DATA_BINDING_COLLECTION is
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

end -- class WEB_IDATA_BINDINGS_ACCESSOR
