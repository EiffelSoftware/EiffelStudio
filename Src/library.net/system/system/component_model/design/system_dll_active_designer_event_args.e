indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ActiveDesignerEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ACTIVE_DESIGNER_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_active_designer_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_active_designer_event_args (old_designer: SYSTEM_DLL_IDESIGNER_HOST; new_designer: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost, System.ComponentModel.Design.IDesignerHost) use System.ComponentModel.Design.ActiveDesignerEventArgs"
		end

feature -- Access

	frozen get_new_designer: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.ActiveDesignerEventArgs"
		alias
			"get_NewDesigner"
		end

	frozen get_old_designer: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.ActiveDesignerEventArgs"
		alias
			"get_OldDesigner"
		end

end -- class SYSTEM_DLL_ACTIVE_DESIGNER_EVENT_ARGS
