indexing
	description: "XM_DOCUMENT for DOCUMENTs"
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_XML

inherit
	XM_DOCUMENT
		rename
			text as xm_text
		end
	
	SHARED_OBJECTS
		undefine
			copy,
			is_equal
		end
		
	UTILITY_FUNCTIONS
		undefine
			copy,
			is_equal
		end
		
	XML_ROUTINES
		undefine
			copy,
			is_equal
		end
	
create
	make_from_document
	
feature {DOCUMENT} -- Creation

	make_from_document (a_document: DOCUMENT) is
			-- Set `internal_document'
		require
			document_not_void: a_document /= Void
		local
			l_xml: XM_DOCUMENT
		do
			make
			internal_document := a_document
			l_xml := deserialize_text (internal_document.text)
			if l_xml /= Void then
				set_root_element (l_xml.root_element)
				valid := True
			end				
		ensure
			has_document: internal_document /= Void
		end
	
feature -- Access

	text: STRING is
			-- Text
		do
			Result := document_text (Current)	
		end		
		
	valid: BOOLEAN
			-- Valid XML?
	
feature {DOCUMENT} -- Status Setting

	add_custom_elements is
			-- Add custom elements to xml structure
		local
			l_path: STRING
			l_parent: XM_ELEMENT
		do			
			l_parent := element_by_name ("document")
			if l_parent /= Void then
				l_parent := l_parent.element_by_name ("meta_data")
				if l_parent /= Void then
					l_path := stylesheet_path
					if l_path /= Void then
						create stylesheet_tag.make_child (l_parent, "stylesheet", Void)
						stylesheet_tag.put_last (create {XM_ATTRIBUTE}.make ("rel", Void, "stylesheet", stylesheet_tag))
						stylesheet_tag.put_last (create {XM_ATTRIBUTE}.make ("href", Void, stylesheet_path, stylesheet_tag))
						l_parent.put_last (stylesheet_tag)
					end
				end
			end					
		end

	remove_custom_elements is
			-- Remove custom elements
		local
			l_element: XM_ELEMENT
		do
			l_element := element_by_name ("document")
			if l_element /= Void then
				l_element := l_element.element_by_name ("meta_data")
				if l_element /= Void then
					l_element := l_element.element_by_name ("stylesheet")
					if l_element /= Void then
						l_element.parent.delete (l_element)
					end	
				end
			end			
		end		
	
feature -- Custom Tags

	stylesheet_tag: XM_ELEMENT
			-- Tag representing stylesheet, if any
		
feature {NONE} -- Implementation

	stylesheet_path: STRING is
			-- Path to stylesheet
		local
			l_name,
			l_path: STRING
			l_file_path: FILE_NAME
			l_link: DOCUMENT_LINK
		do
			if Shared_project.preferences.has_stylesheet_file then
				l_name := Shared_project.preferences.stylesheet_file
						-- Create a project relative link to the stylesheet file
				create l_link.make (internal_document.name, l_name)
				l_path := l_link.relative_url
				if l_path /= Void then
					create l_file_path.make_from_string (l_path)	
					Result := l_file_path.string
				end
			end				
		end		

	internal_document: DOCUMENT
			-- Actual document

invariant
	has_document: internal_document /= Void

end -- class DOCUMENT_XML
