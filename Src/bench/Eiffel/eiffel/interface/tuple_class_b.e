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
			is_tuple,
			normalized_type_i,
			partial_actual_type
		end

create
	make

feature -- Status report

	is_tuple: BOOLEAN is True
			-- Current class is TUPLE.

feature {NONE} -- Implementation

	normalized_type_i (data: CL_TYPE_I): TUPLE_TYPE_I is
			-- Class type `data' normalized in terms of the current class.
		do
			create Result.make (class_id, create {META_GENERIC}.make (0), create {ARRAY [TYPE_I]}.make (1, 0))
			Result.set_mark (data.declaration_mark)
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
					create formal.make (False, False, 1)
					actual_generic.put (formal, i)
					i := i + 1
				end
			else
				create actual_generic.make (1, 0)
			end
			create Result.make (class_id, actual_generic)
		end

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {TUPLE_TYPE_A} Result.make (class_id, gen)
			else
				create {TUPLE_TYPE_A} Result.make (class_id, create {ARRAY [TYPE_A]}.make (1, 0))
			end
				-- Note that TUPLE is not expanded by default.
			if is_exp then
				Result.set_expanded_mark
			elseif is_sep then
				Result.set_separate_mark
			end
			if is_expanded then
				Result.set_expanded_class_mark
			end
		end

invariant
	types_has_only_one_element: types /= Void implies types.count <= 1

end
