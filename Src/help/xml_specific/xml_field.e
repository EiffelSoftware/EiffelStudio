indexing
	description: "XML Field"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FIELD

inherit
	XML_COMPOSITE

creation
	make

feature -- Initialization

	make (n: STRING) is
			-- Initialize
		do
			name:= n
			!! heir.make
		end

feature -- Access

	name: STRING

	heir: LINKED_LIST [XML_COMPOSITE]

feature --Managment

	add_heir (c: XML_COMPOSITE) is
		do
			heir.extend (c)
		end

invariant
	XML_FIELD_not_void: heir /= Void and name /= Void
end -- class XML_FIELD
