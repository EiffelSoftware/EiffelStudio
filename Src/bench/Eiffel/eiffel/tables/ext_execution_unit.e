-- Execution unit for an external feature

class EXT_EXECUTION_UNIT 

inherit

	EXECUTION_UNIT
		rename
			real_body_id as basic_real_body_id,
			make as basic_make
		redefine
			is_external, compound_name
		end;

	EXECUTION_UNIT
		redefine
			real_body_id, make,
			is_external, compound_name
		select
			real_body_id, make
		end

creation

	make
		
	
feature 

	external_name: STRING;
			-- Name of the external

	make (cl_type: CLASS_TYPE; f: EXTERNAL_I) is
			-- Initialization
		do
			basic_make (cl_type, f);
			external_name := f.external_name;
		end;

	is_external: BOOLEAN is
			-- Is the current executino unit an external one ?
		do
			Result := True
		end;

	compound_name: STRING is
			-- Compound C routine name
		do
			Result := external_name
		end;

	real_body_id: INTEGER is
			-- Real body id
		local
			frozen_body_id: INTEGER;
		do
			check
				consistency: Externals.has (external_name);
			end;
			frozen_body_id := Externals.item (external_name).real_body_id;
			if frozen_body_id > 0 then
				Result := frozen_body_id
			else
				Result := basic_real_body_id;
			end;
		end;

end
