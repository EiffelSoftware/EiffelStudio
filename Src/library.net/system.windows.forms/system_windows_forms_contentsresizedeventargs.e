indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ContentsResizedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_CONTENTSRESIZEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_contentsresizedeventargs

feature {NONE} -- Initialization

	frozen make_contentsresizedeventargs (new_rectangle: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Windows.Forms.ContentsResizedEventArgs"
		end

feature -- Access

	frozen get_new_rectangle: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ContentsResizedEventArgs"
		alias
			"get_NewRectangle"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTENTSRESIZEDEVENTARGS
