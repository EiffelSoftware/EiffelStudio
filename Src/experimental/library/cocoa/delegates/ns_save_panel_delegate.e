note
	description: "Wrapper for delegate methods of NSSavePanel."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_SAVE_PANEL_DELEGATE

inherit
	NS_OBJECT

feature


	panel_should_show_filename (a_sender: NS_OBJECT; a_filename: NS_STRING): BOOLEAN
		do
		end

--	panel_compare_filename_with_case_sensitive (a_sender: NS_OBJECT; a_name1: NS_STRING; a_name2: NS_STRING; a_case_sensitive: BOOLEAN): NS_COMPARISON_RESULT
--		do
--		end

	panel_is_valid_filename (a_sender: NS_OBJECT; a_filename: NS_STRING): BOOLEAN
		do
		end

	panel_user_entered_filename_confirmed (a_sender: NS_OBJECT; a_filename: NS_STRING; a_ok_flag: BOOLEAN): NS_STRING
		do
		end

	panel_will_expand (a_sender: NS_OBJECT; a_expanding: BOOLEAN)
		do
		end

	panel_directory_did_change (a_sender: NS_OBJECT; a_path: NS_STRING)
		do
		end

	panel_selection_did_change (a_sender: NS_OBJECT)
		do
		end

feature {NONE} -- Implementation

	frozen save_panel_panel_should_show_filename (a_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
		do
		end

	frozen save_panel_panel_compare_filename_with_case_sensitive (a_save_panel: POINTER; a_sender: POINTER; a_name1: POINTER; a_name2: POINTER; a_case_sensitive: BOOLEAN): POINTER
		do
		end

	frozen save_panel_panel_is_valid_filename (a_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER): BOOLEAN
		do
		end

	frozen save_panel_panel_user_entered_filename_confirmed (a_save_panel: POINTER; a_sender: POINTER; a_filename: POINTER; a_ok_flag: BOOLEAN): POINTER
		do
		end

	save_panel_panel_will_expand (a_save_panel: POINTER; a_sender: NS_OBJECT; a_expanding: BOOLEAN)
		do
		end

	save_panel_panel_directory_did_change (a_save_panel: POINTER; a_sender: POINTER; a_path: POINTER)
		do
		end

	save_panel_panel_selection_did_change (a_save_panel: POINTER; a_sender: POINTER)
		do
		end
end
