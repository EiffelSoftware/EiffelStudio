indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_XML

inherit
	RESOURCE_FOLDER_I

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

create
	make_root, make_default, make_default_root

feature -- Initialization

	make_root (file_name: FILE_NAME; struct: RESOURCE_STRUCTURE) is
		do
			make_default_root (file_name, struct)
		end

feature -- Update

	update_root (file_name: FILE_NAME) is
		local
			parser: XM_EIFFEL_PARSER
			error_message: STRING
			l_file: KL_BINARY_INPUT_FILE
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_concat_filter: XM_CONTENT_CONCATENATOR
		do
			name := "root"
			description := "root folder"
			create parser.make
			create l_file.make (file_name.string)
			l_file.open_read
			if l_file.is_open_read then
				create l_tree_pipe.make
				create l_concat_filter.make_null
				parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, l_tree_pipe.start>>))
				parser.parse_from_stream (l_file)
				l_file.close

				check
					structure_initialized: structure /= Void
				end
				if not l_tree_pipe.document.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					error_message := "EIFFEL_DOCUMENT TAG missing%N"
				else
					xml_data := l_tree_pipe.document.root_element
					update_attributes (xml_data)
				end
			else
				error_message := "does not exist%N"
				error_message.prepend (file_name)
			end
			if error_message /= Void then
				io.put_string (error_message)
			end
		end

	update_attributes (doc: XM_ELEMENT) is
		local
			resource: RESOURCE
			child: like Current
			cursor, des_cursor: DS_LINKED_LIST_CURSOR [XM_NODE]
			node: XM_ELEMENT
			txt: XM_CHARACTER_DATA
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
								description.append (txt.content)
							end
							des_cursor.forth
						end
					elseif node.name.is_equal ("TEXT") then
						resource := load_xml_resource (node)
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

feature -- Saving

	root_save (location: FILE_NAME) is
		local
			file: RAW_FILE
			s: STRING
			l: LIST [like Current]
		do
			create file.make_open_write (location)
			if file.exists then
				s := "<EIFFEL_DOCUMENT>%N"
				from
					l := child_list
					l.start
				until
					l.after
				loop
					s.append (l.item.xml_trace (""))
					l.forth
				end
				s.append ("</EIFFEL_DOCUMENT>%N")
				file.put_string (s)
				file.close
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

	new_child (doc: XM_ELEMENT; struct: like structure): like Current is
			-- New instance of Current belonging to `struct' according to `doc'.
		do
			create Result.make_default (doc, struct)
		end

end -- class RESOURCE_FOLDER_XML
