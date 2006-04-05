indexing
	description: "Pre processor of XML content.  Functions here are used to apply project-wide%
		%settings into document content, e.g. process includes, headers, footers, external file references, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			if 
				preferences.generate_dhtml_filter and then
				generation_data.is_generating and then
				shared_constants.help_constants.is_web_help
			then			
				insert_filter_script
			end
			if preferences.process_includes then
				insert_includes
			end
			insert_content_div
		end		

feature {NONE} -- Processing

	insert_content_div is
			-- Insert reference to content style which excludes header and footer
		local
			l_parent,			
			l_content: XM_ELEMENT	
			l_ns: XM_NAMESPACE		
		do			
			l_parent := internal_xml.element_by_name ("document")
			if l_parent /= Void then
				create l_ns.make_default				
				create l_content.make (l_parent, "outer_content", l_ns)
				l_parent.put_last (l_content)
				l_parent := l_parent.element_by_name ("paragraph")				
				if l_parent /= Void then
					
							-- Move the header and footer up a level				
					if header_inserted then
						l_content.put_first (l_parent.item (1))
					end
					
					l_content.put_last (l_parent)
					
					if footer_inserted then
						l_content.put_last (l_parent.last)
						l_parent.remove (l_parent.count - 1)
					else
						l_parent.remove_last
					end								
							
					l_content.set_name ("paragraph")					
					l_parent.set_name ("div")						
					l_parent.put_first (create {XM_ATTRIBUTE}.make ("style", l_ns, "content_style", l_parent))				
				end
			end	
		end

	insert_html_stylesheet_link is
			-- Insert reference to project or document HTML stylesheet file
		local
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
						create l_stylesheet_tag.make (l_parent, "stylesheet", create {XM_NAMESPACE}.make_default)
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
			l_filename: STRING
		do
				-- Build header
			if preferences.use_header_file then
				l_filename := shared_project.preferences.header_name
				if l_filename /= Void and not l_filename.is_empty then
					if preferences.override_file_header_declarations then
						create l_header.make_from_file (shared_project.preferences.header_name)	
					end
				end
			else
				if internal_xml.document /= Void then
					create l_header.make_from_document_data (internal_xml.document)
				end
			end			
			
				-- Insert header in document
			if l_header /= Void then
				l_parent := internal_xml.element_by_name ("document")
				if l_parent /= Void then
					l_parent := l_parent.element_by_name ("paragraph")
					if l_parent /= Void then					
						l_parent.put_first (l_header.root_element)
						header_inserted := True
					end
				end
			end
		end
		
	insert_footer is
			-- Insert footer
		local
			l_footer: DOCUMENT_FOOTER
			l_parent: XM_ELEMENT
			l_filename: STRING
		do
				-- Build footer
			if preferences.use_footer_file then
				l_filename := shared_project.preferences.footer_name
				if l_filename /= Void and not l_filename.is_empty then
					if preferences.override_file_header_declarations then
						create l_footer.make_from_file (shared_project.preferences.footer_name)	
					end
				end
			else
				create l_footer.make_from_file (footer_xml_template_file_name)
			end
			
				-- Insert footer in document
			if l_footer /= Void then
				l_parent := internal_xml.element_by_name ("document")
				if l_parent /= Void then
					l_parent := l_parent.element_by_name ("paragraph")
					if l_parent /= Void then					
						l_parent.put_last (l_footer.root_element)		
						footer_inserted := True
					end
				end
			end
		end		
		
	insert_navigation_links is
			-- Insert project navigation links
		local
			l_toc: TABLE_OF_CONTENTS
			l_node,	l_parent: TABLE_OF_CONTENTS_NODE
			l_label, l_url,	l_link_text, l_separator: STRING		
			l_doc_link: DOCUMENT_LINK
			l_xm_parent, l_xm_link, l_xm_label, l_xm_url: XM_ELEMENT
			l_is_one: BOOLEAN
		do
			create l_link_text.make_empty
			l_toc := shared_constants.help_constants.toc
			if l_toc /= Void then
					-- Get node matching document
				l_node := l_toc.node_by_url (internal_xml.name)
				l_xm_parent := internal_xml.element_by_name ("document")
				if l_xm_parent /= Void then
  					l_xm_parent := l_xm_parent.element_by_name ("paragraph")
  					if l_xm_parent /= Void then
  						l_xm_parent := l_xm_parent.element_by_name ("span")	
  						if l_xm_parent /= Void then
  							l_xm_parent := l_xm_parent.elements.item (2)
  							if l_xm_parent /= Void then
  								l_xm_parent := l_xm_parent.elements.item (1)
  								if l_xm_parent /= Void then
  									l_xm_parent := l_xm_parent.elements.item (1)
  								end
  							end
  						end
  					end
      			end
				if l_node /= Void and l_xm_parent /= Void then
						-- Move internal cursor of `l_xm_parent' at the end for proper additional
						-- insertions.
					check
						l_xm_parent_not_empty: not l_xm_parent.is_empty
					end
					l_xm_parent.finish

					if l_node.url /= Void then
						create l_doc_link.make (l_node.url.twin, l_node.url.twin)
					end					
			
						-- Build link information					
					from					
						l_separator := " > "
						l_parent := l_node.parent
					until
						l_parent = Void
					loop
							-- Take parent information of node recursively and build link text
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
							if l_parent /= Void then
								l_is_one := True
								create l_xm_link.make (l_xm_parent, "link", create {XM_NAMESPACE}.make_default)
           						create l_xm_label.make (l_xm_link, "label", create {XM_NAMESPACE}.make_default)							
								l_xm_label.put_first (create {XM_CHARACTER_DATA}.make (l_xm_label, l_label))
        						l_xm_link.put_first (l_xm_label)
        						if l_url /= Void then
									create l_xm_url.make (l_xm_link, "url", create {XM_NAMESPACE}.make_default)
									l_xm_url.put_first (create {XM_CHARACTER_DATA}.make (l_xm_url, l_url))
           							l_xm_link.put_first (l_xm_url)								
           						end
           						if l_parent /= Void then								
           							l_xm_parent.put_right (l_xm_link)
           							if l_parent.parent /= Void then
           								l_xm_parent.put_right (create {XM_CHARACTER_DATA}.make (l_xm_parent, l_separator))
           							end
           						end
							end
						end					
					end
					
						-- Create a default link to the root of the tree
					if l_is_one then
           				l_xm_parent.put_right (create {XM_CHARACTER_DATA}.make (l_xm_parent, l_separator))
           			end
					create l_xm_link.make (l_xm_parent, "link", create {XM_NAMESPACE}.make_default)
           			create l_xm_label.make (l_xm_link, "label", create {XM_NAMESPACE}.make_default)							
					l_xm_label.put_first (create {XM_CHARACTER_DATA}.make (l_xm_label, "Documentation Home"))
        			l_xm_link.put_first (l_xm_label)
        			create l_xm_url.make (l_xm_link, "url", create {XM_NAMESPACE}.make_default)
        			if l_url /= Void then
        				l_xm_url.put_first (create {XM_CHARACTER_DATA}.make (l_xm_url, "../" + l_url))
        			else
        				l_xm_url.put_first (create {XM_CHARACTER_DATA}.make (l_xm_url, "/index.html"))
        			end					
           			l_xm_link.put_first (l_xm_url)								           			
					l_xm_parent.put_right (l_xm_link)						
				end
			end
		end		

	insert_filter_script is
			-- Insert filter script for web generated help project.
			-- Note: this is required because Internet Explorer does not
			-- support the captureEvents() JavaScript method and therefore
			-- a page load event handler is required for all page so that
			-- it can filter out unwanted content at loading time.
		local
			l_script_text,
			l_toc_name: STRING
			l_parent,
			l_script_tag: XM_ELEMENT
			l_util: UTILITY_FUNCTIONS
		do
			if not shared_constants.help_constants.is_tree_web_help then				
				if generation_data.filter_toc_hash.count < 2 then					
					l_toc_name := "simple_toc_single.js"
				else						
					l_toc_name := "simple_toc.js"
				end
			else				
				l_toc_name := "toc.js"
			end
			create l_util		
			l_script_text := "doc = '"
			l_script_text.append (l_util.toc_friendly_url (l_util.file_no_extension (internal_xml.name)) + ".html';")
			l_script_text.append ("toc = '" + l_util.short_name (shared_constants.help_constants.toc.name) + "';")
			l_script_text.append ("deleteCookie('tocName');var now = new Date();var expdate = new Date (now.getTime () + 1 * 24 + 60 * 60 * 1000);setCookie ('tocName', toc, expdate);")
			l_script_text.append ("if (parent.toc_frame){parent.toc_frame.documentLoaded(doc);}%
				%else{var now = new Date();var expdate = new Date (now.getTime () + 1 * 24 + 60 * 60 * 1000);setCookie ('delete', 'true', expdate);%
				%setCookie ('redirecturl', doc, expdate);window.location.replace ('" + relative_path_to_help_project (internal_xml.name) + 
				shared_constants.help_constants.help_project_name + "_no_content.html');}")
			l_parent := internal_xml.element_by_name ("document")
			if l_parent /= Void then
					-- Insert script in header
				l_parent := l_parent.element_by_name ("meta_data")
				if l_parent /= Void then
						-- External Javascript includes					
					create l_script_tag.make (l_parent, "script", create {XM_NAMESPACE}.make_default)
					l_script_tag.put_last (create {XM_ATTRIBUTE}.make ("Language", create {XM_NAMESPACE}.make_default, "JavaScript", l_script_tag))
					l_script_tag.put_last (create {XM_ATTRIBUTE}.make ("type", create {XM_NAMESPACE}.make_default, "text/javascript", l_script_tag))
					l_script_tag.put_last (create {XM_ATTRIBUTE}.make ("src", create {XM_NAMESPACE}.make_default, relative_path_to_help_project (internal_xml.name) + l_toc_name, l_script_tag))
					l_parent.put_last (l_script_tag)
					
						-- Page Load event handler
					create l_script_tag.make (l_parent, "script", create {XM_NAMESPACE}.make_default)
					l_script_tag.put_last (create {XM_ATTRIBUTE}.make ("Language", create {XM_NAMESPACE}.make_default, "JavaScript", l_script_tag))
					l_script_tag.put_last (create {XM_CHARACTER_DATA}.make (l_script_tag, l_script_text))
					l_parent.put_last (l_script_tag)
				end
			end						
		end		

	insert_includes is
			-- Find all includes directives and insert into document
		do
			-- TO DO
		end		

feature {NONE} -- Implementation

	internal_xml: DOCUMENT_XML
			-- XML

	preferences: DOCUMENT_PROJECT_PREFERENCES is
			-- Preferences
		once
			Result := shared_project.preferences	
		end
	
	header_inserted,
	footer_inserted: BOOLEAN	
			-- Was header/footer inserted?
		
	relative_path_to_help_project (a_file: STRING): STRING is
			-- 
		local
			l_link: DOCUMENT_LINK
			l_path: STRING
		do
			l_path := temporary_html_location (a_file, True)			
			create l_link.make (l_path, shared_constants.application_constants.temporary_html_directory.string)
			Result := l_link.relative_url
			if Result.last_index_of ('/', Result.count) > 0 then				
				Result := Result.substring (1, Result.last_index_of ('/', Result.count))
			end
			if generation_data.filter_toc_hash.count < 2 and then Result.substring (1, 3).is_equal ("../") then
				Result.replace_substring ("", 1, 3)
			end
		end		
		
invariant
	has_content: internal_xml /= Void

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
end -- class XML_PRE_PROCESSOR
