indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER_I

	WARNING_MESSAGES
		export
			{NONE} All
		end

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

create
	make, make_root, make_default, make_default_root

feature -- Initialization

	make (doc: XM_ELEMENT; struct: like structure) is
			-- Initialization of Current, belonging to `struct',
			-- according to `doc'.
		do
			make_default (doc, struct)
		end

	make_root (file_name: FILE_NAME; struct: RESOURCE_STRUCTURE) is
			-- Create Current (as a root folder of `struct')
			-- taking data from `file_name'.
		do
			make_default_root (file_name, struct)
		end

feature -- Update

	update_root (file_name: FILE_NAME) is
			-- Update information with data from `file_name'.
		local
			l_parser: XM_EIFFEL_PARSER
			l_file: KL_BINARY_INPUT_FILE
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_concat_filter: XM_CONTENT_CONCATENATOR
		do
			name := "root"
			description := "root folder"

			create l_file.make (file_name.out)
			if l_file.exists then
				l_file.open_read
				create l_parser.make
				create l_tree_pipe.make
				create l_concat_filter.make_null
				l_parser.set_callbacks (standard_callbacks_pipe (<<l_concat_filter, l_tree_pipe.start>>))
				l_parser.parse_from_stream (l_file)
				check
					ok_parsing: l_parser.is_correct
				end
				l_file.close
				
				if not l_tree_pipe.document.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					io.put_string (w_Invalid_preference_file_root (file_name))
				else
					xml_data := l_tree_pipe.document.root_element
					update_attributes (xml_data)
				end
			end
		end

	update_attributes (doc: XM_ELEMENT) is
			-- Update Current, according to `doc'.
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
								create description.make_from_string (txt.content)
							end
							des_cursor.forth
						end
					elseif node.name.is_equal ("TEXT") then
						resource := load_xml_resource (node)
						resource_list.search (resource)
						if not resource_list.exhausted then
							if resource.description = Void and resource_list.item.description /= Void then
								resource.set_description (resource_list.item.description)
							end
							resource.set_effect_is_delayed (resource_list.item.effect_is_delayed)
							resource_list.remove
						end
						resource_list.extend (resource)
						structure.replace_resource (resource)
					elseif node.name.is_equal ("TOPIC") then
						if node.has_attribute_by_name ("TOPIC_ID") then
							child := child_of_name (node.attribute_by_name ("TOPIC_ID").value)
						else
							child := Void
						end
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
			-- Save folder in `location' as a root folder.
			-- Used as a part of `save' from RESOURCE_STRUCTURE_I
		local
			file: RAW_FILE
			s: STRING
			l: LIST [RESOURCE_FOLDER_IMP]
			retried: BOOLEAN
		do
			if retried then
				create file.make (location)
				if file.exists then
					io.error.putstring (w_Not_readable (location))
				else
					io.error.putstring (w_Not_creatable (location))
				end
			else
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
					from
						resource_list.start
					until
						resource_list.after
					loop
						s.append (resource_list.item.xml_trace)
						s.extend ('%N')
						resource_list.forth
					end
					s.append ("</EIFFEL_DOCUMENT>%N")
					file.put_string (s)
					file.close
				end
			end
		rescue
			retried := True
			retry
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

end -- class RESOURCE_FOLDER_IMP
