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
			root_class_name,
			creation_routine,
			evaluate_require,
			evaluate_ensure,
			evaluate_check,
			evaluate_loop,
			evaluate_invariant,
			working_directory,
			arguments,
			debug_info,
			clusters,
			compilation_type,
			console_application,
			assemblies,
			apply,
			set_system_name,
			set_root_class_name,
			set_creation_routine,
			set_evaluate_require,
			set_evaluate_ensure,
			set_evaluate_check,
			set_evaluate_loop,
			set_evaluate_invariant,
			set_working_directory,
			set_arguments,
			set_compilation_type,
			set_console_application,
			set_debug_info,
			add_cluster,
			remove_cluster,
			cluster_properties,
			add_assembly,
			remove_assembly
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
			f: RAW_FILE
			retried: BOOLEAN
		do
			create ace.make
			if not retried then
				if not is_valid then
					if Eiffel_project.system_defined then
						sys_name := Eiffel_system.name
					else
						sys_name := "sample"
					end
					create f.make_open_write (Eiffel_ace.file_name)
					if f.exists and then f.is_writable then
						f.putstring (blank_ace_file (sys_name))
						f.close
						create ace.make
						check is_valid end
					end
				end
			end
		rescue
			retried := True
			retry
		end
	
feature -- Access
	
	system_name: STRING is
			-- System name.
		do
			if is_valid then
				Result := ace.system_name
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
		
	working_directory: STRING is
			-- Working directory.
		do
			if is_valid then
				Result := ace.working_directory
			end
		end

	arguments: STRING is
			-- Program arguments.
		do
			if is_valid then
				Result := ace.arguments	
			end
		end

	debug_info: BOOLEAN is
			-- Generate debug info?
		do
			if is_valid then
				Result := ace.line_generation
			end
		end

	clusters: ECOM_VARIANT is
			-- List of clusters in current project (list of IEiffelClusterProperties*).
		local
			res: ARRAY [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			ecom_res: ECOM_ARRAY [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]
			clp: CLUSTER_PROPERTIES
			ace_res: LINKED_LIST [STRING]
			i: INTEGER
		do
			if is_valid then
				ace_res := ace.clusters
				if ace_res /= Void and then not ace_res.is_empty then
					create res.make (1, ace_res.count)
					from
						ace_res.start
						i := 1
					until
						ace_res.after
					loop
						create clp.make (ace_res.item, ace)
						res.put (clp, i)
						i := i + 1
						ace_res.forth
					end
				end
				create ecom_res.make_from_array (res, 1, <<1>>, <<res.count>>)
				create Result.make
				Result.set_unknown_array (ecom_res)
			end
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
		
	assemblies: ECOM_ARRAY [STRING] is
			-- Imported assemblies.
			-- Void if none.
		local
			res: ARRAY [STRING]
			ace_res: LINKED_LIST [STRING]
			i: INTEGER
		do
			if is_valid then
				ace_res := ace.assemblies
				if ace_res /= Void and then not ace_res.is_empty then
					create res.make (1, ace_res.count)
					from
						ace_res.start
						i := 1
					until
						ace_res.after
					loop
						res.put (ace_res.item, i)
						i := i + 1
						ace_res.forth
					end
				end
				if res /= Void then
					create Result.make_from_array (res, 1, <<1>>, <<res.count>>)
				end
			end
		end

	cluster_properties (cluster_name: STRING): IEIFFEL_CLUSTER_PROPERTIES_INTERFACE is
			-- Cluster properties.
		local
			ace_clusters: LINKED_LIST [STRING]
		do
			if is_valid then
				ace_clusters := ace.clusters
				ace_clusters.compare_objects
				if ace_clusters.has (cluster_name) then
					create {CLUSTER_PROPERTIES} Result.make (cluster_name, ace)
				end
			end
		end
		
feature -- Element change

	set_system_name (return_value: STRING) is
			-- Assign `return_value' to system name.
		do
			if is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.set_system_name (return_value)
				end
			end
		end

	set_root_class_name (return_value: STRING) is
			-- Assign `return_value' to root class name.
		do
			if is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.set_root_class_name (return_value)
				end
			end
		end
	
	set_creation_routine (return_value: STRING) is
			-- Assign `return_value' to creation routine name.
		do
			if is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.set_creation_routine_name (return_value)
				end
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
			if ace.is_valid then
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

	set_working_directory (return_value: STRING) is
			-- Working directory.
		do
			if is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.set_working_directory (return_value)
				end				
			end
		end

	set_arguments (return_value: STRING) is
			-- Program arguments.
		do
			if is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.set_arguments (return_value)
				end				
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

	add_cluster (cluster_name: STRING; parent_name: STRING; cluster_path: STRING) is
			-- Add a cluster to the project.
		do
			if is_valid then
				if
					cluster_name /= Void and cluster_path /= Void
				and then
					not cluster_name.is_empty and not cluster_path.is_empty
				then
					ace.add_cluster (cluster_name, parent_name, cluster_path)
				end
			end
		end

	remove_cluster (cluster_name: STRING) is
			-- Remove a cluster from the project.
		do
			if is_valid then
				if cluster_name /= Void and then not cluster_name.is_empty then
					ace.remove_cluster (cluster_name)
				end
			end
		end

	add_assembly (assembly_path: STRING) is
			-- Add an assembly to the project.
		do
			if is_valid then
				if assembly_path /= Void and then not assembly_path.is_empty then
					ace.add_assembly (assembly_path)
				end
			end
		end

	remove_assembly (assembly_path: STRING) is
			-- Remove an assembly from the project.
		do
			if is_valid then
				if assembly_path /= Void and then not assembly_path.is_empty then
					ace.remove_assembly (assembly_path)
				end				
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
				ace.apply
			end
		end

feature {NONE} -- Implementation

	ace: ACE_FILE_MODIFIER
			-- Access to the Ace file.

	blank_ace_file (sys_name: STRING): STRING is
			-- Minimal ace file generated when a syntax error is detected.
		do
			Result := "system%N%T" + sys_name 
				+ "%N%Nroot%N%Troot_class%N%Ndefault%N%Tmsil_generation(yes)%N%Tmsil_generation_type(%"exe%")%N%Ncluster%N%Nend"
		end
		
end -- class PROJECT_PROPERTIES
