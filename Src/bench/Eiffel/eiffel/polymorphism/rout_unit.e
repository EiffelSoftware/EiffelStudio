-- Polymorhic unit for an Eiffel routine

class ROUT_UNIT

inherit

	POLY_UNIT;
	SHARED_PATTERN_TABLE;

feature

	body_index: BODY_INDEX;
			-- Body index of the unit

	written_in: CLASS_ID;
			-- Id of the class where the associated feature of the
			-- unit is written in

	pattern_id: PATTERN_ID;
			-- Pattern id of the unit

	set_body_index (i: BODY_INDEX) is
			-- Assign `i' to `body_index'.
		do
			body_index := i
		end;

	set_written_in (i: CLASS_ID) is
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end;

	set_pattern_id (i: PATTERN_ID) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i;
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in);
		end;

	new_poly_table (pid: PATTERN_ID): ROUT_UNIT_TABLE is
			-- New associated polymorhic table
		do
			!!Result.make;
		end;

	entry (class_type: CLASS_TYPE): ROUT_ENTRY is
			-- Entry for a routine
		local
			written_type: CL_TYPE_I;
		do
			!!Result;
			Result.set_type_id (class_type.type_id);
			Result.set_type (feature_type (class_type));
			Result.set_body_index (body_index);
debug
io.error.putstring ("arg = ");
io.error.putstring (class_type.type.base_class.name);
io.error.putstring ("   ");
io.error.putstring ("cur = ");
io.error.putstring (written_class.name);
io.error.new_line;
end;
			written_type := written_class.meta_type (class_type.type);
			Result.set_written_type_id (written_type.type_id);
			-- Not necessary anymore
			--Result.set_pattern_id
			--	(Pattern_table.c_pattern_id (pattern_id, written_type) - 1);
		end;

end
