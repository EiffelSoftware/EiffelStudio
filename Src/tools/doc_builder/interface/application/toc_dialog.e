indexing
	description: "Dialog for filtering and sorting table of contents structures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class TOC_DIALOG

