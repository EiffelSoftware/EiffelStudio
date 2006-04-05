indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			process_message
		end
		
	SHARED_PROJECT_PROPERTIES
		export
			{NONE} all
		end
		
create 
	make_top
	
feature {WEL_DISPATCHER}

	process_message (hwnd: POINTER; msg:INTEGER; wparam, lparam: POINTER): POINTER is
			-- Was declared in WEL_COMPOSITE_WINDOW as synonym of `composite_process_message'.
		do
			inspect msg
			when generate_html_docs_msg then
				check
					non_void_html_document_generator: html_document_generator /= Void
				end
				html_document_generator.item.generate_docs
				Result := default_pointer
			when compile_msg then
				check
					non_void_compiler: compiler /= Void
				end
				compiler.item.compile (lparam.to_integer_32)
				Result := default_pointer
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

feature {HTML_DOC_GENERATOR}

	process_generate_message is
			-- process the generate HTML docs message
		do
			cwin_post_message (item, generate_html_docs_msg, default_pointer, default_pointer)
		end

feature {COMPILER}
		
	process_compile (mode: INTEGER) is
			-- process melt compile system message
		do
			cwin_post_message (item, compile_msg, default_pointer, default_pointer + mode)
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
end -- class MAIN_WINDOW
