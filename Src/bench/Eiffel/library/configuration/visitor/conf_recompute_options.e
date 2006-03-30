indexing
	description: "Recompute options."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_RECOMPUTE_OPTIONS

inherit
	CONF_ITERATOR
		export
			{NONE} process_system
		redefine
			process_target,
			process_group
		end

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_new_target: CONF_TARGET) is
			-- Create from `a_new_target'.
		require
			a_new_target_not_void: a_new_target /= Void
		do
			new_target := a_new_target
		end

feature -- Update

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target'.
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		require else
			new_target_group_equivalent: new_target.is_group_equivalent (a_target)
		local
			l_pre, l_old_pre: CONF_PRECOMPILE
		do
			if not is_error then
				a_target.set_version (new_target.internal_version)
				a_target.set_settings (new_target.internal_settings)
				if new_target.internal_options /= Void then
					a_target.set_options (new_target.internal_options)
				end
				a_target.set_external_includes (new_target.internal_external_include)
				a_target.set_external_objects (new_target.internal_external_object)
				a_target.set_external_ressources (new_target.internal_external_ressource)
				a_target.set_external_make (new_target.internal_external_make)

				l_pre := a_target.precompile
				if l_pre /= Void then
					l_old_pre := new_target.precompile
					check
						l_old_pre_not_void: l_old_pre /= Void
					end
					l_pre.set_options (l_old_pre.internal_options)
					l_pre.set_class_options (l_old_pre.class_options)
				end
				process_with_new (a_target.internal_libraries, new_target.internal_libraries)
				process_with_new (a_target.internal_assemblies, new_target.internal_assemblies)
				process_with_new (a_target.internal_clusters, new_target.internal_clusters)
				process_with_new (a_target.internal_overrides, new_target.internal_overrides)
			end
		end

	process_group (a_group: CONF_GROUP) is
			-- Visit `a_group'.
		do
			if not is_error then
				a_group.set_options (new_group.internal_options)
				a_group.set_class_options (new_group.class_options)
			end
		end


feature -- Access

	application_target: CONF_TARGET
			-- The application target of the system.

	new_target: CONF_TARGET
			-- The new, compiled target that is group equivalent to the old target.

	new_group: CONF_GROUP
			-- The new group, for the group we are currently processing.

feature {NONE} -- Implementation

	process_with_new (an_old_groups, a_new_groups: HASH_TABLE [CONF_GROUP, STRING]) is
			-- Process `a_old_groups' and set `new_group' to the corresponding group of `a_new_groups'.
		local
			l_group: CONF_GROUP
		do
			from
				an_old_groups.start
			until
				an_old_groups.after
			loop
				l_group := an_old_groups.item_for_iteration
				new_group := a_new_groups.item (l_group.name)
				check
					new_group_found: new_group /= Void
				end
				l_group.process (Current)
				an_old_groups.forth
			end
		end

end
