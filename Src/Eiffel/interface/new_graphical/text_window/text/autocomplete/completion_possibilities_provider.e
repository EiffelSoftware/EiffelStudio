indexing
	description: "Objects provide possibilities for code completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLETION_POSSIBILITIES_PROVIDER

feature -- Access

	code_completable: CODE_COMPLETABLE
			-- A code completable.

	completion_possibilities: SORTABLE_ARRAY [like name_type] is
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	insertion: STRING is
			-- String to be partially completed
		require
			is_prepared : is_prepared
		deferred
		end

	insertion_remainder: INTEGER is
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		require
			is_prepared : is_prepared
		deferred
		end

	name_type: NAME_FOR_COMPLETION

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion is
			-- Prepare completion possibilities.
		require
			code_completable_attached: code_completable /= Void
		do
			is_prepared := true
		ensure
			is_prepared: is_prepared
		end

feature -- Status report

	is_prepared: BOOLEAN
			-- Is completion possibilities prepared?

	completion_possible: BOOLEAN is
			-- Is completion possible?
		do
			Result := completion_possibilities /= Void and then not completion_possibilities.is_empty
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
