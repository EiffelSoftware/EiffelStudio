indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ItemCheckEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_ITEM_CHECK_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_item_check_event_args

feature {NONE} -- Initialization

	frozen make_winforms_item_check_event_args (index: INTEGER; new_check_value: WINFORMS_CHECK_STATE; current_value: WINFORMS_CHECK_STATE) is
		external
			"IL creator signature (System.Int32, System.Windows.Forms.CheckState, System.Windows.Forms.CheckState) use System.Windows.Forms.ItemCheckEventArgs"
		end

feature -- Access

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"get_Index"
		end

	frozen get_new_value: WINFORMS_CHECK_STATE is
		external
			"IL signature (): System.Windows.Forms.CheckState use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"get_NewValue"
		end

	frozen get_current_value: WINFORMS_CHECK_STATE is
		external
			"IL signature (): System.Windows.Forms.CheckState use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"get_CurrentValue"
		end

feature -- Element Change

	frozen set_new_value (value: WINFORMS_CHECK_STATE) is
		external
			"IL signature (System.Windows.Forms.CheckState): System.Void use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"set_NewValue"
		end

end -- class WINFORMS_ITEM_CHECK_EVENT_ARGS
