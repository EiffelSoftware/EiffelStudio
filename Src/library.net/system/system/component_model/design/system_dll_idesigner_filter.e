indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IDesignerFilter"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_FILTER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	post_filter_events (events: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterEvents"
		end

	pre_filter_attributes (attributes: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterAttributes"
		end

	post_filter_properties (properties: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterProperties"
		end

	pre_filter_properties (properties: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterProperties"
		end

	pre_filter_events (events: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterEvents"
		end

	post_filter_attributes (attributes: IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterAttributes"
		end

end -- class SYSTEM_DLL_IDESIGNER_FILTER
