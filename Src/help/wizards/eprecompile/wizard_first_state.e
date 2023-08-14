note
	description: "Page in which the user choose where he wants to generate the sources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FIRST_STATE

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			wizard_information
		end

	WIZARD_PROJECT_SHARED

create
	make

feature -- Access

	wizard_information: WIZARD_INFORMATION

feature -- Basic Operation

	build
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

			to_precompile_libraries.pointer_motion_actions.extend (agent on_precompilable_libraries_pointer_motion (?, ?, ?, ?, ?, ?, ?, to_precompile_libraries))
			precompilable_libraries.pointer_motion_actions.extend (agent on_precompilable_libraries_pointer_motion (?, ?, ?, ?, ?, ?, ?, precompilable_libraries))

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
			choice_box.disable_item_expand (h1)

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

				-- This is the code of `set_updatable_entries' that is inlined here because
				-- the `select_actions' here expects an argument and `set_updatable_entries'
				-- does not.
			precompilable_libraries.select_actions.extend (agent (a_row: EV_MULTI_COLUMN_LIST_ROW) do change_entries end)
			precompilable_libraries.select_actions.extend (agent (a_row: EV_MULTI_COLUMN_LIST_ROW) do check_wizard_status end)
			to_precompile_libraries.select_actions.extend (agent (a_row: EV_MULTI_COLUMN_LIST_ROW) do change_entries end)
			to_precompile_libraries.select_actions.extend (agent (a_row: EV_MULTI_COLUMN_LIST_ROW) do check_wizard_status end)
		end

	proceed_with_current_info
		do
			Precursor
			if to_precompile_libraries.is_empty then
				proceed_with_new_state (create {WIZARD_CHOOSE_ONE_ERROR_STATE}.make (wizard_information))
			else
				proceed_with_new_state (create {WIZARD_FINAL_STATE}.make (wizard_information))
			end
		end

	update_state_information
			-- Check User Entries
			-- Update the two lists of precompilable and to_precompile libraries
			-- If no item have been selected, we fill an empty list
		local
			list: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			across
				to_precompile_libraries.linear_representation as l
			from
				create list.make
			loop
				list.extend (l.item)
			end
			wizard_information.set_l_to_precompile (list)
			across
				precompilable_libraries.linear_representation as l
			from
				create list.make
			loop
				list.extend (l.item)
			end
			wizard_information.set_l_precompilable (list)
			Precursor
		end

