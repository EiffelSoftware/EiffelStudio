indexing
	description: "Visitor that looks for an assembly name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FIND_ASSEMBLY_VISITOR

inherit
	CONF_ITERATOR
		redefine
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
			create found_assemblies.make
			create targets_done.make (5)
		end

feature -- Access

	found_assemblies: LINKED_SET [CONF_ASSEMBLY]
			-- Classes with `name' retrieved during last process.

	name: STRING
			-- Name to look for.

feature -- Update

	set_name (a_name: STRING) is
			-- Set `name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		end

feature -- Visit nodes

	process_assembly (an_assembly: CONF_ASSEMBLY) is
			-- Visit `an_assembly'.
		do
			if
				an_assembly.assembly_name /= Void and then
				an_assembly.assembly_name.is_case_insensitive_equal (name)
			then
				found_assemblies.force (an_assembly)
			end
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
			retrieve_recursively (a_library.library_target)
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			retrieve_recursively (a_precompile.library_target)
		end

feature {NONE} -- Implementation

	targets_done: SEARCH_TABLE [UUID]
			-- Lookup for libraries where we already searched.

	retrieve_recursively (a_target: CONF_TARGET) is
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
	found_assemblies_not_void: found_assemblies /= Void
	targets_done_not_void: targets_done /= Void

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
