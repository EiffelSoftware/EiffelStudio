indexing
	description: "Miscellaneous actions applicable to error reports."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_ACTIONS
		
inherit
	SHARED_OBJECTS

create {ERROR_REPORT}
	default_create

feature -- Actions

	highlight_text_in_editor (a_line_no, a_line_pos: INTEGER) is
			-- Highlight error in editor
		local
			l_current_widget: DOCUMENT_TEXT_WIDGET
		do
			l_current_widget := shared_document_editor.current_widget.internal_edit_widget
			l_current_widget.highlight_error_pos (a_line_no, a_line_pos)
			l_current_widget.set_focus
		end
		
	load_file_in_editor (a_filename: STRING) is
			-- Load file in editor
		require
			filename_not_void: a_filename /= Void
		do
			Shared_document_manager.load_document_from_file (a_filename)
		end

end -- class ERROR_ACTIONS
