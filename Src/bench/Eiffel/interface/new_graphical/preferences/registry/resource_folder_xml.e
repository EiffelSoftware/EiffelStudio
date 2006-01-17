indexing
	description: "Objects containing the information relative to a resource folder."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_XML

inherit
	RESOURCE_FOLDER_I

create
	make, make_root, make_default, make_default_root

feature -- Initialization

	make (doc: XML_ELEMENT; struct: like structure) is
		do
			make_default (doc, struct)
		end

	make_root (file_name: FILE_NAME; struct: RESOURCE_STRUCTURE) is
		do
			make_default_root (file_name, struct)
		end

feature -- Update

	update_root (file_name: FILE_NAME) is
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			error_message: STRING
		do
			name := "root"
			description := "root folder"

			create parser.make
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.read_stream (file.count)
				s := file.last_string
				parser.parse_string (s)
				parser.set_end_of_file
				file.close
				if not parser.root_element.name.is_equal ("EIFFEL_DOCUMENT") then
					error_message := "EIFFEL_DOCUMENT TAG missing%N"
				else
					xml_data := parser.root_element
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

	update_attributes (doc: XML_ELEMENT) is
		local
			res_xml: XML_RESOURCE
			resource: RESOURCE
			child: like Current
			cursor, des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
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

feature -- Saving

	root_save (location: FILE_NAME) is
		local
			file: RAW_FILE
			s: STRING
			l: LINKED_LIST [like Current]
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class RESOURCE_FOLDER_XML
