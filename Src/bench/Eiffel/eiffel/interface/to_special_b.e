--- Compiled class TO_SPECIAL

class TO_SPECIAL_B 

inherit

	CLASS_C
		redefine
			check_validity, new_type, is_special, mark_all_used
		end;
	SPECIAL_CONST

creation

	make
	
feature 

	check_validity is
			-- Check validity of class TO_SPECIAL
		local
			feat_table: FEATURE_TABLE;
			area_feature: ATTRIBUTE_I;
			make_area_feature: PROCEDURE_I;
			special_error: SPECIAL_ERROR;
		do
			feat_table := feature_table;

				-- Check if class has one formal generic
			if generics = Void or else generics.count /= 1 then
				!!special_error.make (Case_1, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Check if class has an attribute `area' of type SPECIAL [T].
			area_feature ?= feature_table.item ("area");
			if 	(area_feature = Void)
				or else not (area_feature.written_in = class_id)
				or else not Area_type.is_deep_equal (area_feature.type.actual_type)
			then
				!!special_error.make (Case_2, Current);
				Error_handler.insert_error (special_error);
			end;

				-- Check if class has a procedure `make_area'.
			make_area_feature ?= feature_table.item ("make_area");
			if 	make_area_feature = Void
				or else not (make_area_feature.written_in = class_id)
			then
				!!special_error.make (Case_3, Current);
				Error_handler.insert_error (special_error);
			end;
		end;

	Area_type: GEN_TYPE_A is
			-- Type SPECIAL [T]
		local
			f: FORMAL_A;
			gen: ARRAY [TYPE_A];
		once
			create f
			f.set_position (1)
			create gen.make (1, 1)
			gen.put (f, 1)
			create Result.make (System.special_id, gen)
		end;

	new_type (data: CL_TYPE_I): TO_SPECIAL_CLASS_TYPE is
			-- New class type for class TO_SPECIAL
		do
			!!Result.make (data);
		end;

	is_special: BOOLEAN is True;
			-- Is the class special ?

	mark_all_used (remover: REMOVER) is
			-- Mark attribute `area' used for dead code removal
		do
			remover.record (feature_table.item ("area"), Current)
		end;

end
