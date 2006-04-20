indexing
	description: "Objects containing the information relative to a resource folder."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard"

class
	RESOURCE_FOLDER_IMP

inherit
	RESOURCE_FOLDER_I

	WARNING_MESSAGES
		export
			{NONE} All
		end

create
	make, make_root, make_default, make_default_root

feature -- Initialization

	make (doc: XML_ELEMENT; struct: like structure) is
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
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
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
					io.put_string (w_Invalid_preference_file_root (file_name))
				else
					xml_data := parser.root_element
					update_attributes (xml_data)
				end
			end
		end

	update_attributes (doc: XML_ELEMENT) is
			-- Update Current, according to `doc'.
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
								create description.make_from_string (txt.string)
							end
							des_cursor.forth
						end
					elseif node.name.is_equal ("TEXT") then
						create res_xml.make (node)
						resource := res_xml.value
						resource_list.start
						resource_list.compare_objects
						resource_list.search(resource)
						if not resource_list.exhausted then
							if
								resource.description = Void and
								resource_list.item.description /= Void
							then
								resource.set_description (resource_list.item.description)
							end
							resource.set_effect_is_delayed (resource_list.item.effect_is_delayed)
							resource_list.remove
						end
						resource_list.extend (resource)
						structure.replace_resource (resource)
					elseif node.name.is_equal ("TOPIC") then
						node.attributes.search("TOPIC_ID")
						if node.attributes.found then
							child := child_of_name(node.attributes.found_item.value)
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
			l: LINKED_LIST [RESOURCE_FOLDER_IMP]
			retried: BOOLEAN
		do
			if retried then
				create file.make (location)
				if file.exists then
					io.error.put_string (w_Not_readable (location))
				else
					io.error.put_string (w_Not_creatable (location))
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

end -- class RESOURCE_FOLDER_IMP
