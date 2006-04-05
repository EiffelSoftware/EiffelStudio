indexing
	description: "Dialog for start generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_DIALOG

inherit
	GENERATION_DIALOG_IMP	

	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do			
			finish_button.select_actions.extend (agent run)
			cancel_button.select_actions.extend (agent cancel)
			transform_file_combo.select_actions.extend (agent conversion_combo_changed)
			filter_option_combo.select_actions.extend (agent filter_combo_changed)
			browse_button.select_actions.extend (agent browse_location)
			html_radio.select_actions.extend (agent help_type_changed)
			vs_radio.select_actions.extend (agent help_type_changed)
			web_radio.select_actions.extend (agent help_type_changed)
			populate_widgets
			help_type_changed
		end

feature -- Status Setting

	browse_location is
			-- Browse disk directory structure.  Write chosen location to `location_text'
		local
			l_directory_dialog: EV_DIRECTORY_DIALOG
		do
			create l_directory_dialog
			l_directory_dialog.show_modal_to_window (Current)
			if l_directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				location_text.set_text (l_directory_dialog.directory)
				generation_data.set_generated_file_location (l_directory_dialog.directory)
			end
		end	

feature {NONE} -- Query

	is_html: BOOLEAN is
			-- Is html generation?
		do
			Result := transform_file_combo.selected_item.text.is_equal ("html")
		end	
		
	is_help: BOOLEAN is
			-- Is help project generation?
		do
			Result := transform_file_combo.selected_item.text.is_equal ("help project")
		end

	options_valid: BOOLEAN is
			-- Are options valid?
		do
			Result := True
			shared_error_reporter.set_error (Void)
			
				-- Test for output directory
			if location_text.text.is_empty then
				shared_error_reporter.set_error (create {ERROR}.make ("No output location specified."))	
			end
			
				-- Test for help specific details
			if is_help then
				if help_name_text.text.is_empty then
					shared_error_reporter.set_error (create {ERROR}.make ("Name for help project is required."))
				end
				if Shared_toc_manager.is_empty then
					shared_error_reporter.set_error (create {ERROR}.make ("No table of content defined."))
				end		
				if toc_list.selected_items.is_empty then
					shared_error_reporter.set_error (create {ERROR}.make ("You must choose at least one table of contents %
						%from which to generate the help structure."))						
				end
				if web_radio.is_selected and then filter_list.selected_items.is_empty then
					shared_error_reporter.set_error (create {ERROR}.make ("You must choose at least one document filter type %
						%to generate web based help."))
				end
			end
			
			Result := shared_error_reporter.error = Void
		end	

feature {NONE} -- GUI

	populate_widgets is
			-- Build widgets with data
		do
			populate_file_combo			
			populate_toc_widgets
			populate_filter_widgets
		end		
		
	populate_file_combo is
			-- Populate file type combo
		do
			transform_file_combo.wipe_out
			transform_file_combo.extend (create {EV_LIST_ITEM}.make_with_text ("html"))
			transform_file_combo.extend (create {EV_LIST_ITEM}.make_with_text ("help project"))
		end

feature {NONE} -- Filter UI
	
	populate_filter_widgets is
			-- Populate filter widgets
		do
			populate_filter_combos
			populate_filter_list
		end		
	
	populate_filter_combos is
			-- Populate filter combo
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_list_item: EV_LIST_ITEM
		do			
			if shared_project.filter_manager /= Void then
				l_filters := shared_project.filter_manager.filters
				filter_option_combo.wipe_out
				web_filter_option_combo.wipe_out
				from
					l_filters.start
				until
					l_filters.after
				loop
					create l_list_item.make_with_text (l_filters.key_for_iteration.twin)					
					l_list_item.set_data (l_filters.item_for_iteration)
					filter_option_combo.extend (l_list_item)					
					create l_list_item.make_with_text (l_filters.key_for_iteration.twin)					
					l_list_item.set_data (l_filters.item_for_iteration)
					web_filter_option_combo.extend (l_list_item)
					l_filters.forth
				end
				web_filter_option_combo.select_actions.extend (agent filter_toc_option_selected)
				web_filter_option_combo.disable_sensitive
			end			
		end

	populate_filter_list is
			-- Populate filter list
		local
			l_filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			l_list_row: EV_MULTI_COLUMN_LIST_ROW			
			l_default_toc_name: STRING
		do			
			if shared_project.filter_manager /= Void then
				filter_list.select_actions.force_extend (agent filter_list_item_selected)
				filter_list.set_column_titles (<<"Description", "Associated TOC">>)
				filter_list.set_column_widths (<<150, 150>>)
				l_filters := shared_project.filter_manager.filters
				if not shared_toc_manager.displayed_tocs.is_empty then
					l_default_toc_name := shared_toc_manager.displayed_tocs.item (1)
				else
					l_default_toc_name := ""
				end
				from
					l_filters.start
				until
					l_filters.after
				loop
					create l_list_row
					l_list_row.extend (l_filters.key_for_iteration)
					l_list_row.extend (l_default_toc_name)
					l_list_row.set_data (l_filters.item_for_iteration)
					filter_list.extend (l_list_row)
					l_filters.forth
				end
			end
		end

	filter_combo_changed is
			-- Filter type combo was changed
		local
			l_description: STRING
			l_filter: OUTPUT_FILTER
		do
			l_description := filter_option_combo.selected_item.text
			l_filter ?= shared_project.filter_manager.filter_by_description (l_description)
			shared_project.filter_manager.set_filter (l_filter)
		end	

	filter_list_item_selected is
			-- A filter list item was selected
		do
			if filter_list.selected_items.count > 1 then
				web_toc_option_combo.disable_sensitive
			else
				web_toc_option_combo.enable_sensitive				
			end	
		end		
		
	filter_toc_option_selected (a_item: EV_LIST_ITEM) is
			-- A filter type was chosen for a toc in the list
		local
			l_toc: TABLE_OF_CONTENTS
			l_filter: DOCUMENT_FILTER
		do
			l_toc ?= toc_list.selected_item.data
			l_filter ?= a_item.data
			if l_toc /= Void and l_filter /= Void then
				l_toc.set_filter (l_filter)
				toc_list.selected_item.put_i_th (l_filter.description, 2)	
			end
		end		

feature -- TOC UI

		
	populate_toc_widgets is
			-- Populate toc widgets
		do
			populate_toc_list
			populate_toc_combo
		end

	populate_toc_list is
			-- Populate toc list
		local
			l_list_row: EV_MULTI_COLUMN_LIST_ROW
			l_tocs: ARRAY [STRING]
			l_manager: TABLE_OF_CONTENTS_MANAGER
			l_cnt: INTEGER
			l_toc: TABLE_OF_CONTENTS
		do
			l_manager := Shared_toc_manager
			toc_list.select_actions.force_extend (agent toc_list_item_selected)
			toc_list.set_column_titles (<<"Table of Contents", "Document filter">>)
			toc_list.set_column_widths (<<150, 150>>)
			from				
				toc_list.wipe_out
				l_tocs := l_manager.displayed_tocs
				l_cnt := 1
			until
				l_cnt > l_tocs.count
			loop
				l_toc := l_manager.toc_by_name (l_tocs.item (l_cnt))
				create l_list_row
				l_list_row.extend (l_tocs.item (l_cnt))			
				l_list_row.extend (l_toc.filter.description)
				l_list_row.set_data (l_toc)
				toc_list.extend (l_list_row)
				l_cnt := l_cnt + 1
			end
		end

	populate_toc_combo is
			-- Populate toc combo
		local
			l_list_item: EV_LIST_ITEM
			l_cnt: INTEGER			
			l_manager: TABLE_OF_CONTENTS_MANAGER
			l_tocs: ARRAY [STRING]
		do			
			l_manager := Shared_toc_manager
			from				
				web_toc_option_combo.wipe_out
				l_tocs := l_manager.displayed_tocs
				l_cnt := 1
			until
				l_cnt > l_tocs.count
			loop
				create l_list_item.make_with_text (l_tocs.item (l_cnt))
				l_list_item.set_data (l_manager.toc_by_name (l_tocs.item (l_cnt)))
				web_toc_option_combo.extend (l_list_item)				
				l_cnt := l_cnt + 1
			end
			web_toc_option_combo.select_actions.extend (agent toc_filter_option_selected)
		end

	toc_list_item_selected is
			-- A toc list item was selected
		do
			if toc_list.selected_items.count > 1 then
				web_filter_option_combo.disable_sensitive
			else
				web_filter_option_combo.enable_sensitive				
			end	
		end

	toc_filter_option_selected (a_item: EV_LIST_ITEM) is
			-- A toc was chosen for association with a filter
		do	
			filter_list.selected_item.put_i_th (a_item.text, 2)
		end		

feature {NONE} -- Implementation

	cancel is
			-- Cancel
		do
			hide	
		end		
		
	run is
			-- Run
		local
			l_html_dir, l_toc_dir: DIRECTORY					
		do
			if options_valid then
				if is_help then
					generation_data.set_conversion_type (generation_data.to_html_to_help)						
					
						-- For [XML -> HTML] put HTML into intermediate directory					
					create l_html_dir.make (shared_constants.application_constants.temporary_html_directory)
					if l_html_dir.exists then
						l_html_dir.recursive_delete
					end
					l_html_dir.create_dir
					
						-- For [HTML -> Help] put Help into intermediate directory					
					create l_toc_dir.make (shared_constants.application_constants.temporary_html_directory)
					if l_toc_dir.exists then
						l_toc_dir.recursive_delete
					end
					l_toc_dir.create_dir
					
					shared_constants.help_constants.set_help_project_name (help_name_text.text)
					
					if vs_radio.is_selected then
						shared_constants.help_constants.set_help_type (shared_constants.help_constants.vsip_help)
					elseif html_radio.is_selected then
						shared_constants.help_constants.set_help_type (shared_constants.help_constants.html_help)						
					elseif web_radio.is_selected then
						if tree_web_help_radio.is_selected then							
							shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_tree)												
						else		
							shared_constants.help_constants.set_help_type (shared_constants.help_constants.web_help_simple)																		
						end
					end					
				elseif is_html then
					generation_data.set_conversion_type (generation_data.to_html)				
				end				
				generate		
				hide
			else
				shared_error_reporter.show
			end			
		end	

	generate is
			-- Generate
		local
			l_generator: FINAL_GENERATOR
			l_toc: TABLE_OF_CONTENTS
			l_tocs: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			l_filters: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			create l_generator
			if not web_radio.is_selected then	
				if toc_list.is_sensitive then
					l_toc ?= toc_list.selected_item.data
					shared_project.filter_manager.set_filter (l_toc.filter)
					shared_constants.help_constants.set_help_toc (l_toc)				
				end					
				l_generator.generate
			else
					-- For web output we must associated filters chosen with tocs
				from
					generation_data.filter_toc_hash.clear_all
					l_filters := filter_list.selected_items
					l_filters.start
				until
					l_filters.after
				loop	
					generation_data.filter_toc_hash.extend (l_filters.item.i_th (2), l_filters.item.i_th (1))
					l_filters.forth					
				end
				
					-- For web output we may have to generate more than 1 toc
				from 
					l_tocs := toc_list.selected_items
					l_tocs.start
				until
					l_tocs.after
				loop					
					l_toc ?= l_tocs.item.data
					shared_project.filter_manager.set_filter (l_toc.filter)
					shared_constants.help_constants.set_help_toc (l_toc)	
					l_generator.generate
					l_tocs.forth
				end
			end
		end		

	conversion_combo_changed is
			-- Conversion type combo was changed
		do
			if is_help then
				help_frame.enable_sensitive
				filter_option_combo.disable_sensitive
			else
				help_frame.disable_sensitive
				filter_option_combo.enable_sensitive
			end	
		end		

	help_type_changed is
			-- Help type was changed
		do
			if web_radio.is_selected then				
				toc_list.enable_multiple_selection				
				filter_list.enable_multiple_selection
				help_filter_box.show
				web_toc_type_box.show
			else
				toc_list.disable_multiple_selection
				help_filter_box.hide
				web_toc_type_box.hide
			end
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
end -- class GENERATION_DIALOG

