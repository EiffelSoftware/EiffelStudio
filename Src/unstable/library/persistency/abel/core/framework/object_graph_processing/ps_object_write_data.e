note
	description: "Write-specific object data."
	author: "Roman Schmocker"
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

	make_with_object (idx: INTEGER; a_reflector: REFLECTED_OBJECT; a_level: INTEGER; a_type: PS_TYPE_METADATA)
			-- Initialization for `Current'.
		do
			index := idx
			level := a_level
			type := a_type

			create {ARRAYED_LIST [INTEGER]} references.make (a_type.attribute_count)

			if attached {REFLECTED_REFERENCE_OBJECT} a_reflector as ref and then ref.physical_offset = 0 then
					-- For normal reference types, reuse the inherited reflector, as `a_reflector' will not be stable.
					-- Note that some expanded types may slip into this code section as well, due to missing reflectors
					-- for tuples or `SPECIAL [EXPANDED_TYPE]'.
				set_object (a_reflector.object)
				reflector := Current
			else
					-- For expanded types or copy-semantics references, `a_reflector' is stable and can be aliased.
				reflector := a_reflector
				set_object (Current)
			end
		end

end
