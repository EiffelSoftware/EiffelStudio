indexing
	description: "Custom XML to send for transformation which is not an intrinsic part%
		%of the XML being transformed.  Final XML including custom tags is found in `text'"
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_XML

inherit
	SHARED_OBJECTS
	
	XML_ROUTINES

create
	make_from_xml

feature -- Creation

	make_from_xml (a_xml: STRING) is
			-- Initialize with `a_xml'
		require
			xml_not_void: a_xml /= Void
			is_valid_xml (a_xml)
		do
			document := deserialize_text (a_xml)
			add_hierarchy_links
		end	
		
feature -- Access
		
	document: XM_DOCUMENT
			-- Initial xml
			
feature {NONE} -- Implementation

	add_hierarchy_links is
			-- Add XML representing hierarchical link structure of documents generated from a
			-- multi-directory project
		local
			l_start, l_cnt: INTEGER
			l_path, l_link_separator: STRING
			l_par_element, l_link_element, l_url_element, l_label_element: XM_ELEMENT
			links: ARRAYED_LIST [XM_ELEMENT]
		do
			if not Location_string_titles.is_empty then
				if document.root_element.count > 1 then
					l_par_element ?= document.root_element @ (2)
				end				
				if l_par_element /= Void then
					from
						create links.make (3)
						create l_path.make_empty
						create l_link_separator.make_from_string (" > ")
						Location_string_titles.finish
					until
						Location_string_titles.before
					loop
						create l_link_element.make_child (l_par_element, "link", Void)
						create l_url_element.make_child (l_link_element, "url", Void)
						create l_label_element.make_child (l_link_element, "label", Void)
						l_link_element.put_first (l_label_element)
						l_link_element.put_first (l_url_element)							
						l_link_element.element_by_name ("url").put_first (create {XM_CHARACTER_DATA}.make (l_link_element, l_path + "index.html"))
						l_link_element.element_by_name ("label").put_first (create {XM_CHARACTER_DATA}.make (l_link_element, Location_string_titles.item))
						links.extend (l_link_element)
						Location_string_titles.back
						l_path.append ("../")
					end						

					if not links.is_empty then
						from
							links.start
						until
							links.after
						loop
							l_par_element.put_first (links.item)
							if not (links.item = links.last) then
								l_par_element.put_first (create {XM_CHARACTER_DATA}.make (l_par_element, l_link_separator))
							end
							links.forth
						end
						l_par_element.put_first (create {XM_CHARACTER_DATA}.make (l_par_element, "<line_break/>"))
					end
				end
			end			
		end		

end -- class CUSTOM_XML
