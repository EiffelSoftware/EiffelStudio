-- Entry for external table representation

class EXTERN_ENTRY

inherit

	ROUT_ENTRY
		redefine
			routine_name
		end

feature

	external_name: STRING;
			-- External name to generate

	set_external_name (s: STRING) is
			-- Assign `s' to `external_name'.
		do
			external_name := s;
		end;

	routine_name: STRING is
			-- Routine name to generate
		do
			Result := external_name;
		end;

end
