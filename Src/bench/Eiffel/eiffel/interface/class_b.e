indexing
	description: "Internal description of a basic class such as INTEGER, BOOLEAN etc.."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_B 

inherit
	CLASS_C
		redefine
			is_basic, partial_actual_type, check_validity
		end
		
	SPECIAL_CONST
		export
			{NONE} all
		end

create
	make
	
feature 

	is_basic: BOOLEAN is True
			-- Is the current class a basic class ?

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_ref: BOOLEAN; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. Or it could be a reference even though it is an
			-- expanded class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {GEN_TYPE_A} Result.make (class_id, gen)
			else
				if is_ref then
					create Result.make (class_id)
				else
					Result := actual_type
				end
			end
				-- Note that basic types are expanded by default.
			Result.set_is_expanded (is_exp or not is_ref)
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
				-- First, no generics
			if generics /= Void then
				create special_error.make (basic_case_1, Current)
				Error_handler.insert_error (special_error)
			end
			
				-- Check for `item' attribute
			skelet := types.first.skeleton
			if
				skelet.count /= 1 or else
				not skelet.first.type_i.same_as (actual_type.type_i)
			then
				create special_error.make (basic_case_2, Current)
				Error_handler.insert_error (special_error)
			else
					-- Check it is indeed called `item'.
				l_attr ?= feature_table.item_id (names_heap.item_name_id)
				if l_attr = Void then
					create special_error.make (basic_case_3, Current)
					Error_handler.insert_error (special_error)
				end
			end
			
				-- Check for a procedure `set_item'.
			l_feat ?= feature_table.item_id (Names_heap.set_item_name_id)
			if
				l_feat = Void or else
				l_feat.argument_count /= 1 or else
				not l_feat.arguments.i_th (1).actual_type.same_as (actual_type)
			then
				create special_error.make (basic_case_4, Current)
				Error_handler.insert_error (special_error)
			end
		end

end
