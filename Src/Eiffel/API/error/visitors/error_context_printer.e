indexing
	description: "[
		Utility class used to print error context information.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ERROR_CONTEXT_PRINTER

feature -- Output

	print_context_group (a_formatter: !TEXT_FORMATTER; a_group: !CONF_GROUP) is
			-- Prints a context group URI.
		do
			if {l_cluster: !CONF_CLUSTER} a_group then
				if {l_parent: !CONF_GROUP} l_cluster.parent then
					print_context_group (a_formatter, l_parent)
					a_formatter.add (".")
				end
			end
			a_formatter.add_group (a_group, a_group.name)
		end

	print_context_class (a_formatter: !TEXT_FORMATTER; a_class: !CLASS_C) is
			-- Prints a context class URI, including the group name.
		do
			a_class.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add (" (")
				print_context_group (a_formatter, l_group)
				a_formatter.add (")")
			end
		end

	print_context_feature (a_formatter: !TEXT_FORMATTER; a_feature: !E_FEATURE; a_class: !CLASS_C) is
			-- Prints a context feature URI, including the class and group name.
		do
			a_class.append_name (a_formatter)
			a_formatter.add (".")
			a_feature.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add (" (")
				print_context_group (a_formatter, l_group)
				a_formatter.add (")")
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
