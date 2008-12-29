note
	description: "Error if unique class names are enforced and the class names are not unique."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VD87

inherit
	CLUSTER_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_first, a_second: CLASS_I)
			-- Create.
		require
			a_first_not_void: a_first /= Void
			a_second_not_void: a_second /= Void
		do
			first := a_first
			second := a_second
		end

feature -- Properties

	first: CLASS_I
			-- First class in conflict

	second: CLASS_I
			-- Second class in conflict with first

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
		local
			l_ext: EXTERNAL_CLASS_I
		do
			put_cluster_name (a_text_formatter)
			a_text_formatter.add ("First class: ")
			a_text_formatter.add_classi (first, first.name)
			a_text_formatter.add_new_line
			l_ext ?= first
			if l_ext /= Void then
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("First file: %"")
				a_text_formatter.add (first.file_name)
			end
			a_text_formatter.add ("%"")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Second class: ")
			a_text_formatter.add_classi (second, second.name)
			a_text_formatter.add_new_line
			l_ext ?= second
			if l_ext /= Void then
				a_text_formatter.add ("In assembly: %"")
				l_ext.assembly.format (a_text_formatter)
			else
				a_text_formatter.add ("Second file: %"")
				a_text_formatter.add (second.file_name)
			end
			a_text_formatter.add ("%"")
			a_text_formatter.add_new_line
		end

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
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
