indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatingEventArgs"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_TOOLBOX_COMPONENTS_CREATING_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_drawing_toolbox_components_creating_event_args

feature {NONE} -- Initialization

	frozen make_drawing_toolbox_components_creating_event_args (host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost) use System.Drawing.Design.ToolboxComponentsCreatingEventArgs"
		end

feature -- Access

	frozen get_designer_host: SYSTEM_DLL_IDESIGNER_HOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.Drawing.Design.ToolboxComponentsCreatingEventArgs"
		alias
			"get_DesignerHost"
		end

end -- class DRAWING_TOOLBOX_COMPONENTS_CREATING_EVENT_ARGS
