indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.EventInfo"

deferred external class
	SYSTEM_REFLECTION_EVENTINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	frozen get_event_handler_type: SYSTEM_TYPE is
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

	get_member_type: SYSTEM_REFLECTION_MEMBERTYPES is
		external
			"IL signature (): System.Reflection.MemberTypes use System.Reflection.EventInfo"
		alias
			"get_MemberType"
		end

	get_attributes: SYSTEM_REFLECTION_EVENTATTRIBUTES is
		external
			"IL deferred signature (): System.Reflection.EventAttributes use System.Reflection.EventInfo"
		alias
			"get_Attributes"
		end

feature -- Basic Operations

	frozen remove_event_handler (target: ANY; handler: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.Reflection.EventInfo"
		alias
			"RemoveEventHandler"
		end

	frozen add_event_handler (target: ANY; handler: SYSTEM_DELEGATE) is
		external
			"IL signature (System.Object, System.Delegate): System.Void use System.Reflection.EventInfo"
		alias
			"AddEventHandler"
		end

	frozen get_add_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

	get_raise_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

	get_add_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

	get_remove_method_boolean (non_public: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_remove_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_raise_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

end -- class SYSTEM_REFLECTION_EVENTINFO
