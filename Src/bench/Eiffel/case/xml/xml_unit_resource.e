indexing
	description: "Class which encapsulates the information for one resource."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_UNIT_RESOURCE

creation
	make

feature -- Initialization
	
	make(root_resource: XML_NODE; r: XML_STRUCTURE[XML_UNIT_RESOURCE]) is
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

	process_unit_specific(node: XML_ELEMENT) is
			-- Process the content of the node.
			-- Should be redefine in heirs.
		require
			node_exists: node /= Void
		do
		ensure
			value_exists: value /= Void
		end

feature -- Implementation

	structure: XML_STRUCTURE[XML_UNIT_RESOURCE]
		-- Structure of the resources.

	name: STRING
		-- Name of the variable.

	value: RESOURCE
		-- Value of the variable.

invariant
	XML_UNIT_RESOURCE_not_void: structure /= Void and name/=Void and value/=Void
	XML_UNIT_RESOURCE_consistency: not name.empty
end -- class XML_UNIT_RESOURCE
