indexing
	description: "AST structure in Lace file for setting system level options.";
	date: "$Date$";
	revision: "$Revision $"

class FREE_OPTION_SD

inherit
	OPTION_SD
		rename
			initialize as initialize_option
		redefine
			set, process_system_level_options, is_system_level,
			is_valid, is_free_option
		end;

	SHARED_RESCUE_STATUS;

	EIFFEL_ENV;

	SHARED_BENCH_LICENSES

feature {LACE_AST_FACTORY} -- Initialization

	initialize (on: like option_name) is
			-- Create a new FREE_OPTION AST node.
		require
			on_not_void: on /= Void
		do
			option_name := on
		ensure
			option_name_set: option_name = on
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization.
		do
			option_name ?= yacc_arg (0);
		ensure then
			option_name_exists: option_name /= Void;
		end;

feature -- Properties

	option_name: ID_SD;
			-- Free option name

	is_free_option: BOOLEAN is True

feature {COMPILER_EXPORTER}

	is_valid: BOOLEAN is
		do
			Result := valid_options.has (option_name)
		end;

	is_system_level: BOOLEAN is
		local
			opt: INTEGER
		do
			if is_valid then
				opt := valid_options.item (option_name)
				Result := opt /= hide and then
					opt /= document and then
					opt /= profile
			end;
		end;

feature {NONE}

	dead_code, exception_stack_managed, collect,
	code_replication, check_vape, array_optimization, inlining, 
	inlining_size, server_file_size,
	hide, override_cluster, address_expression, profile,
	document, hide_implementation, java_generation, line_generation,
	multithreaded, dynamic_runtime, console_application: INTEGER is UNIQUE;

	valid_options: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			!!Result.make (20);
			Result.force (dead_code, "dead_code_removal");
			Result.force (array_optimization, "array_optimization");
			Result.force (inlining, "inlining");
			Result.force (inlining_size, "inlining_size");
			Result.force (check_vape, "check_vape");
			Result.force (collect, "collect");
			Result.force (exception_stack_managed, "exception_trace");
			Result.force (code_replication, "code_replication");
			Result.force (server_file_size, "server_file_size");
			Result.force (hide, "hide");
			Result.force (profile, "profile");
			Result.force (override_cluster, "override_cluster");
			Result.force (address_expression, "address_expression");
			Result.force (document, "document");
			Result.force (hide_implementation, "hide_implementation");
			Result.force (java_generation, "java_generation")
			Result.force (line_generation, "line_generation")
			Result.force (multithreaded, "multithreaded")
			Result.force (dynamic_runtime, "dynamic_runtime")
			Result.force (console_application, "console_application")
		end;

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
			-- Adapt should not process the system level options
		require else
			is_valid
		local
			hide_sd: HIDE_SD;
			document_sd: DOCUMENT_SD;
			profile_sd: PROFILE_SD;
			hide_imp_sd: HIDE_IMPLEMENTATION_SD;
			opt: INTEGER
		do
			opt := valid_options.item (option_name);
			if opt = hide then
				!! hide_sd;
				hide_sd.adapt (value, classes, list)	
			elseif opt = hide_implementation then
				!! hide_imp_sd;
				hide_imp_sd.adapt (value, classes, list)	
			elseif opt = document then
				!! document_sd;
				document_sd.adapt (value, classes, list)	
			elseif opt = profile then
				!! profile_sd;
				profile_sd.adapt (value, classes, list)	
			end
		end;

	process_system_level_options (value: OPT_VAL_SD) is
		require else
			is_valid
		local
			error_found: BOOLEAN;
			vd37: VD37;
			i: INTEGER;
			string_value: STRING;
			path: DIRECTORY_NAME
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
							System.server_controler.set_block_size (i)
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

			when override_cluster then
				if value = void or else not value.is_name then
					error_found := true
				elseif compilation_modes.is_precompiling then
					error_found := true
				elseif universe.has_override_cluster then
					error_found := true
				elseif universe.has_cluster_of_name (value.value) then
					universe.set_override_cluster_name (value.value)
				else
					error_found := true
				end

			when address_expression then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.allow_address_expression (False)
				elseif value.is_yes then
					System.allow_address_expression (True)
				else
					error_found := True;
				end;

			when profile then
				if value = Void then
					error_found := True
				else
					Lace.ace_options.set_has_external_profile (not (value.is_yes or value.is_no) and value.is_name)
				end

			when java_generation then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_java_generation (False)
				elseif value.is_yes then
					System.set_java_generation (True)
				else
					error_found := True;
				end;

			when line_generation then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_line_generation (False)
				elseif value.is_yes  or else value.is_all then
					System.set_line_generation (True)
				else
					error_found := True;
				end;

			when dynamic_runtime then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_dynamic_runtime (False)
				elseif value.is_yes or else value.is_all then
					System.set_dynamic_runtime (True)
				else
					error_found := True;
				end;

			when console_application then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_console_application (False)
				elseif value.is_yes or else value.is_all then
					System.set_console_application (True)
				else
					error_found := True;
				end;

			when multithreaded then
				if value = Void then
					error_found := True
				elseif value.is_no then
					System.set_has_multithreaded (False)
				elseif value.is_yes or else value.is_all then
					System.set_has_multithreaded (True)
				else
					error_found := True
				end

			when hide then
					-- This has been taken care of in `adapt'.

			when document then
				string_value := value.value;
				!! path.make_from_string (string_value);
				if path.is_valid then
					System.set_document_path (path)
				else
					error_found := True
				end;

			when hide_implementation then
					-- Processing for each class is done
					-- in `adapt'
				if not compilation_modes.is_precompiling then
					error_found := True
				end
			else
				error_found := True
			end;
			if error_found then
				error (value);
			end;
		end;

end -- class FREE_OPTION_SD
