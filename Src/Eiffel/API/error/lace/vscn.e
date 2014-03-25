note
	description: "Error when name clash in a cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VSCN

inherit
	CLUSTER_ERROR

feature -- Properties

	first: CONF_CLASS
			-- First class in conflict

	second: CONF_CLASS
			-- Second class in conflict with first

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		local
			l_ext: EXTERNAL_CLASS_I
			l_cl: CLASS_I
		do
			l_cl ?= first
			check
				class_i: l_cl /= Void
			end
			put_cluster_name (a_text_formatter)
			a_text_formatter.add ("First class: ")
			a_text_formatter.add_classi (l_cl, first.name)
			a_text_formatter.add_new_line
			l_ext ?= first
			if l_ext /= Void then
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("First file: %"")
				a_text_formatter.add (first.full_file_name.name)
				a_text_formatter.add ("%"")
				a_text_formatter.add_new_line
				a_text_formatter.add ("Referenced from: ")
				a_text_formatter.add (first.group.target.system.file_name)
				a_text_formatter.add_string (" (")
				a_text_formatter.add (first.group.name)
				a_text_formatter.add_char (')')
			end
			a_text_formatter.add_new_line
			l_cl ?= second
			check
				class_i: l_cl /= Void
			end
			a_text_formatter.add ("Second class: ")
			a_text_formatter.add_classi (l_cl, second.name)
			a_text_formatter.add_new_line
			l_ext ?= second
			if l_ext /= Void then
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("Second file: %"")
				a_text_formatter.add (second.full_file_name.name)
				a_text_formatter.add ("%"")
				a_text_formatter.add_new_line
				a_text_formatter.add ("Referenced from: ")
				a_text_formatter.add (second.group.target.system.file_name)
				a_text_formatter.add_string (" (")
				a_text_formatter.add (second.group.name)
				a_text_formatter.add_char (')')
			end
			a_text_formatter.add_new_line
		end

feature {UNIVERSE_I, CLUSTER_I} -- Setting

	set_first (c: like first)
			-- Assign `c' to `first'.
		require
			c_not_void: c /= Void
		do
			first := c
		ensure
			first_set: first = c
		end

	set_second (c: like second)
			-- Assing `c' to `second'.
		require
			c_not_void: c /= Void
		do
			second := c
		ensure
			second_set: second = c
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class VSCN
