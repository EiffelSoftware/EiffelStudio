indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyTabChangedEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_TAB_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_property_tab_changed_event_args

feature {NONE} -- Initialization

	frozen make_winforms_property_tab_changed_event_args (old_tab: WINFORMS_PROPERTY_TAB; new_tab: WINFORMS_PROPERTY_TAB) is
		external
			"IL creator signature (System.Windows.Forms.Design.PropertyTab, System.Windows.Forms.Design.PropertyTab) use System.Windows.Forms.PropertyTabChangedEventArgs"
		end

feature -- Access

	frozen get_new_tab: WINFORMS_PROPERTY_TAB is
		external
			"IL signature (): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyTabChangedEventArgs"
		alias
			"get_NewTab"
		end

	frozen get_old_tab: WINFORMS_PROPERTY_TAB is
		external
			"IL signature (): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyTabChangedEventArgs"
		alias
			"get_OldTab"
		end

end -- class WINFORMS_PROPERTY_TAB_CHANGED_EVENT_ARGS
