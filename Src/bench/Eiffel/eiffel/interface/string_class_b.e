--- Compiled class STRING

class STRING_CLASS_B 

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
			-- Check validity of class STRING
		local
			set_count_feat: FEATURE_I;
			stop, error, done: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			to_special_p, parent_t: CL_TYPE_A
		do
			-- First check if class inherits directly from parent
			-- TO_SPECIAL [CHARACTER]
			from
				parents.start
				to_special_p := To_special_parent
			until
				parents.after or else stop
			loop
				parent_t := parents.item
				stop := parent_t.same_type (to_special_p) and then
					to_special_p.is_equivalent (parent_t)
				parents.forth;
			end;
			if not stop then
				!!special_error.make (Case_4, Current);
				Error_handler.insert_error (special_error);
			end;
			
			-- Second check if class has only one reference attribute
			-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				!!special_error.make (Case_5, Current);
				Error_handler.insert_error (special_error);
			end;
			
			-- Third check if class has one creation procedure with
			-- one integer argument
			error := creators = Void
			if not error then
				from
					creators.start
				until
					done or else creators.after
				loop
					creat_feat := feature_table.item (creators.key_for_iteration);
					if
						creat_feat.feature_name_id = Make_signature.feature_name_id and then
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
				!!special_error.make (Case_6, Current);
				Error_handler.insert_error (special_error);
			end;

			-- Fourth, presence of a procedure `set_count'.
			set_count_feat := feature_table.item_id (Names_heap.set_count_name_id);
			if 	set_count_feat = Void
				or else
				(not set_count_feat.same_signature (Set_count_signature))
				or else
				not (set_count_feat.written_in = class_id)
			then
				!!special_error.make (Case_17, Current);
				Error_handler.insert_error (special_error);
			end;
		end; -- check_validity

	
	To_special_parent: GEN_TYPE_A is
			-- Parent type TO_SPECIAL [CHARACTER];
		local
			gen: ARRAY [TYPE_A];
		once
			create gen.make (1, 1)
			gen.put (Character_type, 1)
			create Result.make (System.to_special_id, gen)
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
			Result.set_feature_name_id (Names_heap.make_name_id);
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
			Result.set_feature_name_id (Names_heap.set_count_name_id);
		end;

	mark_all_used (remover: REMOVER) is
			-- Protection of features `make' and `set_count'.
		local
			feat: FEATURE_I;
			feat_table: FEATURE_TABLE;
		do
			creators.start;
			feat_table := feature_table;
			feat := feat_table.item_id (Names_heap.make_name_id)
			remover.record (feat, Current);
			feat := feat_table.item_id (Names_heap.set_count_name_id);
			remover.record (feat, Current);
		end;

end
