indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatedEventArgs"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_TOOLBOX_COMPONENTS_CREATED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_drawing_toolbox_components_created_event_args

feature {NONE} -- Initialization

	frozen make_drawing_toolbox_components_created_event_args (components: NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT]) is
		external
			"IL creator signature (System.ComponentModel.IComponent[]) use System.Drawing.Design.ToolboxComponentsCreatedEventArgs"
		end

feature -- Access

	frozen get_components: NATIVE_ARRAY [SYSTEM_DLL_ICOMPONENT] is
		external
			"IL signature (): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxComponentsCreatedEventArgs"
		alias
			"get_Components"
		end

end -- class DRAWING_TOOLBOX_COMPONENTS_CREATED_EVENT_ARGS
