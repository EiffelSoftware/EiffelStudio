indexing
	description: "Eiffel call stack for the stopped application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

deferred class EIFFEL_CALL_STACK

feature -- Properties

	thread_id: INTEGER is
			-- Thread ID related to `Current' call stack
		deferred
		end

	stack_depth: INTEGER is
		deferred
		end

	error_occurred: BOOLEAN is
			-- Did an error occurred when retrieving the eiffel stack?
		deferred
		end

	is_loaded: BOOLEAN
			-- Is Call stacks loaded ?

feature -- fake TWO_WAY_LIST Interface

	count: INTEGER is
		deferred
		end

	is_empty: BOOLEAN is
			-- Call Stack empty ?
		deferred
		end

feature -- Access

	item: CALL_STACK_ELEMENT is
		deferred
		end

	i_th alias "[]" (i: INTEGER): like item is
		deferred
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within allowable bounds?
		deferred
		end

feature -- Queries

	to_string: STRING is
		local
			i: like item
		do
			create Result.make (0)
			from
				start
			until
				after
			loop
				i := item
				if i /= Void then
					Result.append_string (i.to_string)
				end
				Result.append_character ('%N')
				forth
			end
		end

feature -- Change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		deferred
		end

feature -- Cursor movement

	start is
		deferred
		end

	forth is
		deferred
		end

	after: BOOLEAN is
		deferred
		end

feature {APPLICATION_STATUS} -- Change

	reload (n: INTEGER) is
			-- Reload call stack up to level `n'
		require
			all_level_or_positive: n = -1 or n > 0
		deferred
		ensure
			is_loaded: is_loaded
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
