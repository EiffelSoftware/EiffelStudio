-- Entry for external table representation

class EXTERN_ENTRY

inherit

	ROUT_ENTRY
		rename
			routine_name as old_routine_name
		end;

	ROUT_ENTRY
		redefine
			routine_name
		select
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
				Result := old_routine_name
			else
				Result := external_name;
			end;
		end;

end
