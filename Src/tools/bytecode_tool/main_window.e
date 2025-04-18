﻿note
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create main_container
			create selection_grid
			create melted_text
			create bytecode_text
			create log_text
			create bytecode_grid
				-- Status bar.
			create standard_status_bar
			create standard_status_label.make_with_text ("Add your status text here...")
		end

	initialize
			-- <Precursor>
		do
			Precursor

				-- Create and add the status bar.
			build_standard_status_bar
			lower_bar.extend (standard_status_bar)

			extend (main_container)

			build_tools

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)
		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end

feature -- Element change

	add_melted_filename (fn: READABLE_STRING_GENERAL)
		require
			fn_attached: fn /= Void
		local
			fns: LINKED_LIST [READABLE_STRING_GENERAL]
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			if f.exists and then f.is_readable then
				create fns.make
				fns.extend (fn)
				on_files_dropped (fns)
			end
		end

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window

	standard_status_label: EV_LABEL
			-- Label situated in the standard status bar.
			--
			-- Note: Call `standard_status_label.set_text (...)' to change the text
			--       displayed in the status bar.

	build_standard_status_bar
			-- Create and populate the standard toolbar.
		do
				-- Set the status bar properties.
			standard_status_bar.set_border_width (2)
				-- Populate the status bar.
			standard_status_label.align_text_left
			standard_status_bar.extend (standard_status_label)
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)
			if question_dialog.selected_button ~ (create {EV_DIALOG_CONSTANTS}).ev_ok then
					-- Destroy the window and exit application.
				destroy_and_exit_if_last
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_tools
			--
		local
			c0,c1,c2,c3,clog: SD_CONTENT
			g: EV_GRID
			t: EV_TEXT
			docking_manager: SD_DOCKING_MANAGER
		do
			create docking_manager.make (main_container, Current)
			docking_manager.close_editor_place_holder
			g := selection_grid
			create c0.make_with_widget (g, "select...", docking_manager)
			c0.set_short_title ("Drop *.melted below ...")
			c0.set_long_title ("Drop *.melted below ...")
			docking_manager.contents.extend (c0)
			c0.set_top ({SD_ENUMERATION}.top)
			selection_grid_content := c0

			t := melted_text
			create c1.make_with_widget (t, "melted", docking_manager)
			c1.set_short_title ("Melted")
			c1.set_long_title ("Melted")
			docking_manager.contents.extend (c1)
			c1.set_relative (c0 , {SD_ENUMERATION}.bottom)

			g := bytecode_grid
			g.enable_tree
--			g.disable_row_height_fixed
			g.enable_single_row_selection
			g.set_column_count_to (4)
			g.column (cst_name_column).set_title ("name")
			g.column (cst_written_in_column).set_title ("written")
			g.column (cst_routine_id_column).set_title ("rout id")
			g.column (cst_body_id_column).set_title ("body id")

			create c2.make_with_widget (g, "bytecode", docking_manager)
			c2.set_short_title ("Bytecode")
			c2.set_long_title ("Bytecode")
			docking_manager.contents.extend (c2)
			c2.set_tab_with (c1 , True)

			t := bytecode_text
			create c3.make_with_widget (t, "bytecode_details", docking_manager)
			c3.set_short_title ("Bytecode ...")
			c3.set_long_title ("Bytecode ...")
			docking_manager.contents.extend (c3)
			c3.set_relative (c2, {SD_ENUMERATION}.right)

			t := log_text
			create clog.make_with_widget (t, "console", docking_manager)
			clog.set_short_title ("Console ...")
			clog.set_long_title ("Console ...")
			docking_manager.contents.extend (clog)
			clog.set_relative (c3, {SD_ENUMERATION}.bottom)
			clog.set_auto_hide ({SD_ENUMERATION}.bottom)

			selection_grid.set_row_count_to (0)
			selection_grid.enable_tree
			selection_grid.enable_single_row_selection
			selection_grid.file_drop_actions.extend (agent on_files_dropped ({LIST [STRING_32]} ?))
			selection_grid.row_select_actions.extend (agent on_row_selected)
			selection_grid.hide_header

			show_actions.extend_kamikaze (agent (ac0,ac1,ac2: SD_CONTENT)
					do
						ac0.set_split_proportion ({REAL_32} 0.3)
						ac1.set_split_proportion ({REAL_32} 0.5)
						ac2.set_split_proportion ({REAL_32} 0.5)
					end (c0, c1, c2)
				)
		end

	selection_grid_content: detachable SD_CONTENT

	selection_grid: EV_GRID
	melted_text: EV_TEXT
	bytecode_text: EV_TEXT
	log_text: EV_TEXT
	bytecode_grid: EV_GRID

	on_files_dropped (fns: LIST [READABLE_STRING_GENERAL])
			--
		local
			fn: READABLE_STRING_GENERAL
			gl: EV_GRID_LABEL_ITEM
		do
			if fns /= Void and then fns.count > 0 then
				if ev_application.ctrl_pressed then
					selection_grid.set_row_count_to (0)
				end
				from
					fns.start
				until
					fns.after
				loop
					fn := fns.item
					create gl.make_with_text (fn)
					selection_grid.set_item (cst_name_column, selection_grid.row_count + 1, gl)
					gl.row.set_data (fn)
					fns.forth
				end
			end
			if selection_grid.column_count > 0 then
				selection_grid.column (1).resize_to_content
			end
			if
				selection_grid.row_count = 1 and then
				attached {READABLE_STRING_GENERAL} selection_grid.row (1).data as s
			then
				process_filename (s)
			end
		end

	on_row_selected	(r: EV_GRID_ROW)
			-- <Precursor>
		do
			if attached {READABLE_STRING_GENERAL} r.data as s then
				process_filename (s)
			end
		end

	clean_result (wd: STRING)
		do
			bytecode_grid.set_row_count_to (0)
			delete_file (bytecode_eif_filename (wd))
			delete_file (bytecode_txt_filename (wd))
			delete_file (melted_txt_filename (wd))
		end


	bytecode_eif_filename (wd: STRING): FILE_NAME
		do
			create Result.make_from_string (wd)
			Result.set_file_name ("bytecode")
			Result.add_extension ("eif")
		end

	bytecode_txt_filename (wd: STRING): FILE_NAME
		do
			create Result.make_from_string (wd)
			Result.set_file_name ("bytecode")
			Result.add_extension ("txt")
		end

	melted_txt_filename (wd: STRING): FILE_NAME
		do
			create Result.make_from_string (wd)
			Result.set_file_name ("melted")
			Result.add_extension ("txt")
		end

	delete_file (fn: FILE_NAME)
		local
			f: RAW_FILE
		do
			create f.make (fn.string)
			if f.exists then
				f.delete
			end
		end

	process_filename (s: READABLE_STRING_GENERAL)
			--
		local
			fn: FILE_NAME
			t: STRING
			f: PLAIN_TEXT_FILE
			nfn: FILE_NAME
			wd: STRING
		do
			last_bytecode_txt_filename := Void
			if s /= Void then
				if attached selection_grid_content as c then
					c.minimize
				end
				create fn.make_from_string (s.to_string_8)
				if fn.is_valid then
					create wd.make_from_string (fn)
					wd.keep_head (wd.last_index_of (operating_environment.directory_separator, wd.count))
					clean_result (wd)

					create f.make (fn)
					if f.exists and then f.is_readable then
						standard_status_label.set_text ("loading file %"" + s.out + "%""); standard_status_label.refresh_now
						set_pointer_style ((create {EV_STOCK_PIXMAPS}).Busy_cursor)
						standard_status_label.set_text ("meltdump ..."); standard_status_label.refresh_now
						nfn := process_meltdump (fn, wd)
						t := content_of (nfn)
						t.prune_all ('%R')
						melted_text.set_text (t)

						create nfn.make_from_string (wd)
						nfn.set_file_name ("bytecode")
						nfn.add_extension ("eif")
						standard_status_label.set_text ("bytedump ..."); standard_status_label.refresh_now
						nfn := process_bytedump (nfn, wd)
						standard_status_label.set_text ("Analyze bytecode ..."); standard_status_label.refresh_now
						analyze_bytecode_from (nfn)
						standard_status_label.set_text ("Display bytecode ..."); standard_status_label.refresh_now
						fill_bytecode_tool
						standard_status_label.set_text ("Terminated."); standard_status_label.refresh_now
						set_pointer_style ((create {EV_STOCK_PIXMAPS}).Standard_cursor)
					end
				end
			end
		end

	last_bytecode_txt_filename: detachable STRING

	analyze_bytecode_from (fn: STRING)
			--
		local
			f: RAW_FILE
			line, src: STRING
			h,b: STRING
			e: like analyzes_entry
			a: like analyzes
		do
			last_bytecode_txt_filename := fn
			analyzes := Void
			create f.make (fn)
			if f.exists then
				f.open_read
				from
					create a.make
					analyzes := a
					f.read_line
					line := f.last_string
				until
					f.end_of_file or line = Void
				loop
					if line.has_substring (once ": BC_START") then
						create e
						a.extend (e)
						create h.make_empty
						create b.make_empty
						e.header := h
						e.body := b
--						b.append (line)
--						b.append_character ('%N')
						from
							f.read_line
							line.left_adjust
						until
							line = Void
							or else line.item (1).is_digit
							or f.end_of_file
						loop
							h.append (line)
							h.append_character ('%N')
							if e.rout_id = 0 and then string_started_by (line, "Routine Id", False) then
								e.rout_id := line.substring (line.index_of (':', 1) + 1, line.count).to_integer_32
							elseif e.body_id = 0 and then string_started_by (line, "Body Id", False) then
								e.body_id := line.substring (line.index_of (':', 1) + 1,  line.count).to_integer_32
							elseif e.written_in = 0 and then string_started_by (line, "Written", False) then
								e.written_in := line.substring (line.index_of (':', 1) + 1,  line.count).to_integer_32
							elseif e.name = Void and then string_started_by (line, "Routine name", False) then
								e.name := line.substring (line.index_of (':', 1) + 1, line.count)
							else
							end
							f.read_line
							line.left_adjust
						end
						if line /= Void and then line.item (1).is_digit then
							b.append (line)
							b.append_character ('%N')
						end
						from
							f.read_line
							src := line.twin
							line.left_adjust
						until
							line = Void
							or else line.is_empty
							or f.end_of_file
						loop
							b.append (src)
							b.append_character ('%N')
							f.read_line
							src := line.twin
							line.left_adjust
						end
						f.readline
					end
					f.read_line
					line.left_adjust
				end
				f.close
			end
		end

	fill_bytecode_tool
			--
		local
			e: like analyzes_entry
			glab: EV_GRID_LABEL_ITEM
			r: EV_GRID_ROW
		do
			bytecode_grid.set_row_count_to (0)
			if not attached analyzes as a then
				create glab.make_with_text ("Error during analysis.")
				bytecode_grid.set_item (cst_name_column, bytecode_grid.row_count + 1, glab)
			else
				from
					a.start
				until
					a.after
				loop
					e := a.item
					if e.name = Void then
						e.name := "..."
					end
					if e.name /= Void then
						create glab.make_with_text (e.name)
						bytecode_grid.set_item (cst_name_column, bytecode_grid.row_count + 1, glab)
						r := bytecode_grid.row (bytecode_grid.row_count)
						r.set_data (e)

						create glab.make_with_text (e.written_in.out)
						r.set_item (cst_written_in_column, glab)

						create glab.make_with_text (e.rout_id.out)
						r.set_item (cst_routine_id_column, glab)

						create glab.make_with_text (e.body_id.out)
						r.set_item (cst_body_id_column, glab)

		--				r.insert_subrows (2, 1)
		--				create glab.make_with_text (e.header)
		--				r.subrow (1).set_item (2, glab)
		--				r.subrow (1).set_height (glab.text_height)
		--				create glab.make_with_text (e.body)
		--				r.subrow (2).set_item (2, glab)
		--				r.subrow (2).set_height (glab.text_height)

						r.select_actions.extend (agent (ar: EV_GRID_ROW)
								local
									t: STRING
								do
									if attached {like analyzes_entry} ar.data as le then
										t := le.header + "%N" + le.body
										t.prune_all ('%R')
										bytecode_text.set_text (t)
									else
										bytecode_text.remove_text
									end
								end(r)
							)
						r.deselect_actions.extend (agent
								do
									ev_application.add_idle_action_kamikaze (agent
										local
											f: RAW_FILE
											s: detachable STRING
										do
											if bytecode_grid.selected_rows.is_empty then
												if attached last_bytecode_txt_filename as fn then
													create f.make (fn)
													if f.exists and f.is_readable then
														f.open_read
														from
															create s.make (f.count)
															f.read_stream (1024)
															s.append (f.last_string)
														until
															f.exhausted or f.last_string.is_empty
														loop
															f.read_stream (1024)
															s.append (f.last_string)
														end
														f.close
													end
												end
												if s /= Void then
													bytecode_text.set_text (s)
												end
											end
										end
									)
								end
							)
					end
					a.forth
				end
			end
		end


	analyzes: detachable LINKED_LIST [like analyzes_entry]

	analyzes_entry: TUPLE [written_in, rout_id, body_id: INTEGER; name: STRING; header: STRING; body: STRING]
			-- A type anchor.
		require
			False
		do
			check from_precondition: False then end
		ensure
			False
		end

	string_started_by (s: STRING_GENERAL; pre: STRING_GENERAL; b: BOOLEAN): BOOLEAN
			--
		local
			i: INTEGER
		do
			Result := s.count >= pre.count
			from
				i := 1
			until
				i > pre.count or not Result
			loop
				Result := s.code (i) = pre.code (i)
				i := i + 1
			end
		end

	bad_string_started_by (s: STRING; a_prefix: STRING; a_is_entire: BOOLEAN): BOOLEAN
			-- Is string `s' started by `a_prefix' string ?
			-- (first blanks are ignored)
		require
			s /= Void
		local
			i,j: INTEGER
		do
			if a_prefix /= Void and then s.count >= a_prefix.count then
				from
					i := 1
					j := 1
					Result := True
				until
					not Result or j > a_prefix.count
				loop

					if s.item (i) /= ' ' then
						Result := s.item (i).as_lower = a_prefix.item (j).as_lower
						j := j + 1
					end
					i := i + 1
				end
			end
			if Result and a_is_entire then
				Result := s.count = a_prefix.count or else s.item (a_prefix.count + 1).is_space
			end
		end

	process_bytedump (fn: FILE_NAME; wd: STRING): FILE_NAME
			--
		local
			exefn: FILE_NAME
			cmd: STRING
		do
			if attached (create {EXECUTION_ENVIRONMENT}).get ("EIFFEL_SRC") as s then
				create exefn.make_from_string (s)
				exefn.extend ("C")
				exefn.extend ("bench")
				exefn.set_file_name ("bytedump")
				if attached extension_exe as e then
					exefn.add_extension (e)
				end

				create cmd.make_from_string (exefn)
				cmd.append (" ")
				cmd.append (fn)
				Result := bytecode_txt_filename (wd)

				execute_command (cmd, wd)
			else
				;(create {EV_ERROR_DIALOG}.make_with_text ("Environment variable EIFFEL_SRC is not set, exiting...")).show
				;(create {EXCEPTIONS}).die (1)
			end
		end

	process_meltdump (fn: FILE_NAME; wd: STRING): FILE_NAME
		local
			exefn: FILE_NAME
			cmd: STRING
		do
			if attached (create {EXECUTION_ENVIRONMENT}).get ("EIFFEL_SRC") as s then
				create exefn.make_from_string (s)
				exefn.extend ("C")
				exefn.extend ("bench")
				exefn.set_file_name ("meltdump")
				if attached extension_exe as e then
					exefn.add_extension (e)
				end

				create cmd.make_from_string (exefn)
				cmd.append (" ")
				cmd.append (fn)
				Result := melted_txt_filename (wd)

				execute_command (cmd, wd)
			else
				;(create {EV_ERROR_DIALOG}.make_with_text ("Environment variable EIFFEL_SRC is not set, exiting...")).show
				;(create {EXCEPTIONS}).die (1)
			end
		end

	execute_command (cmd: STRING; wd: STRING)
		local
			pf: PROCESS_FACTORY
			p: PROCESS
			output: STRING
		do
			log_text.append_text ("Execute: " + cmd + "%T in dir: " +  wd + "%N")
			create pf
			p := pf.process_launcher_with_command_line (cmd, wd)
			create output.make_empty
			p.redirect_output_to_agent (agent execute_command_output_handler (output, ?))
			p.redirect_error_to_same_as_output
			p.set_hidden (True)
			p.set_separate_console (False)
			p.launch
			p.wait_for_exit_with_timeout (30 * 1_000)
			if p.has_exited then
				log_text.append_text (output)
			else
				log_text.append_text (output)
				log_text.append_text ("%NExecution exited after TIMEOUT%N")
			end
			log_text.append_text ("%N")
		end

	execute_command_output_handler (res: STRING; s: STRING)
		local
			t: STRING
		do
			if s /= Void then
				create t.make_from_string (s)
				t.prune_all ('%R')
				res.append (t)
--				log_text.append_text (t)
			end
		end

	extension_exe: detachable STRING
		local
			pl: PLATFORM
		once
			create pl
			if pl.is_windows then
				Result := "exe"
			end
		end

	content_of (fn: FILE_NAME): STRING
		local
			f: RAW_FILE
		do
			create f.make (fn)
			if f.exists then
				f.open_read
				create Result.make_empty
				from
					f.start
				until
					f.exhausted
				loop
					f.read_stream (512)
					Result.append_string (f.last_string)
				end
				f.close
			else
				Result := "Unable to open file %"" + fn + "%""
			end
		end

feature {NONE} -- Implementation / Constants

	cst_name_column: INTEGER = 1
	cst_written_in_column: INTEGER = 2
	cst_routine_id_column: INTEGER = 3
	cst_body_id_column: INTEGER = 4

	Window_title: STRING = "bytecode_tool"
			-- Title of the window.

	Window_width: INTEGER = 400
			-- Initial width for this window.

	Window_height: INTEGER = 400
			-- Initial height for this window.

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
