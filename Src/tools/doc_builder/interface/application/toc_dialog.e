indexing
	description: "Dialog for filtering and sorting table of contents structures."
	date: "$Date$"
	revision: "$Revision$"

class
	TOC_DIALOG

inherit
	TOC_DIALOG_IMP

	SHARED_OBJECTS
		undefine
			default_create,
			copy
		end


feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do			
			okay_button.select_actions.extend (agent okay)
			cancel_button.select_actions.extend (agent hide)
			populate_filter_combo
		end

feature {NONE} -- Implementation

	populate_filter_combo is
			-- Populate filter combo
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_list_item: EV_LIST_ITEM
		do			
			if shared_project.filter_manager /= Void then
				l_filters := shared_project.filter_manager.filters
				filter_combo.wipe_out
				from
					l_filters.start
				until
					l_filters.after
				loop
					create l_list_item.make_with_text (l_filters.key_for_iteration.twin)					
					l_list_item.set_data (l_filters.key_for_iteration.twin)
					filter_combo.extend (l_list_item)					
					l_filters.forth
				end
			end			
		end

	okay is
			-- Okay pressed
		local
			l_qdlg: EV_QUESTION_DIALOG
		do
			create l_qdlg.make_with_text ("To ensure accurate toc generation all project files%Nmust be both XML and schema valid.%N%
				%Would you like to validate the project files first?")
			l_qdlg.show_modal_to_window (application_window)
			if l_qdlg.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_yes) then
				shared_project.validate_files
				if not shared_project.has_invalid_files then
					hide
					sort_toc
				end
			else
				hide
				sort_toc
			end
		end		

	sort_toc is
			-- Sort new toc from selected options
		local
			l_filter: DOCUMENT_FILTER
		do
			Shared_constants.Application_constants.set_index_file_name (index_filename_text.text)
			l_filter := Shared_project.filter_manager.filter_by_description (filter_combo.selected_item.text)
			Shared_project.filter_manager.set_filter (l_filter)
			Shared_toc_manager.sort_toc (
				l_filter,
				index_root_check.is_selected,
				include_empty_dirs_check.is_selected,
				include_no_index_check.is_selected,
				include_skipped_sub_dirs_check.is_selected,
				order_alphabetical_check.is_selected,
				description_text.text)
		end

end -- class TOC_DIALOG

