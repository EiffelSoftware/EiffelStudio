indexing
	description: "Information on a cluster in Ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_PROPERTIES

inherit
	LACE_AST_FACTORY
		export
			{NONE} all
		end

	IEIFFEL_CLUSTER_PROPERTIES_IMPL_STUB
		redefine
			name,
			cluster_namespace,
			cluster_path,
			parent_name,
			override,
			is_library,
			all1,
			use_system_default,
			evaluate_require_by_default,
			evaluate_ensure_by_default,
			evaluate_check_by_default,
			evaluate_loop_by_default,
			evaluate_invariant_by_default,
			excluded,
			expanded_cluster_path,
			has_parent,
			is_eiffel_library,
			subclusters,
			has_children,
			set_cluster_namespace,
			set_cluster_namespace_user_precondition,
			set_cluster_path,
			set_cluster_path_user_precondition,
			set_override,
			set_is_library,
			set_all,
			set_use_system_default,
			set_assertions,
			set_parent_name,
			set_parent_name_user_precondition,
			add_exclude,
			add_exclude_user_precondition,
			remove_exclude,
			remove_exclude_user_precondition,
			cluster_id
		end		
create
	make_new,
	make_with_cluster_sd_and_ace_accesser
	
feature {NONE} -- Initialization

	make_new (a_name: STRING) is
			-- Make new cluster.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		local
			id_sd: ID_SD
		do
			id_sd := new_id_sd (a_name, False)
			create cluster_sd.initialize (id_sd, Void, Void, Void, False, False)
			create ace_dictionary
		ensure
			non_void_cluster_sd: cluster_sd /= Void
		end
		
	make_with_cluster_sd_and_ace_accesser (a_cluster: CLUSTER_SD; an_ace: ACE_FILE_ACCESSER) is
			-- Make with CLUSTER_SD and ACE_FILE_ACCESSER.
		require
			non_void_cluster: a_cluster /= Void
		do
			cluster_sd := a_cluster
			ace := an_ace
			create ace_dictionary
		ensure
			non_void_cluster_sd: cluster_sd /= Void
		end

