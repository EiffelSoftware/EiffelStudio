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
			document_valid: a_document.is_valid_to_schema
		local
			l_product: STRING
		do
			make_from_file (header_xml_template_file_name)
			l_product := (create {SHARED_OBJECTS}).shared_project.filter_manager.filter.description
			if l_product.is_equal ((create {OUTPUT_CONSTANTS}).unfiltered) then
				l_product. wipe_out
			end
			insert_product (l_product)
			insert_title (a_document.title)
			insert_navigation_string ("")
		ensure
			generation_successful: not text.is_empty
		end

feature -- Commands

	insert_navigation_string (a_string: STRING) is
			-- Insert navigation details
		require
			nav_not_void: a_string /= Void
		local
			l_nav_el: XM_ELEMENT
		do			
			l_nav_el := element_by_name ("table").elements.item (2).elements.item (2)
			wipe_out_text (l_nav_el)
			l_nav_el.put_last (create {XM_CHARACTER_DATA}.make (l_nav_el, a_string))
		end		

	insert_title (a_title: STRING) is
			-- Insert title
		require
			title_not_void: a_title /= Void
		local
			l_title_el: XM_ELEMENT
		do			
			l_title_el := element_by_name ("table").elements.item (2).element_by_name ("cell")
			wipe_out_text (l_title_el)
			l_title_el.put_last (create {XM_CHARACTER_DATA}.make (l_title_el, a_title))
		end
		
	insert_product (a_product: STRING) is
			-- Insert product
		require
			product_not_void: a_product /= Void
		local
			l_prod_el: XM_ELEMENT
		do			
			l_prod_el := element_by_name ("table").element_by_name ("row").element_by_name ("cell")
			wipe_out_text (l_prod_el)
			l_prod_el.put_last (create {XM_CHARACTER_DATA}.make (l_prod_el, a_product))			
		end		

end -- class DOCUMENT_HEADER
