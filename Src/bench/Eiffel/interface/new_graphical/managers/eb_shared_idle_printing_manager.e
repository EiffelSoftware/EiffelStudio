indexing
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

create
	make

feature{NONE} -- Initialization

	make is
		do
			is_printing_freezing := False
			is_printing_finalizing := False
		ensure
			is_printing_freezing_set: not is_printing_freezing
			is_printing_finalizing_set: not is_printing_finalizing
		end

feature -- Printing Timer

	initial_time_interval: INTEGER is 100
			-- Initial timer interval for printing check

	remove_printer (ptr: INTEGER) is
			-- Remove printer numbered `ptr' from `printer_list'.
		do
			if printer_timer.actions.has (printer_list.i_th (ptr)) then
				printer_timer.actions.prune_all (printer_list.i_th (ptr))
				if printer_timer.actions.is_empty then
					printer_timer.set_interval (0)
				end
			end
		end

	add_printer (ptr: INTEGER) is
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

	external_printer: INTEGER is 1
			-- Printer to display external command output

	freezing_printer: INTEGER is 2
			-- Printer to display freezing output

	finalizing_printer: INTEGER is 3
			-- Printer to display finalizing output

	printer_list: ARRAYED_LIST [ PROCEDURE [ANY, TUPLE]] is
			-- List of printers
		once
			create Result.make (3)
			Result.extend (agent print_external)
			Result.extend (agent print_freezing)
			Result.extend (agent print_finalizing)
		end

feature -- Printing

	print_freezing is
			-- Print freezing output.
		local
			gm: EB_C_COMPILATION_OUTPUT_MANAGER
			data_block:	EB_PROCESS_IO_DATA_BLOCK
		do
			if not is_printing_finalizing and freezing_storage.has_new_block then
				gm := c_compilation_output_manager
				data_block := freezing_storage.all_blocks (True)
				gm.process_block_text (data_block)
				gm.scroll_to_end
				if process_manager.is_freezing_running then
					is_printing_freezing := True
				else
					if data_block.count = 0 then
						is_printing_freezing := False
						remove_printer (freezing_printer)
					else
						is_printing_freezing := True
					end
				end
			end
		end

	print_finalizing is
			-- Print finaizing output.
		local
			gm: EB_C_COMPILATION_OUTPUT_MANAGER
			data_block:	EB_PROCESS_IO_DATA_BLOCK
		do
			if not is_printing_freezing and finalizing_storage.has_new_block then
				gm := c_compilation_output_manager
				data_block := finalizing_storage.all_blocks (True)
				gm.process_block_text (data_block)
				gm.scroll_to_end
				if process_manager.is_finalizing_running then
					is_printing_finalizing := True
				else
					if data_block.count = 0 then
						is_printing_finalizing := False
						remove_printer (finalizing_printer)
					else
						is_printing_finalizing := True
					end
				end
			end
		end

	print_external is
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

feature{NONE} -- Implementation

	is_printing_freezing: BOOLEAN
			-- Is freezing information being printed now?

	is_printing_finalizing: BOOLEAN
			-- Is finalizing information being printed now?

feature{NONE}

	printer_timer: EV_TIMEOUT is
			-- Timer to call an agent to print output and error from another process		
		once
			create Result.make_with_interval (0)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