feature -- Access

	cluster_sd: CLUSTER_SD
			-- Abstract representation of cluster in AST fo Lace.

	name: STRING is
			-- Cluster name.
		do
			Result := cluster_sd.cluster_name
			if Result = Void then
				Result := ""
			end
		end

	cluster_namespace: STRING is 
			-- namespace of the cluster
		local
			cl_prop: CLUST_PROP_SD
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			cl_prop ?= cluster_sd.cluster_properties
			if cl_prop /= Void then
				defaults ?= cl_prop.default_option
				if defaults /= Void then
					from
						defaults.start
					until
						defaults.after
					loop
						if defaults.item.option.is_free_option then
							free_opt ?= defaults.item.option
							if free_opt.code = free_opt.Namespace then
								Result := defaults.item.value.value
							end
						end
						defaults.forth
					end
				end				
			end
			if Result = Void then
				Result := ""
			end
		ensure
			non_void_result: Result /= Void
		end

	cluster_path: STRING is
			-- Full path to cluster.
		do
			Result := cluster_sd.directory_name
			if Result = Void then
				Result := ""
			end
		end

	parent_name: STRING is
			-- Name of parent cluster.
		do
			Result := cluster_sd.parent_name
			if Result = Void then
				Result := ""
			end
		end
		
	override: BOOLEAN is
			-- Should this cluster classes take priority over other classes with same name.
		do
			if ace.is_valid then
				if ace.override_cluster /= Void then
					Result := name.is_equal (ace.override_cluster)
				end
			end
		end

	is_library: BOOLEAN is
			-- Should this cluster be treated as library?
		do
			Result := cluster_sd.is_library
		end

	all1: BOOLEAN is
			-- Should all subclusters be included?
		do
			Result := cluster_sd.is_recursive and (not cluster_sd.is_library)
		end

	use_system_default: BOOLEAN is
			-- Should use system default?
		local
			cl_prop: CLUST_PROP_SD
		do
			Result := True
			cl_prop := cluster_sd.cluster_properties
			if cl_prop /= Void then
				if cl_prop.default_option /= Void then
					Result := cl_prop.default_option.count > 0
				end
			end
		end
		
	evaluate_require_by_default: BOOLEAN is
			-- Should preconditions be evaluated by default?
		local
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
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
				end
			end
		end

	evaluate_ensure_by_default: BOOLEAN is
			-- Should postconditions be evaluated by default?
		local
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
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
				end
			end
		end

	evaluate_check_by_default: BOOLEAN is
			-- Should check assertions be evaluated by default?
		local
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
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
				end
			end
		end

	evaluate_loop_by_default: BOOLEAN is
			-- Should loop assertions be evaluated by default?
		local
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
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
				end
			end
		end

	evaluate_invariant_by_default: BOOLEAN is
			-- Should class invariants be evaluated by default?
		local
			cl_prop: CLUST_PROP_SD
			cl_defaults: LACE_LIST [D_OPTION_SD]
			opt: OPTION_SD
			val: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
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
				end
			end
		end

	excluded: CLUSTER_EXCLUDES_ENUMERATOR is
			-- List of excluded directories.
			-- Void if none.
		local
			res: ARRAYED_LIST [STRING]
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [FILE_NAME_SD]
		do
			cl_prop := cluster_sd.cluster_properties
			create res.make (0)
			if cl_prop /= Void then
				l_ex := cl_prop.exclude_option
				if l_ex /= Void then
					from
						l_ex.start
					until
						l_ex.after
					loop
						res.extend (l_ex.item.file__name)
						l_ex.forth
					end
				end
			end
			create Result.make (res)				
		end
		
	expanded_cluster_path: STRING is
			-- return the full cluster path
		local
			var: STRING
			formatted_var: STRING
			dollar_pos: INTEGER
			slash_pos: INTEGER
			parth_pos: INTEGER
			next_dollar_pos: INTEGER
			env_var: STRING
			env: EXECUTION_ENVIRONMENT
		do
			create env
			Result := cluster_path.clone(cluster_path)
			Result.replace_substring_all ("/", "\")
			
			dollar_pos := Result.index_of ('$', 1)
			if dollar_pos > 0 then
				from 
				until
					dollar_pos = 0
				loop
					-- look for '\'
					slash_pos := Result.index_of ('\', dollar_pos + 1)
					
					-- now look for ) and return the first
					-- allows for $(ENV)Ext\...
					parth_pos := Result.index_of (')', dollar_pos + 1)
					
					-- look or $ as path could be $var1$var2
					next_dollar_pos := Result.index_of ('$', dollar_pos + 1)

					if slash_pos > 0 then
						if parth_pos > 0 then
							slash_pos := slash_pos.min (parth_pos + 1)
						end
						if next_dollar_pos > 0 then
							slash_pos := slash_pos.min (next_dollar_pos)
						end
					elseif parth_pos > 0 then
						if next_dollar_pos > 0 then
							slash_pos := slash_pos.min (next_dollar_pos)
						else
							slash_pos := parth_pos + 1
						end
					else
						if next_dollar_pos > 0 then
							slash_pos := next_dollar_pos
						else
							slash_pos := Result.count + 1
						end
					end
					
					var := Result.substring (dollar_pos, slash_pos - 1)
					
					-- remove the () and $
					formatted_var := var.clone(var);
					formatted_var.prune_all('(')
					formatted_var.prune_all(')')
					formatted_var.prune_all_leading('$')
					
					env_var := env.get (formatted_var)
					if env_var /= Void and then env_var.count > 0 then
						Result.replace_substring_all (var, env_var)
					end
					if dollar_pos + 1 <= Result.count then
						dollar_pos := Result.index_of ('$', dollar_pos + 1)
					else
						dollar_pos := 0
					end
				end
			end
		end
		

	subclusters: CLUSTER_PROP_ENUMERATOR is
			-- List of subclusters (list of IEiffelClusterProperties*).
		do
			if subclusters_impl = Void then
				create subclusters_impl.make (0)
			end
			create Result.make (subclusters_impl)
		end

	cluster_id: INTEGER is
			-- Cluster identifier.
		require
			id_set: is_id_defined
		do
			Result := id
		ensure
			valid_id: Result > 0
		end	
		
	is_eiffel_library: BOOLEAN is
			-- Is the cluster part of the Eiffel library
		local
			library: STRING
			path: STRING
		do
			if ace.is_valid then
				library := ace.library_path
				if library /= Void then
					path := cluster_path.clone(cluster_path)
					path.replace_substring_all (ace.ise_eiffel_envvar, ace.ise_eiffel)
					path.replace_substring_all ("/", "\")
					Result := (path.substring_index (library, 1) = 1)
				else
					library := ace.library_dotnet_path
					if library /= Void then
						path := cluster_path.clone(cluster_path)
						path.replace_substring_all (ace.ise_eiffel_envvar, ace.ise_eiffel)
						path.replace_substring_all ("/", "\")
						Result := (path.substring_index (library, 1) = 1)
					end
				end
			else
				Result := false
			end
		end
		

feature -- Status

	has_parent: BOOLEAN is
			-- Does Current have parent cluster?
		do
			Result := cluster_sd.has_parent			
		ensure
			has_parent: Result implies parent_name /= Void
			not_has_parent: not Result implies parent_name = Void
		end

	has_children: BOOLEAN is
			-- Does Current have children?
		do
			Result := subclusters_impl /= Void and then
						not subclusters_impl.is_empty
		end

	has_child (a_name: STRING): BOOLEAN is
			-- Does Current have child with `a_name'?
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			if has_children then
				from
					subclusters_impl.start
				until
					Result or subclusters_impl.after
				loop
					Result := subclusters_impl.item.name.is_equal (a_name)
					subclusters_impl.forth
				end
			end
		end
	
	is_id_defined: BOOLEAN
			-- Is ID defined?
			
feature -- Element change

	set_cluster_namespace (a_namespace: STRING) is
			-- Set 'cluster_namespace' with 'a_namespace'
		require else
			non_void_namespace: a_namespace /= Void
		local
			cl_prop: CLUST_PROP_SD
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
			v: OPT_VAL_SD
		do
			cl_prop ?= cluster_sd.cluster_properties

			if cl_prop = Void then
				create cl_prop
				cluster_sd.set_cluster_properties (cl_prop)
			end
			
			defaults ?= cl_prop.default_option
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.Namespace then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			else
				create defaults.make (0)
				cluster_sd.cluster_properties.set_default_option (defaults)
			end

			-- only add namespace if it not empty.
			-- if namespace exists then it is removed
			if not a_namespace.is_empty then
				create free_opt.make (feature {FREE_OPTION_SD}.Namespace)
				create v.make (new_id_sd (a_namespace, True))
				defaults.extend (create {D_OPTION_SD}.initialize (free_opt, v))
			end
		end
		

	set_cluster_path (a_path: STRING) is
			-- set 'cluster_path' to 'a_path'
		require else
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			id_sd: ID_SD
			l_ise_path: STRING
			l_cluster_path: STRING
			l_new_path: STRING
		do
			l_new_path := a_path.clone (a_path)
			l_new_path.replace_substring_all ("/", "\")
			l_new_path.to_lower
			l_ise_path := ace.ise_eiffel.clone (ace.ise_eiffel)
			l_ise_path.to_lower
			if l_new_path.substring_index (l_ise_path, 1) = 1 then
				l_cluster_path := a_path.substring (l_ise_path.count + 1, a_path.count)
				l_cluster_path.prepend (ace.ise_eiffel_envvar)
			else
				l_cluster_path := a_path.clone (a_path)
			end
			l_cluster_path.prune_all_trailing ('\')
			id_sd := new_id_sd (l_cluster_path, True)
			cluster_sd.set_directory_name (id_sd)
		end

	set_override (return_value: BOOLEAN) is
			-- Should this cluster classes take priority over other classes with same name.
		do
			if ace.is_valid then
				if return_value then
					ace.set_override_cluster (name)
				end
			end
		end

	set_is_library (flag: BOOLEAN) is
			-- Should this cluster be treated as library?
		do
			cluster_sd.set_is_library (flag)
			if flag then
				cluster_sd.set_is_recursive (false)
			end
		end

	set_all (flag: BOOLEAN) is
			-- Should all subclusters be included?
		do
			cluster_sd.set_is_recursive (flag)
			if flag then
				cluster_sd.set_is_library (false)
			end
		end

	set_use_system_default (flag: BOOLEAN) is
			-- Should use system default?
		local
			cl_prop: CLUST_PROP_SD
			defaults: LACE_LIST [D_OPTION_SD]
		do
			cl_prop := cluster_sd.cluster_properties
			if cl_prop = Void and not flag then
				create cl_prop
				cluster_sd.set_cluster_properties (cl_prop)
			end
			if cl_prop /= Void then
				defaults := cl_prop.default_option
				if defaults = Void and not flag then
					create defaults.make (10)
					cl_prop.set_default_option (defaults)
				elseif defaults /= Void and flag then
					cl_prop.set_default_option (Void)
				end
			end
		end
		
	set_assertions (evaluate_check: BOOLEAN; 
					evaluate_require: BOOLEAN; 
					evaluate_ensure: BOOLEAN; 
					evaluate_loop: BOOLEAN; 
					evaluate_invariant: BOOLEAN) is
			-- Set assertions for cluster.
			-- `evaluate_check' [in].  
			-- `evaluate_require' [in].  
			-- `evaluate_ensure' [in].  
			-- `evaluate_loop' [in].  
			-- `evaluate_invariant' [in].  
		local
			cl_prop: CLUST_PROP_SD
			new_defaults: LACE_LIST [D_OPTION_SD]
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
		do
			cl_prop := cluster_sd.cluster_properties
			if cl_prop = Void then
				create cl_prop
				cluster_sd.set_cluster_properties (cl_prop)
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
						new_defaults.forth
					end
				end
			else
				create new_defaults.make (10)
				cl_prop.set_default_option (new_defaults)
			end

			if evaluate_invariant then
				create v.make_invariant
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)
			end			
			if evaluate_loop then
				create v.make_loop
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)	
			end
			if evaluate_ensure then
				create v.make_ensure
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)	
			end
			if evaluate_require then
				create v.make_require
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)	
			end	
			if evaluate_check then
				create v.make_check
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)	
			end
			
			-- need to place assertion(no) at the beginning to reset all assertion levels for clusters
			if evaluate_require or evaluate_ensure or evaluate_check or evaluate_loop or evaluate_invariant then
				create v.make_no
				create ass
				create d_option.initialize (ass, v)
				new_defaults.put_front (d_option)
				set_use_system_default (False)
			else
				set_use_system_default (True)
			end	
		end

	set_parent_name (a_parent_name: STRING) is
			-- set 'parent_name' with 'a_parent_name'
		require
			non_void_parent_name: a_parent_name /= Void
			valid_parent_name: valid_parent_name (a_parent_name)
		do
			cluster_sd.set_parent_name (create {ID_SD}.initialize (a_parent_name))
		ensure
			parent_name_set: parent_name.is_equal (a_parent_name)
		end
		
	add_exclude (a_file_name: STRING) is
			-- Add 'a_file_name' to list of cluster excludes.
		require else
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [FILE_NAME_SD]
		do
			cl_prop := cluster_sd.cluster_properties
			if cl_prop = Void then
				create cl_prop
				cluster_sd.set_cluster_properties (cl_prop)
			end
			l_ex := cl_prop.exclude_option
			if l_ex = Void then
				create l_ex.make (10)
				cl_prop.set_exclude_option (l_ex)
			end
			l_ex.extend (create {FILE_NAME_SD}.initialize (new_id_sd (a_file_name, True)))
		end

	remove_exclude (a_file_name: STRING) is
			-- Remove 'a_file_name' from list of cluster excludes.
		require else
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.is_empty
		local
			cl_prop: CLUST_PROP_SD
			l_ex: LACE_LIST [FILE_NAME_SD]
		do
			cl_prop := cluster_sd.cluster_properties
			if cl_prop /= Void then
				l_ex := cl_prop.exclude_option
				if l_ex /= Void then
					from
						l_ex.start
					until
						l_ex.after
					loop
						if l_ex.item.file__name.is_equal (new_id_sd (a_file_name, True)) then
							l_ex.remove
						else
							l_ex.forth
						end
					end
					if l_ex.is_empty then
						cl_prop.set_exclude_option (Void)
					end
				end
			end
		end
	
