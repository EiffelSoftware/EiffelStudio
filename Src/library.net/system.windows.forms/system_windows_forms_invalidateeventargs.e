indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.InvalidateEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_INVALIDATEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_invalidateeventargs

feature {NONE} -- Initialization

	frozen make_invalidateeventargs (invalid_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Rectangle) use System.Windows.Forms.InvalidateEventArgs"
		end

feature -- Access

	frozen get_invalid_rect: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.InvalidateEventArgs"
		alias
			"get_InvalidRect"
		end

end -- class SYSTEM_WINDOWS_FORMS_INVALIDATEEVENTARGS
