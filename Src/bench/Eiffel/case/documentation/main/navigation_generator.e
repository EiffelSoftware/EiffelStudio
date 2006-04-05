indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAVIGATION_GENERATOR

create
	make

feature -- Initialize

	make (gen: HTML_GENERATOR) is
		do
		--	format_generator := gen
		end

feature -- Actions


	generate_index ( dir_path: STRING) is
		local
			fi_n: FILE_NAME
			fi: PLAIN_TEXT_FILE
		do
				-- Copy the index file.
		--	Create fi_n.make_from_String("index.html")
		--	navigation_template.process_file("index.html")
		--	Create fi_n.make_from_string(dir_path)
		--	fi_n.extend("index.html")
		--	Create fi.make_create_read_write(fi_n)
		--	fi.put_string(navigation_template.result_string)
		--	fi.close	
--
	--			-- Process the navigation file.
	--		navigation_template.initialize("navigation_template")
			
		end

feature -- Implementation

	navigation_template: XML_DOCUMENTATION_READER is
		once
			Create Result.make
		end

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

end -- class NAVIGATION_GENERATOR
