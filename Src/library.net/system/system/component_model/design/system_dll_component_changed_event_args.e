indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ComponentChangedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_COMPONENT_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_component_changed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_component_changed_event_args (component: SYSTEM_OBJECT; member: SYSTEM_DLL_MEMBER_DESCRIPTOR; old_value: SYSTEM_OBJECT; new_value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object, System.ComponentModel.MemberDescriptor, System.Object, System.Object) use System.ComponentModel.Design.ComponentChangedEventArgs"
		end

feature -- Access

	frozen get_component: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_Component"
		end

	frozen get_new_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_NewValue"
		end

	frozen get_member: SYSTEM_DLL_MEMBER_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.MemberDescriptor use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_Member"
		end

	frozen get_old_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangedEventArgs"
		alias
			"get_OldValue"
		end

end -- class SYSTEM_DLL_COMPONENT_CHANGED_EVENT_ARGS
