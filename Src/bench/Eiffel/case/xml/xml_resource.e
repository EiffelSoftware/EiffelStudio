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
	
	make(root_resource: XML_NODE; r: RESOURCE_STRUCTURE) is
			-- initialization
		require
			not_void: root_resource /= Void and r /= Void
		local
			cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node: XML_ELEMENT
			txt: XML_TEXT
		do
			!! name.make(20)
			structure ?= r
			cursor := root_resource.new_cursor
			from
				cursor.start
			until
				cursor.after
			loop
				txt ?= cursor.item
				if txt /= Void then
					name.append(txt.string)
				else
					node ?= cursor.item
					if node /= Void then
						process_unit_specific(node)
					end
				end
				cursor.forth
			end
		end

feature -- Implementation

	process_unit_specific(node: XML_ELEMENT) is
		local
			s: STRING
			type: INTEGER
			b: BOOLEAN
			type0: STRING_RESOURCE
			type1: COLOR_RESOURCE
			type2: INTEGER_RESOURCE
			type3: FONT_RESOURCE
			type4: BOOLEAN_RESOURCE
			txt: XML_TEXT
		do
			if node.name.is_equal("STRING") then
				-- String
				type := 0
			elseif node.name.is_equal("COLOR") then
				-- Color
				type := 1
			elseif node.name.is_equal("INTEGER") then
				-- Integer
				type := 2
			elseif node.name.is_equal("FONT") then
				-- Font
				type := 3
			elseif node.name.is_equal("BOOLEAN") then
				-- Boolean
				type := 4
			elseif node.name.is_equal("A") then
				txt ?= node.first
				s := clone(txt.string)
				if not s.empty then
					s.prune_all('%R')
					s.prune_all('%T')
					name.append(s)
				end
			end
			txt ?= node.first
			if txt /= Void then
				s := txt.string
				s.prune_all('%R')
				s.prune_all('%T')
			end
			if type=0 then
				!!type0.make(name,structure.table,s)
				value := type0
			elseif type=1 then
				!!type1.make(name,structure.table,s)
				value := type1
			elseif type=2 and then s.is_integer then
				!! type2.make(name,structure.table,s.to_integer)
				value := type2
			elseif type=3 then
				!! type3.make(name,structure.table,s)
				value := type3
			elseif type=4 then
				b := s.is_equal("TRUE")
				!! type4.make(name,structure.table,b)
				value := type4
			end
		end

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
	XML_RESOURCE_not_void: structure /= Void and name/=Void and value/=Void
	XML_RESOURCE_consistency: not name.empty
end -- class XML_RESOURCE
