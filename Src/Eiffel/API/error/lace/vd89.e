note
	description: "Errors of cycled library dependency"
	date: "$Date$"
	revision: "$Revision$"

class
	VD89

inherit
	LACE_WARNING
		redefine
			build_explain
		end

feature -- Output

	build_explain (st: TEXT_FORMATTER)
		local
			l_table: SEARCH_TABLE [CONF_TARGET]
			l_location: SEARCH_TABLE [CONF_TARGET]
		do
			st.add ("Found library dependency cycles:");
			if attached cycles as l_cycles and then not l_cycles.is_empty then
				st.add_new_line
				st.add_indent
				create l_location.make (5)
				across
					l_cycles as l_c
				loop
					st.process_symbol_text ("[")
					l_table := l_c.item
					from
						l_table.start
					until
						l_table.after
					loop
						st.add (l_table.item_for_iteration.name)
						l_location.force (l_table.item_for_iteration)
						l_table.forth
						if not l_table.after then
							st.process_symbol_text (", ")
						end
					end
					st.process_symbol_text ("] ")
				end
				st.add_new_line
				st.add ("Library locations:")
				st.add_new_line
				across
					l_location as l_ct
				loop
					st.add_indent
					st.add (l_ct.item.name)
					st.add (": ")
					st.add (l_ct.item.system.file_name)
					st.add_new_line
				end

			end
			st.add_new_line
		end

feature -- Element Change

	set_cycles (a_cycles: like cycles)
			-- Set cycles
		do
			cycles := a_cycles
		end

feature -- Access

	cycles: detachable ARRAYED_LIST [SEARCH_TABLE [CONF_TARGET]];
			-- Cycles

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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
