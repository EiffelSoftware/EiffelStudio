indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LayoutEventArgs"

frozen external class
	SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_layouteventargs

feature {NONE} -- Initialization

	frozen make_layouteventargs (affected_control: SYSTEM_WINDOWS_FORMS_CONTROL; affected_property: STRING) is
		external
			"IL creator signature (System.Windows.Forms.Control, System.String) use System.Windows.Forms.LayoutEventArgs"
		end

feature -- Access

	frozen get_affected_property: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.LayoutEventArgs"
		alias
			"get_AffectedProperty"
		end

	frozen get_affected_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.LayoutEventArgs"
		alias
			"get_AffectedControl"
		end

end -- class SYSTEM_WINDOWS_FORMS_LAYOUTEVENTARGS
