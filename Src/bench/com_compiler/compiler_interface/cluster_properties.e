indexing
	description: "Information on a cluster in Ace file"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_PROPERTIES

inherit
	IEIFFEL_CLUSTER_PROPERTIES_IMPL_STUB
		redefine
			name,
			cluster_path,
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
			set_name,
			set_cluster_path,
			set_override,
			set_is_library,
			set_all,
			set_use_system_default,
			set_evaluate_require_by_default,
			set_evaluate_ensure_by_default,
			set_evaluate_check_by_default,
			set_evaluate_loop_by_default,
			set_evaluate_invariant_by_default,
			add_exclude,
			remove_exclude
		end
	
create
	make
	
feature {NONE} -- Initialization

	make (a_name: STRING; acm: ACE_FILE_MODIFIER) is
			-- Initialize structure.
		require
			name_not_void: a_name /= Void
			name_not_empty: not a_name.is_empty
			acm_not_void: acm /= Void
			acm_valid: acm.is_valid
		do
			ace := acm
			create internal_name.make_from_string (a_name)
		end

feature -- Access

	name: STRING is
			-- Cluster name.
		do
			Result := internal_name
		end

	cluster_path: STRING is
			-- Full path to cluster.
		do
			if ace.is_valid then
				Result := ace.cluster_path (internal_name)
			end
		end
		
	override: BOOLEAN is
			-- Should this cluster classes take priority over other classes with same name.
		do
			if ace.is_valid then
				if ace.override_cluster /= Void then
					Result := internal_name.is_equal (ace.override_cluster)
				end
			end
		end

	is_library: BOOLEAN is
			-- Should this cluster be treated as library?
		do
			if ace.is_valid then
				Result := ace.is_library (internal_name)
			end
		end

	all1: BOOLEAN is
			-- Should all subclusters be included?
		do
			if ace.is_valid then
				Result := ace.is_recursive (internal_name)
			end
		end

	use_system_default: BOOLEAN is
			-- Should use system default?
		do
			if ace.is_valid then
				Result := ace.system_defaults_used (internal_name)
			end
		end
		
	evaluate_require_by_default: BOOLEAN is
			-- Should preconditions be evaluated by default?
		do
			if ace.is_valid then
				Result := ace.require_evaluated_in_cluster (internal_name)
			end
		end

	evaluate_ensure_by_default: BOOLEAN is
			-- Should postconditions be evaluated by default?
		do
			if ace.is_valid then
				Result := ace.ensure_evaluated_in_cluster (internal_name)
			end
		end

	evaluate_check_by_default: BOOLEAN is
			-- Should check assertions be evaluated by default?
		do
			if ace.is_valid then
				Result := ace.check_evaluated_in_cluster (internal_name)
			end
		end

	evaluate_loop_by_default: BOOLEAN is
			-- Should loop assertions be evaluated by default?
		do
			if ace.is_valid then
				Result := ace.loop_evaluated_in_cluster (internal_name)
			end
		end

	evaluate_invariant_by_default: BOOLEAN is
			-- Should class invariants be evaluated by default?
		do
			if ace.is_valid then
				Result := ace.invariant_evaluated_in_cluster (internal_name)
			end
		end

	excluded: ECOM_ARRAY [STRING] is
			-- List of excluded directories.
			-- Void if none.
		local
			res: ARRAY [STRING]
			ace_res: LINKED_LIST [STRING]
			i: INTEGER
		do
			if ace.is_valid then
				ace_res := ace.excluded_in_cluster (internal_name)
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

feature -- Element change

	set_name (return_value: STRING) is
			-- Cluster name.
		do
			if ace.is_valid then
				if return_value /= Void and then not return_value.is_empty then
					ace.rename_cluster (internal_name, return_value)
					internal_name := return_value
				end
			end
		end

	set_cluster_path (path: STRING) is
			-- Full path to cluster.
		do
			if ace.is_valid then
				if path /= Void and then not path.is_empty then
					ace.change_cluster_path (internal_name, path)
				end
			end
		end

	set_override (return_value: BOOLEAN) is
			-- Should this cluster classes take priority over other classes with same name.
		do
			if ace.is_valid then
				if return_value then
					ace.set_override_cluster (internal_name)
				end
			end
		end

	set_is_library (return_value: BOOLEAN) is
			-- Should this cluster be treated as library?
		do
			if ace.is_valid then
				ace.set_is_library (internal_name, return_value)
			end
		end

	set_all (return_value: BOOLEAN) is
			-- Should all subclusters be included?
		do
			if ace.is_valid then
				ace.set_is_recursive (internal_name, return_value)
			end
		end

	set_use_system_default (return_value: BOOLEAN) is
			-- Should use system default?
		do
			if ace.is_valid then
				ace.set_system_defaults_used (internal_name, return_value)
			end
		end
		
	set_evaluate_require_by_default (return_value: BOOLEAN) is
			-- Should preconditions be evaluated by default?
		do
			if ace.is_valid then
				ace.set_assertions_for_cluster (
					internal_name,
					return_value,
					evaluate_ensure_by_default,
					evaluate_check_by_default,
					evaluate_loop_by_default,
					evaluate_invariant_by_default
				)
			end
		end

	set_evaluate_ensure_by_default (return_value: BOOLEAN) is
			-- Should postconditions be evaluated by default?
		do
			if ace.is_valid then
				ace.set_assertions_for_cluster (
					internal_name,
					evaluate_require_by_default,
					return_value,
					evaluate_check_by_default,
					evaluate_loop_by_default,
					evaluate_invariant_by_default
				)
			end
		end

	set_evaluate_check_by_default (return_value: BOOLEAN) is
			-- Should check assertions be evaluated by default?
		do
			if ace.is_valid then
				ace.set_assertions_for_cluster (
					internal_name,
					evaluate_require_by_default,
					evaluate_ensure_by_default,
					return_value,
					evaluate_loop_by_default,
					evaluate_invariant_by_default
				)
			end
		end

	set_evaluate_loop_by_default (return_value: BOOLEAN) is
			-- Should loop assertions be evaluated by default?
		do
			if ace.is_valid then
				ace.set_assertions_for_cluster (
					internal_name,
					evaluate_require_by_default,
					evaluate_ensure_by_default,
					evaluate_check_by_default,
					return_value,
					evaluate_invariant_by_default
				)
			end
		end

	set_evaluate_invariant_by_default (return_value: BOOLEAN) is
			-- Should class invariants be evaluated by default?
		do
			if ace.is_valid then
				ace.set_assertions_for_cluster (
					internal_name,
					evaluate_require_by_default,
					evaluate_ensure_by_default,
					evaluate_check_by_default,
					evaluate_loop_by_default,
					return_value
				)
			end
		end		

	add_exclude (dir_name: STRING) is
			-- Add a directory to exclude.
		do
			if ace.is_valid then
				if dir_name /= Void and then not dir_name.is_empty then
					ace.add_exclude_to_cluster (internal_name, dir_name)
				end
			end
		end

	remove_exclude (dir_name: STRING) is
			-- Remove a directory to exclude.
		do
			if ace.is_valid and then not dir_name.is_empty then
				ace.remove_exclude_from_cluster (internal_name, dir_name)
			end
		end
		
feature {NONE} -- Implementation

	ace: ACE_FILE_MODIFIER
			-- Access to the ace file.
			
	internal_name: STRING
			-- Name `Current' was created with.

end -- class CLUSTER_PROPERTIES
