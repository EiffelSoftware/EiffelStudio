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
			error, done: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			area_feature: FEATURE_I
		do
				-- Check if class has an attribute `area' of type SPECIAL [CHARACTER].
			area_feature ?= feature_table.item_id (Names_heap.area_name_id)
			if
				(area_feature = Void)
				or else not area_type.same_as (area_feature.type.actual_type)
			then
				create special_error.make (string_case_1, Current)
				Error_handler.insert_error (special_error)
			end

				-- Second check if class has only one reference attribute
				-- only (which is necessary `area' then).
			if types.first.skeleton.nb_reference /= 1 then
				create special_error.make (string_case_2, Current);
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
						creat_feat.feature_name_id = names_heap.make_name_id and then
						creat_feat.same_signature (make_signature)
					then
						done := True
					else
						creators.forth
					end
				end
				error := not done
			end;
			if error then
				create special_error.make (string_case_3, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Fourthsence of a procedure `set_count'.
			set_count_feat := feature_table.item_id (Names_heap.set_count_name_id);
			if 	set_count_feat = Void
				or else
				(not set_count_feat.same_signature (set_count_signature))
				or else
				not (set_count_feat.written_in = class_id)
			then
				create special_error.make (string_case_4, Current);
				Error_handler.insert_error (special_error);
			end;

			if not System.il_generation then
					-- Presence of attribute `internal_hash_code'.
				internal_hash_code_feat ?=
					feature_table.item_id (Names_heap.internal_hash_code_name_id)
				if
					internal_hash_code_feat = Void or else
					not internal_hash_code_feat.type.same_as (Integer_type)
				then
					create special_error.make (string_case_5, Current)
					Error_handler.insert_error (special_error)
				end
			end
		end

feature {NONE} -- Implementation

	make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (1);
			args.put_i_th (Integer_type, 1);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.make_name_id, 0)
		end;

	area_type: GEN_TYPE_A is
			-- Type SPECIAL [CHARACTER]
		local
			f: CHARACTER_A
			gen: ARRAY [TYPE_A]
		do
			create f.make (False)
			create gen.make (1, 1)
			gen.put (f, 1)
			create Result.make (System.special_id, gen)
		ensure
			area_type_not_void: area_type /= Void
		end

	set_count_signature: DYN_PROC_I is
			-- Required signature for `set_count' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (1);
			args.put_i_th (Integer_type, 1);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (Names_heap.set_count_name_id, 0)
		end;

end
