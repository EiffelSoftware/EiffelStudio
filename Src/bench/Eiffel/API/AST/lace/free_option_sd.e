indexing
	description: "AST structure in Lace file for setting system level options.";
	date: "$Date$";
	revision: "$Revision$"

class FREE_OPTION_SD

inherit
	OPTION_SD
		rename
			initialize as initialize_option
		redefine
			process_system_level_options, is_system_level,
			is_free_option, duplicate, is_valid
		end;

	SHARED_RESCUE_STATUS;

	EIFFEL_ENV;

	SHARED_BENCH_LICENSES

	SHARED_EIFFEL_PARSER

feature {OPTION_SD, LACE_AST_FACTORY} -- Initialization

	initialize (on: like option_name) is
			-- Create a new FREE_OPTION AST node.
		require
			on_not_void: on /= Void
		do
			if option_codes.has (on) then
				code := option_codes.item (on)
			else
					-- Will raise an error during parsing
				code := -1
			end
		ensure
			option_name_set: option_name.is_equal (on)
		end

feature -- Properties

	is_valid: BOOLEAN is
			-- Is current option valid?
		do
			Result := code /= -1
		end

	option_name: ID_SD is
			-- Free option name
		do
			create Result.initialize (option_names.item (code))
		end

	code: INTEGER
			-- Code representing option.

	is_free_option: BOOLEAN is True

	is_override: BOOLEAN is
			-- Is Current the override_cluster option?
		do
			Result := override_cluster = code
		end

	address_expression,
	arguments,
	array_optimization,
	check_vape,
	collect,
	console_application,
	dead_code,
	document,
	dynamic_runtime,
	exception_stack_managed,
	hide,
	hide_implementation,
	msil_generation,
	msil_generation_type,
	msil_culture,
	msil_version,
	msil_assembly_compatibility,
	msil_full_name,
	il_verifiable,
	inlining, 
	inlining_size,
	ise_gc_runtime,
	java_generation,
	line_generation,
	multithreaded,
	override_cluster,
	profile,
	server_file_size,
	shared_library_definition,
	working_directory,
	force_recompile: INTEGER is unique

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result
			Result.initialize (option_name.duplicate)
		end

feature {COMPILER_EXPORTER}

	is_system_level: BOOLEAN is
		local
			opt: INTEGER
		do
			opt := code
			Result := opt /= hide and then
				opt /= document and then
				opt /= profile
		end;

