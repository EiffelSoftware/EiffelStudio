indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.CancelEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CANCEL_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_cancel_event_args,
	make_system_dll_cancel_event_args_1

feature {NONE} -- Initialization

	frozen make_system_dll_cancel_event_args is
		external
			"IL creator use System.ComponentModel.CancelEventArgs"
		end

	frozen make_system_dll_cancel_event_args_1 (cancel: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.CancelEventArgs"
		end

feature -- Access

	frozen get_cancel: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.CancelEventArgs"
		alias
			"get_Cancel"
		end

feature -- Element Change

	frozen set_cancel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.CancelEventArgs"
		alias
			"set_Cancel"
		end

end -- class SYSTEM_DLL_CANCEL_EVENT_ARGS
