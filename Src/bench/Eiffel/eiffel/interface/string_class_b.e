--- Compiled class STRING

class STRING_CLASS_B 

inherit

	CLASS_C
		redefine
			check_validity, mark_all_used
		end;
	SPECIAL_CONST;
	SHARED_TYPES

creation

	make

	
feature 

	check_validity is
			-- Check validity of class STRING
		local
			set_count_feat: FEATURE_I;
			stop, error: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
		do
			-- First check if class inherits directly from parent
			-- TO_SPECIAL [CHARACTER]
			from
				parents.start
			until
				parents.offright or else stop
			loop
				stop := deep_equal (parents.item, To_special_parent);
				parents.forth;
			end;
			if not stop then
				!!special_error.make (Case_4, id);
				Error_handler.insert_error (special_error);
			end;
			
			-- Second check if class has only one reference attribute
			-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				!!special_error.make (Case_5, id);
				Error_handler.insert_error (special_error);
			end;
			
			-- Third check if class has only one creation procedure with
			-- one integer argument
			error := creators = Void or else creators.count /= 1;
			if not error then
				creators.start;
				creat_feat := feature_table.item
												(creators.key_for_iteration);
				error := not creat_feat.same_signature
												(Make_signature);
			end;
			if error then
				!!special_error.make (Case_6, id);
				Error_handler.insert_error (special_error);
			end;

			-- Fourth, presence of a procedure `set_count'.
			set_count_feat := feature_table.item ("set_count");
			if 	set_count_feat = Void
				or else
				(not set_count_feat.same_signature (Set_count_signature))
				or else
				set_count_feat.written_in /= id
			then
				!!special_error.make (Case_17, id);
				Error_handler.insert_error (special_error);
			end;
		end; -- check_validity

	
	To_special_parent: GEN_TYPE_A is
			-- Parent type TO_SPECIAL [CHARACTER];
		local
			gen: ARRAY [TYPE_A];
		once
			!!gen.make (1, 1);
			gen.put (Character_type, 1);
			!!Result;
			Result.set_generics (gen);
			Result.set_base_type (System.to_special_id);
		end;

	Make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		once
			!!args.make (1);
			args.put_i_th (Integer_type, 1);
			!!Result;
			Result.set_arguments (args);
			Result.set_feature_name ("make");
		end;

	Set_count_signature: DYN_PROC_I is
			-- Required signature for `set_count' of class STRING
		local
			args: FEAT_ARG;
		once
			!!args.make (1);
			args.put_i_th (Integer_type, 1);
			!!Result;
			Result.set_arguments (args);
			Result.set_feature_name ("set_count");
		end;

	mark_all_used (remover: REMOVER) is
			-- Protection of features `make' and `set_count'.
		local
			feat: FEATURE_I;
			feat_table: FEATURE_TABLE;
		do
			creators.start;
			feat_table := feature_table;
			feat := feat_table.item (creators.key_for_iteration);
--			if not feat.used then
				remover.record (feat, Current);
--			end;
			feat := feat_table.item ("set_count");
--			if not feat.used then
				remover.record (feat, Current);
--			end;
		end;

end
