indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ToolBarButtonClickEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_tool_bar_button_click_event_args

feature {NONE} -- Initialization

	frozen make_winforms_tool_bar_button_click_event_args (button: WINFORMS_TOOL_BAR_BUTTON) is
		external
			"IL creator signature (System.Windows.Forms.ToolBarButton) use System.Windows.Forms.ToolBarButtonClickEventArgs"
		end

feature -- Access

	frozen get_button: WINFORMS_TOOL_BAR_BUTTON is
		external
			"IL signature (): System.Windows.Forms.ToolBarButton use System.Windows.Forms.ToolBarButtonClickEventArgs"
		alias
			"get_Button"
		end

feature -- Element Change

	frozen set_button (value: WINFORMS_TOOL_BAR_BUTTON) is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Void use System.Windows.Forms.ToolBarButtonClickEventArgs"
		alias
			"set_Button"
		end

end -- class WINFORMS_TOOL_BAR_BUTTON_CLICK_EVENT_ARGS
