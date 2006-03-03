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
			is_free_option,
			is_valid
		end

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
