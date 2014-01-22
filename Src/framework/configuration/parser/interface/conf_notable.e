note
	description: "Configuration elements with notes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_NOTABLE

feature -- Access queries

	note_node: detachable CONF_NOTE_ELEMENT
			-- Notes of current.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_note_node (a_note: like note_node)
			-- Set `note_node' with `a_note'.
		do
			note_node := a_note
		ensure
			note_node_set: note_node = a_note
		end

	add_note (a_note: CONF_NOTE_ELEMENT)
			-- Set `internal_notes' with `a_notes'
		require
			a_note_not_void: a_note /= Void
		local
			l_note_node: like note_node
		do
			l_note_node := note_node
			if l_note_node = Void then
				create l_note_node.make ("note")
				note_node := l_note_node
			end
			l_note_node.extend (a_note)
		ensure
			note_node_not_void: attached note_node as el_note_node
			a_note_extended: el_note_node.has (a_note)
		end

	remove_note (a_note: CONF_NOTE_ELEMENT)
			-- Remove `a_note' from `notes'
		require
			a_note_not_void: a_note /= Void
		do
			if attached note_node as l_note_notes then
				l_note_notes.prune_all (a_note)
			end
		end

	replace_note (a_old_note, a_new_note: CONF_NOTE_ELEMENT)
			-- Replace `a_old_note' with `a_new_note' in `notes'.
		require
			a_old_note_void: a_old_note /= Void
			a_new_note_void: a_new_note /= Void
			notes_not_void: attached note_node as l_note_node
			has_old_note: l_note_node.has (a_old_note)
		do
			if attached note_node as l_note_node then
				l_note_node.start
				l_note_node.search (a_old_note)
				l_note_node.replace (a_new_note)
			end
		ensure
			note_node_has_new_note: attached note_node as el_note_node and then el_note_node.has (a_new_note)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
