note
	description	: "Final state for the precompilation wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info,
			wizard_information
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as exec_command_line
		undefine
			default_create
		end

	WIZARD_PROJECT_SHARED
		undefine
			default_create
		end

create
	make

feature -- Access

	wizard_information: WIZARD_INFORMATION
			-- Information about current state.

feature -- Basic Operations

	build_finish
			-- Build user entries.
		local
			cell: EV_CELL
		do
			choice_box.wipe_out
			choice_box.set_border_width (Default_border_size)
			choice_box.set_padding (Small_padding_size)

			create progress
			progress.set_minimum_height (Dialog_unit_to_pixels(20))
			progress.set_minimum_width (Dialog_unit_to_pixels(100))
			create progress_text
			progress_text.align_text_left
			progress.set_background_color (white_color)
			progress.set_foreground_color (white_color)
			progress_text.set_background_color (white_color)

			create progress_2
			progress_2.set_minimum_height(Dialog_unit_to_pixels(20))
			progress_2.set_minimum_width(Dialog_unit_to_pixels(100))
			create progress_text_2
			progress_text_2.align_text_left
			progress_2.set_background_color (white_color)
			progress_2.set_foreground_color (white_color)
			progress_text_2.set_background_color (white_color)

			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)
			choice_box.extend(progress_2)
			choice_box.disable_item_expand(progress_2)
			choice_box.extend(progress_text_2)
			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)

			choice_box.set_background_color (white_color)
		end


	proceed_with_current_info
		local
			mess: EV_INFORMATION_DIALOG
		do
			build_finish
			first_window.disable_next_button
			first_window.disable_back_button

			if not first_window.is_destroyed then
				first_window.unlock_update
			end

			launch_precompilations
			create mess.make_with_text (final_message)
			mess.show_modal_to_window (first_window)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text
		do
			title.set_text (interface_names.t_launch_precompilations)
			message.set_text (interface_names.m_precompilation_will_be_launch)
		end

	final_message: STRING_32
			-- final message for the last message dialog at the end of all the precompilations
		do
			Result:= interface_names.m_precompilation_done
		end

	launch_precompilations
			-- Launch all the choosen precompilations
		local
			current_it: EV_MULTI_COLUMN_LIST_ROW
			lib_info: TUPLE [path: READABLE_STRING_GENERAL; path_exists: BOOLEAN]
			sys_name: READABLE_STRING_GENERAL
			ace_path: READABLE_STRING_GENERAL
			already_precompiled: BOOLEAN
			rescued: BOOLEAN
			error_dialog: EV_ERROR_DIALOG
		do
			if not rescued then
				progress.set_proportion (0)
				progress_2.set_proportion (0)
				progress_text.set_text (interface_names.l_total_progress)
				progress_text_2.set_text (interface_names.l_preparing_precompilation)

				from
					wizard_information.l_to_precompile.start
					n_lib_to_precompile:= wizard_information.l_to_precompile.count
					n_lib_done:= 0
				until
					wizard_information.l_to_precompile.after
				loop
					current_it:= wizard_information.l_to_precompile.item
					sys_name := current_it.i_th (1)
					lib_info ?= current_it.data
					ace_path := lib_info.path
					already_precompiled := lib_info.path_exists

					precompile (sys_name.as_string_32, ace_path.as_string_32, already_precompiled)
					wizard_information.l_to_precompile.forth
				end
			end
		rescue
			rescued := True
			create error_dialog.make_with_text (interface_names.m_internal_error_occurred)
			error_dialog.show_modal_to_window (first_window)
			retry
		end

	precompile (lib_name, lib_ace: STRING_32; lib_compiled: BOOLEAN)
			-- Launch the precompilation for the library 'lib_name'
			-- Using the ace file 'lib_ace'
			-- If the library is already compiled, in 'lib_compiled' then
			-- the previous EIFGEN will be deleted.
		require
			lib_exists: lib_name /= Void and then lib_ace /= Void
		local
			time_left: INTEGER
			new_time_left: INTEGER
			command: STRING_32
			total_prog: INTEGER
			progress_file_path: PATH
			eifgen_path: PATH
			l_process_factory: PROCESS_FACTORY
			l_process: PROCESS
		do
				-- Create the callback file
			create eifgen_path.make_from_string (lib_ace)
			eifgen_path := eifgen_path.parent
			progress_file_path := eifgen_path.extended ("EIFGENs").extended (Progress_filename)

				-- Launch the precompilation and update the progress bars.
			from
				compt := 1 -- Not needed if the file is used....
				time_left := 0
				progress_text_2.set_text (interface_names.l_precompiling_library (lib_name))
				create command.make (50)
				command.append_character ('"')
				command.append (eiffel_layout.ec_command_name.name)
				command.append ("%" ")
				command.append (" -precompile -config %"")
				command.append (lib_ace)
				command.append ("%" -project_path %"")
				command.append (eifgen_path.name)
				command.append ("%" -output_file %"")
				command.append (progress_file_path.name)
				command.append ("%" -c_compile -clean")
				create l_process_factory
				l_process := l_process_factory.process_launcher_with_command_line (command, Void)
				l_process.set_hidden (True)
				l_process.launch
			until
				l_process.has_exited
			loop
				new_time_left := find_time (progress_file_path)
				if new_time_left /= -1 then
					if new_time_left >= 100 then
						time_left := 100
					else
						time_left := time_left.max (new_time_left)
					end
				end
					-- We truncate percentage to 0.9 because the remaining 0.1 are for the C compilation which is
					-- not included.
				progress_2.set_proportion (((time_left / 100) * 0.9).truncated_to_real)
				progress_text_2.set_text (interface_names.l_precompiling_library (lib_name) + ((time_left * 90) // 100).out + "%%")

				total_prog := ((time_left * 0.9 + 100*n_lib_done)/(n_lib_to_precompile)).floor
				progress.set_proportion (((time_left * 0.9 + 100*n_lib_done)/(100*n_lib_to_precompile)).truncated_to_real)
				progress_text.set_text (interface_names.l_total_progress_is (total_prog.out))
			end
			n_lib_done := n_lib_done + 1
		end

	find_time (progress_file_path: PATH): INTEGER
			-- Check the progress file to determine the current progress of the precompilation
			-- The function will check the project file in the directory 'project_path'
		require
			progress_file_path_valid: progress_file_path /= Void
		local
			fi: PLAIN_TEXT_FILE
			s: STRING
			retried: BOOLEAN
			curr_degree: INTEGER
			curr_percent: INTEGER
		do
			if not retried then
				current_application.sleep (100)
				current_application.process_events

				create fi.make_with_path (progress_file_path)
				if fi.exists then
					fi.open_read
					fi.read_stream (fi.count)
					s := fi.last_string
					fi.close
					if s.is_equal ("finished") or s.is_equal ("finished%N") then
						Result := 100
						fi.delete
					else
						curr_degree := degree_from_output (s)
						curr_percent := percentage_from_output (s)
						if curr_degree /= -1 and curr_percent /= -1 then
							Result := (((6 - curr_degree)* 100 + curr_percent) // 7).min(99)
						else
							Result := -1
						end
					end
				else
					Result := -1
				end
			else
				Result := -1
			end
		rescue
			retried := True
			retry
		end

	degree_from_output (a_output_string: STRING): INTEGER
			-- Return a degree between 6 and 0 if everything went ok,
			-- -1 otherwise.
		local
			tab_index: INTEGER
			degree_substring: STRING
		do
			tab_index := a_output_string.index_of('%T', 1)
			if tab_index > 1 then
				degree_substring := a_output_string.substring (1, tab_index - 1)
				if degree_substring.is_integer then
					Result := degree_substring.to_integer
				end
			end

			if Result = -1 then
				Result := 1
			elseif Result = -2 then
				Result := 0
			end

			if Result > 6 or Result < 0 then
				Result := -1
			end
		ensure
			Result_valid: (Result <= 6 and Result >= 0) or (Result = -1)
		end

	percentage_from_output (a_output_string: STRING): INTEGER
			-- Return a percentage between 100 and 0 if everything went ok,
			-- -1 otherwise.
		local
			tab_index: INTEGER
			percentage_substring: STRING
		do
			Result := -1
			tab_index := a_output_string.index_of('%T', 1)
			percentage_substring := a_output_string.substring (tab_index + 1, a_output_string.count - 2)
			if percentage_substring.is_integer then
				Result := percentage_substring.to_integer
				if Result > 100 or Result < 0 then
					Result := -1
				end
			end
		ensure
			Result_valid: (Result <= 100 and Result >= 0) or (Result = -1)
		end

feature -- Access

	pixmap_icon_location: PATH
			-- Icon for the Eiffel Precompile Wizard.
		once
			create Result.make_from_string ("eiffel_wizard_icon" + pixmap_extension)
		end

	Progress_filename: STRING = "progress.eif"

	progress_text_2: EV_LABEL
			-- 2nd progress text (For each library)

	progress_2: EV_HORIZONTAL_PROGRESS_BAR
			-- 2nd progress bar (For each library)

	n_lib_to_precompile: INTEGER
			-- Number of library left to precompile

	n_lib_done: INTEGER
			-- Number of library already precompiled

	compt: INTEGER;
			-- Used to test .. unuseful if the progress file is used

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			 Customer support http://support.eiffel.com
		]"

end
