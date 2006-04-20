indexing
	description: "Get a list of all classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_uuid: UUID
		do
			l_uuid := a_target.system.uuid
			if not targets_done.has (l_uuid) then
				targets_done.force (l_uuid)
				a_target.process (Current)
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
