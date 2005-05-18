--- Compiled class ARRAY

class
	ARRAY_CLASS_B 

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
			-- Check validity of class ARRAY
		local
			error: BOOLEAN;
			special_error: SPECIAL_ERROR;
			creat_feat: FEATURE_I;
			area_feature: ATTRIBUTE_I
			done: BOOLEAN
		do
			-- First check if current class has one formal generic parameter
			if (generics = Void) or else generics.count /= 1 then
				create special_error.make (array_case_1, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Check if class has an attribute `area' of type SPECIAL [T].
			area_feature ?= feature_table.item_id (names_heap.area_name_id)
			if
				(area_feature = Void)
				or else not area_type.same_as (area_feature.type.actual_type)
			then
				create special_error.make (array_case_2, Current)
				Error_handler.insert_error (special_error)
			end

			-- Third check if class has only one reference attribute
			-- only (which is necessary `area' then).
			if 
				types.first.skeleton.nb_reference /= 1
			then
				create special_error.make (array_case_3, Current);
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
				create special_error.make (array_case_4, Current);
				Error_handler.insert_error (special_error);
			end;
				
		end; -- check_validity

feature {NONE}

	make_signature: DYN_PROC_I is
			-- Required signature for feature `make' of class STRING
		local
			args: FEAT_ARG;
		do
			create args.make (2);
			args.put_i_th (Integer_type, 1);
			args.put_i_th (Integer_type, 2);
			create Result;
			Result.set_arguments (args);
			Result.set_feature_name_id (names_heap.make_name_id, 0)
		end;

	area_type: GEN_TYPE_A is
			-- Type SPECIAL [T]
		local
			f: FORMAL_A
			gen: ARRAY [TYPE_A]
		do
			create f.make (False, False, 1)
			create gen.make (1, 1)
			gen.put (f, 1)
			create Result.make (System.special_id, gen)
		end

end
