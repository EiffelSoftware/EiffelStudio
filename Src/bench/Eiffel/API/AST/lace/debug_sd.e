class DEBUG_SD

inherit

	OPTION_SD
		redefine
			is_debug
		end

feature

	option_name: STRING is
		once
			Result := "debug"
		end;

	is_debug: BOOLEAN is
			-- Is the option a debug one ?
		do
			Result := True;
		end

end
