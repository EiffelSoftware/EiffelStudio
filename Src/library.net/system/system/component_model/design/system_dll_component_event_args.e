indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ComponentEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPONENT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_component_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_component_event_args (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL creator signature (System.ComponentModel.IComponent) use System.ComponentModel.Design.ComponentEventArgs"
		end

feature -- Access

	get_component: SYSTEM_DLL_ICOMPONENT is
		external
			"IL signature (): System.ComponentModel.IComponent use System.ComponentModel.Design.ComponentEventArgs"
		alias
			"get_Component"
		end

end -- class SYSTEM_DLL_COMPONENT_EVENT_ARGS
