indexing
	description: "Get a list of all classes."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ALL_CLASSES_VISITOR

inherit
	CONF_ITERATOR
		redefine
			process_cluster,
			process_override,
			process_assembly,
			process_library,
			process_precompile
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create classes.make (1000)
			create targets_done.make (5)
			create assemblies_done.make (5)
		end

feature -- Access

	classes: ARRAYED_LIST [CONF_CLASS]
			-- All classes in the target.

feature -- Visit nodes

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
			if a_library.library_target /= Void then
				retrieve_recursively (a_library.library_target)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			if a_precompile.library_target /= Void then

				retrieve_recursively (a_precompile.library_target)
			end
		end

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		do
			if an_assembly.guid /= Void and then not assemblies_done.has (an_assembly.guid) then
				assemblies_done.force (an_assembly.guid)
				retrieve_from_group (an_assembly)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
			retrieve_from_group (a_cluster)
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
			retrieve_from_group (an_override)
		end

feature {CONF_ALL_CLASSES_VISITOR}

	set_targets_done (a_targets: like targets_done) is
			-- Set `targets_done' to `a_targets'.
		require
			a_targets_not_void: a_targets /= Void
		do
			targets_done := a_targets
		ensure
			targets_done_set: targets_done = a_targets
		end

	set_assemblies_done (an_assemblies: like assemblies_done) is
			-- Set `assemblies_done' to `a_assemblies'.
		require
			an_assemblies_done_not_void: an_assemblies /= Void
		do
			assemblies_done := an_assemblies
		ensure
			assemblies_done_set: assemblies_done = an_assemblies
		end

feature {NONE} -- Implementation

	targets_done: SEARCH_TABLE [UUID]
			-- Lookup for libraries we already handled.

	assemblies_done: SEARCH_TABLE [STRING]
			-- Lookup for assemblies we already handled.

	retrieve_recursively (a_target: CONF_TARGET) is
			-- Retrieve classes recursively from `a_target'.
		require
			a_target_not_void: a_target /= Void
		local
			l_vis: like Current
			l_uuid: UUID
		do
			l_uuid := a_target.system.uuid
			if not targets_done.has (l_uuid) then
				targets_done.force (l_uuid)
				create l_vis.make
				l_vis.set_targets_done (targets_done)
				l_vis.set_assemblies_done (assemblies_done)
				a_target.process (l_vis)
				classes.append (l_vis.classes)
			end
		end

	retrieve_from_group (a_group: CONF_GROUP) is
			-- Retrieve classes from `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			if a_group.classes_set then
				classes.append (a_group.classes.linear_representation)
			end
		end

invariant
	classes_not_void: classes /= Void
	targets_done_not_void: targets_done /= Void
	assemblies_done_not_void: assemblies_done /= Void

end
