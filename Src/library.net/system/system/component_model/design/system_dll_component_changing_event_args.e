indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ComponentChangingEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_COMPONENT_CHANGING_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_component_changing_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_component_changing_event_args (component: SYSTEM_OBJECT; member: SYSTEM_DLL_MEMBER_DESCRIPTOR) is
		external
			"IL creator signature (System.Object, System.ComponentModel.MemberDescriptor) use System.ComponentModel.Design.ComponentChangingEventArgs"
		end

feature -- Access

	frozen get_component: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentChangingEventArgs"
		alias
			"get_Component"
		end

	frozen get_member: SYSTEM_DLL_MEMBER_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.MemberDescriptor use System.ComponentModel.Design.ComponentChangingEventArgs"
		alias
			"get_Member"
		end

end -- class SYSTEM_DLL_COMPONENT_CHANGING_EVENT_ARGS
