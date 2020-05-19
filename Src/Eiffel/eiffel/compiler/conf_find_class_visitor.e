note
	description: "Visitor that looks for a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FIND_CLASS_VISITOR

inherit
	CONF_CONDITIONED_ITERATOR
		redefine
			make,
			process_assembly,
			process_physical_assembly,
			process_library,
			process_precompile,
			process_cluster,
			process_override
		end

create
	make

feature {NONE} -- Initialization

	make (a_state: like state)
			-- Create.
		do
			Precursor (a_state)
			create found_classes.make
			create targets_done.make (5)
			create assemblies_done.make (5)
		end

feature -- Access

	found_classes: LINKED_SET [CLASS_I]
			-- Classes with `name' retrieved during last process.

	name: READABLE_STRING_GENERAL
			-- Name to look for.
			-- Class name is ASCII compatible.

feature -- Update

	set_name (a_name: READABLE_STRING_GENERAL)
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
		do
			name := a_name
		end

feature -- Visit nodes

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- Visit `an_assembly'.
		do
			if an_assembly.classes_set then
				an_assembly.physical_assembly.process (Current)
			end
		end

	process_physical_assembly (a_assembly: CONF_PHYSICAL_ASSEMBLY)
			-- Visist `a_assembly'.
		do
			if not assemblies_done.has (a_assembly.guid) then
				assemblies_done.put (a_assembly.guid)
				retrieve_from_group (a_assembly)
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- Visit `a_library'.
		do
			if attached a_library.library_target as l_library_target then
				retrieve_recursively (l_library_target)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- Visit `a_precompile'.
		do
			if attached a_precompile.library_target as l_library_target then
				retrieve_recursively (l_library_target)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- Visit `a_cluster'.
		do
			retrieve_from_group (a_cluster)
		end

	process_override (an_override: CONF_OVERRIDE)
			-- Visit `an_override'.
		do
			retrieve_from_group (an_override)
		end

feature {NONE} -- Implementation

	targets_done: SEARCH_TABLE [UUID]
			-- Lookup for libraries where we already searched.

	assemblies_done: SEARCH_TABLE [like {CONF_PHYSICAL_ASSEMBLY}.guid]
			-- Lookup for assemblies where we already searched.

	retrieve_from_group (a_group: CONF_GROUP)
			-- Retrieve classes with `name' from `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			if
				a_group.classes_set and then
				attached {CLASS_I} a_group.classes.item (name) as l_class
			then
				found_classes.force (l_class)
			end
		end

	retrieve_recursively (a_target: CONF_TARGET)
			-- Retrieve classes with `name' recursively from `a_target'.
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

invariant
	name_set_upper: name /= Void implies name.is_equal (name.as_upper)
	found_classes_not_void: found_classes /= Void
	targets_done_not_void: targets_done /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
