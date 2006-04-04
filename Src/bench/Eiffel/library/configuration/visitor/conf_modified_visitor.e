indexing
	description: "Get the classes that have been modified."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_MODIFIED_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		export
			{NONE} process_system
		redefine
			make,
			process_assembly,
			process_library,
			process_precompile,
			process_cluster,
			process_override,
			process_group
		end

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_platform, a_build: INTEGER) is
			-- Create.
		do
			Precursor (a_platform, a_build)
			create modified_classes.make (0)
			create process_group_observer.make (1)
			create processed_libraries.make (100)
			create processed_assemblies.make (100)
		end


feature -- Visit nodes

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Process `an_assembly'.
		local
			l_deps: LINKED_SET [CONF_ASSEMBLY]
		do
			if not is_error and then not processed_assemblies.has (an_assembly.guid) then
				processed_assemblies.force (an_assembly.guid)
				an_assembly.check_changed
				find_modified (an_assembly.classes)
				l_deps := an_assembly.dependencies
				if l_deps /= Void then
					from
						l_deps.start
					until
						l_deps.after
					loop
						l_deps.item.process (Current)
						l_deps.forth
					end
				end
			end
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Process `a_library'.
		do
			if not is_error and then not processed_libraries.has (a_library.uuid) then
				processed_libraries.force (a_library.uuid)
				a_library.library_target.process (Current)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Process `a_precompile'.
		do
			if not is_error then
				process_library (a_precompile)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Process `a_cluster'.
		do
			if not is_error then
				find_modified (a_cluster.classes)
			end
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Process `an_override'.
		do
			if not is_error then
				process_cluster (an_override)
			end
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		do
			on_process_group (a_group)
		end

feature -- Access

	modified_classes: ARRAYED_LIST [CONF_CLASS]
			-- The list of modified classes.

feature -- Update

	resest_modified_classes is
			-- Reset `modified_classes'.
		do
			create modified_classes.make (0)
		end

feature -- Observer

	process_group_observer: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CONF_GROUP]]]
			-- Observer if a group is processed.

feature -- Events

	on_process_group (a_group: CONF_GROUP) is
			-- `A_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
			from
				process_group_observer.start
			until
				process_group_observer.after
			loop
				process_group_observer.item.call ([a_group])
				process_group_observer.forth
			end
		end

feature {NONE} -- Implementation

	processed_libraries: SEARCH_TABLE [UUID]
			-- Libraries that have been processed.

	processed_assemblies: SEARCH_TABLE [STRING]
			-- Assemblies that have been processed.

	find_modified (a_classes: HASH_TABLE [CONF_CLASS, STRING]) is
			-- Find classes that have been modified and add them to `modified_classes'.
		local
			l_class: CONF_CLASS
		do
			if a_classes /= Void then
				from
					a_classes.start
				until
					a_classes.after
				loop
					l_class := a_classes.item_for_iteration
					if l_class.is_compiled then
							-- check for changes and update name if necessary
						l_class.check_changed
						if l_class.is_error then
							add_error (l_class.last_error)
						end
						if l_class.is_modified then
							modified_classes.extend (l_class)
						end
					end
					a_classes.forth
				end
			end
		end


invariant
	modifed_classes_not_void: modified_classes /= Void
	process_group_observer_not_void: process_group_observer /= Void

end
