class FREE_OPTION_SD

inherit

	OPTION_SD
		redefine
			set, process_system_level_options, is_system_level,
			is_valid, is_free_option, is_precompiled
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

	is_free_option: BOOLEAN is
		do
			Result := True
		end;

	is_valid: BOOLEAN is
		do
			Result := valid_options.has (option_name);
		end;

	is_system_level: BOOLEAN is
		require else
			is_valid: is_valid
		do
			Result := True
		end;

	is_precompiled: BOOLEAN is
		do
			Result := is_valid and then
				valid_options.item (option_name) = precompilation
		end;

feature {NONE}

	dead_code, exception_stack_managed, collect, precompilation,
	code_replication: INTEGER is UNIQUE;

	valid_options: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			!!Result.make (5);
			Result.force (dead_code, "dead_code_removal");
			Result.force (collect, "collect");
			Result.force (exception_stack_managed, "exception_stack_managed");
			Result.force (precompilation, "precompiled");
			Result.force (code_replication, "code_replication");
		end;

feature

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
			-- 
			-- Adapt should not process the system level options
		do
			-- Do nothing
			-- All the free options are system level
		end;

	process_system_level_options (value: OPT_VAL_SD) is
		require else
			is_valid
		local
			error_found: BOOLEAN;
			vd37: VD37;
		do
			inspect
				valid_options.item (option_name)
			when dead_code then
				if value.is_no then
					System.set_remover_off (True)
				elseif value.is_yes then
					System.set_remover_off (False)
				else
					error_found := True;
				end;
			when collect then
				!!vd37;
				Error_handler.insert_warning (vd37);
			when exception_stack_managed then
				if value.is_no then
					System.set_exception_stack_managed (False)
				elseif value.is_yes then
					System.set_exception_stack_managed (True)
				else
					error_found := True;
				end;
			when code_replication then
				if value.is_no then
					System.set_code_replication_off (True);
				elseif value.is_yes then
					System.set_code_replication_off (False);
				else
					error_found := True;
				end;
			when precompilation then
					-- Do nothing: the normal case has already been solved
				if not value.is_name then
					error_found := True;
				end;
			else
				error_found := True
			end;
			if error_found then
				error (value);
			end;
		end;

end
