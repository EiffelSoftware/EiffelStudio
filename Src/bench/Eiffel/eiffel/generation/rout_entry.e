-- Representation for an routine entry in an instance of ROUT_TABLE

class ROUT_ENTRY

inherit
	ENTRY
		redefine
			update
		end

	SHARED_ID_TABLES
	SHARED_EXEC_TABLE
	SHARED_USED_TABLE
	SHARED_PATTERN_TABLE
	COMPILER_EXPORTER

feature -- from ROUT_ENTRY

	body_index: BODY_INDEX;
			-- Body index

	written_type_id: INTEGER;
			-- Type id where the feature is written in

	pattern_id: PATTERN_ID;
			-- Pattern id of the entry

	set_body_index (i: BODY_INDEX) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_written_type_id (i: INTEGER) is
			-- Assign `i' to `written_type_id'.
		do
			written_type_id := i
		end;

	set_pattern_id (i: PATTERN_ID) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end;

	body_id: BODY_ID is
			-- Body id of the feature
		do
			Result := Body_index_table.item (body_index);
		end;

feature -- previously in ROUT_UNIT

	written_in: CLASS_ID
			-- Id of the class where the associated feature of the
			-- unit is written in

	set_written_in (i: CLASS_ID) is
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in);
		end;

	new_poly_table: ROUT_TABLE is
			-- New associated polymorhic table
		do
			!!Result;
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

feature -- update

	update (class_type: CLASS_TYPE) is
		do
			{ENTRY} Precursor (class_type)
			set_written_type_id (written_class.meta_type (class_type.type).type_id)
		end

feature -- from ROUT_ENTRY

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result := 	remover = Void						-- Workbench mode
						or else System.remover_off			-- Dead code removal disconnected
						or else remover.is_body_alive (body_id)	-- Final mode
		end;

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := body_id.feature_name (written_class_type.id);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		local
			creation_type: CL_TYPE_I;
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1);
				-- Real body index
			ba.append_short_integer (real_body_index.id - 1);
				-- Pattern id
			ba.append_short_integer (pattern_id.id);
		end;

	written_class_type: CLASS_TYPE is
		do
			Result := System.class_type_of_id (written_type_id)
		end;

	real_body_index: REAL_BODY_INDEX is
			-- Real body index
		do
			Result := Dispatch_table.real_body_index
									(body_index, written_class_type)
		end;

end
