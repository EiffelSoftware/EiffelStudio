-- Polymorphic unit associated to an external Eiffel feature

class EXTERNAL_UNIT

inherit

	ROUT_UNIT
		redefine
			entry
		end

feature

	external_name: STRING;
			-- Name of the associated external feature

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s
		end;

	entry (class_type: CLASS_TYPE): EXTERN_ENTRY is
			-- Entry for an external feature
		local
			written_type: CL_TYPE_I;
		do
			!!Result;
			Result.set_type_id (class_type.type_id);
			Result.set_type (feature_type (class_type));
			Result.set_body_index (body_index);
			written_type := written_class.meta_type (class_type.type);
			Result.set_written_type_id (written_type.type_id);
			Result.set_external_name (external_name);
			-- Not necessary anymore
			--Result.set_pattern_id
			--	(Pattern_table.c_pattern_id (pattern_id, written_type) - 1);
		end;

end
