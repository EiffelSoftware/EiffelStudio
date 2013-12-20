note
	description: "Summary description for {PS_WRITE_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_OBJECT_WRITE_DATA

inherit
	PS_OBJECT_DATA

create
	make_with_object

feature {PS_ABEL_EXPORT} -- Access

	references: ARRAYED_LIST [INTEGER]
			-- The index set of the objects referred to by the current object.

feature {NONE} -- Initialization

	make_with_object (idx: INTEGER; an_object: REFLECTED_OBJECT; a_level: INTEGER; a_type: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			index := idx
			reflector := an_object
			level := a_level
			type := a_type
			create {ARRAYED_LIST [INTEGER]} references.make (a_type.attribute_count)
			set_object (Current)
		end

end
