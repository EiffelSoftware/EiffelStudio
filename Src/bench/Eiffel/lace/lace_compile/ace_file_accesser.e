indexing
	description: "Facilities for accessing and modifying project properties."
	date: "$Date$"
	revision: "$Revision$"

class
	ACE_FILE_ACCESSER

inherit
	LACE_AST_FACTORY
		export {NONE}
			all
		end

	SHARED_LACE_PARSER
		export {NONE}
			all
		end
		
create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
			-- Initialize ast.
		local
			is_successful: BOOLEAN
		do
			is_successful := False
			ace_file_name := a_file_name
			if ace_file_name = Void then
				ace_file_name := clone (default_ace_file_name)
			end
			root_ast := parsed_ast (ace_file_name)
			is_successful := root_ast /= Void
			if not is_successful then
				last_error_message := Warning_messages.w_Cannot_read_file (ace_file_name) +
					"%NNot a valid configuration file."
			end
		ensure
			ace_parsed: is_valid implies root_ast /= Void
		end
		
feature -- Access

	ace_file_name: STRING 
			-- Name of ace file

	root_ast: ACE_SD
			-- Parsed/Newly created Ace file

	system_name: STRING is
			-- System name.
		do
			Result := root_ast.system_name
		ensure
			non_void_system_name: Result /= Void
		end

	root_class_name: STRING is
			-- Root class name.
		do
			Result := clone (root_ast.root.root_name)
			Result.to_upper
		ensure
			non_void_root_class_name: Result /= Void
		end

	creation_routine_name: STRING is
			-- Creation routine name.
		do
			Result := root_ast.root.creation_procedure_name
		ensure
			non_void_creation_routine: Result /= Void
		end

	require_evaluated: BOOLEAN is
			-- Are preconditions evaluated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or else defaults.after
				loop
					opt := defaults.item.option
					if opt.is_assertion then
						val := defaults.item.value
						if val.is_require or else val.is_all then
							Result := True
						end
					end
					defaults.forth
				end
			end
		end
		
	ensure_evaluated: BOOLEAN is
			-- Are postconditions evaluated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or else defaults.after
				loop
					opt := defaults.item.option
					if opt.is_assertion then
						val := defaults.item.value
						if val.is_ensure or else val.is_all then
							Result := True
						end
					end
					defaults.forth
				end
			end
		end

	check_evaluated: BOOLEAN is
			-- Are check statements evaluated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or else defaults.after
				loop
					opt := defaults.item.option
					if opt.is_assertion then
						val := defaults.item.value
						if val.is_check or else val.is_all then
							Result := True
						end
					end
					defaults.forth
				end
			end
		end

	loop_evaluated: BOOLEAN is
			-- Are loop assertions evaluated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or else defaults.after
				loop
					opt := defaults.item.option
					if opt.is_assertion then
						val := defaults.item.value
						if val.is_loop or else val.is_all then
							Result := True
						end
					end
					defaults.forth
				end
			end		
		end

	invariant_evaluated: BOOLEAN is
			-- Are invariants evaluated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD			
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or else defaults.after
				loop
					opt := defaults.item.option
					if opt.is_assertion then
						val := defaults.item.value
						if val.is_invariant or else val.is_all then
							Result := True
						end
					end
					defaults.forth
				end
			end
		end

	working_directory: STRING is
			-- Application working directory.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			create Result.make (20)
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					not Result.is_empty or defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.working_directory then
							Result := defaults.item.value.value
						end
					end
					defaults.forth
				end
			end
		ensure
			non_void_directory: Result /= Void
		end
		
	il_generation: BOOLEAN is
			-- Is IL code generated?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Msil_generation then
							Result := defaults.item.value.is_yes
						end
					end
					defaults.forth
				end
			end	
		end

	il_generation_type: INTEGER is
			-- Type of the IL file generated if any.
		require
			valid_ast: is_valid
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			value: STRING
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Msil_generation_type then
							value := defaults.item.value.value
							if value.is_equal ("exe") then
								Result := il_generation_exe
							elseif value.is_equal ("dll") then
								Result := il_generation_dll
							else
								Result := il_generation_no
							end
						end
					end
					defaults.forth
				end
			end
			if Result /= il_generation_exe and Result /= il_generation_dll then
				Result := il_generation_no
			end
		ensure
			known_result: Result = il_generation_no
				or	Result = il_generation_exe
				or Result = il_generation_dll
		end

	is_console_application: BOOLEAN is
			-- Does application use console mode?
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Console_application then
							Result := defaults.item.value.is_yes
						end
					end
					defaults.forth
				end
			end	
		end

	line_generation: BOOLEAN is
			-- Line generation status for current system.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			Result := False
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					Result or defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Line_generation then
							Result := defaults.item.value.is_yes
						end
					end
					defaults.forth
				end
			end	
		ensure
			valid_ast: is_valid
		end

	cluster_names: LINKED_LIST [STRING] is
			-- Names of clusters in current project.
		require
			valid_ast: is_valid
		local
			l: LACE_LIST [CLUSTER_SD]
		do
			create Result.make
			l := root_ast.clusters
			if l /= Void then
				from
					l.start
				until
					l.after
				loop
					Result.extend (l.item.cluster_name)
					l.forth
				end
			end
		ensure
			valid_ast: is_valid
		end

	cluster_path (name: STRING): STRING is
			-- Full path to cluster named `name'.
			-- Void if no match.
		require
			valid_ast: is_valid
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			cl: CLUSTER_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				Result := cl.directory_name
			end
		ensure
			valid_ast: is_valid
		end

	is_recursive (cluster_name: STRING): BOOLEAN is
			-- Was cluster named `cluster_name' declared with keyword `all'?
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			cl: CLUSTER_SD
		do
			cl := cluster_sd_with_name (cluster_name)
			if cl /= Void then
				Result := cl.is_recursive
			end		
		end

	is_library (cluster_name: STRING): BOOLEAN is
			-- Is cluster named `cluster_name' part of a library?
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			cl: CLUSTER_SD
		do
			cl := cluster_sd_with_name (cluster_name)
			if cl /= Void then
				Result := cl.is_library
			end	
		end

	system_defaults_used (cluster_name: STRING): BOOLEAN is
			-- Does cluster named `cluster_name' use system defaults?
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
		do
			cl := cluster_sd_with_name (cluster_name)
			if cl /= Void then
				Result := True
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					Result := cl_prop.default_option = Void
				end
			end
		end
			
	require_evaluated_in_cluster (name: STRING): BOOLEAN is
			-- Are preconditions evaluated in cluster named `name'?
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			not_system_defaults: not system_defaults_used (name)
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					cl_defaults	:= cl_prop.default_option
					if cl_defaults /= Void then
						from
							cl_defaults.start
						until
							Result or else cl_defaults.after
						loop
							opt := cl_defaults.item.option
							if opt.is_assertion then
								val := cl_defaults.item.value
								if val.is_require or else val.is_all then
									Result := True
								end
							end								
							cl_defaults.forth
						end
					else
						Result := require_evaluated
					end
				else
					Result := require_evaluated
				end
			end
		end

	ensure_evaluated_in_cluster (name: STRING): BOOLEAN is
			-- Are postconditions evaluated in cluster named `name'?
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			not_system_defaults: not system_defaults_used (name)
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					cl_defaults	:= cl_prop.default_option
					if cl_defaults /= Void then
						from
							cl_defaults.start
						until
							Result or else cl_defaults.after
						loop
							opt := cl_defaults.item.option
							if opt.is_assertion then
								val := cl_defaults.item.value
								if val.is_ensure or else val.is_all then
									Result := True
								end
							end								
							cl_defaults.forth
						end
					else
						Result := ensure_evaluated
					end
				else
					Result := ensure_evaluated
				end
			end
		end

	check_evaluated_in_cluster (name: STRING): BOOLEAN is
			-- Are check statements evaluated in cluster named `name'?
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			not_system_defaults: not system_defaults_used (name)
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					cl_defaults	:= cl_prop.default_option
					if cl_defaults /= Void then
						from
							cl_defaults.start
						until
							Result or else cl_defaults.after
						loop
							opt := cl_defaults.item.option
							if opt.is_assertion then
								val := cl_defaults.item.value
								if val.is_check or else val.is_all then
									Result := True
								end
							end								
							cl_defaults.forth
						end
					else
						Result := check_evaluated
					end
				else
					Result := check_evaluated
				end
			end
		end

	loop_evaluated_in_cluster (name: STRING): BOOLEAN is
			-- Are loop assertions evaluated in cluster named `name'?
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			not_system_defaults: not system_defaults_used (name)
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					cl_defaults	:= cl_prop.default_option
					if cl_defaults /= Void then
						from
							cl_defaults.start
						until
							Result or else cl_defaults.after
						loop
							opt := cl_defaults.item.option
							if opt.is_assertion then
								val := cl_defaults.item.value
								if val.is_loop or else val.is_all then
									Result := True
								end
							end								
							cl_defaults.forth
						end
					else
						Result := loop_evaluated
					end
				else
					Result := loop_evaluated
				end
			end
		end

	invariant_evaluated_in_cluster (name: STRING): BOOLEAN is
			-- Are invariants evaluated in cluster named `name'?
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
			not_system_defaults: not system_defaults_used (name)
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					cl_defaults	:= cl_prop.default_option
					if cl_defaults /= Void then
						from
							cl_defaults.start
						until
							Result or else cl_defaults.after
						loop
							opt := cl_defaults.item.option
							if opt.is_assertion then
								val := cl_defaults.item.value
								if val.is_invariant or else val.is_all then
									Result := True
								end
							end								
							cl_defaults.forth
						end
					else
						Result := invariant_evaluated
					end
				else
					Result := invariant_evaluated
				end
			end
		end

	excluded_in_cluster (name: STRING): LINKED_LIST [STRING] is
			-- Directories excluded in cluster named `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [EXCLUDE_SD]
		do
			create Result.make
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					l_ex := cl_prop.exclude_option
					if l_ex /= Void then
						from
							l_ex.start
						until
							l_ex.after
						loop
							Result.extend (l_ex.item.file__name)
							l_ex.forth
						end
					end
				end
			end
		end

	override_cluster: STRING is
			-- Name of the override cluster.
			-- Void if none.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.override_cluster then
							create Result.make_from_string (defaults.item.value.value)
						end
					end
					defaults.forth
				end
			end
		end
		
	assemblies: LINKED_LIST [STRING] is
			-- Paths of imported assemblies.
		require
			valid_ast: is_valid
		local
			l_ext: LACE_LIST [LANG_TRIB_SD]
			file_names: LACE_LIST [ID_SD]
		do
			create Result.make
			l_ext := root_ast.externals
			if l_ext /= Void then
				from
					l_ext.start
				until
					l_ext.after
				loop
					if l_ext.item.language_name.is_assembly then
						file_names := l_ext.item.file_names
						check
							has_files: file_names /= Void
						end
						from
							file_names.start
						until
							file_names.after
						loop
							Result.extend (file_names.item)
							file_names.forth
						end
					end
					l_ext.forth
				end
			end
		ensure
			valid_ast: is_valid
		end
		
