indexing
	description: "Options of the system as there are specified in the ace file"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_OPTIONS

inherit
	CONF_VALIDITY

feature -- Access

	remover_off: BOOLEAN
			-- Is the remover off (by specifying the Ace option)

	array_optimization_on: BOOLEAN
			-- Is array optimization on?

	inlining_on: BOOLEAN;
			-- Is inlining on ?

	inlining_size: INTEGER
			-- Size of the feature which will be inlined.

	dynamic_def_file: STRING
			-- File where the `.def' file of the system is declared.

	do_not_check_vape: BOOLEAN
			-- Does system check for VAPE error in precondition?

	check_generic_creation_constraint: BOOLEAN
			-- Do we check a generic type against any of the creation constraint specified
			-- in associated base class.

	address_expression_allowed: BOOLEAN
			-- Does system accept such statement as $(a.to_c)?

	line_generation: BOOLEAN
			-- Does the system generate the line number in the C-code?

	automatic_backup: BOOLEAN
			-- Automatic backup generation?

	has_multithreaded: BOOLEAN is
			-- Is the system a multithreaded one, only true for classic system?
		do
			Result := not il_generation and then internal_has_multithreaded
		end

	has_old_verbatim_strings: BOOLEAN
			-- Is old semantics of verbatim strings used?

	exception_stack_managed: BOOLEAN;
			-- Is the exception stack managed in final mode

	has_expanded: BOOLEAN;
			-- Is there an expanded declaration in the system,
			--| i.e. some extra check must be done after pass2 ?

	is_console_application: BOOLEAN
			-- Is the application going to be a console application?
			--| ie on Windows only we need to link with the correct flags.

	check_for_void_target: BOOLEAN
			-- Are targets of a call check for Voidness?

	check_for_catcall_at_runtime: BOOLEAN
			-- Are we checking at run-time for potential catcalls?

	force_32bits: BOOLEAN
			-- Is the application going to be a 32bit bound application?

	has_dynamic_runtime: BOOLEAN
			-- Does the application need to be linked with a dynamic runtime?
			--| ie on Windows the application will run with a DLL and on UNIX it
			-- |will be a .so file.

	external_runtime: STRING
			-- Name of run-time to use for linking.

	uses_ise_gc_runtime: BOOLEAN is
			-- Does current use the ISE GC runtime?
		do
			Result := external_runtime = Void or else external_runtime.is_empty
		ensure
			uses_ise_gc_runtime: Result implies (external_runtime = Void or else external_runtime.is_empty)
		end

	platform: INTEGER
			-- User specified platform.

feature -- Access: IL code generation

	use_cluster_as_namespace, use_all_cluster_as_namespace: BOOLEAN
			-- Flag to tell how to generate a namespace in our code generation.
			-- `use_cluster_as_namespace' will use either name of cluster or
			-- given namespace in Ace file as namespace.
			-- `use_all_cluster_as_namespace' is identical to `use_cluster_as_namespace'
			-- but adds implicit clusters created by `all' qualifier in Ace file.

	java_generation: BOOLEAN
			-- Does system generate Java byte code?

	il_generation: BOOLEAN
			-- Does system generate IL byte code?

	il_verifiable: BOOLEAN
			-- Should generated IL code be verifiable?

	clr_runtime_version: STRING
			-- Version of IL runtime available.

	metadata_cache_path: STRING
			-- Alternative EAC metadata path

	msil_generation_type: STRING
			-- Type of IL generation?

	msil_culture: STRING
			-- Culture of current assembly.

	msil_classes_per_module: INTEGER is
			-- Number of classes per generated module in IL code generation
		do
			Result := internal_msil_classes_per_module
			if Result = 0 then
				Result := 5
			end
		ensure
			msil_classes_per_module_nonnegative: Result > 0
		end

	msil_version: STRING
			-- Version of current assembly.

	msil_assembly_compatibility: STRING
			-- Compatibility of current assembly with other assemblies.

	msil_key_file_name: STRING
			-- Location of key pair used to sign current generated assembly.

	cls_compliant, dotnet_naming_convention: BOOLEAN
			-- Let the compiler generates CLS compliant metadata along with or
			-- without using .NET naming convention.
			--| Used for IL generation.

	il_quick_finalization: BOOLEAN
			-- Should finalization skip generation of single class modules?

	msil_use_optimized_precompile: BOOLEAN
			-- Should compiler take optimized precompile assembly?

feature -- Update

	set_use_cluster_as_namespace (v: BOOLEAN) is
			-- Set `use_cluster_as_namespace' to `v'.
		do
			use_cluster_as_namespace := v
		ensure
			use_cluster_as_namespace_set: use_cluster_as_namespace = v
		end

	set_use_all_cluster_as_namespace (v: BOOLEAN) is
			-- Set `use_all_cluster_as_namespace' to `v'.
		do
			use_all_cluster_as_namespace := v
		ensure
			use_all_cluster_as_namespace_set: use_all_cluster_as_namespace = v
		end

	set_java_generation (v: BOOLEAN) is
			-- Set `java_generation' to `v' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				java_generation := v
				il_generation := v
				set_msil_generation_type ("dll")
			end
		ensure
			java_generation_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				java_generation = v
			il_generation_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				il_generation = v
			msil_generation_type_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started
				or else msil_generation_type.is_equal ("dll")
		end

	set_il_verifiable (b: BOOLEAN) is
			-- Set `il_verifiable' with `b'.
		do
			il_verifiable := b
		ensure
			il_verifiable_set: il_verifiable = b
		end

	set_clr_runtime_version (version: like clr_runtime_version) is
			-- Set `clr_runtime_version' to `version'.
		require
			version_not_void: version /= Void
			version_not_empty: not version.is_empty
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				clr_runtime_version := version
			end
		ensure
			clr_runtime_version_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				clr_runtime_version = version
		end

	set_metadata_cache_path (s: STRING) is
			-- Set `metadata_cache_path' to `s'
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			if not (create {SHARED_WORKBENCH}).Workbench.is_already_compiled then
				metadata_cache_path := s
			end
		ensure
			metadata_cache_path_set: (create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else s.is_equal (metadata_cache_path)
		end

	set_msil_generation_type (s: STRING) is
			-- Set `msil_generation_type' to `s'
		require
			s_not_void: s /= Void
			s_equal_exe_or_dll: s.is_equal ("exe") or s.is_equal ("dll")
		do
			msil_generation_type := s
		ensure
			msil_generation_type_set : msil_generation_type.is_equal (s)
		end

	set_il_generation (v: BOOLEAN) is
			-- Set `il_generation' to `v' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				il_generation := v
			end
		ensure
			il_generation_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				il_generation = v
		end

	set_msil_classes_per_module (nb: like msil_classes_per_module) is
			-- Set `msil_classes_per_module' to `nb'.
		require
			nb_nonngegative: nb > 0
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				internal_msil_classes_per_module := nb
			end
		ensure
			msil_classes_per_module_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				msil_classes_per_module = nb
		end

	set_msil_culture (cult: STRING) is
			-- Set `msil_culture' with `cult'.
		do
			msil_culture := cult
		ensure
			msil_culture_set: msil_culture = cult
		end

	set_msil_version (vers: STRING) is
			-- Set `msil_version' with `vers'.
		require
			valid_version: (create {VERSION}).is_version_valid (vers)
		do
			msil_version := vers
		ensure
			msil_version_set: msil_version = vers
		end

	set_msil_assembly_compatibility (comp: STRING) is
			-- Set `msil_assembly_compatibility' with `comp'.
		require
			comp_not_void: comp /= Void
			comp_not_empty: not comp.is_empty
		do
			msil_assembly_compatibility := comp
		ensure
			msil_assembly_compatibility_set: msil_assembly_compatibility = comp
		end

	set_msil_key_file_name (a_file_name: STRING) is
			-- Set `msil_key_file_name' with `a_file_name'.
		do
			msil_key_file_name := a_file_name
		ensure
			msil_key_file_name_set: msil_key_file_name = a_file_name
		end

	set_cls_compliant (v: BOOLEAN) is
			-- Set `cls_compliant' to `v' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.is_already_compiled then
				cls_compliant := v
			end
		ensure
			cls_compliant_set:
				(create {SHARED_WORKBENCH}).Workbench.is_already_compiled or else cls_compliant = v
		end

	set_dotnet_naming_convention (v: BOOLEAN) is
			-- Set `dotnet_naming_convention' to `v' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.is_already_compiled then
				dotnet_naming_convention := v
			end
		ensure
			dotnet_naming_convention_set:
				(create {SHARED_WORKBENCH}).Workbench.is_already_compiled or else dotnet_naming_convention = v
		end

	set_do_not_check_vape (b: BOOLEAN) is
		do
			do_not_check_vape := b
		ensure
			do_not_check_vape_set: do_not_check_vape = b
		end

	set_check_generic_creation_constraint (b: BOOLEAN) is
			-- Set `check_generic_creation_constraint' with `b'.
		do
			check_generic_creation_constraint := b
		ensure
			check_generic_creation_constraint_set: check_generic_creation_constraint = b
		end

	allow_address_expression (b: BOOLEAN) is
		do
			address_expression_allowed := b
		ensure
			address_expression_allowed_set: address_expression_allowed = b
		end

	set_automatic_backup (b: BOOLEAN) is
		do
			automatic_backup := b
		ensure
			automatic_backup_set: automatic_backup = b
		end

	set_inlining_size (i: INTEGER) is
		do
			inlining_size := i
		ensure
			inlining_size_set: inlining_size = i
		end

	set_inlining_on (b: BOOLEAN) is
		do
			inlining_on := b
		ensure
			inlining_on_set: inlining_on = b
		end

	set_array_optimization_on (b: BOOLEAN) is
		do
			array_optimization_on := b
		ensure
			array_optimization_on_set: array_optimization_on = b
		end

	set_remover_off (b: BOOLEAN) is
			-- Assign `b' to `remover_off'
		do
			remover_off := b
		ensure
			remover_off_set: remover_off = b
		end

	set_exception_stack_managed (b: BOOLEAN) is
		do
			exception_stack_managed := b
		ensure
			exception_stack_managed_set: exception_stack_managed = b
		end

	set_has_expanded is
			-- Set `has_expanded' to True
		do
			has_expanded := True
		ensure
			has_expanded_set: has_expanded = True
		end

	set_line_generation (b: BOOLEAN) is
			-- Set `line_generation' to `b'
		do
			line_generation := b
		ensure
			line_generation_set : line_generation = b
		end

	set_has_multithreaded (b: BOOLEAN) is
			-- Set `internal_has_multithreaded' to `b'
		do
			if internal_has_multithreaded /= b then
				request_freeze
			end
			internal_has_multithreaded := b
		ensure
			has_multithreaded_set: internal_has_multithreaded = b
		end

	set_has_old_verbatim_strings (b: BOOLEAN) is
			-- Set `has_old_verbatim_strings' to `b'.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.has_compilation_started then
				has_old_verbatim_strings := b
			end
		ensure
			has_old_verbatim_strings_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else
				has_old_verbatim_strings = b
		end

	set_console_application (b: BOOLEAN) is
			-- Set `is_console_application' to `b'
		do
			if is_console_application /= b then
				request_freeze
			end
			is_console_application := b
		ensure
			is_console_application_set: is_console_application = b
		end

	set_check_for_void_target (b: BOOLEAN) is
			-- Set `check_for_void_target' to `b'.
		do
			check_for_void_target := b
		ensure
			check_for_void_target_set: check_for_void_target = b
		end

	set_check_for_catcall_at_runtime (b: BOOLEAN) is
			-- Set `check_for_catcall_at_runtime' to `b'.
		do
			check_for_catcall_at_runtime := b
		ensure
			check_for_catcall_at_runtime_set: check_for_catcall_at_runtime = b
		end

	set_32bits (b: BOOLEAN) is
			-- Set `force_32bits' to `b'
		do
			if force_32bits /= b then
				request_freeze
			end
			force_32bits := b
		ensure
			is_32bits_set: force_32bits = b
		end

	set_dynamic_runtime (b: BOOLEAN) is
			-- Set `is_console_application' to `b'
		do
			if has_dynamic_runtime /= b then
				request_freeze
			end
			has_dynamic_runtime := b
		ensure
			has_dynamic_runtime: has_dynamic_runtime = b
		end

	set_external_runtime (v: STRING) is
			-- Set `external_runtime' to `v'
		do
			external_runtime := v
		ensure
			external_runtime_set: external_runtime = v
		end

	set_dynamic_def_file (f: STRING) is
			-- Set `dynamic_def_file' to `f'.
		do
			dynamic_def_file := f
		ensure
			dynamic_def_file_set: dynamic_def_file = f
		end

	request_freeze is
			-- Force freezing of system.
		do
			is_freeze_requested := True
		end

	set_melt is
			-- Force melting of system.
		do
			private_melt := True
		end

	set_finalize is
			-- Force finalization of system.
		do
			private_finalize := True
		ensure
			finalize_set: private_finalize
		end

	set_il_quick_finalization is
			-- Skip generation of single class modules
		do
			il_quick_finalization := True
		ensure
			il_quick_finalization_set: il_quick_finalization
		end

	set_msil_use_optimized_precompile (b: BOOLEAN) is
			-- Take optimized version of precompile assembly from F_code
		do
			msil_use_optimized_precompile := b
		ensure
			msil_use_optimized_precompile_set: msil_use_optimized_precompile = b
		end

	set_platform (a_platform: INTEGER) is
			-- Override platform.
		require
			valid_platform: valid_platform (a_platform)
		do
			platform := a_platform
		ensure
			platform_set: platform = a_platform
		end

feature -- Status report

	is_freeze_requested: BOOLEAN
			-- Is freeze requested by the compiler due to some
			-- conditions like the need to generate an external
			-- feature, a feature, called by CECIL, etc.?

feature {SYSTEM_I} -- Implementation

	internal_msil_classes_per_module: INTEGER
			-- Number of classes per generated module in IL code generation

	private_finalize: BOOLEAN
			-- Force a finalization even if no classes have changed.
			-- Used when Ace file has changed.

	private_melt: BOOLEAN
			-- Force melt process when only Ace file has been changed.

	internal_has_multithreaded: BOOLEAN;
			-- Is the system a multithreaded one?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SYSTEM_OPTIONS
