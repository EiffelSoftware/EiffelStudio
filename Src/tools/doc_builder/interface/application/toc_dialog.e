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
		end

feature {NONE} -- Implementation

	okay is
			-- Okay pressed
		do
			hide
			sort_toc			
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
				index_root_check.is_selected,
				include_empty_dirs_check.is_selected,
				include_no_index_check.is_selected,
				include_skipped_sub_dirs_check.is_selected,
				order_alphabetical_check.is_selected,
				description_text.text)
		end

end -- class TOC_DIALOG

