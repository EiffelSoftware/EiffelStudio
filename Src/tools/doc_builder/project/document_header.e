indexing
	description: "Document header."
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

end -- class DOCUMENT_HEADER
