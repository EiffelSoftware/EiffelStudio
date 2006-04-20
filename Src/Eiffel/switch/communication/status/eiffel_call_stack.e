indexing
	description: "Eiffel call stack for the stopped application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class EIFFEL_CALL_STACK

feature -- Fake inherit from TWO_WAY_LIST

	stack_depth: INTEGER is
		deferred
		end

	count: INTEGER is
		deferred
		end

	is_empty: BOOLEAN is
			-- Call Stack empty ?
		deferred
		end

	start is
		deferred
		end

	forth is
		deferred
		end

	after: BOOLEAN is
		deferred
		end

	item: CALL_STACK_ELEMENT is
		deferred
		end

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		deferred
		end

	i_th alias "[]" (i: INTEGER): like item is
		deferred
		end

feature -- Properties

	error_occurred: BOOLEAN is
			-- Did an error occurred when retrieving the eiffel stack?
		deferred
		end

feature -- Output

	display_stack (st: TEXT_FORMATTER) is
			-- Display callstack in `st'.
		deferred
		end

invariant

	empty_if_error: error_occurred implies is_empty

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

end -- class EIFFEL_CALL_STACK
