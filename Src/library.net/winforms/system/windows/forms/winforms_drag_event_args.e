indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DragEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DRAG_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_drag_event_args

feature {NONE} -- Initialization

	frozen make_winforms_drag_event_args (data: WINFORMS_IDATA_OBJECT; key_state: INTEGER; x: INTEGER; y: INTEGER; allowed_effect: WINFORMS_DRAG_DROP_EFFECTS; effect: WINFORMS_DRAG_DROP_EFFECTS) is
		external
			"IL creator signature (System.Windows.Forms.IDataObject, System.Int32, System.Int32, System.Int32, System.Windows.Forms.DragDropEffects, System.Windows.Forms.DragDropEffects) use System.Windows.Forms.DragEventArgs"
		end

feature -- Access

	frozen get_allowed_effect: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragEventArgs"
		alias
			"get_AllowedEffect"
		end

	frozen get_key_state: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_KeyState"
		end

	frozen get_effect: WINFORMS_DRAG_DROP_EFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragEventArgs"
		alias
			"get_Effect"
		end

	frozen get_data: WINFORMS_IDATA_OBJECT is
		external
			"IL signature (): System.Windows.Forms.IDataObject use System.Windows.Forms.DragEventArgs"
		alias
			"get_Data"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DragEventArgs"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_effect (value: WINFORMS_DRAG_DROP_EFFECTS) is
		external
			"IL signature (System.Windows.Forms.DragDropEffects): System.Void use System.Windows.Forms.DragEventArgs"
		alias
			"set_Effect"
		end

end -- class WINFORMS_DRAG_EVENT_ARGS
