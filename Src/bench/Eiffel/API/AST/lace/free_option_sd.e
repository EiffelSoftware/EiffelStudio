class FREE_OPTION_SD

inherit

	OPTION_SD
		redefine
			set
		end

feature

	option_name: ID_SD;
			-- Free option name

	set is
			-- Yacc initialization
		do
			option_name ?= yacc_arg (0);
		ensure then
			option_name_exists: option_name /= Void;
		end;

end
