indexing
	description: "Information on the ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_PROPERTIES

inherit
	IEIFFEL_PROJECT_PROPERTIES_IMPL_STUB
		redefine
			system_name,
			default_namespace,
			root_class_name,
			key_file_name,
			creation_routine,
			evaluate_require,
			evaluate_ensure,
			evaluate_check,
			evaluate_loop,
			evaluate_invariant,
			debug_info,
			clusters,
			externals,
			assemblies,
			precompiled,
			compilation_type,
			console_application,
			title,
			description,
			company,
			product,
			copyright,
			trademark,
			version,
			culture,
			apply,
			set_system_name,
			set_default_namespace,
			set_root_class_name,
			set_creation_routine,
			set_evaluate_require,
			set_evaluate_ensure,
			set_evaluate_check,
			set_evaluate_loop,
			set_evaluate_invariant,
			set_compilation_type,
			set_console_application,
			set_debug_info,
			set_key_file_name,
			set_title,
			set_description,
			set_company,
			set_product,
			set_copyright,
			set_trademark,
			set_version,
			set_culture,
			set_precompiled
		end
	
	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		require
			initialized: Eiffel_project.initialized
		local
			sys_name: STRING
			retried: BOOLEAN
		do
			create ace.make (Eiffel_ace.file_name)
			if not retried then
				if not is_valid then
					if Eiffel_project.system_defined then
						sys_name := Eiffel_system.name
					else
						sys_name := "sample"
					end
				end
			end
		end
	
feature -- Access
	
	system_name: STRING is
			-- System name.
		do
			if is_valid then
				Result := ace.system_name
			end
		end
		
	default_namespace: STRING is
			-- Default namespace
		do
			if is_valid then
				Result := ace.default_namespace
			end
		end
	
	root_class_name: STRING is
			-- Root class name.
		do
			if is_valid then
				Result := ace.root_class_name
			end
		end
	
	creation_routine: STRING is
			-- Creation routine name.
		do
			if is_valid then
				Result := ace.creation_routine_name
			end
		end
		
	evaluate_require: BOOLEAN is
			-- Should preconditions be evaluated?
		do
			if is_valid then
				Result := ace.require_evaluated
			end
		end

	evaluate_ensure: BOOLEAN is
			-- Should postconditions be evaluated?
		do
			if is_valid then
				Result := ace.ensure_evaluated
			end
		end

	evaluate_check: BOOLEAN is
			-- Should check assertions be evaluated?
		do
			if is_valid then
				Result := ace.check_evaluated
			end
		end

	evaluate_loop: BOOLEAN is
			-- Should loop assertions be evaluated?
		do
			if is_valid then
				Result := ace.loop_evaluated
			end
		end

	evaluate_invariant: BOOLEAN is
			-- Should class invariants be evaluated?
		do
			if is_valid then
				Result := ace.invariant_evaluated
			end
		end

	debug_info: BOOLEAN is
			-- Generate debug info?
		do
			if is_valid then
				Result := ace.line_generation
			end
		end
		
	title: STRING is
			-- Title of the system
		do
			if is_valid then
				Result := ace.title
			end
		end
		
	description: STRING is 
			-- Description of the system
		do
			if is_valid then
				Result := ace.description
			end
		end
		
	company: STRING is
			-- Company that own the system
		do
			if is_valid then
				Result := ace.company
			end
		end
		
	copyright: STRING is
			-- Copyright information
		do
			if is_valid then
				Result := ace.copyright
			end
		end
		
	trademark: STRING is
			-- Trademark related information
		do
			if is_valid then
				Result := ace.trademark
			end	
		end

	product: STRING is
			-- Product information
		do
			if is_valid then
				Result := ace.product
			end	
		end
		
	version: STRING is
			-- Four part version number for system
		do
			if is_valid then
				Result := ace.version
			end
		end
		
	culture: STRING is
			-- Assembly culture (short code - 'en-gb' etc.)
		do
			if is_valid then
				Result := ace.msil_culture
			end
		end
	
		
	clusters: SYSTEM_CLUSTERS is
			-- List of clusters in current project (list of IEiffelClusterProperties*).
		do
			create Result.make (ace)
		end
		
	externals: SYSTEM_EXTERNALS is
			-- List of the externals in the current project (IEiffelExternalProperties*)
		do
			create Result.make (ace)
		end
		
	assemblies: SYSTEM_ASSEMBLIES is
			-- System assemblies
		do
			create Result.make (ace)
		end

	compilation_type: INTEGER is
			-- IL Compilation type.
		local
			enum: ECOM_X__EIF_COMPILATION_TYPES_ENUM
		do
			if is_valid then
				create enum
				if ace.il_generation_type = ace.Il_generation_exe then
					Result := enum.eif_compt_is_application
				elseif ace.il_generation_type = ace.Il_generation_dll then
					Result := enum.eif_compt_is_library
				else
					Result := -1
				end
			else
				Result := -1
			end
		end

	console_application: BOOLEAN is
			-- Is console application?
		do
			if is_valid then
				Result := ace.is_console_application
			end
		end
		
	working_directory: STRING is
			-- system working directory
		do
			if is_valid then 
				Result := ace.working_directory
			end
		end
		
	key_file_name: STRING is
			-- assembly sign key filename
		do
			if is_valid then 
				Result := ace.msil_key_file_name
			end
		end
		
	precompiled: STRING is
			-- Precompiled library
		do
			if is_valid then 
				Result := ace.precompiled
			end
		end
		
