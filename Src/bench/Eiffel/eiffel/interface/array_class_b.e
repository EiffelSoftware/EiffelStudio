--- Compiled class ARRAY

class
	ARRAY_CLASS_B 

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
			-- Check validity of class ARRAY
		local
			stop, error: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			to_special_p, parent_t: CL_TYPE_A
			done: BOOLEAN
		do
			-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				!!special_error.make (Case_7, Current);
				Error_handler.insert_error (special_error);
			end;

			-- Second check if class inherits directly from parent
			-- TO_SPECIAL [Generic #1]
			from
				parents.start
				to_special_p := To_special_parent
			until
				parents.after or else stop
			loop
				parent_t := parents.item
				stop := parent_t.same_type (to_special_p) and then
					parent_t.is_equivalent (to_special_p)
				parents.forth;
			end;
			if not stop then
				!!special_error.make (Case_8, Current);
				Error_handler.insert_error (special_error);
			end;
			
			-- Third check if class has only one reference attribute
			-- only (which is necessary `area' then).
			if 
				types.first.skeleton.nb_reference /= 1
			then
				!!special_error.make (Case_9, Current);
				Error_handler.insert_error (special_error);
			end;

			-- Fouth, check if there is only one creation procedure 
			-- having only two integer arguments
			error := creators = Void
			if not error then
				from
					creators.start
				until
					done or else creators.after
				loop
					creat_feat := feature_table.item (creators.key_for_iteration);
					if
						creat_feat.feature_name.is_equal (Make_signature.feature_name) and then
						creat_feat.same_signature (Make_signature)
					then
						done := True
					else
						creators.forth
					end
				end
				error := not done
			end;
			if error then
				!! special_error.make (Case_10, Current);
				Error_handler.insert_error (special_error);
			end;
				
		end; -- check_validity

feature	-- Dead code removal

	mark_all_used (remover: REMOVER) is
			-- Mark `make', default creation routine of ARRAYS used at
			-- run-time.
		do
			remover.record (feature_table.item ("make"), Current);
		end;

feature {NONE}

	To_special_parent: GEN_TYPE_A is
			-- Parent type TO_SPECIAL [Generic #1];
		local
			f: FORMAL_A;
			gen: ARRAY [TYPE_A];
		once
			create f
			f.set_position (1)
			create gen.make (1, 1)
			gen.put (f, 1)
			create Result.make (gen)
			Result.set_base_class_id (System.to_special_id)
		end;

	Make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		once
			!! args.make (2);
			args.put_i_th (Integer_type, 1);
			args.put_i_th (Integer_type, 2);
			!! Result;
			Result.set_arguments (args);
			Result.set_feature_name ("make");
		end;

end
