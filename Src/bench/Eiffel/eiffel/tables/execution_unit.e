-- Execution unit

class EXECUTION_UNIT 

inherit

	CALL_UNIT
		rename
			id as body_id,
			set_id as set_body_id
		redefine
			body_id, index
		end

creation

	make

feature

	body_id: BODY_ID;
			-- Body id	

	type: TYPE_C;
			-- C type of the unit

	real_body_id: REAL_BODY_ID is
			-- Real body id
			--| To be redefined in EXT_EXECUTION_UNIT
		do
			Result := index;
		end;

	index: REAL_BODY_ID;

	pattern_id: PATTERN_ID;
		-- Pattern id of feature corresponding to Current
		-- unit

	written_in: CLASS_ID;
		-- Id of class in which the feature corresponding
		-- to Current execution unit is written.
		--|Note: for ATTRIBUTE_I it is the `generate_in' value.

	real_pattern_id: INTEGER is
			-- Pattern id associated with Current execution unit
		local
			written_type: CL_TYPE_I;
			written_class: CLASS_C
		do
			written_class := System.class_of_id (written_in);
			written_type :=	class_type.written_type (written_class);
			Result := Pattern_table.c_pattern_id (pattern_id, written_type) - 1;
		end;

	is_valid: BOOLEAN is
			-- Is the executino unit still valid ?
		local
			written_type: CL_TYPE_I;
			written_class: CLASS_C;
			s: TWO_WAY_SORTED_SET [BODY_ID];
		do
			written_class := System.class_of_id (written_in);
			if written_class /= Void and then
				System.class_type_of_id (type_id) /= Void
			then
				written_type :=	class_type.written_type (written_class);
				if written_type /= Void then
					if
						written_type.associated_class_type.is_precompiled
					then
						Result := True
						-- The next line is solely here to grow some extra
						-- gray hair on the head of whoever is going to read it.
						-- Seriously: the body id may correspond to a FEATURE_I
						-- having undergone a "body id change". In that case the
						-- body id is not valid if the system has an equivalent
						-- one which is different.
					else
						s := class_type.valid_body_ids;
							-- valid_body_ids is void for the first compilation
						Result := (s = Void) or else (s.has (body_id));
					end;
				end;
			end;
		end;

	is_external: BOOLEAN is
			-- Is the current execution unit an external one ?
		do
			-- Do nothing
		end;

	make (cl_type: CLASS_TYPE; f: FEATURE_I) is
			-- Initialization
		require
			good_argument: not (f = Void or else cl_type = Void);
			consistency1: f.body_id /= Void;
			consistency2: f.to_generate_in (cl_type.associated_class)
		local
			result_type: TYPE_I;
			gen_type: GEN_TYPE_I;
			ai: ATTRIBUTE_I;
		do
			class_type := cl_type;
			body_id := f.body_id;
				-- Save information for later computation
				-- of pattern id.
			pattern_id := f.pattern_id;
			ai ?= f;
			if ai /= Void then
				written_in := ai.generate_in;
			else
				written_in := f.written_in;
			end;
			result_type := f.type.actual_type.type_i;
			if result_type.has_formal then
				gen_type ?= cl_type.type;
				result_type := result_type.instantiation_in (gen_type);
			end;
			type := result_type.c_type;
		end;

	compound_name: STRING is
			-- Compound C routine name
		do
			Result := body_id.feature_name (class_type.id)
		end;

	generate_declaration (buffer: GENERATION_BUFFER) is
			-- Generate external declaration for the compound routine
		require
			good_argument: buffer /= Void;
		do
			buffer.putstring ("extern ");
			type.generate (buffer);
			buffer.putstring (compound_name);
			buffer.putstring ("();%N");
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generate compound pointer
		require
			good_argument: buffer /= Void;
		do
			buffer.putstring ("(fnptr) ");
			buffer.putstring (compound_name);
			buffer.putstring (",%N");
		end;

feature -- Debug

	trace is
		do
			io.error.putstring (generator);
			io.error.putstring ("%NBody_id: ");
			body_id.trace;
			io.error.putstring ("%NIndex: ");
			index.trace;
			io.error.putstring ("%NPattern id: ");
			io.error.putint (pattern_id.id);
			io.error.putstring ("%Nwritten_in: ");
			written_in.trace;
			io.error.putstring ("%NType: ");
			type.trace;
			io.error.new_line;
		end;

end
