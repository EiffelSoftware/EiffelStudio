indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ItemDragEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_ITEM_DRAG_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_item_drag_event_args,
	make_winforms_item_drag_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_item_drag_event_args (button: WINFORMS_MOUSE_BUTTONS) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons) use System.Windows.Forms.ItemDragEventArgs"
		end

	frozen make_winforms_item_drag_event_args_1 (button: WINFORMS_MOUSE_BUTTONS; item: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons, System.Object) use System.Windows.Forms.ItemDragEventArgs"
		end

feature -- Access

	frozen get_item: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ItemDragEventArgs"
		alias
			"get_Item"
		end

	frozen get_button: WINFORMS_MOUSE_BUTTONS is
		external
			"IL signature (): System.Windows.Forms.MouseButtons use System.Windows.Forms.ItemDragEventArgs"
		alias
			"get_Button"
		end

end -- class WINFORMS_ITEM_DRAG_EVENT_ARGS
