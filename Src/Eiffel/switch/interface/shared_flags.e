indexing
	description: "Collection of statuses for various processing."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_FLAGS

feature -- Setting

	set_gui (b: BOOLEAN) is
			-- Set `gui_cell' with `b'.
		do
			gui_cell.put (b)
		ensure
			gui_cell_set: gui_cell.item = b
		end

	set_is_last_c_compilation_freezing (b: BOOLEAN) is
			-- Set `is_last_c_compilation_freezing' with `b'.
		do
			compilation_cell.put (b)
		ensure
			compilation_cell_set: compilation_cell.item = b
		end

	set_is_exit_requested (b: BOOLEAN) is
			-- Set `is_exit_requested' with `b'.
		do
			exit_request_cell.put (b)
		ensure
			is_exit_requested_set: is_exit_requested = b
		end

feature -- Status reporting

	is_gui: BOOLEAN is
			-- Is ec running on GUI mode?
		do
			Result := gui_cell.item
		ensure
			good_result: Result = gui_cell.item
		end

	is_last_c_compilation_freezing: BOOLEAN is
			-- Is last c compilation a freezing?
		do
			Result := compilation_cell.item
		ensure
			good_result: Result = compilation_cell.item
		end

	is_last_c_compilation_finalizing: BOOLEAN is
			-- Is last c compilation a finalizing?
		do
			Result := not compilation_cell.item
		ensure
			good_result: Result = not compilation_cell.item
		end

	is_exit_requested: BOOLEAN is
			-- Is exit requested?
		do
			Result := exit_request_cell.item
		ensure
			good_result: Result = exit_request_cell.item
		end

feature{NONE} -- Implementation

	gui_cell: CELL [BOOLEAN] is
			-- GUI mode cell
		once
			create Result.put (False)
		end

	compilation_cell: CELL [BOOLEAN] is
			-- Compilation flag
		once
			create Result.put (True)
		end

	exit_request_cell: CELL[BOOLEAN] is
			-- Exit request cell
		once
			create Result.put (False)
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

end
