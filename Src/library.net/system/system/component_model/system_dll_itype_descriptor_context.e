indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ITypeDescriptorContext"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT

inherit
	ISERVICE_PROVIDER

feature -- Access

	get_property_descriptor: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ITypeDescriptorContext"
		alias
			"get_PropertyDescriptor"
		end

	get_container: SYSTEM_DLL_ICONTAINER is
		external
			"IL deferred signature (): System.ComponentModel.IContainer use System.ComponentModel.ITypeDescriptorContext"
		alias
			"get_Container"
		end

	get_instance: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.ComponentModel.ITypeDescriptorContext"
		alias
			"get_Instance"
		end

feature -- Basic Operations

	on_component_changing: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.ITypeDescriptorContext"
		alias
			"OnComponentChanging"
		end

	on_component_changed is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.ITypeDescriptorContext"
		alias
			"OnComponentChanged"
		end

end -- class SYSTEM_DLL_ITYPE_DESCRIPTOR_CONTEXT
