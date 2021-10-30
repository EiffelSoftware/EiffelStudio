note
	description: "Cycle detected in parents chain of a target."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CYCLE_IN_PARENTS

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_target: CONF_TARGET; a_targets: ITERABLE [CONF_TARGET])
		require
			a_targets_set: a_targets /= Void
		do
			target := a_target
			create {ARRAYED_LIST [CONF_TARGET]} targets.make (5)
			across
				a_targets as ic
			loop
				targets.force (ic)
			end
		end

feature -- Access

	target: CONF_TARGET

	targets: LIST [CONF_TARGET]

	text: STRING_32
			-- Error message.
		local
			t: CONF_TARGET
			n: INTEGER
		do
			Result := {STRING_32} "Cycle detected in target parents:%N"
			across
				targets as ic
			loop
				n := n.max (ic.name.count)
			end
			across
				targets as ic
			loop
				t := ic
				if t.same_as (target) then
					Result.append_character ('!')
				else
					Result.append_character (' ')
				end
				append_target_info_to (t, n, Result)
				Result.append_character ('%N')
			end
			Result.append_character ('!')
			append_target_info_to (target, n, Result)
			Result.append_character ('%N')

			Result.append ("%NFor each target involved in the cycle, review the parent to find the cause of the cycle.")
		end

feature {NONE} -- Implementation		

	append_target_info_to (t: CONF_TARGET; a_max_name_size: INTEGER; buf: STRING_32)
		do
			buf.append ({STRING_32} "- ")
			buf.append (adjusted_string (t.name, a_max_name_size))
			buf.append ({STRING_32} " (" + t.system.file_path.name + {STRING_32} ")")
		end

	adjusted_string (s: READABLE_STRING_32; nb: INTEGER): STRING_32
		do
			if s.count < nb then
				create Result.make_from_string (s)
				Result.append (create {STRING_32}.make_filled (' ', nb - Result.count))
			else
				Result := s
			end
		end

invariant
	target_attached: target /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
