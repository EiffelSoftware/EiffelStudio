indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER_I
		rename
			load_default_attributes as load_attributes
		end

create
	make, make_root, make_default, make_default_root

feature -- Initialization

	make (doc: XML_ELEMENT; struct: like structure) is
		do
			make_default (doc, struct)
		end

	make_root (doc: XML_ELEMENT; struct: RESOURCE_STRUCTURE) is
		do
			xml_data := doc
			name := "root"
			structure := struct
			load_attributes (doc)
			description := "root folder"
		end

feature -- Update

	update_root (doc: XML_ELEMENT) is
		do
			name := "root"
			update_attributes (doc)
			description := "root folder"
		end

	update_attributes (doc: XML_ELEMENT) is
		local
			res_xml: XML_RESOURCE
			resource: RESOURCE
			child: like Current
			cursor, des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node, category_node: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
			att: XML_ATTRIBUTE
		do
			cursor := doc.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				node ?= cursor.item
				if node /= Void then
					if node.name.is_equal ("HEAD") then
						des_cursor := node.new_cursor
						from
							des_cursor.start
						until
							des_cursor.after
						loop
							txt ?= des_cursor.item
							if txt /= Void then
								description.append (txt.string)
							end
							des_cursor.forth
						end
					elseif node.name.is_equal ("TEXT") then
						create res_xml.make (node)
						resource := res_xml.value
						resource_list.extend (resource)
						structure.replace_resource (resource)
					elseif node.name.is_equal ("TOPIC") then
						if child /= Void then
							child.update_attributes (node)
						end
					end
				end
				cursor.forth
			end
		end

feature -- Output

	xml_trace (identation: STRING): STRING is
			-- XML representation of Current and its content.
		local
			new_ident: STRING
		do
			Result := identation + "<TOPIC TOPIC_ID=%""
			Result.append (name)
			Result.append ("%">%N")
			new_ident := "%T"
			new_ident.append (identation)
			if description /= Void then
				Result.append (new_ident)
				Result.append ("<HEAD>")
				Result.append (description)
				Result.append ("</HEAD>%N")
			end
			from
				child_list.start
			until
				child_list.after
			loop
				Result.append (child_list.item.xml_trace (new_ident))
				child_list.forth
			end
			from
				resource_list.start
			until
				resource_list.after
			loop
				Result.append (new_ident)
				Result.append (resource_list.item.xml_trace)
				Result.extend ('%N')
				resource_list.forth
			end
			Result.append (identation)
			Result.append ("</TOPIC>%N")
		end

feature {NONE} -- Implementation

	xml_data: XML_ELEMENT

end -- class RESOURCE_FOLDER_IMP
