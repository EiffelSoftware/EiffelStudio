class FREE_OPTION_SD

inherit

	OPTION_SD
		redefine
			set, process_system_level_options, is_system_level,
			is_valid, is_free_option, is_precompiled
		end;
	SHARED_RESCUE_STATUS

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
	code_replication, fail_on_rescue, check_vape,
	array_optimization: INTEGER is UNIQUE;

	valid_options: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			!!Result.make (6);
			Result.force (dead_code, "dead_code_removal");
			Result.force (array_optimization, "array_optimization");
			Result.force (check_vape, "check_vape");
			Result.force (collect, "collect");
			Result.force (exception_stack_managed, "exception_stack_managed");
			Result.force (precompilation, "precompiled");
			Result.force (code_replication, "code_replication");
			Result.force (fail_on_rescue, "fail_on_rescue");
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
			val: STRING
		do
			inspect
				valid_options.item (option_name)
			when dead_code then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_remover_off (True)
				elseif value.is_yes then
					System.set_remover_off (False)
				else
					error_found := True;
				end;
			when array_optimization then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_array_optimization_level (0)
				elseif value.is_name then
					val := clone (value.value);
					val.to_lower;
					if val.is_equal ("level0") then
						System.set_array_optimization_level (0)
					elseif val.is_equal ("level1") then
						System.set_array_optimization_level (1)
					elseif val.is_equal ("level2") then
						System.set_array_optimization_level (2)
					else
						error_found := True;
					end;
				else
					error_found := True;
				end;
			when check_vape then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_do_not_check_vape (True)
				elseif value.is_yes then
					System.set_do_not_check_vape (False)
				else
					error_found := True;
				end;
			when collect then
				!!vd37;
				Error_handler.insert_warning (vd37);
			when exception_stack_managed then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_exception_stack_managed (False)
				elseif value.is_yes then
					System.set_exception_stack_managed (True)
				else
					error_found := True;
				end;
			when fail_on_rescue then
				if value = Void then
					error_found := True
				elseif value.is_no then
					Rescue_status.set_fail_on_rescue (False);
				elseif value.is_yes then
					Rescue_status.set_fail_on_rescue (True);
				else
					error_found := True;
				end;
			when code_replication then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_code_replication_off (True);
				elseif value.is_yes then
					System.set_code_replication_off (False);
				else
					error_found := True;
				end;
			when precompilation then
					-- Do nothing: the normal case has already been solved
				if value = Void or else not value.is_name then
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
