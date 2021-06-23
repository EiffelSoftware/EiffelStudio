note
	description: "Summary description for {SCM_CHANGELIST}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CHANGELIST

inherit
	ITERABLE [SCM_STATUS]

	DEBUG_OUTPUT

create
	make_with_location

convert
	make_with_location ({SCM_LOCATION}),
	as_command_line_arguments: {STRING_32}

feature {NONE} -- Initialization

	make_with_location (a_location: SCM_LOCATION)
		do
			create {ARRAYED_LIST [SCM_STATUS]} items.make (1)
			items.compare_objects
			root := a_location
		end

feature -- Access

	root: SCM_LOCATION

	items: LIST [SCM_STATUS]
			-- Elements of current changelist.

	new_cursor: INDEXABLE_ITERATION_CURSOR [SCM_STATUS]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

	count: INTEGER
		do
			Result := items.count
		end

	debug_output: STRING_32
		do
			create Result.make (10)
			Result.append_string_general ("count=" + count.out)
			Result.append_string_general (" [")
			Result.append_string_general (root.nature)
			Result.append_string_general ("] %"")
			Result.append_string (root.location.name)
			Result.append_string_general ("%"")
		end

feature -- Status report

	has_path (p: PATH): BOOLEAN
		do
			Result := has (p.name)
		end

	has (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := a_name.same_string (ic.item.location.name)
			end
		end

	has_status (a_status: SCM_STATUS): BOOLEAN
		do
			across
				items as ic
			until
				Result
			loop
				Result := a_status.location.same_as (ic.item.location)
			end
		end

feature -- Element change

	extend_status (a_status: SCM_STATUS)
		require
			not has_status (a_status)
		do
			items.force (a_status)
		end

	extend_path (p: PATH)
		require
			not has_path (p)
		do
			extend_status (create {SCM_STATUS_UNKNOWN}.make (p))
		ensure
			has_path (p)
		end

--	extend (a_name: READABLE_STRING_GENERAL)
--		require
--			not has (a_name)
--		do
--			extend_status (create {SCM_STATUS_UNKNOWN}.make_with_name (a_name))
--		ensure
--			has (a_name)
--		end

	remove_path (p: PATH)
		do
			remove (p.name)
		ensure
			not has_path (p)
		end

	remove (a_name: READABLE_STRING_GENERAL)
		do
			from
				items.start
			until
				items.off
			loop
				if
					attached items.item_for_iteration as l_status and then
					a_name.same_string (l_status.location.name)
				then
					items.remove
				else
					items.forth
				end
			end
		ensure
			not has (a_name)
		end

	wipe_out
		do
			items.wipe_out
		ensure
			count = 0
		end

feature -- Conversion

	as_command_line_arguments: STRING_32
		do
			create Result.make (10)
			append_as_command_line_arguments_to (Result)
		end

	append_as_command_line_arguments_to (a_output: STRING_32)
		local
			i: READABLE_STRING_GENERAL
		do
			a_output.append_character (' ')
			across
				items as ic
			loop
				i := ic.item.location.name
				if i.has (' ') or i.has ('%T') then
					a_output.append_string_general ("%"")
					a_output.append_string_general (i)
					a_output.append_string_general ("%"")
				else
					a_output.append_string_general (i)
				end
				a_output.append_character (' ')
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
