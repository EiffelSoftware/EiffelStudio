indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDesignerFilter"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERFILTER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	post_filter_events (events: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterEvents"
		end

	pre_filter_attributes (attributes: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterAttributes"
		end

	post_filter_properties (properties: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterProperties"
		end

	pre_filter_properties (properties: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterProperties"
		end

	pre_filter_events (events: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PreFilterEvents"
		end

	post_filter_attributes (attributes: SYSTEM_COLLECTIONS_IDICTIONARY) is
		external
			"IL deferred signature (System.Collections.IDictionary): System.Void use System.ComponentModel.Design.IDesignerFilter"
		alias
			"PostFilterAttributes"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERFILTER
