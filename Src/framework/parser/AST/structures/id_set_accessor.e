note
	description: "Collection of routine IDs with the corresponding class ID of the call target."

deferred class
	ID_SET_ACCESSOR

inherit
	ID_SET
		rename
			make as make_id_set
		undefine
			is_equal, copy
		end

feature -- Access

	routine_ids: ID_SET
			-- Routine IDs of the feature being called.
		do
			Result := Current
		ensure
			id_set_not_void: Result /= Void
		end

	class_id: INTEGER
			-- Class ID of the target of the call.

feature -- Modification

	set_routine_ids (s: ID_SET)
			-- Set `routine_ids' to `s'.
		require
			s_attached: attached s
		do
			first := s.first
			if s.count > 1 and attached s.area as l_area then
				area := l_area.twin
			else
				area := Void
			end
		end

	set_class_id (id: like class_id)
			-- Set `class_id' to `id'.
		require
			id_ok: id > 0 or id = -1
		do
			class_id := id
		ensure
			class_id_set: class_id = id
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
