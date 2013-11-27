note
	description: "Summary description for {PS_REFLECTED_SPECIAL_EXPANDED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_REFLECTED_SPECIAL_EXPANDED

inherit
	REFLECTED_REFERENCE_OBJECT

create
	make_special_expanded

feature {NONE} -- Initialization

	make_special_expanded (special: SPECIAL [detachable ANY]; i: INTEGER)
			-- Setup a proxy to copy semantics item located at the `i'-th position of special represented by `a_enclosing_object'.
		require
			valid_index: special.valid_index (i)
		local
			item: detachable ANY
		do
			enclosing_object := special

--			item := special [i]
--			print ({ISE_RUNTIME}.object_size ($item).as_integer_32)
--			physical_offset := 16 + i * ({ISE_RUNTIME}.object_size ($item).as_integer_32)

			physical_offset := (special.item_address (i).to_integer_32 - ($special).to_integer_32)

			dynamic_type := special.generating_type.generic_parameter_type (1).type_id


--			referring_object := a_enclosing_object
--			check attached {SPECIAL [detachable ANY]} a_enclosing_object.object as special then
--						-- Offset to start
--				item := special [i]
--				referring_physical_offset := 16 + i * {ISE_RUNTIME}.object_size ($item).as_integer_32
----				print (referring_physical_offset)
--				dynamic_type := special.generating_type.generic_parameter_type (1).type_id
--			end
--			physical_offset := 0
		ensure
--			enclosing_object_set: referring_object = a_enclosing_object
		end



end
