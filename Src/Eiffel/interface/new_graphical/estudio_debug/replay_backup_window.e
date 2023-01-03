note
	description: "Interface for replaying a backup."
	date: "$Date$"
	revision: "$Revision$"

class
	REPLAY_BACKUP_WINDOW

inherit
	ANY

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	SHARED_COMPILATION_MODES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make
		do
			build_preferences
			create backup_controller
			backup_controller.set_is_ignore_bad_libraries (ignore_bad_libraries_pref.value)
			build_interface
		end

feature -- Access

	window: EV_TITLED_WINDOW
			-- Window holding the backup tool

feature {REPLAY_BACKUP_WINDOW} -- Implementation: Access

	backup_controller: CONF_PARSER_CONTROLLER

	ignore_missing_library_check: EV_CHECK_BUTTON

	copy_ecf_file_check: EV_CHECK_BUTTON

	backup_path_text: EV_PATH_FIELD
			-- UI for `backup_path_pref'.

	counter: EV_SPIN_BUTTON
			-- Value for current iteration in reproducing the backup.

	reset_button, next_button: EV_BUTTON

	compilation_info_text: EV_TEXT
			-- Text of `compilation_info.txt'.

	files_output: EV_TEXT
			-- List all files being copied/removed.

feature {NONE} -- Preferences

	ignore_bad_libraries_pref: BOOLEAN_PREFERENCE
			-- Should we ignore missing libraries?

	backup_path_pref: PATH_PREFERENCE
			-- Path to BACKUP directory.

	compilation_counter_pref: INTEGER_PREFERENCE
			-- Index of compilation being done.

	copy_ecf_allowed: BOOLEAN
			-- Should we copy new ecf file over?
			-- Usually disabled when we have to modify the `config.ecf' file manually because
			-- something wrong with it.

feature {NONE} -- Actions

	reset_preferences
			-- Reset preferences to their default value.
		do
			ignore_bad_libraries_pref.set_value (True)
			backup_path_pref.set_value (create {PATH}.make_empty)
			compilation_counter_pref.set_value (1)
			refresh_ui
		end

	perform_compilation
			-- Perform compilation for current iteration in backup directory.
		local
			l_text: STRING_32
			l_dev: EB_DEVELOPMENT_WINDOW
			l_values: like extract_values
		do
				-- Take any development window, we simply use it to launch the compilation
			l_dev := window_manager.a_development_window

				-- Copy the files of `i-th' compilation to the 1 one which is used for compiling
			copy_files

				-- Launch the type of compilation specified in `compilation_info_text_representation'.
			check l_dev_not_void: l_dev /= Void end
			l_values := extract_values (counter.value, "Type")
			if not l_values.is_empty and l_values.count >= 1 then
				l_text := l_values.first
				if
					l_text.is_equal (compilation_modes.precompile_type) or
					l_text.is_equal (compilation_modes.precompile_finalize_type)
				then
					l_dev.precompilation_cmd.execute_and_wait
				elseif l_text.is_equal (compilation_modes.discover_type) then
					l_dev.discover_melt_cmd.execute_and_wait
				elseif l_text.is_equal (compilation_modes.freeze_type) then
					l_dev.freeze_project_cmd.execute_and_wait
				elseif l_text.is_equal (compilation_modes.finalize_type) then
					l_dev.finalize_project_cmd.execute_and_wait
				else
					l_dev.melt_project_cmd.execute_and_wait
				end
			else
				l_dev.melt_project_cmd.execute_and_wait
			end
			compilation_counter_pref.set_value (counter.value + 1)
			refresh_ui
			window.raise
		end

	load_text
			-- Load content of `compilation_info.txt' into `compilation_info_text'.
		do
			compilation_info_text.set_text (compilation_info_text_representation (counter.value))
		end

