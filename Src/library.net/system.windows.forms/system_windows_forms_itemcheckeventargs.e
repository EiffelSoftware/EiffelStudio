indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ItemCheckEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_ITEMCHECKEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_itemcheckeventargs

feature {NONE} -- Initialization

	frozen make_itemcheckeventargs (index: INTEGER; new_check_value: SYSTEM_WINDOWS_FORMS_CHECKSTATE; current_value: SYSTEM_WINDOWS_FORMS_CHECKSTATE) is
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

	frozen get_new_value: SYSTEM_WINDOWS_FORMS_CHECKSTATE is
		external
			"IL signature (): System.Windows.Forms.CheckState use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"get_NewValue"
		end

	frozen get_current_value: SYSTEM_WINDOWS_FORMS_CHECKSTATE is
		external
			"IL signature (): System.Windows.Forms.CheckState use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"get_CurrentValue"
		end

feature -- Element Change

	frozen set_new_value (value: SYSTEM_WINDOWS_FORMS_CHECKSTATE) is
		external
			"IL signature (System.Windows.Forms.CheckState): System.Void use System.Windows.Forms.ItemCheckEventArgs"
		alias
			"set_NewValue"
		end

end -- class SYSTEM_WINDOWS_FORMS_ITEMCHECKEVENTARGS
