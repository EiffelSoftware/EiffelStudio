indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.EventDescriptor"

deferred external class
	SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR

inherit
	SYSTEM_COMPONENTMODEL_MEMBERDESCRIPTOR

feature -- Access

	get_event_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.EventDescriptor"
		alias
			"get_EventType"
		end

	get_is_multicast: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.ComponentModel.EventDescriptor"
		alias
			"get_IsMulticast"
		end

	get_component_type: SYSTEM_TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.EventDescriptor"
		alias
			"get_ComponentType"
		end

feature -- Basic Operations

	add_event_handler (component: ANY; value: SYSTEM_DELEGATE) is
		external
			"IL deferred signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventDescriptor"
		alias
			"AddEventHandler"
		end

	remove_event_handler (component: ANY; value: SYSTEM_DELEGATE) is
		external
			"IL deferred signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventDescriptor"
		alias
			"RemoveEventHandler"
		end

end -- class SYSTEM_COMPONENTMODEL_EVENTDESCRIPTOR
