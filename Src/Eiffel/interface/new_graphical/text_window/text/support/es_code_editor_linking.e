note
	description: "Linked token behavior, used for linked editing."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CODE_EDITOR_LINKING

feature -- Access

	is_active_at (a_pos_in_text: INTEGER): BOOLEAN
		deferred
		end

feature -- Execution

	prepare
			-- Prepare linking mode.
		do
		end

	terminate
			-- Terminate linking mode.
		do
		end

	propagate_on_insertion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
			-- On char, string insertion event,
			-- resulting into a size difference of `a_size_diff'.
		do
		end

	propagate_on_deletion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
			-- On char, string (or selection) deleted event,
			-- resulting into a size difference of `a_size_diff'.
		require
			a_size_diff < 0
		do
		end

	on_editing  (a_pos_in_text: INTEGER; a_size_diff: INTEGER)
			-- On char, string insertion event,
			-- resulting into a size difference of `a_size_diff'.
		require
			valid_pos_in_text: a_pos_in_text > 0
		do
		end

--	on_insertion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
--			-- On char, string insertion event,
--			-- resulting into a size difference of `a_size_diff'.
--		require
--			a_size_diff > 0
--		do
--		end

--	on_deletion (a_cursor: EDITOR_CURSOR; a_size_diff: INTEGER)
--			-- On char, string (or selection) deleted event,
--			-- resulting into a size difference of `a_size_diff'.
--		require
--			a_size_diff < 0
--		do
--		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
