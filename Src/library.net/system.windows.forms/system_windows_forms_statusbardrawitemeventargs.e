indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBarDrawItemEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTARGS

inherit
	SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTARGS

create
	make_statusbardrawitemeventargs

feature {NONE} -- Initialization

	frozen make_statusbardrawitemeventargs (g: SYSTEM_DRAWING_GRAPHICS; font: SYSTEM_DRAWING_FONT; r: SYSTEM_DRAWING_RECTANGLE; item_id: INTEGER; item_state: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE; panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState, System.Windows.Forms.StatusBarPanel) use System.Windows.Forms.StatusBarDrawItemEventArgs"
		end

feature -- Access

	frozen get_panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBarDrawItemEventArgs"
		alias
			"get_Panel"
		end

end -- class SYSTEM_WINDOWS_FORMS_STATUSBARDRAWITEMEVENTARGS
