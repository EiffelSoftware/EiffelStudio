indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ITypeDescriptorFilterService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_ITYPEDESCRIPTORFILTERSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	filter_events (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; events: SYSTEM_COLLECTIONS_IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterEvents"
		end

	filter_attributes (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; attributes: SYSTEM_COLLECTIONS_IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterAttributes"
		end

	filter_properties (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; properties: SYSTEM_COLLECTIONS_IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ITYPEDESCRIPTORFILTERSERVICE