feature -- Validation

	valid_parent_name (a_parent_name: STRING): BOOLEAN is
			-- is 'a_parent_name' a valid parent name
		local
			l_parent_name: STRING
			l_cluster_name: STRING
		do
			if a_parent_name /= Void and not a_parent_name.is_empty then
				l_parent_name := a_parent_name.clone (a_parent_name)
				l_parent_name.to_lower
				l_cluster_name := name.clone (name)
				l_cluster_name.to_lower
				Result := not l_cluster_name.is_equal (l_parent_name)
			end
		end
		
	
feature -- User Preconditions

	set_cluster_namespace_user_precondition (a_namespace: STRING): BOOLEAN is
			-- 'set_cluster_namespace ' precondition
		do
			Result := False
		end
		
	set_cluster_path_user_precondition (path: STRING): BOOLEAN is
			-- 'set_cluster_path ' precondition
		do
			Result := False
		end
		
	set_parent_name_user_precondition (return_value: STRING): BOOLEAN is
			-- 'set_parent_name ' precondition
		do
			Result := False
		end
		
	add_exclude_user_precondition (dir_name: STRING): BOOLEAN is
			-- 'add_exclude ' precondition
		do
			Result := False
		end
		
	remove_exclude_user_precondition (dir_name: STRING): BOOLEAN is
			-- 'remove_exclude ' precondition
		do
			Result := False
		end


