note
	description: "Object which is responsable for printing c compiler or external command output and error when idle."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_IDLE_PRINTING_MANAGER

inherit
	EB_SHARED_MANAGERS

	EB_SHARED_PROCESS_IO_DATA_STORAGE

	ES_SHARED_OUTPUTS

	SHARED_LOCALE
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initialization

	make
		do
			is_printing_freezing := False
			is_printing_finalizing := False
		ensure
			is_printing_freezing_set: not is_printing_freezing
			is_printing_finalizing_set: not is_printing_finalizing
		end

feature -- Printing Timer

	initial_time_interval: INTEGER = 100
			-- Initial timer interval for printing check

	remove_printer (ptr: INTEGER)
			-- Remove printer numbered `ptr' from `printer_list'.
		do
			if printer_timer.actions.has (printer_list.i_th (ptr)) then
				printer_timer.actions.prune_all (printer_list.i_th (ptr))
				if printer_timer.actions.is_empty then
					printer_timer.set_interval (0)
				end
			end
		end

	add_printer (ptr: INTEGER)
			-- Add a printer numbered `ptr' to `printer list'.
		require
			printer_number_valid: ptr = external_printer or ptr = freezing_printer or ptr = finalizing_printer
		do
			if not printer_timer.actions.has (printer_list.i_th (ptr)) then
				printer_timer.actions.extend (printer_list.i_th (ptr))
				if printer_timer.interval = 0 then
					printer_timer.set_interval (initial_time_interval)
				end
			end
		end

	external_printer: INTEGER = 1
			-- Printer to display external command output

	freezing_printer: INTEGER = 2
			-- Printer to display freezing output

	finalizing_printer: INTEGER = 3
			-- Printer to display finalizing output

	printer_list: ARRAYED_LIST [ PROCEDURE [ANY, TUPLE]]
			-- List of printers
		once
			create Result.make (3)
			Result.extend (agent print_external)
			Result.extend (agent print_freezing)
			Result.extend (agent print_finalizing)
		end

feature -- Printing

	print_freezing
			-- Print freezing output.
		local
			l_encoding: detachable ENCODING
			l_data_block: EB_PROCESS_IO_DATA_BLOCK
		do
			if not is_printing_finalizing and freezing_storage.has_new_block then
				if
					attached {ES_OUTPUT_PANE_I} c_compiler_output as l_output and then
					attached window_manager.last_focused_development_window as l_window and then
					attached {ES_LOCALE_EDITOR_WIDGET} l_output.widget_from_window (l_window) as l_locale_widget
				then
						-- Fetch the encoding of the widget.
					l_encoding := l_locale_widget.encoding
				end

					-- Process a block of text using a selected encoding.
				l_data_block := freezing_storage.all_blocks (True)
				process_block_text (l_data_block, c_compiler_formatter, l_encoding)

				if process_manager.is_freezing_running then
					is_printing_freezing := True
				else
					if freezing_storage.has_new_block then
						is_printing_freezing := True
					else
						is_printing_freezing := False
						remove_printer (freezing_printer)
					end
				end
			end
		end

	print_finalizing
			-- Print finaizing output.
		local
			l_encoding: detachable ENCODING
			l_data_block: EB_PROCESS_IO_DATA_BLOCK
		do
			if not is_printing_freezing and finalizing_storage.has_new_block then
				if
					attached {ES_OUTPUT_PANE_I} c_compiler_output as l_output and then
					attached window_manager.last_focused_development_window as l_window and then
					attached {ES_LOCALE_EDITOR_WIDGET} l_output.widget_from_window (l_window) as l_locale_widget
				then
						-- Fetch the encoding of the widget.
					l_encoding := l_locale_widget.encoding
				end

					-- Process a block of text using a selected encoding.
				l_data_block := finalizing_storage.all_blocks (True)
				process_block_text (l_data_block, c_compiler_formatter, l_encoding)

				if process_manager.is_finalizing_running then
					is_printing_finalizing := True
				else
					if finalizing_storage.has_new_block then
						is_printing_finalizing := True
					else
						is_printing_finalizing := False
						remove_printer (finalizing_printer)
					end
				end
			end
		end

	print_external
			-- Print output and error if any, of external command which is running.
		local
			b: EB_PROCESS_IO_DATA_BLOCK
		do
			if external_storage.has_new_block then
				b := external_storage.all_blocks (True)
				external_output_manager.process_block_text (b)
				if b.is_end then
					external_launcher.on_ouput_print_session_over
					remove_printer (external_printer)
				end
			end
		end

feature -- Process

	process_block_text (a_block: EB_PROCESS_IO_DATA_BLOCK; a_formatter: TEXT_FORMATTER; a_encoding: detachable ENCODING)
			-- Print `text_block' on `console'.
		require
			a_block_attached: a_block /= Void
			a_formatter_attached: a_formatter /= Void
		local
			l_lines: LIST [STRING_32]
		do
			if attached {READABLE_STRING_GENERAL} a_block.data as l_str then
				l_lines := l_str.as_string_32.split ('%N')
				from l_lines.start until l_lines.after loop
					if attached l_lines.item as l_line then
						if not l_line.is_empty then
							if a_encoding /= Void then
								a_formatter.process_basic_text (console_encoding_to_utf32 (a_encoding, l_line))
							else
								a_formatter.process_basic_text (l_line)
							end
						end
						if not l_lines.islast then
							a_formatter.process_new_line
						end
					end
					l_lines.forth
				end
			end
		end

feature{NONE} -- Implementation

	is_printing_freezing: BOOLEAN
			-- Is freezing information being printed now?

	is_printing_finalizing: BOOLEAN
			-- Is finalizing information being printed now?

feature{NONE}

	printer_timer: EV_TIMEOUT
			-- Timer to call an agent to print output and error from another process		
		once
			create Result.make_with_interval (0)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
