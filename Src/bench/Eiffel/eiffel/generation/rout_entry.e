-- Representation for an routine entry in an instance of ROUT_TABLE

class ROUT_ENTRY

inherit
	ENTRY
		redefine
			update, is_attribute
		end

	SHARED_ID_TABLES
	SHARED_EXEC_TABLE
	SHARED_PATTERN_TABLE
	SHARED_GENERATION
	COMPILER_EXPORTER

feature -- from ROUT_ENTRY

	body_index: INTEGER;
			-- Body index

	written_type_id: INTEGER;
			-- Type id where the feature is written in

	pattern_id: INTEGER;
			-- Pattern id of the entry
	
	is_attribute: BOOLEAN is false
			-- is the feature_i associated an attribute ?	

	set_body_index (i: INTEGER) is
			-- Assign `i' to `body_index'.
		do
			body_index := i;
		end;

	set_written_type_id (i: INTEGER) is
			-- Assign `i' to `written_type_id'.
		do
			written_type_id := i
		end;

	set_pattern_id (i: INTEGER) is
			-- Assign `i' to `pattern_id'.
		do
			pattern_id := i
		end;

feature -- previously in ROUT_UNIT

	written_in: INTEGER
			-- Id of the class where the associated feature of the
			-- unit is written in

	set_written_in (i: INTEGER) is
			-- Assign `i' to `written_in'.
		do
			written_in := i
		end;

	written_class: CLASS_C is
			-- Class where the feature is written in
		do
			Result := System.class_of_id (written_in);
		end;

	new_poly_table (routine_id: INTEGER): ROUT_TABLE is
			-- New associated polymorhic table
		do
			!!Result.make (routine_id);
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
			system_i: SYSTEM_I
		do
			system_i := System
			remover := system_i.remover;
			Result := 	remover = Void						-- Workbench mode
						or else system_i.remover_off		-- Dead code removal disconnected
						--or else is_marked
						or else remover.is_alive (body_index)	-- Final mode
		end;

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := Encoder.feature_name (written_class_type.static_type_id, body_index);
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for current entry.
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1);
				-- Real body index
			ba.append_short_integer (real_body_index - 1);
				-- Pattern id
			ba.append_short_integer (pattern_id);
		end;

	written_class_type: CLASS_TYPE is
		do
			Result := System.class_type_of_id (written_type_id)
		end;

	real_body_index: INTEGER is
			-- Real body index
		do
			Result := Execution_table.real_body_index (body_index, written_class_type)
		end;

end
