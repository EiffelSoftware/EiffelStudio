class TUPLE_CLASS_B 

inherit

	CLASS_C
		redefine
			check_validity, mark_all_used, actual_type,
			init_types, update_types
		end

	SPECIAL_CONST

creation
	make
	
feature 

	check_validity is
			-- Check validity of class TUPLE
		local
			stop, error: BOOLEAN
			special_error: SPECIAL_ERROR
			creat_feat: FEATURE_I
			array_p, parent_t: CL_TYPE_A
		do
			-- First check that class inherits directly from parent
			-- ARRAY [ANY]

			from
				parents.start
				array_p := Array_parent
			until
				parents.after or else stop
			loop
				parent_t := parents.item
				stop := parent_t.same_type (array_p) and then
					parent_t.is_equivalent (array_p)
				parents.forth
			end

			if not stop then
				!!special_error.make (Case_18, Current)
				Error_handler.insert_error (special_error)
			end
			
			-- Second, check if there is only one creation procedure 
			-- having no arguments.

			error := (creators = Void) or else creators.count /= 1
			if not error then
				creators.start
				creat_feat := feature_table.item (creators.key_for_iteration)
				error := not creat_feat.same_signature (Make_signature) 
			end

			if error then
				!!special_error.make (Case_19, Current)
				Error_handler.insert_error (special_error)
			end
				
		end -- check_validity

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
			types.put_front (class_type)
			System.insert_class_type (class_type)
		end

	update_types (data: GEN_TYPE_I) is
			-- Do nothing. TUPLEs are treated
			-- as non-generic here.
		do
		end

feature -- Dead code removal

	mark_all_used (remover: REMOVER) is

		local
			feat: FEATURE_I
			feat_table: FEATURE_TABLE
		do
			creators.start
			feat_table := feature_table
			feat := feat_table.item (creators.key_for_iteration)
			remover.record (feat, Current)
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
					!! actual_generic.make (1, count)
				until
					i > count
				loop
					!! formal
					formal.set_position (i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			else
				create actual_generic.make (1, 0)
			end
			create Result.make (class_id, actual_generic)
		end
		
feature {NONE}

	Array_parent: GEN_TYPE_A is
			-- Parent type ARRAY [ANY]
		local
			any_a: CL_TYPE_A
			gen: ARRAY [TYPE_A]
		once
			create any_a.make (System.any_id)
			create gen.make (1, 1)
			gen.put (any_a, 1)
			create Result.make (System.array_id, gen)
		end

	Make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class TUPLE
		once
			!! Result
			Result.set_arguments (Void)
			Result.set_feature_name_id (Names_heap.make_name_id)
		end

end -- class TUPLE_CLASS_B

