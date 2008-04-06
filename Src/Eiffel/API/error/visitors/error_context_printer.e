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

	print_context_group (a_formatter: TEXT_FORMATTER; a_group: CONF_GROUP)
			-- Prints a context group URI.
		require
			a_formatter_attached: a_formatter /= Void
			a_group_attached: a_group /= Void
		do
			if {l_cluster: !CONF_CLUSTER} a_group then
				if {l_parent: !CONF_GROUP} l_cluster.parent then
					print_context_group (a_formatter, l_parent)
					a_formatter.add (".")
				end
			end
			a_formatter.add_group (a_group, a_group.name)
		end

	print_context_class (a_formatter: TEXT_FORMATTER; a_class: CLASS_C)
			-- Prints a context class URI, including the group name.
		require
			a_formatter_attached: a_formatter /= Void
			a_class_attached: a_class /= Void
		do
			a_class.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add ("(")
				print_context_group (a_formatter, l_group)
				a_formatter.add (")")
			end
		end

	print_context_lace_class (a_formatter: TEXT_FORMATTER; a_class: CLASS_I)
			-- Prints a context class URI, including the group name.
		require
			a_formatter_attached: a_formatter /= Void
			a_class_attached: a_class /= Void
		do
			a_class.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add ("(")
				print_context_group (a_formatter, l_group)
				a_formatter.add (")")
			end
		end

	print_context_feature (a_formatter: TEXT_FORMATTER; a_feature: E_FEATURE; a_class: CLASS_C)
			-- Prints a context feature URI, including the class and group name.
		require
			a_formatter_attached: a_formatter /= Void
			a_class_attached: a_class /= Void
			a_featire_attached: a_feature /= Void
		do
			a_class.append_name (a_formatter)
			a_formatter.add (".")
			a_feature.append_name (a_formatter)
			if {l_group: !CONF_GROUP} a_class.group then
				a_formatter.add_space
				a_formatter.add ("(")
				print_context_group (a_formatter, l_group)
				a_formatter.add (")")
			end
		end

	print_context_lace_feature (a_formatter: TEXT_FORMATTER; a_feature_name: STRING; a_class: CLASS_I)
			-- Prints a context feature URI, including the class and group name.
		require
			a_formatter_attached: a_formatter /= Void
			a_class_attached: a_class /= Void
			a_feature_name_attached: a_feature_name /= Void
			not_a_feature_name_is_empty: not a_feature_name.is_empty
		local
			l_class: CLASS_C
			l_feature: E_FEATURE
		do
			if a_class.is_compiled then
				l_class ?= a_class.compiled_class
				l_feature := l_class.feature_with_name (a_feature_name)
			end
			if l_class = Void or else l_feature = Void then
					-- Use compiled data
				a_class.append_name (a_formatter)
				a_formatter.add (".")
				a_formatter.add (a_feature_name)
				if {l_group: !CONF_GROUP} a_class.group then
					a_formatter.add_space
					a_formatter.add ("(")
					print_context_group (a_formatter, l_group)
					a_formatter.add (")")
				end
			else
				print_context_feature (a_formatter, l_feature, l_class)
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
