indexing
	description: "Table of contents in XML representation.  Can be filtered and sorted."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS

inherit
	XM_DOCUMENT
		rename
			sort as xml_sort
		end
	
	XML_ROUTINES
		undefine
			copy,
			is_equal
		end	
		
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			copy,
			is_equal
		end
		
create
	make_from_toc

feature -- Creation
			
	make_from_toc (a_toc: TABLE_OF_CONTENTS; a_filename: STRING) is
			-- Make from `a_toc' and save with a_filename
		require
			toc_not_void: a_toc /= Void
		local
			l_root: XM_ELEMENT	
		do
			make
			toc := a_toc
			filename := a_filename
			create l_root.make_root (Current, "table_of_contents", Void)
			set_root_element (l_root)
			build (toc, root_element)
			save_xml_document (Current, filename)
		ensure
			has_toc: toc /= Void
		end

feature {NONE} -- XML
	
	build (a_node: TABLE_OF_CONTENTS_NODE; a_parent: XM_ELEMENT) is
			-- Build XML for `a_node'
		require
			parent_not_void: a_parent /= Void
		local
			l_name,
			l_title,
			l_url,
			l_icon: STRING
			l_id: INTEGER
			l_heading: BOOLEAN
			l_node: XM_ELEMENT
			l_node_attribute: XM_ATTRIBUTE
		do
			if a_node.id > 0 then
					-- Build element from node details
				l_id := a_node.id
				l_title := a_node.title
				l_url := a_node.url
				l_icon := a_node.icon
				l_heading := a_node.has_child
				if l_heading then
					l_name := Heading_string
				else
					l_name := Topic_string
				end
				create l_node.make_child (a_parent, l_name, create {XM_NAMESPACE}.make_default)			
				create l_node_attribute.make ("id", Void, l_id.out, l_node)
				l_node.put_last (l_node_attribute)
				if l_title /= Void then
					create l_node_attribute.make ("title", Void, l_title, l_node)
					l_node.put_last (l_node_attribute)
				end
				if l_url /= Void then
					create l_node_attribute.make ("url", Void, l_url, l_node)
					l_node.put_last (l_node_attribute)
				end
				if l_icon /= Void then
					create l_node_attribute.make ("icon", Void, l_icon, l_node)
					l_node.put_last (l_node_attribute)
				end
				
				a_parent.put_last (l_node)
			else
				l_node := a_parent
			end
			
			
			if a_node.has_child then
				from
					a_node.children.start
				until
					a_node.children.after
				loop
					build (a_node.children.item, l_node)
					a_node.children.forth
				end
			end
		end		
		
feature {NONE} -- Implementation

	toc: TABLE_OF_CONTENTS
			-- Toc

	filename: STRING
			-- Filename

end -- class XML_TABLE_OF_CONTENTS
