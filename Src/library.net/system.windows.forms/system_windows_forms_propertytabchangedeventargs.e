indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyTabChangedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_propertytabchangedeventargs

feature {NONE} -- Initialization

	frozen make_propertytabchangedeventargs (old_tab: SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB; new_tab: SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB) is
		external
			"IL creator signature (System.Windows.Forms.Design.PropertyTab, System.Windows.Forms.Design.PropertyTab) use System.Windows.Forms.PropertyTabChangedEventArgs"
		end

feature -- Access

	frozen get_new_tab: SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB is
		external
			"IL signature (): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyTabChangedEventArgs"
		alias
			"get_NewTab"
		end

	frozen get_old_tab: SYSTEM_WINDOWS_FORMS_DESIGN_PROPERTYTAB is
		external
			"IL signature (): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyTabChangedEventArgs"
		alias
			"get_OldTab"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYTABCHANGEDEVENTARGS
