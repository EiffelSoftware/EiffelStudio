note
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

	completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	insertion: detachable STRING_32
			-- String to be partially completed
		require
			is_prepared : is_prepared
		deferred
		end

	insertion_remainder: INTEGER
			-- The number of characters in the insertion remaining from the cursor position to the
			-- end of the token
		require
			is_prepared : is_prepared
		deferred
		end

	name_type: NAME_FOR_COMPLETION

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion
			-- Prepare completion possibilities.
		require
			code_completable_attached: code_completable /= Void
		do
			is_prepared := True
		ensure
			is_prepared: is_prepared
		end

	reset
			-- Reset
		do
			is_prepared := False
		end

feature -- Status report

	is_prepared: BOOLEAN
			-- Is completion possibilities prepared?

	completion_possible: BOOLEAN
			-- Is completion possible?
		do
			Result := attached completion_possibilities as l_c and then not l_c.is_empty
		end

feature -- Element change

	set_code_completable (a_completable: like code_completable)
			-- Set `code_completable' with `a_completable'.
		require
			a_completable_attached: a_completable /= Void
		do
			code_completable := a_completable
			is_prepared := False
		ensure
			code_completable_not_void: code_completable /= Void
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
