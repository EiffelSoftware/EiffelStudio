indexing
	description	: "Final state for the precompilation wizard"
	author		: "David Solal / Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		select
			default_create
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as exec_command_line,
			default_create as ex_create
		end

	PRECOMPILE_WIZARD_CONSTANT
		undefine
			default_create
		end

create
	make

feature -- Basic Operations

	build_finish is 
			-- Build user entries.
		local
			cell: EV_CELL
		do
			choice_box.wipe_out
			choice_box.set_border_width (10)
			choice_box.set_padding (10)

			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			progress_text.align_text_left
			progress.set_background_color (white_color)
			progress.set_foreground_color (white_color)
			progress_text.set_background_color (white_color)

			create progress_2
			progress_2.set_minimum_height(20)
			progress_2.set_minimum_width(100)
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


	proceed_with_current_info is
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

	display_state_text is
		do
			title.set_text ("Launch Precompilations")
			message.set_text (
				"The precompilation(s) will be launched as soon%N%
				%as you push the Finish button%N%
				%%N%
				%Be patient, this can take a while!"
				)
		end

	final_message: STRING is
			-- final message for the last message dialog at the end of all the precompilations
		do
			Result:= "Precompilations done !"
		end

	launch_precompilations is
			-- Launch all the choosen precompilations
		local
			current_it: EV_MULTI_COLUMN_LIST_ROW
			lib_info: TUPLE [STRING, BOOLEAN]
			sys_name: STRING
			ace_path: STRING
			already_precompiled: BOOLEAN_REF
		do
			progress.set_proportion (0)
			progress_2.set_proportion (0)
			progress_text.set_text ("Total Progress: ")
			progress_text_2.set_text ("Preparing precompilations ...")

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
				ace_path ?= lib_info.item (1)
				already_precompiled ?= lib_info.item (2)

				precompile (sys_name, ace_path, already_precompiled.item)
				wizard_information.l_to_precompile.forth
			end
		end

	precompile (lib_name, lib_ace: STRING; lib_compiled: BOOLEAN) is
			-- Launch the precompilation for the library 'lib_name'
			-- Using the ace file 'lib_ace'
			-- If the library is already compiled, in 'lib_compiled' then
			-- the previous EIFGEN will be deleted.
		require
			lib_exists: lib_name /= Void and then lib_ace /= Void
		local
			to_end: BOOLEAN
			time_left, n_dir: INTEGER
			new_time_left: INTEGER
			proj_path, command: STRING
			total_prog: INTEGER
			progress_file_path: FILE_NAME
			eifgen_path: DIRECTORY_NAME
			finish_freezing_command: FILE_NAME
		do
				-- We need to find the path, the exact name and the full name of the Ace file
				-- knowing the full name. (Can be fixed .. )
			lib_ace.mirror
			if Eiffel_platform.is_equal ("windows") then
				n_dir := lib_ace.index_of ('\', 1)
			else
				n_dir:= lib_ace.index_of ('/', 1)
			end
			proj_path:= lib_ace.substring (n_dir + 1 , lib_ace.count)
			proj_path.mirror
			lib_ace.mirror

			create eifgen_path.make_from_string (proj_path)
			eifgen_path.extend ("EIFGEN")
			create progress_file_path.make_from_string (eifgen_path)
			progress_file_path.set_file_name (Progress_filename)

				-- Remove the EIFGEN dir if it exists.
			if remove_eifgen (eifgen_path) then
					-- Launch the precompilation and update the progress bars.
				from
					compt := 1 -- Not needed if the file is used....
					to_end := False
					progress_text_2.set_text ("Precompiling " + lib_name + " library: ")
					create command.make (50)
					command.append (Eiffel_compiler_command)
					command.append (" -precompile -ace ")
					command.append (lib_ace)
					command.append (" -project_path ")
					command.append (proj_path)
					command.append (" -output_file ")
					command.append (progress_file_path)
					launch (command)
				until
					to_end = True
				loop
					new_time_left := find_time (progress_file_path)
					if new_time_left /= -1 then	
						if new_time_left >= 100 then
							to_end := True
							time_left := 100
						else
							time_left := new_time_left
						end
					end
					progress_2.set_proportion (time_left / 100)
					progress_text_2.set_text ("Precompiling " + lib_name + " library: " + time_left.out + "%%")
						
					total_prog := ((time_left + 100*n_lib_done)/(n_lib_to_precompile)).floor
					progress.set_proportion ((time_left + 100*n_lib_done)/(100*n_lib_to_precompile))
					progress_text.set_text ("Total progress: " + total_prog.out + "%%")
				end
			end
			
				-- Launch `finish_freezing'
			eifgen_path.extend ("W_CODE")
			change_working_directory (eifgen_path)
			create finish_freezing_command.make_from_string (Eiffel_compiler_location)
			finish_freezing_command.set_file_name ("finish_freezing")
			launch (finish_freezing_command)

			n_lib_done := n_lib_done + 1
		end

	remove_eifgen (eifgen_path: DIRECTORY_NAME): BOOLEAN is
			-- Remove the eifgen directory. Return True if Eifgen has been removed.
		local
			eifgen_dir: DIRECTORY
			error_dialog: EV_ERROR_DIALOG
			cancel_removal: BOOLEAN
			new_name: STRING
		do
			if not cancel_removal then
					-- Remove the EIFGEN dir if it exists.
				create eifgen_dir.make (eifgen_path)
				if eifgen_dir.exists then
					new_name := clone (Eifgen_path)
					if new_name.item (new_name.count) = ']' then
							-- VMS specification. We need to append `_old' before the `]'.
						new_name.insert ("_old", new_name.count - 1)
					else
						new_name.append ("_old")
					end
						-- Rename the old project
					eifgen_dir.change_name (new_name)
					eifgen_dir.recursive_delete
				end
			end
			Result := not cancel_removal
		rescue
			create error_dialog.make_with_text (
				"Unable to remove the existing EIFGEN directory%N`"+
				eifgen_path+
				"'.%N%
				%Check your permissions and try again, or cancel the%N%
				%precompilation")
			error_dialog.set_buttons (<<"Try again", "Cancel">>)
			error_dialog.set_default_push_button (error_dialog.button ("Try again"))
			error_dialog.set_default_cancel_button (error_dialog.button ("Cancel"))
			error_dialog.show_modal_to_window (first_window)
			if error_dialog.selected_button.is_equal ("Cancel") then
				cancel_removal := True
			end
			retry
		end

	find_time (progress_file_path: FILE_NAME): INTEGER is
			-- Check the progress file to determine the current progress of the precompilation
			-- The function will check the project file in the directory 'project_path'
		require
			progress_file_path_valid: progress_file_path /= Void and then progress_file_path.is_valid
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

				create fi.make_open_read (progress_file_path)
				if not fi.is_closed and then fi.is_readable then
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
			end
		ensure
			result_is_integer: Result /= Void
		rescue
			retried := True
			retry
		end

	degree_from_output (a_output_string: STRING): INTEGER is
			-- Return a degree between 6 and 0 if everything went ok,
			-- -1 otherwise.
		local
			tab_index: INTEGER
			degree_substring: STRING
		do
			tab_index := a_output_string.index_of('%T', 1)
			Result := a_output_string.substring (1, tab_index).to_integer

			degree_substring := a_output_string.substring (1, tab_index)
			if degree_substring @ 1 = '-' then
				if degree_substring.is_integer then
					Result := -(degree_substring.substring (2, degree_substring.count).to_integer)
				end
			else
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

	percentage_from_output (a_output_string: STRING): INTEGER is
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

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Wizard

	progress_text_2: EV_LABEL
			-- 2nd progress text (For each library)

	progress_2: EV_HORIZONTAL_PROGRESS_BAR
			-- 2nd progress bar (For each library)

	n_lib_to_precompile: INTEGER
			-- Number of library left to precompile

	n_lib_done: INTEGER
			-- Number of library already precompiled

	compt: INTEGER
			-- Used to test .. unuseful if the progress file is used

end -- class WIZARD_FINAL_STATE
