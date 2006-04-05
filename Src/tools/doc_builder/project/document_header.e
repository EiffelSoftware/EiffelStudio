indexing
	description: "Document header."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_HEADER

inherit
	DOCUMENT_XML	

	TEMPLATE_CONSTANTS
		undefine
			copy,
			is_equal
		end

create
	make_from_file,
	make_from_text,
	make_from_document_data

feature -- Create

	make_from_document_data (a_document: DOCUMENT) is
			-- Make new header based upon data in a_document
		require
			document_not_void: a_document /= Void
		local
			l_text,
			l_product: STRING
		do			
			l_text := file_text.twin
			l_product := (create {SHARED_OBJECTS}).shared_project.filter_manager.filter.description
			if l_product.is_equal ((create {OUTPUT_CONSTANTS}).unfiltered) then
				l_product.wipe_out
			end
			replace_token (l_text, html_product_token, l_product)
			replace_token (l_text, html_title_token, a_document.title)
			replace_token (l_text, html_navigation_token, "")
			
			make_from_text (l_text)
		ensure
			generation_successful: not text.is_empty
		end

	file_text: STRING is
			-- The text of the file
		local
			l_file: PLAIN_TEXT_FILE
		once
			create l_file.make_open_read (header_xml_template_file_name)
			l_file.readstream (l_file.count)
			Result := l_file.last_string.twin
			l_file.close
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
end -- class DOCUMENT_HEADER
