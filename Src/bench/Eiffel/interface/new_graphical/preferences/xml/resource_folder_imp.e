indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER
		redefine
			structure
		end

create
	make, make_root

feature -- Initialization

	make (doc: XML_ELEMENT; struct: RESOURCE_STRUCTURE_IMP) is
			-- Initialization
		local
			s: STRING
			att: XML_ATTRIBUTE
			att_table: XML_ATTRIBUTE_TABLE
		do
			xml_data := doc
			att_table := xml_data.attributes
			att := att_table.item ("TOPIC_ID")
			if att /= Void then
				name := att.value
			end
			structure := struct
			if att_table.has ("AUTOMATIC_LOADING") then
				att := att_table.item ("AUTOMATIC_LOADING")
				s := att.value
				s.to_upper
				if s = "NO" then
					non_automatic_loading := True
					loading_not_done := True
				else
					load_attributes
				end
			else
				load_attributes
			end
			if name = Void then
				s := "TOPIC_ID not supplied for "
				if description /= Void and then not description.empty then
					s.append (description)
				else
					s.append ("unknown TOPIC (no description supplied either)")
				end
				s.append ("%N")
				io.put_string (s)
				name := "error"
			else
				name.prune_all ('%R')
				name.prune_all ('%T')
				name.prune_all ('%N')
			end
		end

	make_root (doc: XML_ELEMENT; struct: RESOURCE_STRUCTURE_IMP) is
		do
			xml_data := doc
			name := "root"
			structure := struct
			load_attributes
			description := "root folder"
		end

	load_attributes is
		local
			res_xml: XML_RESOURCE
			resource: RESOURCE
			child: like Current
			cursor,des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node, category_node: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
			att: XML_ATTRIBUTE
		do
			create description.make (20)
			create child_list.make
			create resource_list.make
			cursor := xml_data.new_cursor
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
						create res_xml.make (node, structure)
						resource := res_xml.value
						resource_list.extend (resource)
						structure.table.add_resource (resource)
					elseif node.name.is_equal ("TOPIC") then
						create child.make (node, structure)
						child_list.extend (child)
					end
				end
				cursor.forth
			end
			loading_not_done := False
		end

feature -- Access

	structure: RESOURCE_STRUCTURE_IMP

feature -- Output

	xml_trace (identation: STRING): STRING is
			-- XML representation of Current and its content.
		local
			new_ident: STRING
		do
			Result := identation + "<TOPIC TOPIC_ID=%""
			Result.append (name)
			Result.extend ('"')
			if non_automatic_loading then
				Result.append (" AUTOMATIC_LOADING = %"No%">%N")
			else
				Result.append (">%N")
			end
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
