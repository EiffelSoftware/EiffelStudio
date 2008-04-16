indexing
	description: "Configuration elements with notes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_NOTABLE

feature -- Access queries

	notes: ARRAYED_LIST [HASH_TABLE [STRING, STRING]]
			-- Notes of current.

feature {CONF_ACCESS} -- Update, stored in configuration file

	add_note (a_note: HASH_TABLE [STRING, STRING]) is
			-- Set `internal_notes' with `a_notes'
		require
			a_note_not_void: a_note /= Void
		do
			if notes = Void then
				create notes.make (1)
			end
			notes.extend (a_note)
		ensure
			notes_not_void: notes /= Void
			a_note_extended: notes.has (a_note)
		end

	remove_note (a_note: HASH_TABLE [STRING, STRING]) is
			-- Remove `a_note' from `notes'
		require
			a_note_not_void: a_note /= Void
		do
			if notes /= Void then
				notes.start
				notes.prune (a_note)
			end
		end

	replace_note (a_old_note, a_new_note: HASH_TABLE [STRING, STRING]) is
			-- Replace `a_old_note' with `a_new_note' in `notes'.
		require
			a_old_note_void: a_old_note /= Void
			a_new_note_void: a_new_note /= Void
			notes_not_void: notes /= Void
			has_old_note: notes.has (a_old_note)
		do
			notes.start
			notes.search (a_old_note)
			notes.replace (a_new_note)
		ensure
			notes_has_new_note: notes.has (a_new_note)
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
