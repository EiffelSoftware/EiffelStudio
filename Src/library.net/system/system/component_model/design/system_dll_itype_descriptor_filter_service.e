indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ITypeDescriptorFilterService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ITYPE_DESCRIPTOR_FILTER_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	filter_events (component: SYSTEM_DLL_ICOMPONENT; events: IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterEvents"
		end

	filter_attributes (component: SYSTEM_DLL_ICOMPONENT; attributes: IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterAttributes"
		end

	filter_properties (component: SYSTEM_DLL_ICOMPONENT; properties: IDICTIONARY): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.Collections.IDictionary): System.Boolean use System.ComponentModel.Design.ITypeDescriptorFilterService"
		alias
			"FilterProperties"
		end

end -- class SYSTEM_DLL_ITYPE_DESCRIPTOR_FILTER_SERVICE
