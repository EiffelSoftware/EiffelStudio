indexing

	description:
		"AST structure in Lace file for setting system level options.";
	date: "$Date$";
	revision: "$Revision $"

class FREE_OPTION_SD

inherit

	OPTION_SD
		redefine
			set, process_system_level_options, is_system_level,
			is_valid, is_free_option, is_precompiled, is_extending,
			is_extendible
		end;
	SHARED_RESCUE_STATUS;
	SHARED_DYNAMIC_CALLS;
	EIFFEL_ENV

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
		local
			dle_license: DLE_LICENSE
		do
			if valid_options.has (option_name) then
				inspect valid_options.item (option_name)
				when extending, extendible then
					!! dle_license.make (Eiffel3_dir_name);
					if dle_license.dle_registered then
						Result := true
					end
				else
					Result := true
				end
			end
		end;

	is_system_level: BOOLEAN is
		do
			Result := is_valid and then
				valid_options.item (option_name) /= dynamic
		end;

	is_precompiled: BOOLEAN is
		do
			Result := is_valid and then
				valid_options.item (option_name) = precompilation
		end;

	is_extending: BOOLEAN is
		do
			Result := is_valid and then
				valid_options.item (option_name) = extending
		end;

	is_extendible: BOOLEAN is
		do
			Result := is_valid and then
				valid_options.item (option_name) = extendible
		end;

feature {NONE}

	dead_code, exception_stack_managed, collect, precompilation,
	code_replication, fail_on_rescue, check_vape,
	array_optimization, inlining, inlining_size,
	server_file_size, extendible, extending,
	dynamic: INTEGER is UNIQUE;

	valid_options: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			!!Result.make (14);
			Result.force (dead_code, "dead_code_removal");
			Result.force (array_optimization, "array_optimization");
			Result.force (inlining, "inlining");
			Result.force (inlining_size, "inlining_size");
			Result.force (check_vape, "check_vape");
			Result.force (collect, "collect");
			Result.force (exception_stack_managed, "exception_trace");
			Result.force (precompilation, "precompiled");
			Result.force (code_replication, "code_replication");
			Result.force (fail_on_rescue, "fail_on_rescue");
			Result.force (server_file_size, "server_file_size");
			Result.force (extendible, "extendible");
			Result.force (extending, "extending");
			Result.force (dynamic, "dynamic");
		end;

feature

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
			-- 
			-- Adapt should not process the system level options
		require else
			is_valid
		local
			dynamic_feat: DYNAMIC_FEAT_I;
			v: DYNAMIC_I;
			feat_name, class_name: STRING
		do
			if valid_options.item (option_name) = dynamic then
				if value /= Void then
					if value.is_all then
						v := All_dynamic
					elseif value.is_name then
						feat_name := clone (value.value);
						feat_name.to_lower;
						!! dynamic_feat.make;
						dynamic_feat.extend (feat_name);
						v := dynamic_feat
					else
						error (value)
					end
				else
					v := No_dynamic
				end;
				if v /= Void then
					if list = Void then
						from
							classes.start
						until
							classes.after
						loop
							classes.item_for_iteration.set_dynamic_calls (v);
							classes.forth
						end
					else
						from
							list.start
						until
							list.after
						loop
							class_name := clone (list.item);
							class_name.to_lower;
							classes.item (class_name).set_dynamic_calls (v);
							list.forth
						end
					end
				end
			end
		end;

	process_system_level_options (value: OPT_VAL_SD) is
		require else
			is_valid
		local
			error_found: BOOLEAN;
			vd37: VD37;
			i: INTEGER;
			string_value: STRING
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
					System.set_array_optimization_on (False)
				elseif value.is_yes then
					System.set_array_optimization_on (True)
				else
					error_found := True;
				end;
			when inlining then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_inlining_on (False)
				elseif value.is_yes then
					System.set_inlining_on (True)
				else
					error_found := True;
				end;
			when inlining_size then
				if value = Void then
					error_found := True
				elseif value.is_name then
					string_value := value.value;
					if string_value.is_integer then
						i := value.value.to_integer;
						if (i <= 0 or else i > 100) then
							error_found := True
						else
							System.set_inlining_size (i)
						end
					else
						error_found := True
					end
				else
					error_found := True;
				end;
			when server_file_size then
				if value = Void then
					error_found := True
				elseif value.is_name then
					string_value := value.value;
					if string_value.is_integer then 
						i := value.value.to_integer;
						if i <= 0 then
							error_found := True
						else
							System.server_controler.set_chunk_size (i)
						end
					else
						error_found := True
					end
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
			when extendible then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_extendible (false)
				elseif value.is_yes then
					System.set_extendible (true)
				else
					error_found := True;
				end
			when extending then
				if value = Void or else not value.is_name then
					error_found := True
				else
					-- Do nothing: the normal case has already been solved
				end
			when dynamic then
					-- This has been taken care of in `adapt'.
			else
				error_found := True
			end;
			if error_found then
				error (value);
			end;
		end;

end