feature -- Element change

	set_system_name (new_name: STRING) is
			-- Assign `new_name' to system name.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			root_ast.set_system_name (new_id_sd (new_name, False))
		end

	set_root_class_name (new_name: STRING) is
			-- Set class named `new_name' as new root class.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty
		do
			root_ast.root.set_root_name (new_id_sd (new_name, False))
		end

	set_creation_routine_name (new_name: STRING) is
			-- Set `a_creation_routine_name' as new creation routine.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty			
		do
			root_ast.root.set_creation_procedure_name (new_id_sd (new_name, False))
		end

	set_assertions (evaluate_require, evaluate_ensure, evaluate_check, evaluate_loop, evaluate_invariant: BOOLEAN) is
			-- Change assertion settings.
		local
			new_defaults: LACE_LIST [D_OPTION_SD]
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
			had_assertion: BOOLEAN
		do
			new_defaults := root_ast.defaults
			if new_defaults /= Void then
				from
					new_defaults.start
				until
					new_defaults.after
				loop
					if new_defaults.item.option.is_assertion then
						new_defaults.remove
					else
						new_defaults.forth
					end
				end
			else
				create new_defaults.make (10)
				root_ast.set_defaults (new_defaults)
			end
			
			had_assertion := False
			if evaluate_invariant then
				had_assertion := True
				v := new_invariant_sd (new_id_sd ("invariant", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)
			end			
			if evaluate_loop then
				had_assertion := True
				v := new_loop_sd (new_id_sd ("loop", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)	
			end
			if evaluate_check then
				had_assertion := True
				v := new_check_sd (new_id_sd ("check", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)	
			end
			if evaluate_ensure then
				had_assertion := True
				v := new_ensure_sd (new_id_sd ("ensure", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)	
			end
			if evaluate_require then
				had_assertion := True
				v := new_require_sd (new_id_sd ("require", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)	
			end
			if not had_assertion then
				v := new_no_sd (new_id_sd ("no", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				new_defaults.put_front (d_option)	
			end
		end

	set_il_generation (b: BOOLEAN) is
			-- Generate IL code if `b'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Msil_generation then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			end			
			defaults.extend (new_special_option_sd ("msil_generation", Void, b))
		end

	set_il_generation_type (type: INTEGER) is
			-- Set IL generation type to `type'.
			-- If `type' is unknown or `Il_generation_no', remove IL generation.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults = Void then
				if type = Il_generation_exe or type = Il_generation_dll then
					create defaults.make (20)
					root_ast.set_defaults (defaults)
				end
			else
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Msil_generation_type then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			end
			if type = Il_generation_exe then
				defaults.extend (new_special_option_sd ("msil_generation_type", "exe", True))
			elseif type = Il_generation_dll then
				defaults.extend (new_special_option_sd ("msil_generation_type", "dll", True))
			end
		end

	set_console_application (b: BOOLEAN) is
			-- Set `is_console_application' to `b'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Console_application then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			end			
			defaults.extend (new_special_option_sd ("console_application", Void, b))
		end
		
	set_line_generation (b: BOOLEAN) is
			-- Generate debug information if `b'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Line_generation then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			end			
			defaults.extend (new_special_option_sd ("line_generation", Void, b))
		end

	set_override_cluster (name: STRING) is
			-- Set cluster named `name' as override cluster.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults = Void then
				create defaults.make (20)
				root_ast.set_defaults (defaults)
			end
			from
				defaults.start
			until
				defaults.after
			loop
				is_item_removable := False
				if defaults.item.option.is_free_option then
					free_opt ?= defaults.item.option
					if free_opt.code = free_opt.override_cluster then
						is_item_removable := True
					end
				end
				if is_item_removable then
					defaults.remove
				else
					defaults.forth
				end
			end
			defaults.extend (new_special_option_sd ("override_cluster", name, False))
		end

	add_cluster (name, parent_name, path: STRING) is
			-- Add cluster named `name' with `parent_name' and `path'.
		require
			args_not_void: name /= Void and path /= Void
			args_not_empty: not name.is_empty and not path.is_empty
		local
			cluster_list: LACE_LIST [CLUSTER_SD]
			cl_names: LINKED_LIST [STRING]
			new_cluster: CLUSTER_SD
		do
			if parent_name = Void or else parent_name.is_empty then
				new_cluster := new_cluster_sd (new_id_sd (name, False), Void, new_id_sd (path, True), Void, False, False)
			else
				new_cluster := new_cluster_sd (new_id_sd (name, False), new_id_sd (parent_name, False), new_id_sd (path, True), Void, False, False)
			end
			cluster_list := root_ast.clusters
			if cluster_list = Void then
				create cluster_list.make (5)
				root_ast.set_clusters (cluster_list)
			end
			cl_names := cluster_names
			cl_names.compare_objects
			if not cl_names.has (new_id_sd (name, False)) then
				cluster_list.extend (new_cluster)
			end
		end	
		
	remove_cluster (name: STRING) is
			-- Remove cluster named `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
			done: BOOLEAN
		do
			done := False
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					done or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (name, False)) then
						l_clusters.remove
						done := True
					else
						l_clusters.forth
					end
				end
			end
		end

	add_assembly (path: STRING) is
			-- Add assembly in `path' to included assemblies.
		require
			path_not_void: path /= Void
			path_not_empty: not path.is_empty
		local
			l_ext: LACE_LIST [LANG_TRIB_SD]
			file_names: LACE_LIST [ID_SD]
			lt: LANG_TRIB_SD
			lang: LANGUAGE_NAME_SD
			l_ass: LINKED_LIST [STRING]
		do
			l_ass := assemblies
			l_ass.compare_objects
			if not l_ass.has (new_id_sd (path, True)) then
				l_ext := root_ast.externals
				if l_ext = Void then
					create l_ext.make (20)
					root_ast.set_externals (l_ext)
				end
				from
					l_ext.start
				until
					l_ext.after
				loop
					if l_ext.item.language_name.is_assembly then
						lt := l_ext.item
					end
					l_ext.forth
				end
				if lt = Void then
					lang := new_language_name_sd (new_id_sd ("assembly", True))
					create file_names.make (20)
					lt := new_lang_trib_sd (lang, file_names)
					l_ext.extend (lt)
				end
				lt.file_names.extend (new_id_sd (path, True))
			end
		end

	remove_assembly (path: STRING) is
			-- Remove assembly in `path' from included assemblies.
		require
			path_not_void: path /= Void
			path_not_empty: not path.is_empty
		local
			l_ext: LACE_LIST [LANG_TRIB_SD]
			file_names: LACE_LIST [ID_SD]
			path_sd: ID_SD
		do
			path_sd := new_id_sd (path, True)
			l_ext := root_ast.externals
			if l_ext /= Void then
				from
					l_ext.start
				until
					l_ext.after
				loop
					if l_ext.item.language_name.is_assembly then
						file_names := l_ext.item.file_names
						from
							file_names.start
						until
							file_names.after
						loop
							if file_names.item.is_equal (path_sd) then
								file_names.remove
							else
								file_names.forth
							end
						end
					end
					if file_names.is_empty then
						l_ext.remove
					else
						l_ext.forth
					end
				end
				if l_ext.is_empty then
					l_ext := Void
				end
			end
		end

	rename_cluster (old_name, new_name: STRING) is
			-- Rename cluster named `old_name' in `new_name'.
		require
			names_not_void: old_name /= Void and new_name /= Void
			names_not_empty: not old_name.is_empty and not new_name.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
			done: BOOLEAN
		do
			done := False
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					done or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (old_name, False)) then
						l_clusters.item.set_cluster_name (new_id_sd (new_name, False))
						done := True
					else
						l_clusters.forth
					end
				end
			end			
		end

	change_cluster_path (cluster_name, new_path: STRING) is
			-- Assign `new_path' to directory path of cluster `cluster_name'.
		require
			names_not_void: cluster_name /= Void and new_path /= Void
			names_not_empty: not cluster_name.is_empty and not new_path.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
			done: BOOLEAN
		do
			done := False
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					done or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (cluster_name, False)) then
						l_clusters.item.set_directory_name (new_id_sd (new_path, True))
						done := True
					else
						l_clusters.forth
					end
				end
			end			
		end

	set_is_recursive (cluster_name: STRING; flag: BOOLEAN) is
			-- Assign `flag' to `is_recursive' of cluster named `cluster_name'.
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
			done: BOOLEAN
		do
			done := False
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					done or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (cluster_name, False)) then
						l_clusters.item.set_is_recursive (flag)
						done := True
					end
					l_clusters.forth
				end
			end
		end

	set_is_library (cluster_name: STRING; flag: BOOLEAN) is
			-- Assign `flag' to `is_library' of cluster named `cluster_name'.
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
			done: BOOLEAN
		do
			done := False
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					done or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (cluster_name, False)) then
						l_clusters.item.set_is_library (flag)
						done := True
					end
					l_clusters.forth
				end
			end
		end

	set_system_defaults_used (cluster_name: STRING; b: BOOLEAN) is
			-- Set `system_defaults_used' to `b; for cluster named `cluster_name'.
		require
			name_not_void: cluster_name /= Void
			name_not_empty: not cluster_name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			defaults: LACE_LIST [D_OPTION_SD]
		do
			cl := cluster_sd_with_name (cluster_name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop = Void and not b then
					cl_prop := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, Void, Void)
					cl.set_cluster_properties (cl_prop)
				end
				if cl_prop /= Void then
					defaults := cl_prop.default_option
					if defaults = Void and not b then
						create defaults.make (10)
						cl_prop.set_default_option (defaults)
					elseif defaults /= Void and b then
						cl_prop.set_default_option (Void)
					end
				end
			end
		end

	set_assertions_for_cluster (
		name: STRING;
		evaluate_require, evaluate_ensure, evaluate_check, evaluate_loop, evaluate_invariant: BOOLEAN) is
			-- Change assertion settings for cluster named `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			new_defaults: LACE_LIST [D_OPTION_SD]
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
			had_assertion: BOOLEAN
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop ?= cl.cluster_properties
				if cl_prop = Void then
					cl_prop := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, Void, Void)
					cl.set_cluster_properties (cl_prop)
				end
				new_defaults := cl_prop.default_option
				if new_defaults /= Void then
					from
						new_defaults.start
					until
						new_defaults.after
					loop
						if new_defaults.item.option.is_assertion then
							new_defaults.remove
						else
							new_defaults.remove
						end
					end
				else
					create new_defaults.make (10)
					cl_prop.set_default_option (new_defaults)
				end

				had_assertion := False
				if evaluate_invariant then
					had_assertion := True
					v := new_invariant_sd (new_id_sd ("invariant", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)
				end			
				if evaluate_loop then
					had_assertion := True
					v := new_loop_sd (new_id_sd ("loop", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)	
				end
				if evaluate_check then
					had_assertion := True
					v := new_check_sd (new_id_sd ("check", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)	
				end
				if evaluate_ensure then
					had_assertion := True
					v := new_ensure_sd (new_id_sd ("ensure", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)	
				end
				if evaluate_require then
					had_assertion := True
					v := new_require_sd (new_id_sd ("require", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)	
				end	
				if not had_assertion then
					v := new_no_sd (new_id_sd ("no", False))
					ass := new_assertion_sd
					d_option := new_d_option_sd (ass, v)
					new_defaults.put_front (d_option)	
				end				
			end
		end
	
	add_exclude_to_cluster (name, path: STRING) is
			-- Add `path' to excluded list of cluster named `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [EXCLUDE_SD]
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop = Void then
					cl_prop := new_clust_prop_sd (Void, Void, Void, Void, Void, Void, Void, Void)
					cl.set_cluster_properties (cl_prop)
				end
				l_ex := cl_prop.exclude_option
				if l_ex = Void then
					create l_ex.make (10)
					cl_prop.set_exclude_option (l_ex)
				end
				l_ex.extend (new_exclude_sd (new_id_sd (path, True)))
			end
		end
	
	remove_exclude_from_cluster (name, path: STRING) is
			-- Remove `path' from excluded list of cluster named `name'.
		require
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			cl: CLUSTER_SD
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [EXCLUDE_SD]
		do
			cl := cluster_sd_with_name (name)
			if cl /= Void then
				cl_prop := cl.cluster_properties
				if cl_prop /= Void then
					l_ex := cl_prop.exclude_option
					if l_ex /= Void then
						from
							l_ex.start
						until
							l_ex.after
						loop
							if l_ex.item.file__name.is_equal (new_id_sd (path, True)) then
								l_ex.remove
							else
								l_ex.forth
							end
						end
						if l_ex.is_empty then
							l_ex := Void
						end
					end
				end
			end
		end
	
feature -- Status report

	is_valid: BOOLEAN is
			-- Does `root_ast' exist and represent a valid ace file?
		local
			tmp_ast: ACE_SD
		do
			Result := False
			if ace_file_name /= Void then
				tmp_ast := parsed_ast (ace_file_name)
				if tmp_ast /= Void then
					Result := True
				end
			end	
		end

	last_error_message: STRING
			-- Message describing possible errors in `make' and `apply'.

feature -- Saving

	apply is
			-- Store `root_ast' in ace file.
		local
			st: GENERATION_BUFFER
			ace_file, backup_file: PLAIN_TEXT_FILE
			ast: like root_ast			
		do
			ast := root_ast.duplicate
			create st.make (2048)
			ast.save (st)
			create ace_file.make (ace_file_name)
			if not ace_file.exists or else ace_file.is_writable then
					-- Save a backup_file
				create backup_file.make_open_write (ace_file_name + ".swp")
				ace_file.open_read
				ace_file.copy_to (backup_file)
				backup_file.close
				ace_file.close

				ace_file.open_write
				ace_file.put_string (st)
				ace_file.close
				successful_save := True
			else
					-- Could not save Ace file
				successful_save := False
				last_error_message := Warning_messages.W_not_creatable (ace_file_name)
			end

			if successful_save then
					-- We now check the validity of the syntax
				successful_save := is_valid
				if not successful_save then
						-- Restore backup_file.
					backup_file.open_read
					ace_file.open_write
					backup_file.copy_to (ace_file)
					backup_file.close
					ace_file.close

					last_error_message := Warning_messages.W_incorrect_ace_configuration
				end
				check
					backup_exists: backup_file.exists
				end
				backup_file.delete
			end	
		end

feature -- Constants

	il_generation_no: INTEGER is 0
			-- No IL code will be generated.

	il_generation_exe: INTEGER is 1
			-- An IL exe will be generated.
	
	il_generation_dll: INTEGER is 2
			-- An IL dll will be generated.

feature {NONE} -- Internal status

	successful_save: BOOLEAN
			-- Did we successfully write our changes to disk?

feature {NONE} -- Interface names

	default_ace_file_name: STRING is "Ace.ace"
			-- Default ace file name.
			
	Warning_messages: WARNING_MESSAGES is
			-- All warnings used in the interface
		once
			create Result
		end

feature {NONE} -- Generation of AST

	new_special_option_sd (type: STRING; a_name: STRING; flag: BOOLEAN): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a free
			-- option clause. If `a_name' Void then it is `free_option (flag)'.
		require
			type_not_void: type /= Void
		local
			argument_sd: FREE_OPTION_SD
			v: OPT_VAL_SD
		do
			argument_sd := new_free_option_sd (new_id_sd (type, False))
			if a_name /= Void then
				v := new_name_sd (new_id_sd (a_name, True))
			else
				if flag then
					v := new_yes_sd (new_id_sd ("yes", False))
				else
					v := new_no_sd (new_id_sd ("no", False))
				end
			end
			Result := new_d_option_sd (argument_sd, v)
		end

feature {NONE} -- Implementation

	parsed_ast (a_file_name: STRING): ACE_SD is
			-- Parse Ace file and return a new AST.
		do
			Parser.reset_comment_list
			Parser.parse_file (a_file_name, False)
			Result ?= Parser.ast
			if Result /= Void then
				Result.set_comment_list (Parser.comment_list)
			end
		end

	cluster_sd_with_name (name: STRING): CLUSTER_SD is
			-- Cluster named `name' in current system.
			-- Void if no match.
		require
			valid_ast: is_valid
			name_not_void: name /= Void
			name_not_empty: not name.is_empty
		local
			l_clusters: LACE_LIST [CLUSTER_SD]
		do
			l_clusters := root_ast.clusters
			if l_clusters /= Void then
				from
					l_clusters.start
				until
					Result /= Void or else l_clusters.after
				loop
					if l_clusters.item.cluster_name.is_equal (new_id_sd (name, False)) then
						Result := l_clusters.item
					end
					l_clusters.forth
				end
			end
		end

invariant
	valid_ast: is_valid
	
end -- class ACE_FILE_ACCESSER

