indexing
	description: "Interface for editor related icons"
	date       : "$Date$"
	revision   : "$Revision$"
	
deferred class
    EDITOR_ICONS

feature -- Cursor

	header_left_scroll_pixmap: EV_PIXMAP is
		deferred
		ensure
			result_not_void: Result /= Void
		end

	header_right_scroll_pixmap: EV_PIXMAP is
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	header_close_current_document_pixmap: EV_PIXMAP is
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
end -- class EDITOR_ICONS
