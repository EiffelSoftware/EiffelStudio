indexing
	description: "Compiled class STRING"
	date: "$Date$"
	revision: "$Revision$"

class STRING_CLASS_B 

inherit
	CLASS_C
		redefine
			check_validity
		end

	SPECIAL_CONST

create
	make
	
feature 

	check_validity is
			-- Check validity of class STRING
		local
			set_count_feat: FEATURE_I;
			internal_hash_code_feat: ATTRIBUTE_I
			stop, error, done: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			to_special_p, parent_t: CL_TYPE_A
		do
			if not System.il_generation then
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
					create special_error.make (Case_4, Current);
					Error_handler.insert_error (special_error);
				end;
			end
			
				-- Second check if class has only one reference attribute
				-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				create special_error.make (Case_5, Current);
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
				create special_error.make (Case_6, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Fourthsence of a procedure `set_count'.
			set_count_feat := feature_table.item_id (Names_heap.set_count_name_id);
			if 	set_count_feat = Void
				or else
				(not set_count_feat.same_signature (Set_count_signature))
				or else
				not (set_count_feat.written_in = class_id)
			then
				create special_error.make (Case_17, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Presence of attribute `internal_hash_code'.
			internal_hash_code_feat ?= feature_table.item_id (Names_heap.internal_hash_code_name_id)
			if
				internal_hash_code_feat = Void or else
				not internal_hash_code_feat.type.same_as (Integer_type)
			then
				create special_error.make (Case_17_bis, Current)
				Error_handler.insert_error (special_error)
			end
		end

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
			create args.make (1);
			args.put_i_th (Integer_type, 1);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.make_name_id);
		end;

	Set_count_signature: DYN_PROC_I is
			-- Required signature for `set_count' of class STRING
		local
			args: FEAT_ARG;
		once
			create args.make (1);
			args.put_i_th (Integer_type, 1);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.set_count_name_id);
		end;

end
