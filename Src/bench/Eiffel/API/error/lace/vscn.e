indexing
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

	first: CLASS_I
			-- First class in conflict

	second: CLASS_I
			-- Second class in conflict with first

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			l_ext: EXTERNAL_CLASS_I
		do
			put_cluster_name (a_text_formatter)
			a_text_formatter.add ("First class: ")
			first.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			if first.is_external_class then
				l_ext ?= first
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("First file: %"")
				a_text_formatter.add (first.file_name)
			end
			a_text_formatter.add ("%"")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Second class: ")
			second.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			if second.is_external_class then
				l_ext ?= second
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("Second file: %"")
				a_text_formatter.add (second.file_name)
			end
			a_text_formatter.add ("%"")
			a_text_formatter.add_new_line
		end

feature {UNIVERSE_I, CLUSTER_I, CLUST_REN_SD} -- Setting

	set_first (c: CLASS_I) is
			-- Assign `c' to `first'.
		require
			c_not_void: c /= Void
		do
			first := c
		ensure
			first_set: first = c
		end

	set_second (c: CLASS_I) is
			-- Assing `c' to `second'.
		require
			c_not_void: c /= Void
		do
			second := c
		ensure
			second_set: second = c
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class VSCN
