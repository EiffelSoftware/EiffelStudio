indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.EventDescriptor"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_EVENT_DESCRIPTOR

inherit
	SYSTEM_DLL_MEMBER_DESCRIPTOR

feature -- Access

	get_event_type: TYPE is
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

	get_component_type: TYPE is
		external
			"IL deferred signature (): System.Type use System.ComponentModel.EventDescriptor"
		alias
			"get_ComponentType"
		end

feature -- Basic Operations

	add_event_handler (component: SYSTEM_OBJECT; value: DELEGATE) is
		external
			"IL deferred signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventDescriptor"
		alias
			"AddEventHandler"
		end

	remove_event_handler (component: SYSTEM_OBJECT; value: DELEGATE) is
		external
			"IL deferred signature (System.Object, System.Delegate): System.Void use System.ComponentModel.EventDescriptor"
		alias
			"RemoveEventHandler"
		end

end -- class SYSTEM_DLL_EVENT_DESCRIPTOR
