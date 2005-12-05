indexing
	description: "Internal representation of class POINTER and TYPED_POINTER"
	date: "$Date$"
	revision: "$Revision$"

class POINTER_B

inherit
	CLASS_B
		rename
			make as basic_make
		redefine
			actual_type, partial_actual_type,
			is_typed_pointer, check_validity
		end

create
	make

feature {NONE} -- Initialization

	make (l: CLASS_I; a_is_typed_pointer: like is_typed_pointer) is
			-- Creation of POINTER_B instance where `is_typed_pointer' is initialized
			-- with `a_is_typed_pointer'.
		do
			basic_make (l)
			is_typed_pointer := a_is_typed_pointer
		ensure
			is_typed_pointer_set: is_typed_pointer = a_is_typed_pointer
		end

feature -- Access

	actual_type: BASIC_A is
			-- Actual double type
		local
			l_formal: FORMAL_A
		do
			if is_typed_pointer then
				create l_formal.make (False, False, 1)
				create {TYPED_POINTER_A} Result.make_typed (l_formal)
			else
				Result := Pointer_type
			end
		end

	is_typed_pointer: BOOLEAN
			-- Is current representing TYPED_POINTER?

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if is_typed_pointer then
				if gen /= Void then
					create {TYPED_POINTER_A} Result.make (class_id, gen)
				else
					create Result.make (class_id)
				end
			else
				Result := Precursor {CLASS_B} (gen, is_exp, is_sep)
			end
		end

feature -- Validity

	check_validity is
			-- Check validity of a simple type reference class.
		local
			skelet: SKELETON
			special_error: SPECIAL_ERROR
			l_feat: PROCEDURE_I
			l_attr: ATTRIBUTE_I
		do
			if not is_typed_pointer then
				Precursor {CLASS_B}
			else
					-- First check there is only one generic.
				if generics = Void or else generics.count > 1 then
					create special_error.make (typed_pointer_case_1, Current)
					Error_handler.insert_error (special_error)
				end
				skelet := types.first.skeleton
				if
					skelet.count /= 1 or else
					not skelet.first.type_i.same_as (pointer_type.type_i)
				then
					create special_error.make (typed_pointer_case_2, Current)
					Error_handler.insert_error (special_error)
				else
						-- Check it is indeed called `pointer_item'.
					l_attr ?= feature_table.item ("pointer_item")
					if l_attr = Void then
						create special_error.make (typed_pointer_case_3, Current)
						Error_handler.insert_error (special_error)
					end
				end

					-- Check for a procedure `set_item'.
				l_feat ?= feature_table.item_id (names_heap.set_item_name_id)
				if
					l_feat = Void or else
					l_feat.argument_count /= 1 or else
					not l_feat.arguments.i_th (1).actual_type.same_as (pointer_type)
				then
					create special_error.make (typed_pointer_case_4, Current)
					Error_handler.insert_error (special_error)
				end
			end
		end

end
