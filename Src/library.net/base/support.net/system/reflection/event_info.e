indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.EventInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	EVENT_INFO

inherit
	MEMBER_INFO
	ICUSTOM_ATTRIBUTE_PROVIDER

feature -- Access

	frozen get_event_handler_type: TYPE is
		external
			"IL signature (): System.Type use System.Reflection.EventInfo"
		alias
			"get_EventHandlerType"
		end

	frozen get_is_multicast: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.EventInfo"
		alias
			"get_IsMulticast"
		end

	frozen get_is_special_name: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Reflection.EventInfo"
		alias
			"get_IsSpecialName"
		end

	get_member_type: MEMBER_TYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.EventInfo"
		alias
			"get_MemberType"
		end

	get_attributes: EVENT_ATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.EventAttributes use System.Reflection.EventInfo"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	frozen remove_event_handler (target: SYSTEM_OBJECT; handler: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.Reflection.EventInfo"
		alias
			"RemoveEventHandler"
		end

	frozen add_event_handler (target: SYSTEM_OBJECT; handler: DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.Reflection.EventInfo"
		alias
			"AddEventHandler"
		end

	frozen get_add_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

	get_raise_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

	get_add_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

	get_remove_method_boolean (non_public: BOOLEAN): METHOD_INFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_remove_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_raise_method: METHOD_INFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

end -- class EVENT_INFO
