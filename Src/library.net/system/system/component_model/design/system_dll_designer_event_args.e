indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesignerEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNER_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_designer_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_designer_event_args (host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost) use System.ComponentModel.Design.DesignerEventArgs"
		end

feature -- Access

	frozen get_designer: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.ComponentModel.Design.DesignerEventArgs"
		alias
			"get_Designer"
		end

end -- class SYSTEM_DLL_DESIGNER_EVENT_ARGS
