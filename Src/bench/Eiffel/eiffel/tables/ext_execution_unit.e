-- Execution unit for an external feature

class EXT_EXECUTION_UNIT 

inherit

	EXECUTION_UNIT
		rename
			real_body_id as basic_real_body_id,
			make as basic_make,
			is_valid as old_is_valid
		redefine
			is_external, compound_name
		end;

	EXECUTION_UNIT
		redefine
			real_body_id, make,
			is_external, compound_name,
			is_valid
		select
			real_body_id, make, is_valid
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
			is_cpp := f.is_cpp;
			external_name := f.external_name;
		end;

	is_external: BOOLEAN is True
			-- Is the current executino unit an external one ?

	is_cpp: BOOLEAN
			-- Is Current a C++ member?

	compound_name: STRING is
			-- Compound C routine name
		do
			Result := external_name
		end;

	real_body_id: REAL_BODY_ID is
			-- Real body id
		local
			frozen_body_id: REAL_BODY_ID;
		do
			check
				consistency: Externals.has (external_name);
			end;
			frozen_body_id := Externals.item (external_name).real_body_id;
			if frozen_body_id /= Void then
				Result := frozen_body_id
			else
				Result := basic_real_body_id;
			end;
		end;

	is_valid: BOOLEAN is
		do
			Result := Externals.has (external_name) and then
				IRS_valid
		end;

	IRS_valid: BOOLEAN is
			-- Is the execution unit still valid ?
		local
			written_type: CL_TYPE_I;
			written_class: CLASS_C
		do
			written_class := System.class_of_id (written_in);
			if written_class /= Void and then
				System.class_type_of_id (type_id) /= Void
			then
				written_type := class_type.written_type (written_class);
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
					elseif equal (System.onbidt.item (body_id), body_id) then
						Result := server_has
					end;
				end;
			end;
		end;

	server_has: BOOLEAN is
		do
			Result := Body_server.has (body_id)
		end;
 
end
