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

	is_valid: BOOLEAN is
		do
io.error.putstring ("FIXME FREE_OPTION%N");
--			Result := ("dead_code_removal").is_equal (option_name);

		-- "exception_stack_managed"
		-- "chained_assertions"
		-- "repeated_inheritance"
		end;

	is_system_tag: BOOLEAN is
		do
io.error.putstring ("FIXME FREE_OPTION%N");
		--	Result := option_name.is_equal ("dead_code_removal");
		end;

end
