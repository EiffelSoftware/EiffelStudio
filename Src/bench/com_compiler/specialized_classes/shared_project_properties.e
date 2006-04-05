indexing
	description: "Shared compiler properties"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PROJECT_PROPERTIES
	
feature -- Access

	html_document_generator: CELL [HTML_DOC_GENERATOR] is
			-- html document generator for a project
		once
			create Result.put (Void)
		end
		
	compiler: CELL [COMPILER] is
			-- compiler for project
		once
			create Result.put (Void)
		end
		
	main_window: MAIN_WINDOW is
			-- main windows for server
		once
			create Result.make_top ("Should not see me!")
		end
		
	generate_html_docs_msg: INTEGER is 0x500
			-- generate html docs message
			
	compile_msg: INTEGER is 0x501
			-- compile system message
		
feature -- Status Setting

	set_html_document_generator (a_generator: HTML_DOC_GENERATOR) is
			-- set 'html_document_generator' cell item with 'a_generator'
		require
			non_void_generator: a_generator /= Void
		do
			html_document_generator.put (a_generator)
		end
		
	set_compiler (a_compiler: COMPILER) is
			-- set 'compile' cell item with 'a_compiler'
		require
			non_void_compiler: a_compiler /= Void
		do
			compiler.put (a_compiler)
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
end -- class SHARED_PROJECT_PROPERTIES
