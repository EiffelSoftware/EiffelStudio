indexing
	description: "Pre processor of XML content.  Functions here are used to apply project-wide%
		%settings into document content, e.g. process includes, headers, footers, external file references, etc."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_PRE_PROCESSOR

inherit
	UTILITY_FUNCTIONS
	
	SHARED_OBJECTS
	
	TEMPLATE_CONSTANTS

create {DOCUMENT_XML}
	make
	
feature -- Creation
	
	make (a_xml: like internal_xml) is
			-- Create
		require
			xml_not_void: a_xml /= Void
		do
			internal_xml := a_xml
		ensure
			has_content: internal_xml /= Void
		end	
		
feature -- Commands

	process is
			-- Process
		do
			if preferences.process_html_stylesheet then
				insert_html_stylesheet_link
			end
			if preferences.process_header then
				insert_header
			end
			if preferences.process_footer then
				insert_footer
			end
			if preferences.include_navigation_links then
				insert_navigation_links
			end
		end		

feature {NONE} -- Processing

	insert_html_stylesheet_link is
			-- Insert reference to project or document HTML stylesheet file
		local
			l_name,
			l_path: STRING
			l_parent,
			l_stylesheet_tag: XM_ELEMENT
		do			
			l_parent := internal_xml.element_by_name ("document")
			if l_parent /= Void then
				l_parent := l_parent.element_by_name ("meta_data")
				if l_parent /= Void then
					l_path := stylesheet_path (internal_xml.name, True)
					if l_path /= Void then
						create l_stylesheet_tag.make_child (l_parent, "stylesheet", create {XM_NAMESPACE}.make_default)
						l_stylesheet_tag.put_last (create {XM_CHARACTER_DATA}.make (l_stylesheet_tag, l_path))
						l_parent.put_last (l_stylesheet_tag)
					end
				end
			end	
		end

	insert_header is
			-- Insert header
		local
			l_header: DOCUMENT_HEADER
			l_parent: XM_ELEMENT
		do
				-- Build header
			if preferences.use_header_file then
				if preferences.override_file_header_declarations then
					create l_header.make_from_file (shared_project.preferences.header_name)	
				else
				end
			else
				if internal_xml.document /= Void then
					create l_header.make_from_document_data (internal_xml.document)
				end
			end			
			
				-- Insert header in document
			l_parent := internal_xml.element_by_name ("document")
			if l_parent /= Void then
				l_parent := l_parent.element_by_name ("paragraph")
				if l_parent /= Void then					
					l_parent.put_first (l_header.root_element)		
				end
			end
		end
		
	insert_footer is
			-- Insert footer
		local
			l_footer: DOCUMENT_FOOTER
			l_parent: XM_ELEMENT
		do
				-- Build footer
			if preferences.use_footer_file then
				if preferences.override_file_footer_declarations then
					create l_footer.make_from_file (shared_project.preferences.footer_name)	
				else
				end
			else
				create l_footer.make_from_file (footer_xml_template_file_name)
			end
			
				-- Insert footer in document
			l_parent := internal_xml.element_by_name ("document")
			if l_parent /= Void then
				l_parent := l_parent.element_by_name ("paragraph")
				if l_parent /= Void then					
					l_parent.put_last (l_footer.root_element)		
				end
			end
		end		
		
	insert_navigation_links is
			-- Insert project navigation links
		local
			l_toc: TABLE_OF_CONTENTS
			l_node,
			l_parent: TABLE_OF_CONTENTS_NODE
			l_no_higher: BOOLEAN
			l_links_xml,
			l_link_xml,
			l_label,
			l_url,
			l_separator: STRING		
			l_xm_parent, l_xm_link, l_xm_label, l_xm_url: XM_ELEMENT
			l_doc_link: DOCUMENT_LINK
		do
			l_toc := shared_constants.help_constants.toc
			if l_toc /= Void then
					-- Get node matching document
				l_node := l_toc.node_by_url (internal_xml.name)
				if l_node /= Void then
					
						-- Determine element in which to put link xml
					l_xm_parent := internal_xml.element_by_name ("document")
					if l_xm_parent /= Void then
						l_xm_parent := l_xm_parent.element_by_name ("paragraph").element_by_name ("span").element_by_name ("table").elements.item (2).elements.item (2)
					end
					
					if l_node.url /= Void then
						create l_doc_link.make (l_node.url.twin, l_node.url.twin)
					end
											
					from					
						l_separator := " &gt; "
						l_parent := l_node.parent
					until
						l_parent = Void
					loop
							-- Take parent information of node recursively and build XML link
						if l_parent.title /= Void then							
							l_label := l_parent.title.twin	
						end
						if l_parent.url /= Void then
							if l_doc_link /= Void then
								l_doc_link.set_url (l_parent.url.twin)
								l_url := l_doc_link.relative_url
							end
						end
						l_node := l_parent
						l_parent := l_node.parent
						if l_label /= Void then
							create l_xm_link.make_child (l_xm_parent, "link", create {XM_NAMESPACE}.make_default)
							create l_xm_label.make_child (l_xm_link, "label", create {XM_NAMESPACE}.make_default)							
							l_xm_label.put_first (create {XM_CHARACTER_DATA}.make (l_xm_label, l_label))
							l_xm_link.put_first (l_xm_label)
							if l_url /= Void then
								create l_xm_url.make_child (l_xm_link, "url", create {XM_NAMESPACE}.make_default)
								l_xm_url.put_first (create {XM_CHARACTER_DATA}.make (l_xm_url, l_url))
								l_xm_link.put_first (l_xm_url)								
							end
							if l_parent /= Void then								
								l_xm_parent.put_first (l_xm_link)	
								if l_parent.parent /= Void then
									l_xm_parent.put_first (create {XM_CHARACTER_DATA}.make (l_xm_parent, l_separator))
								end
							end
						end					
					end
				end
			end
		end		

feature {NONE} -- Implementation

	internal_xml: DOCUMENT_XML
			-- XML

	preferences: DOCUMENT_PROJECT_PREFERENCES is
			-- Preferences
		once
			Result := shared_project.preferences	
		end
		
invariant
	has_content: internal_xml /= Void

end -- class XML_PRE_PROCESSOR