feature {SYSTEM_CLUSTERS} -- Element Changes

	set_id (new_id: like id) is
			-- Set `id' with `new_id'.
		require
			id_not_set: not is_id_defined
			valid_id: new_id > 0
		do
			id := new_id
			is_id_defined := True
		ensure
			id_set: is_id_defined
			valid_id: id = new_id
		end
		
	set_name (a_name: STRING) is
			-- Cluster name.
		require
			non_void_name: a_name /= Void
			valid_empty_name: not a_name.is_empty
		local
			id_sd: ID_SD
			is_override_cluster: BOOLEAN
		do
			is_override_cluster := override
			id_sd := new_id_sd (a_name, False)
			cluster_sd.set_cluster_name (id_sd)
				
			-- change all of the sub clusters parent name to the current name
			if subclusters_impl /= Void then
				from
					subclusters_impl.start
				until
					subclusters_impl.after
				loop
					subclusters_impl.item.set_parent_name (a_name)
					subclusters_impl.forth
				end
			end
			
			if is_override_cluster then
				set_override (True)	
			end
		end
		
	add_child (a_child:like Current) is
			-- Add child to `Current'.
		require
			non_void_child: a_child /= Void
			not_has: not has_child (a_child.name)
		do
			if subclusters_impl = Void then
				create subclusters_impl.make (5)
			end
			subclusters_impl.extend (a_child)
		ensure
			non_void_subclusters: subclusters_impl /= Void
			added: old subclusters_impl /= Void implies
						subclusters_impl.count = old subclusters_impl.count + 1
			has_child: has_child (a_child.name)
		end
			
	remove_child (a_name: STRING) is
			-- Remove child with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			has_child: has_child (a_name)
		local
			removed: BOOLEAN
		do
			from
				subclusters_impl.start
			until
				removed or else subclusters_impl.after
			loop
				if subclusters_impl.item.name.is_equal (a_name) then
					subclusters_impl.remove
					removed := True
				else
					subclusters_impl.forth
				end
			end
		ensure
			not_has: not has_child (a_name)
		end

feature -- Externals

	ccom_release (cpp_obj: POINTER) is
			-- Last error code
		external
			"C++ [ecom_eiffel_compiler::IEiffelClusterProperties_impl_stub %"ecom_eiffel_compiler_IEiffelClusterProperties_impl_stub_s.h%"]"
		alias
			"Release"
		end
		
feature {NONE} -- Implementation

	ace: ACE_FILE_ACCESSER
			-- Access to the ace file.
			
	ace_dictionary: ACE_FILE_DICTIONARY
			-- Keyword of the ace file
			
	subclusters_impl: ARRAYED_LIST [like Current]
			-- Subclusters.

	valid_name: BOOLEAN is
		do
			Result := cluster_sd /= Void and then
						name /= Void and then 
						not name.is_empty
		end
	
	id: INTEGER 
			-- ID in cluster tree.
invariant
	has_cluster_sd: cluster_sd /= Void
	valid_name: valid_name
	valid_id: is_id_defined implies id > 0
	
end -- class CLUSTER_PROPERTIES
