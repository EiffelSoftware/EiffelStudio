-- Representation for an routine entry in an instance of ROUT_TABLE

class ROUT_ENTRY

inherit

	ENTRY;
	SHARED_ID_TABLES;
	SHARED_EXEC_TABLE;
	SHARED_USED_TABLE;
	COMPILER_EXPORTER

feature

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

	used: BOOLEAN is
			-- Is the entry used ?
		local
			remover: REMOVER
		do
			remover := System.remover;
			Result := 	remover = Void					-- Workbench mode
						or else
						System.remover_off				-- Dead code removal disconnected
						or else
						remover.is_body_alive (body_id)	-- Final mode
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
