indexing
	description: "AST structure in Lace file for setting options."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FREE_OPTION_SD

inherit
	OPTION_SD
		redefine
			process_system_level_options, is_system_level,
			is_system_level_only, is_free_option, duplicate,
			is_valid, adapt_defaults
		end

	EIFFEL_ENV

	SHARED_EIFFEL_PARSER

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH

create
	initialize,
	make

feature {NONE} -- Initialization

	make (type_id: INTEGER) is
			-- Create a new FREE_OPTION AST node with code `type_id'.
		require
			type_id_positive: type_id > 0
			type_id_big_enough: type_id < {FREE_OPTION_SD}.free_option_count
		do
			code := type_id
		ensure
			code_set: code = type_id
		end

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
			option_name_set: option_codes.has (on) implies option_name.is_equal (on)
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
	check_generic_creation_constraint,
	check_vape,
	company,
	console_application,
	copyright,
	dead_code,
	description,
	document,
	dynamic_runtime,
	exception_stack_managed,
	force_recompile,
	full_type_checking,
	metadata_cache_path,
	msil_assembly_compatibility,
	msil_classes_per_module,
	msil_clr_version,
	msil_culture,
	msil_full_name,
	msil_generation,
	msil_generation_type,
	msil_key_file_name,
	msil_use_optimized_precompile,
	namespace,
	il_verifiable,
	cls_compliant,
	dotnet_naming_convention,
	inlining, 
	inlining_size,
	ise_gc_runtime,
	java_generation,
	line_generation,
	multithreaded,
	old_verbatim_strings,
	old_verbatim_strings_warning,
	override_cluster,
	profile,
	product,
	external_runtime,
	server_file_size,
	shared_library_definition,
	syntax_warning,
	title,
	trademark,
	use_cluster_name_as_namespace,
	use_all_cluster_name_as_namespace,
	version,
	working_directory,
	free_option_count: INTEGER is unique

feature -- Access

	option_names: ARRAY [STRING] is
			-- Name of each option associated to its code
		once
			from
				create Result.make (0, free_option_count)
				option_codes.start
			until
				option_codes.after
			loop
				Result.force (option_codes.key_for_iteration, option_codes.item_for_iteration)	
				option_codes.forth
			end
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result.initialize (option_name.duplicate)
		end

feature {COMPILER_EXPORTER}

	is_system_level: BOOLEAN is
			-- Is Current free option a system level one?
		do
			inspect code
			when document, profile then
				-- Nothing to do as Result is already False.
			else
				Result := True
			end
		end

	is_system_level_only: BOOLEAN is
			-- Is Current free option a system level only one?
		do
			inspect code
			when document, profile, namespace then
				-- Nothing to do as Result is already False.
			else
				Result := True
			end
		end
feature {NONE} -- Codes and names.

	option_codes: HASH_TABLE [INTEGER, STRING] is
			-- Possible values for free operators
		once
			create Result.make (free_option_count)
			Result.force (address_expression, "address_expression")
			Result.force (arguments, "arguments")
			Result.force (array_optimization, "array_optimization")
			Result.force (check_generic_creation_constraint, "check_generic_creation_constraint")
			Result.force (check_vape, "check_vape")
			Result.force (company, "company")
			Result.force (console_application, "console_application")
			Result.force (copyright, "copyright")
			Result.force (cls_compliant, "cls_compliant")
			Result.force (dead_code, "dead_code_removal")
			Result.force (description, "description")
			Result.force (document, "document")
			Result.force (dotnet_naming_convention, "dotnet_naming_convention")
			Result.force (dynamic_runtime, "dynamic_runtime")
			Result.force (exception_stack_managed, "exception_trace")
			Result.force (force_recompile, "force_recompile")
			Result.force (full_type_checking, "full_type_checking")
			Result.force (il_verifiable, "il_verifiable")
			Result.force (inlining, "inlining")
			Result.force (inlining_size, "inlining_size")
			Result.force (ise_gc_runtime, "ise_gc_runtime")
			Result.force (java_generation, "java_generation")
			Result.force (line_generation, "line_generation")
			Result.force (metadata_cache_path, "metadata_cache_path")
			Result.force (msil_assembly_compatibility, "msil_assembly_compatibility")
			Result.force (msil_classes_per_module, "msil_classes_per_module")
			Result.force (msil_clr_version, "msil_clr_version")
			Result.force (msil_culture, "msil_culture")
			Result.force (msil_full_name, "msil_full_name")
			Result.force (msil_generation, "msil_generation")
			Result.force (msil_generation_type, "msil_generation_type")
			Result.force (msil_key_file_name, "msil_key_file_name")
			Result.force (msil_use_optimized_precompile, "msil_use_optimized_precompile")
			Result.force (multithreaded, "multithreaded")
			Result.force (namespace, "namespace")
			Result.force (old_verbatim_strings, "old_verbatim_strings")
			Result.force (old_verbatim_strings_warning, "old_verbatim_strings_warning")
			Result.force (override_cluster, "override_cluster")
			Result.force (product, "product")
			Result.force (profile, "profile")
			Result.force (external_runtime, "external_runtime")
			Result.force (server_file_size, "server_file_size")
			Result.force (shared_library_definition, "shared_library_definition")
			Result.force (syntax_warning, "syntax_warning")
			Result.force (title, "title")
			Result.force (trademark, "trademark")
			Result.force (working_directory, "working_directory")
			Result.force (use_cluster_name_as_namespace, "use_cluster_name_as_namespace")
			Result.force (use_all_cluster_name_as_namespace, "use_all_cluster_name_as_namespace") 
			Result.force (version, "version")
		end

feature {COMPILER_EXPORTER}

	adapt (value: OPT_VAL_SD
			classes:HASH_TABLE [CLASS_I, STRING]
			list: LACE_LIST [ID_SD])
		is
			-- Adapt current option to `classes' or `list'.
		local
			l_option_sd: OPTION_SD
		do
			inspect code
			when document then
				create {DOCUMENT_SD} l_option_sd
			when profile then
				create {PROFILE_SD} l_option_sd
			when namespace then
				create {NAMESPACE_SD} l_option_sd
			else
			end
			
			if l_option_sd /= Void then
				l_option_sd.adapt (value, classes, list)
			end
		end

	adapt_defaults (value: OPT_VAL_SD
			classes:HASH_TABLE [CLASS_I, STRING]
			list: LACE_LIST [ID_SD])
		is
			-- Adapt inherited system default option to `classes' or `list'.
			-- Almost similar to `adapt', but in current case, `namespace'
			-- specification is not handled as it has a different meaning.
		local
			l_option_sd: OPTION_SD
		do
			inspect code
			when document then
				create {DOCUMENT_SD} l_option_sd
			when profile then
				create {PROFILE_SD} l_option_sd
			else
			end
			
			if l_option_sd /= Void then
				l_option_sd.adapt (value, classes, list)
			end
		end
		
	process_system_level_options (value: OPT_VAL_SD) is
		local
			error_found: BOOLEAN
			i: INTEGER
			string_value: STRING
			path: DIRECTORY_NAME
			l_version: VERSION
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
						error_found := True
					end

				when array_optimization then
					if value.is_no then
						System.set_array_optimization_on (False)
					elseif value.is_yes then
							-- FIXME
						System.set_array_optimization_on (False)
					else
						error_found := True
					end

				when inlining then
					if value.is_no then
						System.set_inlining_on (False)
					elseif value.is_yes then
						System.set_inlining_on (True)
					else
						error_found := True
					end

				when inlining_size then
					if value.is_name then
						string_value := value.value
						if string_value.is_integer then
							i := value.value.to_integer
							if (i < 0 or else i > 100) then
								error_found := True
							else
								System.set_inlining_size (i)
							end
						else
							error_found := True
						end
					else
						error_found := True
					end

				when server_file_size then
					if value.is_name then
						string_value := value.value
						if string_value.is_integer then 
							i := value.value.to_integer
							if i <= 0 then
								error_found := True
							else
								System.server_controler.set_block_size (i)
							end
						else
							error_found := True
						end
					else
						error_found := True
					end

				when check_generic_creation_constraint then
					if value.is_no then
						System.set_check_generic_creation_constraint (False)
					elseif value.is_yes then
						System.set_check_generic_creation_constraint (True)
					else
						error_found := True
					end

				when check_vape then
					if value.is_no then
						System.set_do_not_check_vape (True)
					elseif value.is_yes then
						System.set_do_not_check_vape (False)
					else
						error_found := True
					end

				when exception_stack_managed then
					if value.is_no then
						System.set_exception_stack_managed (False)
					elseif value.is_yes then
						System.set_exception_stack_managed (True)
					else
						error_found := True
					end

				when override_cluster then
						-- Do not perform all processing as some is already done
						-- in `build_universe' from ACE_SD through call to
						-- `set_override_cluster'.
					check
						value.is_name
						not compilation_modes.is_precompiling
						universe.has_override_cluster
					end
					if universe.has_cluster_of_name (value.value) then
						universe.add_override_cluster_name (value.value)
					else
						error_found := True
					end

				when address_expression then
					if value.is_no then
						System.allow_address_expression (False)
					elseif value.is_yes then
						System.allow_address_expression (True)
					else
						error_found := True
					end

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
						error_found := True
					end

				when metadata_cache_path then
					if value.is_name then
						if overridden_metadata_cache_path = Void then
							System.set_metadata_cache_path ((create {ENV_INTERP}).interpreted_string (value.value))
						end
					else
						error_found := True
					end

				when msil_generation then
					if value.is_no then
						System.set_il_generation (False)
						set_il_parsing (False)
					elseif value.is_yes then
						System.set_il_generation (True)
						set_il_parsing (True)
					else
						error_found := True
					end

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

				when msil_classes_per_module then
					if value.is_name then
						string_value := value.value
						if string_value.is_integer then
							i := string_value.to_integer
							if (i <= 0) then
								error_found := True
							else
								System.set_msil_classes_per_module (i)
							end
						else
							error_found := True
						end
					else
						error_found := True
					end
					
				when msil_clr_version then
						-- Do not perform any processing as it was done in `build_universe'
						-- from ACE_SD through call to `set_clr_runtime_version'. We only
						-- check it is consistent with the value previously set.
					if
						not value.is_name or else
						not equal (System.clr_runtime_version, value.value.string)
					then
						error_found := True
					end

				when msil_culture then
					if value.is_name then
						System.set_msil_culture (value.value)	
					else
						error_found := True
					end

				when msil_assembly_compatibility then
					if value.is_name then
						System.set_msil_assembly_compatibility (value.value)	
					else
						error_found := True
					end

				when msil_key_file_name then
					if value.is_name then
						System.set_msil_key_file_name ((create {ENV_INTERP}).interpreted_string (value.value))
					else
						error_found := True
					end
					
				when msil_use_optimized_precompile then
					if value.is_no then
						System.set_msil_use_optimized_precompile (False)
					elseif value.is_yes then
						System.set_msil_use_optimized_precompile (True)
					else
						error_found := True
					end

				when line_generation then
					if value.is_no then
						System.set_line_generation (False)
					elseif value.is_yes  or else value.is_all then
						System.set_line_generation (True)
					else
						error_found := True
					end

				when cls_compliant then
						-- CLS compliant implies that the generated
						-- metadata are CLS compliant and that generated
						-- names are too. However, you might want to
						-- keep your Eiffel names in which case, after
						-- having set `cls_compliant (yes)' you
						-- have to do `dotnet_naming_convention (no)'. If
						-- you do it the other way the `dotnet_naming_convention (no)'
						-- option will not be taken into account.
						-- Also you cannot change this option after
						-- the first successful compilation as it might
						-- break a lot of stuff.
					if value.is_no then
						System.set_cls_compliant (False)
					elseif value.is_yes then
						System.set_cls_compliant (True)
					else
						error_found := True
					end

				when dotnet_naming_convention then
						-- See `cls_compliant' comment above.
					if value.is_no then
						System.set_dotnet_naming_convention (False)
					elseif value.is_yes then
						System.set_dotnet_naming_convention (True)
					else
						error_found := True
					end

				when dynamic_runtime then
					if value.is_no then
						System.set_dynamic_runtime (False)
					elseif value.is_yes or else value.is_all then
						System.set_dynamic_runtime (True)
					else
						error_found := True
					end

				when ise_gc_runtime then
						-- Obsolete, use `external_runtime' instead

				when external_runtime then
					if value.is_name then
						System.set_external_runtime (value.value)
					else
						error_found := True
					end

				when syntax_warning then
					if value.is_no then
						System.set_has_syntax_warning (False)
					elseif value.is_yes or else value.is_all then
						System.set_has_syntax_warning (True)
					else
						error_found := True
					end

				when old_verbatim_strings then
					if value.is_no then
						System.set_has_old_verbatim_strings (False)
					elseif value.is_yes then
						System.set_has_old_verbatim_strings (True)
					else
						error_found := True
					end
				
				when old_verbatim_strings_warning then
					if value.is_no then
						System.set_has_old_verbatim_strings_warning (False)
					elseif value.is_yes then
						System.set_has_old_verbatim_strings_warning (True)
					else
						error_found := True
					end
				
				when console_application then
					if value.is_no then
						System.set_console_application (False)
					elseif value.is_yes or else value.is_all then
						System.set_console_application (True)
					else
						error_found := True
					end

				when multithreaded then
					if value.is_no then
						System.set_has_multithreaded (False)
					elseif value.is_yes or else value.is_all then
						System.set_has_multithreaded (True)
					else
						error_found := True
					end

				when document then
					string_value := value.value
					create path.make_from_string (string_value)
					if path.is_valid then
						System.set_document_path (path)
					else
						error_found := True
					end

				when shared_library_definition then
					if value.is_name then
							-- If the release doesn't generate DLL's,
							-- we do not take the option into account in the Ace.
						if has_dll_generation then
							string_value := value.value
							System.set_dynamic_def_file ((create {ENV_INTERP}).interpreted_string (string_value))
						end
					else
						error_found := True
					end

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
						error_found := True
					end

				when full_type_checking then
					if value.is_no then
						System.set_full_type_checking (False)
					elseif value.is_yes then
						System.set_full_type_checking (True)
					else
						error_found := True
					end

				when use_cluster_name_as_namespace then
					if value.is_no then
						System.set_use_cluster_as_namespace (False)
					elseif value.is_yes then
						System.set_use_cluster_as_namespace (True)
					else
						error_found := True
					end

				when use_all_cluster_name_as_namespace then
					if value.is_no then
						System.set_use_all_cluster_as_namespace (False)
					elseif value.is_yes then
						System.set_use_all_cluster_as_namespace (True)
					else
						error_found := True
					end

				when force_recompile then
					if value.is_no then
						Lace.set_full_degree_6_needed (False)
					elseif value.is_yes then
						Lace.set_full_degree_6_needed (True)
					else
						error_found := True
					end

				when namespace then
					if value.is_name then
							-- Set top namespace of all classes.
						System.set_system_namespace (value.value)
					else
						error_found := True
					end
					
				when version then
					if value.is_name then
						create l_version
						if l_version.is_version_valid (value.value) then
							System.set_msil_version (value.value)
						else
							error_found := True
						end
					else
						error_found := True
					end
					
				when title then
--					if value.is_name then
--						System.set_title (value.value)	
--					else
--						error_found := True
--					end
					
				when description then
--					if value.is_name then
--						System.set_description (value.value)	
--					else
--						error_found := True
--					end
					
				when company then
--					if value.is_name then
--						System.set_company (value.value)	
--					else
--						error_found := True
--					end
					
				when product then
--					if value.is_name then
--						System.set_product (value.value)	
--					else
--						error_found := True
--					end
					
				when copyright then
--					if value.is_name then
--						System.set_copyright (value.value)	
--					else
--						error_found := True
--					end
					
				when trademark then
--					if value.is_name then
--						System.set_trademark (value.value)	
--					else
--						error_found := True
--					end
					
				else
					error_found := True
				end
			end
			if error_found then
				error (value)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class FREE_OPTION_SD
