indexing
	description: "Descritpion of an actual native array type. Only used for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY_TYPE_A

inherit
	GEN_TYPE_A
		redefine
			type_i
		end
		
create
	make

feature -- Access

	type_i: NATIVE_ARRAY_TYPE_I is
			-- Meta generic interpretation of the generic type
		do
			create Result.make (class_id, generics.item (1))
			Result.set_is_expanded (is_expanded)
		end

invariant
	il_generation: System.il_generation
	count_set: generics.count = 1

end -- class NATIVE_ARRAY_TYPE_A