feature {NONE} -- Implementation

	build_preferences
		local
			l_manager: PREFERENCE_MANAGER
			l_pref_factory: BASIC_PREFERENCE_FACTORY
		do
			create l_pref_factory
			l_manager := preferences.preferences.new_manager ("BACKUP")

			ignore_bad_libraries_pref := l_pref_factory.new_boolean_preference_value (l_manager, "BACKUP.ignore_bad_libraries", True)
			ignore_bad_libraries_pref.set_hidden (True)

			backup_path_pref := l_pref_factory.new_path_preference_value (l_manager, "BACKUP.path", create {PATH}.make_empty)
			backup_path_pref.set_hidden (True)

			compilation_counter_pref := l_pref_factory.new_integer_preference_value (l_manager, "BACKUP.counter", 1)
			compilation_counter_pref.set_hidden (True)

			copy_ecf_allowed := True
		end

	build_interface
		local
			l_vbox1, l_vbox2: EV_VERTICAL_BOX
			l_frame: EV_FRAME
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			create window.make_with_title ("Replay BACKUP")
			create l_frame.make_with_text ("Settings")
			create l_vbox1
			l_vbox1.set_border_width (small_border_size)
			l_vbox1.set_padding_width (small_padding_size)
			create ignore_missing_library_check.make_with_text ("Ignoring missing libraries")
			ignore_missing_library_check.select_actions.extend (agent
				do
					backup_controller.set_is_ignore_bad_libraries (ignore_missing_library_check.is_selected)
					ignore_bad_libraries_pref.set_value (ignore_missing_library_check.is_selected)
				end)
			l_vbox1.extend (ignore_missing_library_check)
			l_vbox1.disable_item_expand (ignore_missing_library_check)

			create copy_ecf_file_check.make_with_text ("Copy new ecf file")
			copy_ecf_file_check.select_actions.extend (agent
				do
					copy_ecf_allowed := copy_ecf_file_check.is_selected
				end)
			l_vbox1.extend (copy_ecf_file_check)
			l_vbox1.disable_item_expand (copy_ecf_file_check)

			create backup_path_text.make_with_text_and_parent ("Path to BACKUP: ", window)
			l_vbox1.extend (backup_path_text)
			l_vbox1.disable_item_expand (backup_path_text)
			backup_path_text.field.change_actions.extend (agent
				do
					backup_path_pref.set_value (backup_path_text.file_path)
					load_text
				end)

			create l_hbox
			l_hbox.set_padding_width (small_padding_size)
			create l_label.make_with_text ("Current iteration: ")
			l_label.align_text_left
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create counter.default_create
			counter.value_range.adapt (1 |..| 10000)
			counter.change_actions.extend (agent (v: INTEGER)
				do
					compilation_counter_pref.set_value (v)
						-- Update compile button to reflect the current iteration
					next_button.set_text ("Compile Step #" + compilation_counter_pref.value.out)
					load_text
				end)
			counter.return_actions.extend (agent
				do
					compilation_counter_pref.set_value (counter.value)
					load_text
				end)
			l_hbox.extend (counter)
			l_vbox1.extend (l_hbox)
			l_vbox1.disable_item_expand (l_hbox)

			create compilation_info_text
			compilation_info_text.disable_word_wrapping
			compilation_info_text.set_minimum_size (600, 150)
			l_vbox1.extend (compilation_info_text)
			l_vbox1.disable_item_expand (compilation_info_text)

			create l_label.make_with_text ("File activity: ")
			l_label.align_text_left
			l_vbox1.extend (l_label)
			l_vbox1.disable_item_expand (l_label)
			create files_output
			files_output.disable_word_wrapping
			files_output.set_minimum_size (600, 300)
			l_vbox1.extend (files_output)

			l_frame.extend (l_vbox1)

			create l_vbox2
			l_vbox2.set_border_width (small_border_size)
			l_vbox2.set_padding_width (small_padding_size)
			l_vbox2.extend (l_frame)

			create l_hbox
			l_hbox.set_padding_width (default_padding_size)
			l_hbox.extend (create {EV_CELL})
			create reset_button.make_with_text_and_action ("Reset", agent reset_preferences)
			set_default_width_for_button (reset_button)
			l_hbox.extend (reset_button)
			l_hbox.disable_item_expand (reset_button)
			create next_button.make_with_text_and_action ("Compile Step #000000", agent perform_compilation)
			l_hbox.extend (next_button)
			set_default_width_for_button (next_button)
			l_hbox.disable_item_expand (next_button)
			l_vbox2.extend (l_hbox)
			l_vbox2.disable_item_expand (l_hbox)

			window.extend (l_vbox2)
			window.close_request_actions.extend (agent window.hide)

			refresh_ui
		ensure
			window_set: window /= Void
		end

	refresh_ui
			--
		do
				-- Ignore bad libraries.
			ignore_missing_library_check.select_actions.block
			if ignore_bad_libraries_pref.value then
				ignore_missing_library_check.enable_select
			else
				ignore_missing_library_check.disable_select
			end
			ignore_missing_library_check.select_actions.resume

				-- Always bad libraries.
			if copy_ecf_allowed then
				copy_ecf_file_check.enable_select
			else
				copy_ecf_file_check.disable_select
			end

				-- Backup path
			backup_path_text.field.change_actions.block
			backup_path_text.set_file_path (backup_path_pref.value)
			backup_path_text.field.change_actions.resume

				-- Compilation counter
			counter.change_actions.block
			counter.set_value (compilation_counter_pref.value)
			counter.change_actions.resume

				-- Update compile button to reflect the current iteration
			next_button.set_text ("Compile Step #" + compilation_counter_pref.value.out)

			load_text
		end

	backup_path (i: INTEGER): PATH
			-- Path to thr `i'-th compilation backup.
		require
			i_positive: i > 0
		do
			Result := backup_path_text.file_path.extended ("COMP" + i.out)
		ensure
			backup_path_not_void: Result /= Void
		end

	compilation_info_text_representation (i: INTEGER): STRING_32
			-- Text of `compilation_info.txt' file for `i'-th copmpilation.
		require
			i_positive: i > 0
		local
			l_path: PATH
			l_file: PLAIN_TEXT_FILE
		do
			l_path := backup_path (i).extended (backup_info)
			create l_file.make_with_path (l_path)
			if l_file.exists and then l_file.is_readable then
				l_file.open_read
				if l_file.readable then
					l_file.read_stream (l_file.count)
					Result := l_file.last_string
				else
					Result := "Compilation failed and not information was stored."
				end
				l_file.close
			else
				Result := "File `" + l_path.name + "' does not exist."
			end
		ensure
			compilation_info_text_representation_not_void: Result /= Void
		end

	extract_values (i: INTEGER; a_key: STRING): ARRAYED_LIST [STRING_32]
			-- Extract values associated with `a_key' in `compilation_info.txt' for `i'-th compilation.
		require
			i_positive: i > 0
			a_key_not_void: a_key /= Void
		local
			l_text, l_key, l_value: STRING_32
			l_pos, l_end_pos: INTEGER
		do
			from
				l_pos := 1
				l_key := a_key + ": "
				l_text := compilation_info_text_representation (i)
				create Result.make (1)
			until
				l_pos = 0
			loop
				l_pos := l_text.substring_index (l_key, l_pos)
				if l_pos = 1 or else (l_pos > 1 and then l_text.item (l_pos - 1) = '%N') then
						-- A found key is valid either if it is the first character of `l_text', or if its
						-- previous character is a newline.
					l_end_pos := l_text.index_of ('%N', l_pos + 1)
					l_value := l_text.substring (l_pos + l_key.count, l_end_pos - 1)
					if not l_value.is_empty then
						Result.extend (l_value)
					end
					l_pos := l_end_pos
				elseif l_pos /= 0 then
						-- We found something, but that was not a key, we continue the search
						-- to the next occurrence.
					l_pos := l_pos + l_key.count
				end
			end
		ensure
			extract_values_not_void: Result /= Void
		end

	copy_files
			-- Copy files of `counter.value'-th' compilation over to COMP1.
		local
			l_comp_first, l_comp_last, l_file_name: PATH
			l_file: PLAIN_TEXT_FILE
			l_removed_files: ARRAYED_LIST [STRING_32]
			l_split: LIST [STRING_32]
			l_class_name, l_cluster_id: STRING_32
		do
			l_comp_first := backup_path (1)
			l_comp_last := backup_path (counter.value)
				-- Only copy files if we are at the second compilation or greater.
			if not l_comp_first.is_equal (l_comp_last) then
				files_output.remove_text

					-- Removed files that have actually be removed physically from the system.
				l_removed_files := extract_values (counter.value, "OVERRIDE_REMOVED")
				l_removed_files.merge_right (extract_values (counter.value, "REMOVED"))
				if not l_removed_files.is_empty then
					files_output.append_text ("Removing:%N")
					across
						l_removed_files as f
					loop
						l_split := f.item.split (' ')
						if l_split.count = 3 then
								-- Compute class being removed
							l_class_name := l_split.i_th (1).as_lower
							l_cluster_id := l_split.i_th (2)
								-- Remove file from COMP1.
							l_file_name := l_comp_first.extended (l_cluster_id).extended (l_class_name).extended (l_class_name + dot_e)
							create l_file.make_with_path (l_file_name)
							if l_file.exists and then l_file.is_writable then
								files_output.append_text ({STRING_32} " " + l_file_name.name + "%N")
								l_file.delete
							end
						end
					end
					files_output.append_text ("%N")
				end

					-- Copy new files.
				files_output.append_text ("Copying:%N")
				smart_recursive_copy (l_comp_last, l_comp_first)
			end
		end

	smart_recursive_copy (a_source, a_dest: PATH)
			-- Recursively copy files that have changed from `a_source' into `a_dest'.
			-- If `a_source' directory does not exist or if `a_dest' directory could
			-- not be created, do nothing.
			-- If we encounter a `ecf' file, we only copy it if its content has actually changed.
		require
			a_source_not_void: a_source /= Void
			a_dest_not_void: a_dest /= Void
		local
			l_source_name, l_dest_name: PATH
			l_source_file, l_dest_file: RAW_FILE
			l_dest_dir, l_source_dir: DIRECTORY
			l_ecf: STRING_32
			l_copy_content: BOOLEAN
		do
			create l_source_dir.make_with_path (a_source)
			if l_source_dir.exists then
				create l_dest_dir.make_with_path (a_dest)
				create l_dest_file.make_with_path (a_dest)
				if not l_dest_dir.exists and then not l_dest_file.exists then
						-- Create destination if it does not exist.
					l_dest_dir.create_dir
				end
				from
					l_source_dir.open_read
					l_source_dir.start
					l_source_dir.readentry
				until
					l_source_dir.last_entry_32 = Void
				loop
					if not l_source_dir.last_entry_32.same_string ({STRING_32} ".") and not l_source_dir.last_entry_32.same_string ({STRING_32} "..") then
						l_source_name := a_source.extended (l_source_dir.last_entry_32)
						l_dest_name := a_dest.extended (l_source_dir.last_entry_32)
						create l_source_file.make_with_path (l_source_name)
						if l_source_file.exists and then l_source_file.is_directory then
								-- Recursive copy.
							smart_recursive_copy (l_source_name, l_dest_name)
						else
							create l_dest_file.make_with_path (l_dest_name)

								-- Check for ecf files.
							l_ecf := l_source_name.name
							l_ecf.keep_tail (4)
							if l_ecf.is_case_insensitive_equal_general (".ecf") and then l_dest_file.exists then
								l_source_file.open_read
								l_source_file.read_stream (l_source_file.count)
								l_source_file.close
								l_dest_file.open_read
								l_dest_file.read_stream (l_dest_file.count)
								l_dest_file.close
								l_copy_content := not l_source_file.last_string.is_equal (l_dest_file.last_string) and copy_ecf_allowed
							else
								l_copy_content := True
							end
							if l_copy_content then
								l_source_file.open_read
								l_dest_file.open_write
								l_source_file.copy_to (l_dest_file)
								l_source_file.close
								l_dest_file.close
								files_output.append_text ({STRING_32} " " + l_source_name.name + {STRING_32} "%N")
							end
						end
					end
					l_source_dir.readentry
				end
			end
		end

invariant
		-- UI
	window_not_void: window /= Void
	ignore_missing_library_check_not_void: ignore_missing_library_check /= Void
	copy_ecf_file_check_not_void: copy_ecf_file_check /= Void
	backup_path_text_not_void: backup_path_text /= Void
	compilation_info_text_not_void: compilation_info_text /= Void
	counter_not_void: counter /= Void
	reset_button_not_void: reset_button /= Void
	next_button_not_void: next_button /= Void
	files_output_not_void: files_output /= Void
	ui_valid: not window.is_destroyed and
		not ignore_missing_library_check.is_destroyed and
		not copy_ecf_file_check.is_destroyed and
		not backup_path_text.is_destroyed and
		not compilation_info_text.is_destroyed and
		not counter.is_destroyed and
		not reset_button.is_destroyed and
		not next_button.is_destroyed and
		not files_output.is_destroyed

		-- Preferences
	backup_controller_not_void: backup_controller /= Void
	ignore_bad_libraries_pref_not_void: ignore_bad_libraries_pref /= Void
	backup_path_pref_not_void: backup_path_pref /= Void
	compilation_counter_pref_not_void: compilation_counter_pref /= Void

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
