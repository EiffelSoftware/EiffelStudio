indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyValueChangedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_VALUE_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_property_value_changed_event_args

feature {NONE} -- Initialization

	frozen make_winforms_property_value_changed_event_args (changed_item: WINFORMS_GRID_ITEM; old_value: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Windows.Forms.GridItem, System.Object) use System.Windows.Forms.PropertyValueChangedEventArgs"
		end

feature -- Access

	frozen get_changed_item: WINFORMS_GRID_ITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.PropertyValueChangedEventArgs"
		alias
			"get_ChangedItem"
		end

	frozen get_old_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyValueChangedEventArgs"
		alias
			"get_OldValue"
		end

end -- class WINFORMS_PROPERTY_VALUE_CHANGED_EVENT_ARGS
