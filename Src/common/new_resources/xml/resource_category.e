indexing
	description: "Class which encapsulates the information relative to a resource category."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_CATEGORY
 
creation
	make 

feature -- Initialization

	make(doc: XML_ELEMENT;struc: RESOURCE_STRUCTURE) is 
			-- Initialization
		local
			l1,l2: LINKED_LIST [XML_COMPOSITE]
			f1: XML_FIELD
			s1: XML_STRING
			resource: XML_RESOURCE
			category: RESOURCE_CATEGORY
			cursor,des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node,category_node: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
			att: XML_ATTRIBUTE
		do
			!! id.make(20)
			!! Resources.make
			!! Categories.make
			!! description.make(20)
			cursor := doc.new_cursor
			att := doc.attributes.item("TOPIC_ID")
			if att /= Void then
				id := att.value
			end
			from
				cursor.start
			until
				cursor.after
			loop
				node ?= cursor.item
				if node/=Void then
						if node.name.is_equal("HEAD") then
							des_cursor := node.new_cursor
							from
								des_cursor.start
							until
								des_cursor.after
							loop
								txt ?= des_cursor.item
								if txt /= Void then
									description.append(txt.string)
								end
								des_cursor.forth
							end		
						elseif node.name.is_equal("TEXT") then
							!! resource.make(node,struc)
							resources.extend(resource)
						elseif node.name.is_equal("TOPIC") then
							!! category.make(node,struc)
							categories.extend(category)
						end
				end
				cursor.forth
			end	
			if id=Void then
				id := "TOPIC_ID not supplied for "
				if not description.empty then
					id.append(description)
				else
					id := "unknown TOPIC( no description supplied either )"
				end	
				id.append("%N")	
				io.put_string(id)
				id := "error"
			else
				id.prune_all('%R')
				id.prune_all('%T')
				id.prune_all('%N')
			end
		end

feature -- Implementation

	Description: STRING
		-- Description of Current.

	resources: LINKED_LIST [ XML_RESOURCE ]
		-- List of resources.

	categories: LINKED_LIST [ RESOURCE_CATEGORY ]
		-- List of Categories.

	id: STRING
		-- Id of Current, it is unique.

invariant
	not_void: resources /= Void and categories /= Void
	consistent: (not resources.empty implies categories.empty) and
				(not categories.empty implies resources.empty)  
	id_exists: id /= Void and then not id.empty
end -- class RESOURCE_CATEGORY
