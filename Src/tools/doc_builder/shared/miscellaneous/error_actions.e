indexing
	description: "Miscellaneous actions applicable to error reports."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_ACTIONS

inherit
	SHARED_OBJECTS

feature -- Access

	highlight_error (a_item: EV_LIST_ITEM) is
			-- Highlight error in editor
		require
			item_not_void: a_item /= Void
		local
			curr_doc: DOCUMENT
			l_no, l_pos: INTEGER
		do
			curr_doc := Shared_document_editor.current_document
			l_no := Shared_dialogs.error_dialog.line_data (a_item.text).integer_32_item (1)
			l_pos := Shared_dialogs.error_dialog.line_data (a_item.text).integer_32_item (2)
--			a_item.pointer_double_press_actions.force_extend (agent curr_doc.widget.highlight_error (l_no, l_pos))
		end
		
	load_file (a_item: EV_LIST_ITEM) is
			-- Load file in editor
		require
			item_not_void: a_item /= Void
		do
			a_item.pointer_double_press_actions.force_extend (agent Shared_document_manager.load_document_from_file (a_item.text))
		end

end -- class ERROR_ACTIONS
