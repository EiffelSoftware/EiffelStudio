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
			l_name: STRING
			l_filters: ARRAYED_LIST [DOCUMENT_FILTER]
		do
			Shared_constants.Application_constants.set_index_file_name (index_filename_text.text)
			if filter_combo.selected_item.text.is_equal ("EiffelStudio Filtered") then
				l_name := "EiffelStudio"
			elseif filter_combo.selected_item.text.is_equal ("ENViSioN! Filtered") then
				l_name := "ENViSioN!"
			elseif filter_combo.selected_item.text.is_equal ("Unfiltered") then
				l_name := "Unfiltered"
			end
			l_filters := Shared_project.filter_manager.filters
			from
				l_filters.start
			until
				l_filters.after
			loop
				if l_filters.item.description.is_equal (l_name) then
					Shared_project.filter_manager.set_filter (l_filters.item)
				end
				l_filters.forth
			end			
			Shared_toc_manager.sort_toc (
				index_root_check.is_selected,
				include_empty_dirs_check.is_selected,
				include_no_index_check.is_selected,
				include_skipped_sub_dirs_check.is_selected,
				order_alphabetical_check.is_selected)
		end

end -- class TOC_DIALOG

