indexing
	description: "Compiled class TUPLE"
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_CLASS_B

inherit
	CLASS_C
		redefine
			actual_type,
			init_types, update_types, is_tuple
		end

create
	make

feature -- Status report

	is_tuple: BOOLEAN is True
			-- Current class is TUPLE.

feature -- types

	init_types is
			-- Standard initialization of attribute `types'
			-- Special treatment for TUPLEs
		require else
			True
		local
			class_type: CLASS_TYPE
			type_i: TUPLE_TYPE_I
		do
			create type_i.make (class_id)
			type_i.set_true_generics (Void)
			type_i.set_meta_generic (Void)
			class_type := new_type (type_i)
			types.extend (class_type)
			System.insert_class_type (class_type)
		end

	update_types (data: GEN_TYPE_I) is
			-- Do nothing. TUPLEs are treated
			-- as non-generic here.
		do
		end

feature -- Actual class type

	actual_type: TUPLE_TYPE_A is
			-- Actual type of the class
		local
			i, count: INTEGER
			actual_generic: ARRAY [FORMAL_A]
			formal: FORMAL_A
		do
			if generics /= Void then
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
				until
					i > count
				loop
					create formal
					formal.set_position (i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			else
				create actual_generic.make (1, 0)
			end
			create Result.make (class_id, actual_generic)
		end

end -- class TUPLE_CLASS_B

