indexing
	description: "[
		Commander interface for interacting with the Errors and Warnings tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_ERROR_LIST_COMMANDER_I

feature -- Basic operations

	go_to_next_error (a_cycle: BOOLEAN)
			-- Goes to next error in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
		deferred
		end

	go_to_previous_error (a_cycle: BOOLEAN)
			-- Goes to previous error in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
		deferred
		end

	go_to_next_warning (a_cycle: BOOLEAN)
			-- Goes to next warning in the list.
			--
			-- `a_cycle': Specify true to jump back to the beginning of the list when reaching the end, False to perform
			--            not action when the end has been reached.
		deferred
		end

	go_to_previous_warning (a_cycle: BOOLEAN)
			-- Goes to previous warning in the list.
			--
			-- `a_cycle': Specify true to jump to the end of the list when reaching the start, False to perform
			--            not action when the start has been reached.
		deferred
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