feature {NONE} -- Codes and names.

	option_codes: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			!!Result.make (35);
			Result.force (dead_code, "dead_code_removal");
			Result.force (array_optimization, "array_optimization");
			Result.force (inlining, "inlining");
			Result.force (inlining_size, "inlining_size");
			Result.force (collect, "collect");
			Result.force (exception_stack_managed, "exception_trace");
			Result.force (profile, "profile");
			Result.force (override_cluster, "override_cluster");
			Result.force (address_expression, "address_expression");
			Result.force (document, "document");
			Result.force (line_generation, "line_generation")
			Result.force (multithreaded, "multithreaded")
			Result.force (dynamic_runtime, "dynamic_runtime")
			Result.force (console_application, "console_application")
			Result.force (shared_library_definition, "shared_library_definition")
			Result.force (check_vape, "check_vape");
			Result.force (hide, "hide");
			Result.force (hide_implementation, "hide_implementation");
			Result.force (server_file_size, "server_file_size");
			Result.force (java_generation, "java_generation")
			Result.force (msil_generation, "msil_generation");
			Result.force (msil_generation_type, "msil_generation_type");
			Result.force (msil_culture, "msil_culture");
			Result.force (msil_version, "msil_version");
			Result.force (il_verifiable, "il_verifiable");
			Result.force (msil_assembly_compatibility, "msil_assembly_compatibility");
			Result.force (msil_full_name, "msil_full_name");
			Result.force (ise_gc_runtime, "ise_gc_runtime");
			Result.force (arguments, "arguments");
			Result.force (working_directory, "working_directory");
			Result.force (force_recompile, "force_recompile");
		end

	option_names: ARRAY [STRING] is
			-- Name of each option associated to its code
		once
			from
				create Result.make (0, 35)
				option_codes.start
			until
				option_codes.after
			loop
				Result.force (option_codes.key_for_iteration, option_codes.item_for_iteration)	
				option_codes.forth
			end
		end

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
			-- Adapt should not process the system level options
		local
			hide_sd: HIDE_SD;
			document_sd: DOCUMENT_SD;
			profile_sd: PROFILE_SD;
			hide_imp_sd: HIDE_IMPLEMENTATION_SD;
			opt: INTEGER
		do
			opt := code
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
		local
			error_found: BOOLEAN;
			vd37: VD37;
			i: INTEGER;
			string_value: STRING;
			path: DIRECTORY_NAME
		do
			if value = Void then
				error_found := True
			else
				inspect
					code

				when dead_code then
					if value.is_no then
						System.set_remover_off (True)
					elseif value.is_yes then
						System.set_remover_off (False)
					else
						error_found := True;
					end;

				when array_optimization then
					if value.is_no then
						System.set_array_optimization_on (False)
					elseif value.is_yes then
							-- FIXME
						System.set_array_optimization_on (False)
					else
						error_found := True;
					end;

				when inlining then
					if value.is_no then
						System.set_inlining_on (False)
					elseif value.is_yes then
						System.set_inlining_on (True)
					else
						error_found := True;
					end;

				when inlining_size then
					if value.is_name then
						string_value := value.value;
						if string_value.is_integer then
							i := value.value.to_integer;
							if (i < 0 or else i > 100) then
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
					if value.is_name then
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
					if value.is_no then
						System.set_do_not_check_vape (True)
					elseif value.is_yes then
						System.set_do_not_check_vape (False)
					else
						error_found := True;
					end;

				when collect then
					create vd37;
					Error_handler.insert_warning (vd37);

				when exception_stack_managed then
					if value.is_no then
						System.set_exception_stack_managed (False)
					elseif value.is_yes then
						System.set_exception_stack_managed (True)
					else
						error_found := True;
					end;

				when override_cluster then
					if not value.is_name then
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
					if value.is_no then
						System.allow_address_expression (False)
					elseif value.is_yes then
						System.allow_address_expression (True)
					else
						error_found := True;
					end;

				when profile then
					Lace.ace_options.set_has_external_profile (not (value.is_yes or value.is_no) and value.is_name)

				when java_generation then
					if value.is_no then
						System.set_java_generation (False)
						set_il_parsing (False)
					elseif value.is_yes then
						System.set_java_generation (True)
						set_il_parsing (True)
					else
						error_found := True;
					end;

				when msil_generation then
					if value.is_no then
						System.set_il_generation (False)
						set_il_parsing (False)
					elseif value.is_yes then
						System.set_il_generation (True)
						set_il_parsing (True)
					else
						error_found := True;
					end;

				when msil_generation_type then
					if value.is_name then
						string_value := value.value
						string_value.to_lower
						if
							string_value.is_equal ("exe")
							or else string_value.is_equal ("dll")
						then
							System.set_msil_generation_type (string_value)
						else
							error_found := True
						end
					else
						error_found := True
					end

				when msil_culture then
					if value.is_name then
						System.set_msil_culture (value.value)	
					else
						error_found := True
					end

				when msil_version then
					if value.is_name then
						System.set_msil_version (value.value)	
					else
						error_found := True
					end

				when msil_full_name then
					if value.is_name then
						System.set_msil_full_name (value.value)	
					else
						error_found := True
					end

				when msil_assembly_compatibility then
					if value.is_name then
						System.set_msil_assembly_compatibility (value.value)	
					else
						error_found := True
					end

				when line_generation then
					if value.is_no then
						System.set_line_generation (False)
					elseif value.is_yes  or else value.is_all then
						System.set_line_generation (True)
					else
						error_found := True;
					end;

				when dynamic_runtime then
					if value.is_no then
						System.set_dynamic_runtime (False)
					elseif value.is_yes or else value.is_all then
						System.set_dynamic_runtime (True)
					else
						error_found := True;
					end;

				when ise_gc_runtime then
					if value.is_no then
						System.set_ise_gc_runtime (False)
					elseif value.is_yes or else value.is_all then
						System.set_ise_gc_runtime (True)
					else
						error_found := True;
					end;

				when console_application then
					if value.is_no then
						System.set_console_application (False)
					elseif value.is_yes or else value.is_all then
						System.set_console_application (True)
					else
						error_found := True;
					end;

				when multithreaded then
					if value.is_no then
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

				when shared_library_definition then
					if value.is_name then
						string_value := value.value;
						System.set_dynamic_def_file (string_value)
					else
						error_found := True;
					end;

				when arguments then
					if not value.is_name then
						error_found := True
					else
						Lace.argument_list.extend (value.value)
					end
				
				when working_directory then
					if not value.is_name then
						error_found := True
					else
						Lace.set_application_working_directory (value.value)
					end

				when il_verifiable then
					if value.is_no then
						System.set_il_verifiable (False)
					elseif value.is_yes then
						System.set_il_verifiable (True)
					else
						error_found := True;
					end;

				when force_recompile then
					if value.is_no then
						Lace.set_full_degree_6_needed (False)
					elseif value.is_yes then
						Lace.set_full_degree_6_needed (True)
					else
						error_found := True;
					end;

				else
					error_found := True
				end;
			end
			if error_found then
				error (value);
			end;
		end;

end -- class FREE_OPTION_SD
