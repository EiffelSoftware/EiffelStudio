class DEBUG_SD

inherit

	OPTION_SD
		redefine
			is_debug
		end

feature

	is_debug: BOOLEAN is
			-- Is the option a debug one ?
		do
			Result := True;
		end

end
