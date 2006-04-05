indexing
	description: "All information about the wizard ... "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INFORMATION

Creation
	make

feature {WIZARD_WINDOW} -- Initialization
	make is
		do
			Create list_of_html_pages.make
			generation_location:= ""
			project_location:= ""
		end

feature -- Setting

	set_project_location (a_loc: STRING) is
		require
			not_void: a_loc /= Void
		do
			project_location:= a_loc
		ensure
			set: project_location = a_loc
		end

	set_generation_location (a_location: STRING) is
		require
			not_void: a_location /= Void
		do
			generation_location:= a_location
		ensure
			set: generation_location = a_location
		end

	set_new_project is
		do
			is_new_project := TRUE
		ensure
			is_new_project
		end

	set_files(li: LINKED_LIST[STRING]) is
		require
			list_exists: li /= Void
		do
			list_of_html_pages := li
		ensure
			set: li = list_of_html_pages
		end

feature -- Access

	is_new_project: BOOLEAN

	project_location: STRING

	generation_location: STRING

	list_of_html_pages: LINKED_LIST [STRING];

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class WIZARD_INFORMATION
