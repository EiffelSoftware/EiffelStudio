indexing
	description: "Options of the system as there are specified in the ace file";
	date: "$Date$";
	revision: "$Revision$"

class
	SYSTEM_OPTIONS

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

	address_expression_allowed: BOOLEAN
			-- Does system accept such statement as $(a.to_c)?
	
	java_generation: BOOLEAN
			-- Does system generate Java byte code?

	il_generation: BOOLEAN
			-- Does system generate IL byte code?

	il_verifiable: BOOLEAN
			-- Should generated IL code be verifiable?

	msil_generation_type: STRING
			-- Type of IL generation?

	msil_culture: STRING
			-- Culture of current assembly.

	msil_version: STRING
			-- Version of current assembly.

	msil_full_name: STRING
			-- Full name of current assembly.

	msil_assembly_compatibility: STRING
			-- Compatibility of current assembly with other assemblies.

	cls_compliant, cls_compliant_name: BOOLEAN
			-- Let the compiler generates CLS compliant metadata along with or
			-- without having CLS compliant name.
			--| Used for IL generation.

	line_generation: BOOLEAN
			-- Does the system generate the line number in the C-code?

	has_multithreaded: BOOLEAN
			-- Is the system a multithreaded one?

	exception_stack_managed: BOOLEAN;
			-- Is the exception stack managed in final mode

	has_expanded: BOOLEAN;
			-- Is there an expanded declaration in the system,
			--| i.e. some extra check must be done after pass2 ?

	is_console_application: BOOLEAN
			-- Is the application going to be a console application?
			--| ie on Windows only we need to link with the correct flags.

	has_dynamic_runtime: BOOLEAN
			-- Does the application need to be linked with a dynamic runtime?
			--| ie on Windows the application will run with a DLL and on UNIX it
			-- |will be a .so file.

	uses_ise_gc_runtime: BOOLEAN
			-- Does generated application uses ISE's GC.

	generate_eac_metadata: BOOLEAN
			-- Will Eiffel Assembly Cache metadata be generated?

feature -- Update

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
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else java_generation = v
			il_generation_set:
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else il_generation = v
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

	set_msil_generation_type (s: STRING) is
			-- Set `msil_generation_type' to `b'
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
				(create {SHARED_WORKBENCH}).Workbench.has_compilation_started or else il_generation = v
		end

	set_msil_culture (cult: STRING) is
			-- Set `msil_culture' with `cult'.
		require
			cult_not_void: cult /= Void
			cult_not_empty: not cult.is_empty
		do
			msil_culture := cult
		ensure
			msil_culture_set: msil_culture = cult
		end

	set_msil_version (vers: STRING) is
			-- Set `msil_version' with `vers'.
		require
			vers_not_void: vers /= Void
			vers_not_empty: not vers.is_empty
		do
			msil_version := vers
		ensure
			msil_version_set: msil_version = vers
		end

	set_msil_full_name (name: STRING) is
			-- Set `msil_full_name' with `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		do
			msil_full_name := name
		ensure
			msil_full_name_set: msil_full_name = name
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

	set_cls_compliant_name (v: BOOLEAN) is
			-- Set `cls_compliant_name' to `v' if project is not already compiled.
		do
			if not (create {SHARED_WORKBENCH}).Workbench.is_already_compiled then
				cls_compliant_name := v
			end
		ensure
			cls_compliant_name_set:
				(create {SHARED_WORKBENCH}).Workbench.is_already_compiled or else cls_compliant_name = v
		end

	set_generate_eac_metadata (b: BOOLEAN) is
			-- Set `generate_eac_metadata' with `b'.
		do
			generate_eac_metadata := b
		ensure
			generate_eac_metadata_set: generate_eac_metadata = b
		end

	set_do_not_check_vape (b: BOOLEAN) is
		do
			do_not_check_vape := b
		ensure
			do_not_check_vape_set: do_not_check_vape = b
		end

	allow_address_expression (b: BOOLEAN) is
		do
			address_expression_allowed := b
		ensure
			address_expression_allowed_set: address_expression_allowed = b
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
			if line_generation /= b then
				set_freeze
			end
			line_generation := b
		ensure
			line_generation_set : line_generation = b
		end

	set_has_multithreaded (b: BOOLEAN) is
			-- Set `has_multithreaded' to `b'
		do
			if has_multithreaded /= b then
				set_freeze
			end
			has_multithreaded := b
		ensure
			has_multithreaded_set: has_multithreaded = b
		end

	set_console_application (b: BOOLEAN) is
			-- Set `is_console_application' to `b'
		do
			if is_console_application /= b then
				set_freeze
			end
			is_console_application := b	
		ensure
			is_console_application_set: is_console_application = b
		end

	set_dynamic_runtime (b: BOOLEAN) is
			-- Set `is_console_application' to `b'
		do
			if has_dynamic_runtime /= b then
				set_freeze
			end
			has_dynamic_runtime := b	
		ensure
			has_dynamic_runtime: has_dynamic_runtime = b
		end

	set_ise_gc_runtime (b: BOOLEAN) is
			-- Set `is_console_application' to `b'
		do
			uses_ise_gc_runtime := b	
		ensure
			ise_gc_runtime_set: uses_ise_gc_runtime = b
		end

	set_dynamic_def_file (f: STRING) is
			-- Set `dynamic_def_file' to `f'.
		do
			dynamic_def_file := f
		ensure
			dynamic_def_file_set: dynamic_def_file = f
		end

	set_freeze is
			-- Force freezing of system.
		do
			private_freeze := True
		end

	set_melt is
			-- Force melting of system.
		do
			private_melt := True
		end

feature {SYSTEM_I} -- Implementation

	private_freeze: BOOLEAN
			-- Freeze set if externals or new derivation
			-- of special is generated

	private_melt: BOOLEAN
			-- Force melt process when only Ace file has been changed.

end -- class SYSTEM_OPTIONS
