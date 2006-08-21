indexing
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

	make (a_state: like state) is
			-- Create.
		do
			Precursor (a_state)
			create modified_classes.make (0)
			create process_group_observer.make (1)
			create processed_libraries.make (100)
			create processed_assemblies.make (100)
		end

feature -- Visit nodes

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Process `an_assembly'.
		do
--			Patrickr 25/04/2006: At the moment we don't check for changed assemblies as the compiler doesn't handle this anyway.
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Process `a_library'.
		do
			if not is_override_only and then not processed_libraries.has (a_library.uuid) then
				on_process_group (a_library)
				processed_libraries.force (a_library.uuid)
				a_library.library_target.process (Current)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Process `a_precompile'.
		do
			if not is_override_only then
				process_library (a_precompile)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Process `a_cluster'.
		do
			if not is_override_only then
				on_process_group (a_cluster)
				find_modified (a_cluster)
			end
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Process `an_override'.
		do
			on_process_group (an_override)
				-- check if any classes have been added and force a rebuild if this is the case
			process_cluster_recursive ("", an_override, an_override.active_file_rule (state))
			find_modified (an_override)
		end

feature -- Status

	is_override_only: BOOLEAN
			-- Should we only check the override clusters?

	is_force_rebuild: BOOLEAN
			-- Do we need to do a full rebuild of the configuration?

feature -- Status update

	enable_override_only is
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

	find_modified (a_group: CONF_GROUP) is
			-- Find classes that have been modified and add them to `modified_classes'.
		require
			a_group_not_void: a_group /= Void
		local
			l_class: CONF_CLASS
			l_new_classes, l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_name: STRING
			l_err: CONF_ERROR
		do
			l_classes := a_group.classes
			if l_classes /= Void then
				create l_new_classes.make (l_classes.count)
				from
					l_classes.start
				until
					l_classes.after or is_force_rebuild
				loop
					l_class := l_classes.item_for_iteration
						-- check for changes
					l_class.check_changed
					if l_class.is_renamed or l_class.is_removed then
						is_force_rebuild := True
					else
						if l_class.is_compiled then
								-- Invariant of CONF_CLASS tell us that it cannot be an override class.
							if l_class.is_error then
								l_err := l_class.last_error
								l_class.reset_error
								add_and_raise_error (l_err)
							end
							if l_class.is_overriden then
								l_class.actual_class.check_changed
								if l_class.actual_class.is_modified then
									modified_classes.extend (l_class)
								end
							elseif l_class.is_modified then
								modified_classes.extend (l_class)
							end
						end
						l_name := l_class.renamed_name
						if not l_new_classes.has (l_name) then
							l_new_classes.force (l_class, l_name)
						else
							add_and_raise_error (create {CONF_ERROR_CLASSDBL}.make (l_name, l_new_classes.found_item.full_file_name, l_class.full_file_name, a_group.target.system.file_name))
						end
					end
					l_classes.forth
				end
				if not is_force_rebuild then
					a_group.set_classes (l_new_classes)
				end
			end
		end

	handle_class (a_file, a_path: STRING_8; a_cluster: CONF_CLUSTER) is
			-- Handle class in `a_file' with `a_path' in `a_cluster'
		do
			is_force_rebuild := is_force_rebuild or else (valid_eiffel_extension (a_file) and then not a_cluster.classes_by_filename.has (a_path + "/" + a_file))
		end

invariant
	modifed_classes_not_void: modified_classes /= Void
	process_group_observer_not_void: process_group_observer /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
