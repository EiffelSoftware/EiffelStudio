indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Reflection.EventInfo"

deferred external class
	SYSTEM_REFLECTION_EVENTINFO

inherit
	SYSTEM_REFLECTION_MEMBERINFO
	SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER

feature -- Access

	get_attributes: INTEGER is
		external
			"IL deferred signature (): enum System.Reflection.EventAttributes use System.Reflection.EventInfo"
		alias
			"get_Attributes"
		ensure
			valid_event_attributes: Result = 0 or Result = 512 or Result = 1024 or Result = 1024
		end

	get_member_type: INTEGER is
		external
			"IL signature (): enum System.Reflection.MemberTypes use System.Reflection.EventInfo"
		alias
			"get_MemberType"
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

	frozen get_event_handler_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Reflection.EventInfo"
		alias
			"get_EventHandlerType"
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

	get_remove_method_boolean (nonPublic: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_raise_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

	frozen get_remove_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRemoveMethod"
		end

	frozen get_add_method: SYSTEM_REFLECTION_METHODINFO is
		external
			"IL signature (): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

	get_raise_method_boolean (nonPublic: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetRaiseMethod"
		end

	get_add_method_boolean (nonPublic: BOOLEAN): SYSTEM_REFLECTION_METHODINFO is
		external
			"IL deferred signature (System.Boolean): System.Reflection.MethodInfo use System.Reflection.EventInfo"
		alias
			"GetAddMethod"
		end

end -- class SYSTEM_REFLECTION_EVENTINFO
