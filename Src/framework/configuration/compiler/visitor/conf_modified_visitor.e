note
	description: "Get the classes that have been modified."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			process_override
		end

	CONF_SCAN_DIRECTORY

	CONF_ACCESS

	CONF_VALIDITY

create
	make

feature {NONE} -- Initialization

	make (a_state: like state)
			-- Create.
		do
			Precursor (a_state)
			create modified_classes.make (0)
			create process_group_observer.make (1)
			create processed_libraries.make (100)
			create processed_assemblies.make (100)
		end

feature -- Visit nodes

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Process `an_assembly'.
		do
--			Patrickr 25/04/2006: At the moment we don't check for changed assemblies as the compiler doesn't handle this anyway.
		end

	process_library (a_library: CONF_LIBRARY)
			-- Process `a_library'.
		do
			if
				not is_override_only and then
				attached a_library.library_target as t and then
				not processed_libraries.has (t.system.uuid)
			then
				on_process_group (a_library)
				processed_libraries.force (t.system.uuid)
				t.process (Current)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Process `a_precompile'.
		do
			if not is_override_only then
				process_library (a_precompile)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Process `a_cluster'.
		do
			if not is_override_only then
				on_process_group (a_cluster)
				find_modified (a_cluster)
			end
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Process `an_override'.
		do
			on_process_group (an_override)
				-- Check if any classes have been added and force a rebuild if this is the case.
			if attached an_override.active_file_rule (state) as f then
				process_cluster_recursive ({STRING_32} "", an_override, f)
			else
				check
					from_active_file_rule_postcondition: attached an_override.last_error as e
				then
					add_and_raise_error (e)
				end
			end
			find_modified (an_override)
		end

feature -- Status

	is_override_only: BOOLEAN
			-- Should we only check the override clusters?

	is_force_rebuild: BOOLEAN
			-- Do we need to do a full rebuild of the configuration?

feature -- Status update

	enable_override_only
			-- Only scan override clusters.
		do
			is_override_only := True
		ensure
			is_override_only: is_override_only
		end

feature -- Access

	modified_classes: ARRAYED_LIST [CONF_CLASS]
			-- The list of modified classes.

feature -- Update

	resest_modified_classes
			-- Reset `modified_classes'.
		do
			create modified_classes.make (0)
		end

feature -- Observer

	process_group_observer: ARRAYED_LIST [PROCEDURE [CONF_GROUP]]
			-- Observer if a group is processed.

feature -- Events

	on_process_group (a_group: CONF_GROUP)
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

	find_modified (a_group: CONF_GROUP)
			-- Find classes that have been modified and add them to `modified_classes'.
		require
			a_group_not_void: a_group /= Void
		local
			l_class: CONF_CLASS
			is_read_only: BOOLEAN
		do
			if attached a_group.classes as l_classes then
				is_read_only := a_group.is_readonly
				across
					l_classes as c
				until
					is_force_rebuild
				loop
					l_class := c.item
						-- Check for changes.
					if is_read_only then
							-- Do not look into source code changes for read-only group.
						l_class.check_changed_options
					else
							-- Take into account any changes to a class.
						l_class.check_changed
					end
					if l_class.is_error or else l_class.is_renamed or l_class.is_removed then
						l_class.reset_error
						is_force_rebuild := True
					elseif l_class.is_modified then
						if l_class.is_compiled then
								-- Invariant of CONF_CLASS tell us that it cannot be an override class.
							if not l_class.is_overriden then
								modified_classes.extend (l_class)
							end
						elseif attached l_class.overrides as overrides then
							overrides.do_if (agent modified_classes.extend, agent {CONF_CLASS}.is_compiled)
						end
					end
				end
			end
		end

	handle_class (f, d: READABLE_STRING_32; c: CONF_CLUSTER)
			-- Handle class in source file `f` in directory `d` in cluster `c`.
		do
			is_force_rebuild :=
				not is_force_rebuild and then
				valid_eiffel_extension (f) and then
				(attached c.classes_by_filename as t ⇒
				not t.has ((create {PATH}.make_from_string (d)).extended (f)))
		end

invariant
	modifed_classes_not_void: modified_classes /= Void
	process_group_observer_not_void: process_group_observer /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
