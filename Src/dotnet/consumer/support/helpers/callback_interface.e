indexing
	description: "Agents used for callbacks during processing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CALLBACK_INTERFACE

feature -- Access

	status_querier: FUNCTION [ANY, TUPLE[], BOOLEAN]
			-- Check whether to stop process
	
	status_printer, error_printer: ROUTINE [ANY, TUPLE [STRING]]
			-- Print status and error messages

feature -- Element settings

	set_status_querier (querier: like status_querier) is
			-- Set `status_querier' with `querier'.
		require
			non_void_querier: querier /= Void
		do
			status_querier := querier
		ensure
			status_querier_set: status_querier = querier
		end
		
	set_status_printer (printer: like status_printer) is
			-- Set `status_printer' with `printer'.
		require
			non_void_printer: printer /= Void
		do
			status_printer := printer
		ensure
			status_printer_set: status_printer = printer
		end
		
	set_error_printer (printer: like error_printer) is
			-- Set `status_querier' with `printer'.
		require
			non_void_printer: printer /= Void
		do
			error_printer := printer
		ensure
			error_printer_set: error_printer = printer
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


end -- class CALLBACK_INTERFACE
