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
		
	highlight_text_byte_in_editor (a_byte_pos: INTEGER) is
			-- Highlight error in editor based on byte position
		local
			l_current_widget: DOCUMENT_TEXT_WIDGET
		do
			l_current_widget := shared_document_editor.current_widget.internal_edit_widget
			l_current_widget.select_region (a_byte_pos - 1, a_byte_pos)
			l_current_widget.set_focus
		end
		
	load_file_in_editor (a_filename: STRING) is
			-- Load file in editor
		require
			filename_not_void: a_filename /= Void
		do
			Shared_document_manager.load_document_from_file (a_filename)
		end

	search_for_error_text (a_text: STRING) is
			-- Search for error text
		require
			text_not_void: a_text /= Void
		do
			shared_dialogs.search_dialog.search_text.set_text (a_text)
			shared_dialogs.search_dialog.search
		end

end -- class ERROR_ACTIONS
