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
			process_override,
			process_group
		end

	CONF_ACCESS

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
--		local
--			l_deps: LINKED_SET [CONF_ASSEMBLY]
		do
--
--			Patrickr 25/04/2006: To realy check if an assembly has changed we would need to start a consume.
--								 As the compiler doesn't handle changed assemblies yet anyway we save the time to do this.
--
--			if not is_error and then not processed_assemblies.has (an_assembly.guid) then
--				processed_assemblies.force (an_assembly.guid)
--				an_assembly.check_changed
--				find_modified (an_assembly)
--				l_deps := an_assembly.dependencies
--				if l_deps /= Void then
--					from
--						l_deps.start
--					until
--						l_deps.after
--					loop
--						l_deps.item.process (Current)
--						l_deps.forth
--					end
--				end
--			end
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
				find_modified (a_cluster)
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

	find_modified (a_group: CONF_GROUP) is
			-- Find classes that have been modified and add them to `modified_classes'.
		require
			a_group_not_void: a_group /= Void
		local
			l_class: CONF_CLASS
			l_new_classes, l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_name: STRING
		do
			l_classes := a_group.classes
			if l_classes /= Void then
				create l_new_classes.make (l_classes.count)
				from
					l_classes.start
				until
					l_classes.after
				loop
					l_class := l_classes.item_for_iteration
					if l_class.is_compiled then
							-- check for changes and update name if necessary
						l_class.check_changed
						if l_class.is_error then
							add_error (l_class.last_error)
						end
						if l_class.is_modified or (l_class.is_removed and l_class.is_compiled) then
							modified_classes.extend (l_class)
						end
					end
					if not l_class.is_removed then
						l_name := l_class.name
						if not l_new_classes.has (l_name) then
							l_new_classes.force (l_class, l_name)
						else
							add_error (create {CONF_ERROR_CLASSDBL}.make (l_name))
						end
					end
					l_classes.forth
				end
				a_group.set_classes (l_new_classes)
			end
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
