indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IEventBindingService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IEVENTBINDINGSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_compatible_methods (e: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR): SYSTEM_COLLECTIONS_ICOLLECTION is
		external
			"IL deferred signature (System.ComponentModel.EventDescriptor): System.Collections.ICollection use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetCompatibleMethods"
		end

	get_event (property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR): SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.ComponentModel.EventDescriptor use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetEvent"
		end

	get_event_properties (events: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTORCOLLECTION): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.ComponentModel.EventDescriptorCollection): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetEventProperties"
		end

	show_code_icomponent (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; e: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.EventDescriptor): System.Boolean use System.ComponentModel.Design.IEventBindingService"
		alias
			"ShowCode"
		end

	create_unique_method_name (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; e: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR): STRING is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.EventDescriptor): System.String use System.ComponentModel.Design.IEventBindingService"
		alias
			"CreateUniqueMethodName"
		end

	get_event_property (e: SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL deferred signature (System.ComponentModel.EventDescriptor): System.ComponentModel.PropertyDescriptor use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetEventProperty"
		end

	show_code: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.Design.IEventBindingService"
		alias
			"ShowCode"
		end

	show_code_int32 (line_number: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Int32): System.Boolean use System.ComponentModel.Design.IEventBindingService"
		alias
			"ShowCode"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IEVENTBINDINGSERVICE
