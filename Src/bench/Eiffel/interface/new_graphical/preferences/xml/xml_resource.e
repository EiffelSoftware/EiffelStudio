indexing
	description: "Class which describes the features for one resource."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_RESOURCE

creation
	make

feature -- Initialization
	
	make (root_resource: XML_NODE; r: RESOURCE_STRUCTURE) is
			-- initialization
		require
			not_void: root_resource /= Void and r /= Void
		local
			cursor: DS_BILINKED_LIST_CURSOR [XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
		do
			create name.make (20)
			structure ?= r
			cursor := root_resource.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				txt ?= cursor.item
				if txt /= Void then
					name.append (txt.string)
				else
					node ?= cursor.item
					if node /= Void then
						process_unit_specific (node)
					end
				end
				cursor.forth
			end
		end

feature -- Implementation

	process_unit_specific (node: XML_ELEMENT) is
			-- Gets the appropriate resource from `node'
			-- if the type is unknown, it is assumed to be a string.
		local
			s: STRING
			type: INTEGER
			b: BOOLEAN
			txt: XML_TEXT
		do
			if node.name.is_equal ("STRING") then
				type := string_type
			elseif node.name.is_equal ("COLOR") then
				type := color_type
			elseif node.name.is_equal ("INTEGER") then
				type := integer_type
			elseif node.name.is_equal ("FONT") then
				type := font_type
			elseif node.name.is_equal ("BOOLEAN") then
				type := boolean_type
			elseif node.name.is_equal ("LIST_STRING") then
				type := array_type
			elseif node.name.is_equal ("A") then
				txt ?= node.first
				s := clone (txt.string)
				if not s.empty then
					s.prune_all ('%R')
					s.prune_all ('%T')
					name.append (s)
				end
			end
			txt ?= node.first
			if txt /= Void then
				s := txt.string
				s.prune_all ('%R')
				s.prune_all ('%T')
			end
			if type = string_type then
				create {STRING_RESOURCE} value.make (name, s)
			elseif type = color_type then
				create {COLOR_RESOURCE} value.make (name, s)
			elseif type = integer_type and then s.is_integer then
				create {INTEGER_RESOURCE} value.make (name, s.to_integer)
			elseif type = font_type then
				create {FONT_RESOURCE} value.make (name, s)
			elseif type = boolean_type then
				s.to_upper
				b := s.is_equal ("TRUE")
				create {BOOLEAN_RESOURCE} value.make (name, b)
			elseif type = array_type then
				create {ARRAY_RESOURCE} value.make_from_string (name, s)
			else
				create {STRING_RESOURCE} value.make (name, s)
			end
			structure.table.add_resource (value)
		end

feature {NONE} -- Constants

	string_type, color_type, integer_type,
	font_type, boolean_type, array_type: INTEGER is unique

feature -- Implementation

	structure: RESOURCE_STRUCTURE
		-- Structure of the resources.

	name: STRING
		-- Name of the variable.

	value: RESOURCE
		-- Value of the variable.

	external_name: STRING
		-- Name for the outside world of Current.

invariant
	XML_RESOURCE_not_void: structure /= Void and name /= Void and value /= Void
	XML_RESOURCE_consistency: not name.empty

end -- class XML_RESOURCE
