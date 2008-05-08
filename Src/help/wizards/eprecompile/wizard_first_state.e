indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FIRST_STATE

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			wizard_information
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Access

	wizard_information: WIZARD_INFORMATION

feature -- Basic Operation

	build is
			-- Build interface
		local
			h1: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			cell: EV_CELL
			buttons_box: EV_VERTICAL_BOX
			compilable_box: EV_VERTICAL_BOX
			to_compile_box: EV_VERTICAL_BOX
		do
			create to_precompile_libraries
			create precompilable_libraries
			to_precompile_libraries.set_column_titles (<<Interface_names.l_Library_name, Interface_names.l_Done>>)
			to_precompile_libraries.set_column_widths (<<96, 40>>)
			precompilable_libraries.set_column_titles (<<Interface_names.l_Library_name, Interface_names.l_Done>>)
			precompilable_libraries.set_column_widths (<<96, 40>>)

			create add_all_b.make_with_text (Interface_names.b_Add_all)
			add_all_b.select_actions.extend (agent add_all_items)
			set_default_width_for_button (add_all_b)

			create add_b.make_with_text (Interface_names.b_Add)
			add_b.select_actions.extend (agent add_items)
			set_default_width_for_button (add_b)

			create remove_b.make_with_text (Interface_names.b_Remove)
			remove_b.select_actions.extend (agent remove_items)
			set_default_width_for_button (remove_b)

			create remove_all_b.make_with_text (Interface_names.b_Remove_all)
			remove_all_b.select_actions.extend (agent remove_all_items)
			set_default_width_for_button (remove_all_b)

			create buttons_box
			create lab.make_with_text (" ")
			buttons_box.extend (lab)
			buttons_box.disable_item_expand (lab)
			buttons_box.extend (add_all_b)
			buttons_box.disable_item_expand (add_all_b)
			buttons_box.extend (add_b)
			buttons_box.disable_item_expand (add_b)
			buttons_box.extend (remove_b)
			buttons_box.disable_item_expand (remove_b)
			buttons_box.extend (remove_all_b)
			buttons_box.disable_item_expand (remove_all_b)
			buttons_box.extend (create {EV_CELL})
			buttons_box.set_padding (Small_padding_size)
			buttons_box.set_border_width (Small_border_size)

			create compilable_box
			compilable_box.set_padding (Dialog_unit_to_pixels(3))
			create lab.make_with_text (Interface_names.l_Compilable_libraries)
			lab.align_text_left
			compilable_box.extend (lab)
			compilable_box.disable_item_expand(lab)
			compilable_box.extend (precompilable_libraries)

			create to_compile_box
			to_compile_box.set_padding (Dialog_unit_to_pixels(3))
			create lab.make_with_text (Interface_names.l_Libraries_to_compile)
			lab.align_text_left
			to_compile_box.extend(lab)
			to_compile_box.disable_item_expand(lab)
			to_compile_box.extend (to_precompile_libraries)

			create h1
			h1.extend (compilable_box)
			h1.extend (buttons_box)
			h1.disable_item_expand (buttons_box)
			h1.extend (to_compile_box)
			h1.set_border_width (1)
			choice_box.extend (h1)

				-- Add your library box.
			create add_your_own_b.make_with_text_and_action (Interface_names.b_Add_your_own_library, agent browse)
			create h1
			h1.set_border_width (Small_border_size)
			create cell
			cell.set_minimum_width (Dialog_unit_to_pixels(70))
			h1.extend (cell)
			h1.extend (add_your_own_b)
			h1.disable_item_expand (add_your_own_b)
			choice_box.extend (h1)

				-- Fill lists.
			if wizard_information.l_to_precompile /= Void then
				fill_lists_from_previous_state
			else
				fill_lists
			end

				-- Update state
			precompilable_libraries.enable_multiple_selection
			to_precompile_libraries.enable_multiple_selection
			precompilable_libraries.select_actions.extend (agent enable_add_b)
			precompilable_libraries.deselect_actions.extend (agent enable_add_b)
			to_precompile_libraries.select_actions.extend (agent enable_remove_b)
			to_precompile_libraries.deselect_actions.extend (agent enable_remove_b)

			add_b.disable_sensitive
			remove_b.disable_sensitive

			set_updatable_entries(<<precompilable_libraries.select_actions,
									to_precompile_libraries.select_actions>>)

		end

	proceed_with_current_info is
		do
			Precursor
			if to_precompile_libraries.is_empty then
				proceed_with_new_state (create {WIZARD_CHOOSE_ONE_ERROR_STATE}.make (wizard_information))
			else
				proceed_with_new_state (create {WIZARD_FINAL_STATE}.make (wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
			-- Update the two lists of precompilable and to_precompile libraries
			-- If no item have been selected, we fill an empty list
		local
			lin_list, lin_list_2: LINEAR [EV_MULTI_COLUMN_LIST_ROW]
			list: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			lin_list := to_precompile_libraries.linear_representation
			lin_list_2 := precompilable_libraries.linear_representation
			from
				lin_list.start
				create list.make
			until
				lin_list.after
			loop
				list.extend (lin_list.item)
				lin_list.forth
			end
			if list /= Void then
				wizard_information.set_l_to_precompile (list)
			else
				create list.make
				wizard_information.set_l_to_precompile (list)
			end

			from
				lin_list_2.start
				create list.make
			until
				lin_list_2.after
			loop
				list.extend (lin_list_2.item)
				lin_list_2.forth
			end
			if list /= Void then
				wizard_information.set_l_precompilable (list)
			else
				create list.make
				wizard_information.set_l_precompilable (list)
			end

			Precursor
		end

feature {NONE} -- Tools

	fill_lists is
			-- Fill the EV_MULTI_COLUMN_LIST for all the compilable libraries
			-- To determine the compilable libraries, we check the $ISE_EIFFEL directory
			-- This function fill the library from *scratch*
			-- If the user has hit Back, then fill_lists_from_previous_state will be
			-- called
		local
			it: EV_MULTI_COLUMN_LIST_ROW
			eiffel_directory: DIRECTORY
			list_of_preprecompilable_libraries: ARRAYED_LIST [STRING]
			current_lib: STRING
			current_precomp: FILE_NAME
		do
				-- NOTE: for now `a_is_dotnet' is set to False, in future
				-- the wizard should support dotnet precompiles
			create eiffel_directory.make_open_read (eiffel_layout.precomp_platform_path (False))
			if eiffel_directory.exists then
				list_of_preprecompilable_libraries:= eiffel_directory.linear_representation

				from
					list_of_preprecompilable_libraries.start
				until
					list_of_preprecompilable_libraries.after
				loop
					current_lib:= list_of_preprecompilable_libraries.item
					if not (current_lib.is_equal (".") or current_lib.is_equal ("..")) then
						if
							current_lib.count >= 4 and then
							current_lib.substring_index (".ecf", 1) = current_lib.count - 3
						then
							create current_precomp.make_from_string (eiffel_directory.name)
							it:= fill_ev_list_items (current_precomp, current_lib)
							if it /= Void then
								precompilable_libraries.extend (it)
							end
						end
					end
					list_of_preprecompilable_libraries.forth
				end
			end
		end

	fill_ev_list_items (path_lib: STRING; ace_name: STRING): EV_MULTI_COLUMN_LIST_ROW is
			-- retrun an ev_multi_column_list_item with the name of the system for text
			-- and the path of the ace file for data.
			-- 'dir/lib' is the directory where the ace file should be
			-- for the ISE precompile libraries
		local
			info_lib: TUPLE [STRING, BOOLEAN]
			path_name: FILE_NAME
			l_conf: CONF_LOAD
			l_factory: CONF_PARSE_FACTORY
			l_file: RAW_FILE
			l_target_name: STRING
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
			create path_name.make_from_string (path_lib)
			path_name.set_file_name (ace_name)
			create l_factory
			create l_conf.make (l_factory)
			l_conf.retrieve_configuration (path_name)
			if not l_conf.is_error then
				l_targets := l_conf.last_system.compilable_targets
			end
			if l_targets /= Void and l_targets.count = 1 then
				create Result
				create info_lib
				info_lib.put (path_name, 1)

				create path_name.make_from_string (path_lib)
				path_name.extend ("EIFGENs")
				l_targets.start
				l_target_name := l_targets.item_for_iteration.name
				path_name.extend (l_target_name)
				path_name.extend ("project.epr")
				create l_file.make (path_name)

				if l_file.exists then
					info_lib.put (True, 2)
					Result.extend (l_conf.last_system.name)
					Result.extend (Interface_names.l_Yes)
				else
					info_lib.put (False, 2)
					Result.extend (l_conf.last_system.name)
					Result.extend (Interface_names.l_No)
				end
				Result.set_data (info_lib)
			else
				Result := Void
			end
		end

	fill_lists_from_previous_state is
			-- Fill the "To precompile" and "precompilable"
			-- MULTI_COLUMN_LISTs when the user has previously
			-- choose its library to precompile.
			-- Can occur only if the user has pushed the Back button
		do
			fill_list_from_previous_state (to_precompile_libraries, wizard_information.l_to_precompile)
			fill_list_from_previous_state (precompilable_libraries, wizard_information.l_precompilable)
		end

	fill_list_from_previous_state (a_mc_list: EV_MULTI_COLUMN_LIST; a_list: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]) is
			-- Fill `a_mc_list' with `a_list' when the user has previously
			-- choose its library to precompile.
			-- Can occur only if the user has pushed the Back button
		local
			curr_item: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				a_list.start
			until
				a_list.after
			loop
				curr_item := a_list.item
				curr_item.parent.prune_all (curr_item)
				a_mc_list.extend (curr_item)
				a_list.forth
			end
		end

	add_all_items is
			-- Add all the item from precompilable_libraries to to_precompile_libraries
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				precompilable_libraries.start
			until
				precompilable_libraries.after
			loop
				it := precompilable_libraries.item
				it.enable_select
				precompilable_libraries.forth
			end
			add_b.disable_sensitive
			add_items
		ensure
			precompilable_libraries.is_empty
		end

	add_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			currently_selected_items := precompilable_libraries.selected_items
			from
				currently_selected_items.start
			until
				currently_selected_items.after
			loop
				it := currently_selected_items.item
				precompilable_libraries.prune (it)
				to_precompile_libraries.extend (it)
				currently_selected_items.forth
			end
			add_b.disable_sensitive
		end

	remove_all_items is
			-- Remove all the item from to_precompile_libraries to precompilable_libraries
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				to_precompile_libraries.start
			until
				to_precompile_libraries.after
			loop
				it := to_precompile_libraries.item
				it.enable_select
				to_precompile_libraries.forth
			end
			remove_b.disable_sensitive
			remove_items
		ensure
			to_precompile_libraries.is_empty
		end

	remove_items is
		local
			currently_selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW]
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			currently_selected_items := to_precompile_libraries.selected_items
			from
				currently_selected_items.start
			until
				currently_selected_items.after
			loop
				it := currently_selected_items.item
				to_precompile_libraries.prune (it)
				precompilable_libraries.extend (it)
				currently_selected_items.forth
			end
			remove_b.disable_sensitive
		end

	enable_add_b (it: EV_MULTI_COLUMN_LIST_ROW) is
		do
			if precompilable_libraries.selected_item = Void then
				add_b.disable_sensitive
			else
				add_b.enable_sensitive
			end
		end

	enable_remove_b (it: EV_MULTI_COLUMN_LIST_ROW) is
		do
			if to_precompile_libraries.selected_item = Void then
				remove_b.disable_sensitive
			else
				remove_b.enable_sensitive
			end
		end

	browse is
			-- Launch a computer file Browser.
		local
			file_open_dialog: EV_FILE_OPEN_DIALOG
			it: EV_MULTI_COLUMN_LIST_ROW
			file_path: STRING
			file_title: STRING
			error_dialog: EV_WARNING_DIALOG
		do
			create file_open_dialog
			file_open_dialog.filters.extend (["*.ecf", interface_names.l_eiffel_conf_file])
			file_open_dialog.show_modal_to_window (first_window)

			file_path := file_open_dialog.file_path
			file_title := file_open_dialog.file_title
			if not file_path.is_empty and then not file_title.is_empty then
					-- User has selected "OK"
				it := fill_ev_list_items (file_path, file_title)
				if it /= Void then
					if not is_row_already_present (to_precompile_libraries, it) and then
						not is_row_already_present (precompilable_libraries, it)
					then
						to_precompile_libraries.extend (it)
							 -- enable and disable select such that the set_updatable_entries will react
							-- and update_state_information will be called
						it.enable_select
						it.disable_select
					else
						create error_dialog.make_with_text (interface_names.m_configuration_file_is_already_listed)
						error_dialog.show_modal_to_window (first_window)
					end
				else
					create error_dialog.make_with_text (interface_names.m_configuration_file_is_not_valid)
					error_dialog.show_modal_to_window (first_window)
				end
			end
		end

	is_row_already_present (a_mc_list: EV_MULTI_COLUMN_LIST; a_row: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN is
			-- Is the row `a_row' represent the same row as a row found in `a_mc_list'?
		local
			cur_row: EV_MULTI_COLUMN_LIST_ROW
			cur_info_lib: TUPLE [STRING, BOOLEAN]
			ref_info_lib: TUPLE [STRING, BOOLEAN]
			ref_ace: STRING
			cur_ace: STRING
			retried: BOOLEAN
		do
			if not retried then
				ref_info_lib ?= a_row.data
				check ref_info_lib_not_void: ref_info_lib /= Void end
				ref_ace ?= ref_info_lib.item (1)
				check ref_ace_not_void: ref_ace /= Void end
				ref_ace := ref_ace.as_lower
				from
					a_mc_list.start
				until
					Result or a_mc_list.after
				loop
					cur_row := a_mc_list.item
					cur_info_lib ?= cur_row.data
					check cur_info_lib_not_void: cur_info_lib /= Void end
					cur_ace ?= cur_info_lib.item (1)
					check cur_ace_not_void: cur_ace /= Void end
					Result := ref_ace.is_equal (cur_ace.as_lower)

					a_mc_list.forth
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (interface_names.t_choose_libraries)
			subtitle.set_text (interface_names.t_choose_libraries_subtitle)
			message.remove_text
		end

	error_no_ace: BOOLEAN
			-- Is there an ace file in the library directory

	precompilable_libraries: EV_MULTI_COLUMN_LIST
			-- List of precombilable libraries

	to_precompile_libraries: EV_MULTI_COLUMN_LIST
			-- List of libraries to precompile

	remove_b, add_b, remove_all_b, add_all_b: EV_BUTTON

	add_your_own_b: EV_BUTTON;
			-- button to let the user add his own library

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
end -- class wizard_first_state
