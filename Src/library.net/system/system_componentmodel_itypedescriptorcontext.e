indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ITypeDescriptorContext"

deferred external class
	SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT

inherit
	SYSTEM_ISERVICEPROVIDER

feature -- Access

	get_property_descriptor: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ITypeDescriptorContext"
		alias
			"get_PropertyDescriptor"
		end

	get_container: SYSTEM_COMPONENTMODEL_ICONTAINER is
		external
			"IL deferred signature (): System.ComponentModel.IContainer use System.ComponentModel.ITypeDescriptorContext"
		alias
			"get_Container"
		end

	get_instance: ANY is
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

end -- class SYSTEM_COMPONENTMODEL_ITYPEDESCRIPTORCONTEXT
