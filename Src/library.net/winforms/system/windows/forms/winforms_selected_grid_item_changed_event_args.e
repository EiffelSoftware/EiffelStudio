indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.SelectedGridItemChangedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_SELECTED_GRID_ITEM_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_selected_grid_item_changed_event_args

feature {NONE} -- Initialization

	frozen make_winforms_selected_grid_item_changed_event_args (old_sel: WINFORMS_GRID_ITEM; new_sel: WINFORMS_GRID_ITEM) is
		external
			"IL creator signature (System.Windows.Forms.GridItem, System.Windows.Forms.GridItem) use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		end

feature -- Access

	frozen get_old_selection: WINFORMS_GRID_ITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		alias
			"get_OldSelection"
		end

	frozen get_new_selection: WINFORMS_GRID_ITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		alias
			"get_NewSelection"
		end

end -- class WINFORMS_SELECTED_GRID_ITEM_CHANGED_EVENT_ARGS
