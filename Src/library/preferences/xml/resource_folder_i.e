indexing
	description: "Objects containing the information relative to a resource folder."
	author: "Christophe Bonnard"

deferred class
	RESOURCE_FOLDER_I
	
inherit
	EXCEPTIONS

feature -- Initialization

	make_default (doc: XML_ELEMENT; struct: like structure) is
			-- Initialization of Current, belonging to `struct',
			-- according to `doc'.
		local
			s: STRING
			att: XML_ATTRIBUTE
			att_table: XML_ATTRIBUTE_TABLE
		do
			att_table := doc.attributes
			if att_table.has ("TOPIC_ID") then
				att := att_table.item ("TOPIC_ID")
				if att /= Void then
					name := att.value
				end
			end
			if att_table.has ("ICON") then
				att := att_table.item ("ICON")
				if att /= Void then
					icon := att.value
				end
			end
			is_visible := True
			if att_table.has ("VISIBILITY") then
				att := att_table.item ("VISIBILITY")
				if att /= Void and then att.value /= Void and then att.value.is_equal ("hidden") then
					is_visible := False
				end
			end
			structure := struct
			load_default_attributes (doc)
			if name = Void then
				s := "TOPIC_ID not supplied for "
				if description /= Void and then not description.is_empty then
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

	make_root (location: STRING; struct: RESOURCE_STRUCTURE) is
			-- Create Current (as a root folder of `struct')
			-- taking data from `location'.
		deferred
		end

	make_default_root (file_name: FILE_NAME; struct: like structure) is
			-- Create Current (as a root folder of `struct')
			-- taking data from `file_name'.
		local
			file: RAW_FILE
			s: STRING
			parser: XML_TREE_PARSER
			error_message: STRING
		do
			name := "root"
			description := "root folder"
			structure := struct

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
					load_default_attributes (xml_data)
				end
			else
				error_message := "%"" + file_name + "%" does not exist."
			end
			if error_message /= Void then
				raise (error_message)
			end
		end

	load_default_attributes (xml_elem: XML_ELEMENT) is
			-- effective load of data from `xml_elem'.
		local
			resource: RESOURCE
			child: RESOURCE_FOLDER_IMP
			cursor,des_cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
		do
			create description.make (20)
			create {ARRAYED_LIST [RESOURCE_FOLDER_I]} child_list.make (10)
			create {ARRAYED_LIST [RESOURCE]} resource_list.make (20)
			resource_list.compare_objects
			cursor := xml_elem.new_cursor
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
						resource := load_xml_resource (node)
						resource_list.extend (resource)
						structure.put_resource (resource)
					elseif node.name.is_equal ("TOPIC") then
						create child.make_default (node, structure)
						child.create_interface
						child_list.extend (child)
					end
				end
				cursor.forth
			end
		end

feature -- Update

	update_root (location: STRING) is
			-- Update information with data from `location'.
		deferred
		end

feature -- Status Report

	child_of_name (ch_name: STRING): like Current is
			-- Child of Current, whose name is `ch_name'.
			-- Void if no child has this name.
		local
			child_found: BOOLEAN
		do
			from
				child_list.start
			until
				child_found or child_list.after
			loop
				if equal (child_list.item.name, ch_name) then
					child_found := True
					Result := child_list.item
				else
					child_list.forth
				end
			end
		end

	resource_of_name (res_name: STRING): RESOURCE is
			-- Resource of Current, whose name is `res_name'.
			-- Void if no resource has this name.
		local
			resource_found: BOOLEAN
		do
			from
				resource_list.start
			until
				resource_found or resource_list.after
			loop
				if equal (resource_list.item.name, res_name) then
					resource_found := True
					Result := resource_list.item
				else
					resource_list.forth
				end
			end
		end

feature -- Access

	name: STRING
			-- Id of Current, it is unique.

	icon: STRING
			-- Icon name if any, Void otherwise

	is_visible: BOOLEAN
			-- Should this folder be displayed?

	description: STRING
			-- Description of Current.
			-- Meant for providing a help message.

	resource_list: LIST [RESOURCE]
			-- List of resources.

	structure: RESOURCE_STRUCTURE
			-- Structure Current is part of.

	child_list: LIST [like Current]
			-- List of child folders.

feature -- Save

	root_save (location: STRING) is
			-- Save folder in `location' as a root folder.
			-- Used as a part of `save' from RESOURCE_STRUCTURE_I
		deferred
		end

feature -- Interface creation

	create_interface is
			-- Create an interface for Current.
		local
			in: like interface
		do
			create in.make (Current)
			interface := in
		end

feature -- Implementation

	interface: RESOURCE_FOLDER
			-- Interface of Current.

feature {NONE} -- Implementation

	xml_data: XML_ELEMENT

	load_xml_resource (el: XML_ELEMENT): RESOURCE is
			-- Create a resource associated to an XML representation.
		require
			not_void: el /= Void
		local
			cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
			att: XML_ATTRIBUTE
			att_table: XML_ATTRIBUTE_TABLE
			val: STRING
		do
			create resource_name.make (20)
			att_table := el.attributes
			if att_table.has ("DESCRIPTION") then
				att := att_table.item ("DESCRIPTION")
				if att /= Void then
					resource_description := att.value
				end
			end
			if att_table.has ("IMMEDIATE_EFFECT") then
				att := att_table.item ("IMMEDIATE_EFFECT")
				if att /= Void then
					val := clone (att.value)
					val.to_lower
					effect_is_delayed := val.is_equal ("no")
				end
			end
			cursor := el.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				txt ?= cursor.item
				if txt /= Void then
					resource_name.append (txt.string)
				else
					node ?= cursor.item
					if node /= Void then
						Result := process_unit_specific (node)
					end
				end
				cursor.forth
			end
			resource_description := Void
			resource_name := Void
		end

	process_unit_specific (node: XML_ELEMENT): RESOURCE is
			-- Gets the appropriate resource from `node'
			-- if the type is unknown, it is assumed to be a string.
		require
			not_void: node /= Void
		local
			s: STRING
			type: INTEGER
			b: BOOLEAN
			txt: XML_TEXT
			n: STRING
			types: LINEAR [RESOURCE_TYPE]
		do
			n := node.name
			if n /= Void and then not n.is_empty then
				if not node.is_empty then
					txt ?= node.first
				end
				if txt /= Void then
					s := txt.string
					s.prune_all ('%R')
					s.prune_all ('%N')
					s.prune_all ('%T')
				end
				from
					types := structure.registered_types
					types.start
				until
					types.after or Result /= Void
				loop
					if types.item.xml_name.is_equal (n) then
						if resource_name = Void or else resource_name.is_empty then
							raise ("Empty resource name")
						end
						Result := types.item.load_resource (resource_name, s)
						if Result = Void then
							raise ("Not a valid resource")
						end
					end
					types.forth
				end
				if resource_description /= Void then
					Result.set_description (resource_description)
				end
				Result.set_effect_is_delayed (effect_is_delayed)
			end
		end

	resource_name: STRING
			-- Name of the resource currently being loaded.

	resource_description: STRING
			-- Description of the variable.

	effect_is_delayed: BOOLEAN
			-- Is a change in the resource reflected in the application
			-- immediately ?

invariant
	structure_exists: structure /= Void

end -- class RESOURCE_FOLDER_I