feature {NONE} -- Tools

	fill_lists
			-- Fill the EV_MULTI_COLUMN_LIST for all the compilable libraries
			-- To determine the compilable libraries, we check the $ISE_EIFFEL directory
			-- This function fill the library from *scratch*
			-- If the user has hit Back, then fill_lists_from_previous_state will be
			-- called
		local
			eiffel_directory: DIRECTORY
			current_lib: PATH
			current_lib_name: STRING_32
		do
				-- NOTE: for now `a_is_dotnet' is set to False, in future
				-- the wizard should support dotnet precompiles
			eiffel_layout.set_precompile (False, Void)
			create eiffel_directory.make_with_path (eiffel_layout.precompilation_path (False, Void))
			if eiffel_directory.exists then
				across
					eiffel_directory.entries as p
				loop
					current_lib:= p.item
					if not (current_lib.is_current_symbol or current_lib.is_parent_symbol) then
						current_lib_name := current_lib.name
						if
							current_lib_name.count >= 4 and then
							current_lib_name.substring (current_lib_name.count - 3, current_lib_name.count).same_string_general (".ecf") and then
							attached fill_ev_list_items (eiffel_directory.path.name, current_lib_name) as it
						then
							precompilable_libraries.extend (it)
						end
					end
				end
			end
		end

	fill_ev_list_items (path_lib: STRING_32; ace_name: STRING_32): EV_MULTI_COLUMN_LIST_ROW
			-- retrun an ev_multi_column_list_item with the name of the system for text
			-- and the path of the ace file for data.
			-- 'dir/lib' is the directory where the ace file should be
			-- for the ISE precompile libraries
		local
			info_lib: TUPLE [path: READABLE_STRING_GENERAL; path_exists: BOOLEAN]
			path_name: PATH
			l_conf: CONF_LOAD
			l_file: RAW_FILE
			l_target_name: STRING_32
			l_targets: STRING_TABLE [CONF_TARGET]
		do
			create path_name.make_from_string (path_lib)
			path_name := path_name.extended (ace_name)
			create l_conf.make (create {CONF_PARSE_FACTORY})
			l_conf.retrieve_configuration (path_name.name)
			if not l_conf.is_error then
				l_targets := l_conf.last_system.compilable_targets
			end
			if l_targets /= Void and l_targets.count = 1 then
				create Result
				l_targets.start
				l_target_name := l_targets.item_for_iteration.name
				create path_name.make_from_string (path_lib)
				path_name := path_name.extended (ace_name)
				create l_file.make_with_path (path_name.parent.extended ("EIFGENs").extended (l_target_name).extended ("project.epr"))

				if l_file.exists then
					info_lib := [path_name.name, True]
					Result.extend (l_conf.last_system.name)
					Result.extend (Interface_names.l_Yes)
				else
					info_lib := [path_name.name, False]
					Result.extend (l_conf.last_system.name)
					Result.extend (Interface_names.l_No)
				end
				Result.set_data (info_lib)
			else
				Result := Void
			end
		end

	fill_lists_from_previous_state
			-- Fill the "To precompile" and "precompilable"
			-- MULTI_COLUMN_LISTs when the user has previously
			-- choose its library to precompile.
			-- Can occur only if the user has pushed the Back button
		do
			fill_list_from_previous_state (to_precompile_libraries, wizard_information.l_to_precompile)
			fill_list_from_previous_state (precompilable_libraries, wizard_information.l_precompilable)
		end

	fill_list_from_previous_state (a_mc_list: EV_MULTI_COLUMN_LIST; a_list: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW])
			-- Fill `a_mc_list' with `a_list' when the user has previously
			-- choose its library to precompile.
			-- Can occur only if the user has pushed the Back button
		local
			curr_item: EV_MULTI_COLUMN_LIST_ROW
		do
			across
				a_list as l
			loop
				curr_item := l.item
				curr_item.parent.prune_all (curr_item)
				a_mc_list.extend (curr_item)
			end
		end

	add_all_items
			-- Add all the item from precompilable_libraries to to_precompile_libraries
		do
			across
				precompilable_libraries as p
			loop
				p.item.enable_select
			end
			add_b.disable_sensitive
			add_items
		ensure
			precompilable_libraries.is_empty
		end

	add_items
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			across
				precompilable_libraries.selected_items as p
			loop
				it := p.item
				precompilable_libraries.prune (it)
				to_precompile_libraries.extend (it)
			end
			add_b.disable_sensitive
		end

	remove_all_items
			-- Remove all the item from to_precompile_libraries to precompilable_libraries
		do
			across
				to_precompile_libraries as p
			loop
				p.item.enable_select
			end
			remove_b.disable_sensitive
			remove_items
		ensure
			to_precompile_libraries.is_empty
		end

	remove_items
		local
			it: EV_MULTI_COLUMN_LIST_ROW
		do
			across
				to_precompile_libraries.selected_items as p
			loop
				it := p.item
				to_precompile_libraries.prune (it)
				precompilable_libraries.extend (it)
			end
			remove_b.disable_sensitive
		end

	enable_add_b (it: EV_MULTI_COLUMN_LIST_ROW)
		do
			if precompilable_libraries.selected_item = Void then
				add_b.disable_sensitive
			else
				add_b.enable_sensitive
			end
		end

	enable_remove_b (it: EV_MULTI_COLUMN_LIST_ROW)
		do
			if to_precompile_libraries.selected_item = Void then
				remove_b.disable_sensitive
			else
				remove_b.enable_sensitive
			end
		end

	browse
			-- Launch a computer file Browser.
		local
			file_open_dialog: EV_FILE_OPEN_DIALOG
			it: EV_MULTI_COLUMN_LIST_ROW
			file_path, file_title: STRING_32
			error_dialog: EV_WARNING_DIALOG
		do
			create file_open_dialog
			file_open_dialog.filters.extend (["*.ecf", interface_names.l_eiffel_conf_file])
			file_open_dialog.show_modal_to_window (first_window)

			file_path := file_open_dialog.full_file_path.parent.name
			file_title := file_open_dialog.full_file_path.entry.name
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

	is_row_already_present (a_mc_list: EV_MULTI_COLUMN_LIST; a_row: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN
			-- Is the row `a_row' represent the same row as a row found in `a_mc_list'?
		local
			cur_row: EV_MULTI_COLUMN_LIST_ROW
			ref_ace: READABLE_STRING_GENERAL
			cur_ace: READABLE_STRING_GENERAL
			retried: BOOLEAN
		do
			if
				not retried and then
				attached {TUPLE [path: READABLE_STRING_GENERAL; path_exists: BOOLEAN]} a_row.data as ref_info_lib
			then
				ref_ace := ref_info_lib.path
				across
					a_mc_list as i
				until
					Result
				loop
					cur_row := i.item
					if attached {TUPLE [path: READABLE_STRING_GENERAL; path_exists: BOOLEAN]} cur_row.data as cur_info_lib then
						cur_ace := cur_info_lib.path
						check cur_ace_not_void: cur_ace /= Void end
						Result := ref_ace.is_case_insensitive_equal (cur_ace)
					end
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	display_state_text
		do
			title.set_text (interface_names.t_choose_libraries)
			subtitle.set_text (interface_names.t_choose_libraries_subtitle)
			message.remove_text
		end

	on_precompilable_libraries_pointer_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32; a_list: like precompilable_libraries)
			-- Handle pointer motion of `precompilable_libraries'
		require
			not_void: a_list /= Void
		local
			l_item: EV_MULTI_COLUMN_LIST_ROW
			l_found: BOOLEAN
			l_header_height: INTEGER
		do
			from
				a_list.start
				l_header_height := (create {EV_HEADER}).height -- FIXME: Cannot query header from {EV_MULTI_COLUMN_LIST} directly
			until
				a_list.after or l_found
			loop
				l_item := a_list.item_for_iteration
				if l_item.x_position <= a_x and l_item.y_position <= (a_y - l_header_height) and
					 (l_item.x_position + l_item.width) > a_x and
					 (l_item.y_position + l_item.height) > (a_y - l_header_height) then
					if attached {TUPLE [path: READABLE_STRING_GENERAL; path_exists: BOOLEAN]} l_item.data as l_info_lib then
						a_list.set_tooltip (l_info_lib.path)
					else
						check False end -- Implied by data set by `fill_ev_list_items' should not void
					end

					l_found := True
				end

				a_list.forth
			end
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

note
	ca_ignore: "CA093", "CA093: manifest array type mismatch"
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
