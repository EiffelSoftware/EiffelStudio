-- Entry for external table representation

class EXTERN_ENTRY

inherit
	ROUT_ENTRY
		redefine
			routine_name, entry
		end

feature -- from EXTERN_ENTRY

	external_name: STRING;
			-- External name to generate

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	encapsulated: BOOLEAN;
			-- Has the external to be encapsulated ?

	set_encapsulated (b: BOOLEAN) is
			-- set `encapsulated' to b
		do
			encapsulated := b;
		end;

	routine_name: STRING is
			-- Routine name to generate
		do
			if encapsulated then
				Result := {ROUT_ENTRY} Precursor
			else
				Result := external_name;
			end;
		end;

feature -- previously in EXTERNAL_UNIT

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
			Result.set_encapsulated (encapsulated);
			-- Not necessary anymore
			--Result.set_pattern_id
			--	(Pattern_table.c_pattern_id (pattern_id, written_type) - 1);
		end;

end
