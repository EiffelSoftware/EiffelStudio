-- Execution unit

class EXECUTION_UNIT 

inherit

	CALL_UNIT
		rename
			id as body_id,
			set_id as set_body_id
		end

creation

	make

	
feature

	type: TYPE_C;
			-- C type of the unit

	real_body_id: INTEGER is
			-- Real body id
			--| To be redefined in EXT_EXECUTION_UNIT
		do
			Result := index;
		end;

	is_valid: BOOLEAN is
			-- Is the executino unit still valid ?
		do
			Result := Body_server.has (body_id);
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
			consistency1: f.body_id > 0;
			consistency2: f.to_generate_in (cl_type.associated_class)
		local
			result_type: TYPE_I;
			gen_type: GEN_TYPE_I;
		do
			class_type := cl_type;
			body_id := f.body_id;
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
			Result := Encoder.feature_name (class_type.id, body_id);
		end;

	generate_declaration (file: UNIX_FILE) is
			-- Generate external declaration for the compound routine
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		do
			file.putstring ("extern ");
			type.generate (file);
			file.putstring (compound_name);
			file.putstring ("();%N");
		end;

	generate (file: UNIX_FILE) is
			-- Generate compound pointer
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		do
			file.putstring ("(fnptr) ");
			file.putstring (compound_name);
			file.putstring (",%N");
		end;

end
