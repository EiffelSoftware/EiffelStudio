indexing
	description: "Iterates through a configuration."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ITERATOR

inherit
	CONF_VISITOR

feature -- Visit nodes

	process_system (a_system: CONF_SYSTEM) is
			-- Visit `a_system'.
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
			from
				l_targets := a_system.targets
				l_targets.start
			until
				l_targets.after
			loop
				l_targets.item_for_iteration.process (Current)
				l_targets.forth
			end
		end

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		do
			if a_target.precompile /= Void then
				a_target.precompile.process (Current)
			end
			a_target.libraries.linear_representation.do_all (agent {CONF_LIBRARY}.process (Current))
			a_target.assemblies.linear_representation.do_all (agent {CONF_ASSEMBLY}.process (Current))
			a_target.clusters.linear_representation.do_all (agent {CONF_CLUSTER}.process (Current))
				-- overrides must be processed at the end
			a_target.overrides.linear_representation.do_all (agent {CONF_OVERRIDE}.process (Current))
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		do
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		do
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
		end


end
