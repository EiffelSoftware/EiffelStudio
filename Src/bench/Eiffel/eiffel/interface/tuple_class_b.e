-- Experimental compiled class TUPLE

class TUPLE_CLASS_B 

inherit

	CLASS_C
		redefine
			check_validity, mark_all_used
		end

	SPECIAL_CONST

creation
	make
	
feature 

	check_validity is
			-- Check validity of class TUPLE
		local
			stop, error: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			array_any_p, parent_t: CL_TYPE_A
		do
			-- First check if class inherits directly from parent
			-- ARRAY [ANY]
			from
				parents.start
				array_any_p := System.instantiator.Array_type_a
			until
				parents.after or else stop
			loop
				parent_t := parents.item
				stop := parent_t.same_type (array_any_p) and then
					parent_t.is_equivalent (array_any_p)
				parents.forth;
			end;
			if not stop then
				-- FIXME: New error codes needed
				!!special_error.make (Case_8, Current);
				Error_handler.insert_error (special_error);
			end;
			
			-- Second check if class has only one reference attribute
			-- only (which is necessary `area' then).
			if 
				types.first.skeleton.nb_reference /= 1
			then
				-- FIXME: New error codes needed
				!!special_error.make (Case_9, Current);
				Error_handler.insert_error (special_error);
			end;

			-- Third, check if there is only one creation procedure 
			-- having no arguments.
			error := (creators = Void) or else creators.count /= 1;
			if not error then
				creators.start;
				creat_feat := feature_table.item
												(creators.key_for_iteration);
				error := not creat_feat.same_signature
												(Make_signature); 
			end;
			if error then
				-- FIXME: New error codes needed
				!!special_error.make (Case_10, Current);
				Error_handler.insert_error (special_error);
			end;
				
		end; -- check_validity

feature	-- Dead code removal

	mark_all_used (remover: REMOVER) is
		local
			feat: FEATURE_I;
			feat_table: FEATURE_TABLE;
		do
			creators.start;
			feat_table := feature_table;
			feat := feat_table.item (creators.key_for_iteration);
			remover.record (feat, Current);
		end;

feature {NONE}

	Make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class TUPLE
		once
			!! Result;
			Result.set_arguments (Void);
			Result.set_feature_name ("make");
		end;

end -- class TUPLE_CLASS_B

