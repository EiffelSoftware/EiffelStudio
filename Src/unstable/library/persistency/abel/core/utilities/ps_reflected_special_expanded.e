note
	description: "A reflector for SPECIAL [XX], where XX is a user-defined expanded type."
	author: "Roman Schmocker"
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
			physical_offset := (special.item_address (i).to_integer_32 - ($special).to_integer_32)
			dynamic_type := special.generating_type.generic_parameter_type (1).type_id
		end

end
