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
		local
			meta_generic: META_GENERIC
		do
			create meta_generic.make (1)
			meta_generic.put (generics.item (1).type_i, 1)

			create Result.make (class_id)
			Result.set_meta_generic (meta_generic)
			Result.set_true_generics (meta_generic)
			Result.set_is_true_expanded (is_true_expanded)
		end

invariant
	il_generation: System.il_generation
	count_set: generics.count = 1

end -- class NATIVE_ARRAY_TYPE_A