feature -- Element change

	set_system_name (a_system_name: STRING) is
			-- Assign `a_system_name' to system name.
		require else
			non_void_system_name: a_system_name /= Void
			valid_system_name: not a_system_name.is_empty
		do
			if is_valid then
				if a_system_name /= Void and then not a_system_name.is_empty then
					ace.set_system_name (a_system_name)
				end
			end
		end
		
	set_default_namespace (a_namespace: STRING) is
			-- Assign `a_namespace' to system name.
		do
			if is_valid then
				ace.set_default_namespace (a_namespace)
			end
		end
		
	set_root_class_name (a_name: STRING) is
			-- Assign `return_value' to root class name.
		require else
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			if is_valid then
				if a_name /= Void and then not a_name.is_empty then
					ace.set_root_class_name (a_name)
				end
			end
		end
	
	set_creation_routine (a_routine: STRING) is
			-- Assign `return_value' to creation routine name.
		do
			if is_valid then
				ace.set_creation_routine_name (a_routine)
			end
		end

	set_evaluate_require (return_value: BOOLEAN) is
			-- Should preconditions be evaluated?
		do
			if is_valid then
				ace.set_assertions (return_value, evaluate_ensure, evaluate_check, evaluate_loop, evaluate_invariant)
			end
		end

	set_evaluate_ensure (return_value: BOOLEAN) is
			-- Should postconditions be evaluated?
		do
			if is_valid then
				ace.set_assertions (evaluate_require, return_value, evaluate_check, evaluate_loop, evaluate_invariant)
			end
		end

	set_evaluate_check (return_value: BOOLEAN) is
			-- Should check assertions be evaluated?
		do
			if is_valid then
				ace.set_assertions (evaluate_require, evaluate_ensure, return_value, evaluate_loop, evaluate_invariant)
			end
		end

	set_evaluate_loop (return_value: BOOLEAN) is
			-- Should loop assertions be evaluated?
		do
			if is_valid then
				ace.set_assertions (evaluate_require, evaluate_ensure, evaluate_check, return_value, evaluate_invariant)
			end
		end

	set_evaluate_invariant (return_value: BOOLEAN) is
			-- Should class invariants be evaluated?
		do
			if is_valid then
				ace.set_assertions (evaluate_require, evaluate_ensure, evaluate_check, evaluate_loop, return_value)
			end
		end

	set_compilation_type (return_value: INTEGER) is
			-- Compilation type.
		local
			enum: ECOM_X__EIF_COMPILATION_TYPES_ENUM
		do
			if is_valid then
				create enum
				if return_value = enum.eif_compt_is_application then
					ace.set_il_generation_type (ace.Il_generation_exe)
				elseif return_value = enum.eif_compt_is_library then
					ace.set_il_generation_type (ace.Il_generation_dll)
				elseif return_value = enum.Eif_compt_is_precompilation then
					ace.set_il_generation_type (ace.Il_generation_dll)
				end
			end
		end

	set_console_application (return_value: BOOLEAN) is
			-- Is console application?
		do
			if is_valid then
				ace.set_console_application (return_value)
			end
		end
		
	set_debug_info (return_value: BOOLEAN) is
			-- Generate debug info?
		do
			if is_valid then
				ace.set_line_generation (return_value)
			end
		end
		
	set_working_directory (directory: STRING) is 
			-- Set the systems working directory
		do
			if is_valid then
				ace.set_working_directory(directory)
			end
		end
		
	set_key_file_name (filename: STRING) is 
			-- Set the assembly sign key file name
		do
			if is_valid then
				ace.set_msil_key_file_name (filename)
			end
		end
		
	set_title(a_title: STRING) is
			-- Set title of the system
		do
			if is_valid then
				ace.set_title (a_title)
			end
		end
		
	set_description (a_description: STRING) is 
			-- Set description of the system
		do
			if is_valid then
				ace.set_description(a_description)
			end
		end
		
	set_company (a_company: STRING) is
			-- Set company that own the system
		do
			if is_valid then
				ace.set_company(a_company)
			end
		end
		
	set_copyright (a_copyright: STRING) is
			-- Set copyright information
		do
			if is_valid then
				ace.set_copyright(a_copyright)
			end
		end
		
	set_trademark (a_trademark: STRING) is
			-- Set trademark related information
		do
			if is_valid then
				ace.set_trademark(a_trademark)
			end	
		end

	set_product (a_product: STRING) is
			-- Set product information
		do
			if is_valid then
				ace.set_product(a_product)
			end	
		end
		
	set_version (a_version: STRING) is
			-- Set the four part version number for system
		do
			if is_valid then
				ace.set_version(a_version)
			end
		end
		
	set_culture (a_culture: STRING) is
			-- Set assembly culture (short code - 'en-gb' etc.)
		do
			if is_valid then
				ace.set_msil_culture(a_culture)
			end
		end
		
	set_precompiled (a_filename: STRING) is
			-- Set precompiled to 'fia_filename' 
		do
			if is_valid then
				ace.set_precompiled (a_filename)
			end
		end
		
feature -- Status report

	is_valid: BOOLEAN is
			-- Are current properties valid?
		do
			Result := ace.is_valid
		end
		
feature -- Basic operations

	apply is
			-- Apply changes.
		do
			if is_valid then
				clusters.store
				externals.store
				assemblies.store
				ace.apply
			end
		end

feature {NONE} -- Implementation

	ace: ACE_FILE_ACCESSER
			-- Access to the Ace file.

end -- class PROJECT_PROPERTIES
