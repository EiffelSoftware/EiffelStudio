indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IEventBindingService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IEVENT_BINDING_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_compatible_methods (e: SYSTEM_DLL_EVENT_DESCRIPTOR): ICOLLECTION is
		external
			"IL deferred signature (System.ComponentModel.EventDescriptor): System.Collections.ICollection use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetCompatibleMethods"
		end

	get_event (property: SYSTEM_DLL_PROPERTY_DESCRIPTOR): SYSTEM_DLL_EVENT_DESCRIPTOR is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor): System.ComponentModel.EventDescriptor use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetEvent"
		end

	get_event_properties (events: SYSTEM_DLL_EVENT_DESCRIPTOR_COLLECTION): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.ComponentModel.EventDescriptorCollection): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.Design.IEventBindingService"
		alias
			"GetEventProperties"
		end

	show_code_icomponent (component: SYSTEM_DLL_ICOMPONENT; e: SYSTEM_DLL_EVENT_DESCRIPTOR): BOOLEAN is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.EventDescriptor): System.Boolean use System.ComponentModel.Design.IEventBindingService"
		alias
			"ShowCode"
		end

	create_unique_method_name (component: SYSTEM_DLL_ICOMPONENT; e: SYSTEM_DLL_EVENT_DESCRIPTOR): SYSTEM_STRING is
		external
			"IL deferred signature (System.ComponentModel.IComponent, System.ComponentModel.EventDescriptor): System.String use System.ComponentModel.Design.IEventBindingService"
		alias
			"CreateUniqueMethodName"
		end

	get_event_property (e: SYSTEM_DLL_EVENT_DESCRIPTOR): SYSTEM_DLL_PROPERTY_DESCRIPTOR is
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

end -- class SYSTEM_DLL_IEVENT_BINDING_SERVICE
