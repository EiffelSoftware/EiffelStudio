note
	description: "Summary description for {IRON_NODE_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_NODE_CONTROLLER

inherit
	ARGUMENTS_32

	IRON_NODE_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
		local
			i,n: INTEGER
			op: detachable IRON_NODE_CONTROLLER_TASK
		do
			if argument_count > 0 then
				from
					i := 1
					n := argument_count
				until
					i > n
				loop
					if attached argument (i) as arg then
						if arg.starts_with ("-") then
							-- options
						elseif op = Void then
							if arg.is_case_insensitive_equal_general ("system") then
								create {IRON_NODE_CONTROLLER_SYSTEM_TASK} op.make_with_arguments (sub_argument_array (i + 1, n))
--								i := n -- exit loop
							elseif arg.is_case_insensitive_equal_general ("user") then
								create {IRON_NODE_CONTROLLER_USER_TASK} op.make_with_arguments (sub_argument_array (i + 1, n))
--								i := n -- exit loop
							end
						end
					end
					i := i + 1
				end
			end
			initialize_iron
			if op /= Void then
				if op.is_available (iron) then
					op.execute (iron)
				else
					print ("Error: system is not available%N")
				end
			else
				print ("Command: " + argument (0) + "%N")
				print ("IRON version: " + version)
				print ("%N")
				print ("usage: ironctl {system|user}%N")
				print ("%Tsystem: various configuration operations (database, ...) .%N")
				print ("%Tuser: user management.%N")
			end
		end

feature -- Database

	sub_argument_array (i_offset, j_offset: INTEGER): like argument_array
			-- Sub array of [i_offset, j_offset] `argument_array'
			-- with convention `i_offset' starts at 0.
		require
			has_argument_at_index_0: argument_array.valid_index (0)
		local
			l_argument_array: like argument_array
			i,j: INTEGER
		do
			l_argument_array := argument_array
			create Result.make_empty
			Result.rebase (0)
			Result.force (l_argument_array[0], 0)

			if i_offset <= j_offset then
				from
					i := i_offset
					j := 1
				until
					i > j_offset
				loop
					Result.force (l_argument_array[l_argument_array.lower + i], j)
					j := j + 1
					i := i + 1
				end
			end
		end

	initialize_iron
		local
			fac: IRON_NODE_FACTORY
		do
			create fac
			iron := fac.iron_node
		end

	iron: IRON_NODE

invariant

	iron_attached: iron /= Void

note

	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
