indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SelectedGridItemChangedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_SELECTEDGRIDITEMCHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_selectedgriditemchangedeventargs

feature {NONE} -- Initialization

	frozen make_selectedgriditemchangedeventargs (old_sel: SYSTEM_WINDOWS_FORMS_GRIDITEM; new_sel: SYSTEM_WINDOWS_FORMS_GRIDITEM) is
		external
			"IL creator signature (System.Windows.Forms.GridItem, System.Windows.Forms.GridItem) use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		end

feature -- Access

	frozen get_old_selection: SYSTEM_WINDOWS_FORMS_GRIDITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		alias
			"get_OldSelection"
		end

	frozen get_new_selection: SYSTEM_WINDOWS_FORMS_GRIDITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.SelectedGridItemChangedEventArgs"
		alias
			"get_NewSelection"
		end

end -- class SYSTEM_WINDOWS_FORMS_SELECTEDGRIDITEMCHANGEDEVENTARGS
