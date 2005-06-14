indexing
	description: "Table of contents in XML representation."
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
			is_equal,
			string_
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
			l_ns: XM_NAMESPACE
		do
			make
			create l_ns.make_default
			create l_root.make_root (Current, root_string, l_ns)
			set_root_element (l_root)
			build (a_toc, root_element)
			save_xml_document (Current, a_filename)
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
			l_ns: XM_NAMESPACE
		do
			if a_node.id > 0 then
					-- Build element from node details
				create l_ns.make_default
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
				create l_node.make (a_parent, l_name, create {XM_NAMESPACE}.make_default)			
				create l_node_attribute.make ("id", l_ns, l_id.out, l_node)
				l_node.put_last (l_node_attribute)
				if l_title /= Void then
					create l_node_attribute.make ("title", l_ns, l_title, l_node)
					l_node.put_last (l_node_attribute)
				end
				if l_url /= Void then
					create l_node_attribute.make ("url", l_ns, l_url, l_node)
					l_node.put_last (l_node_attribute)
				end
				if l_icon /= Void then
					create l_node_attribute.make ("icon", l_ns, l_icon, l_node)
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

end -- class XML_TABLE_OF_CONTENTS
