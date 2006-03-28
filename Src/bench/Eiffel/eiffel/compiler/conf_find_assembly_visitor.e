indexing
	description: "Visitor that looks for an assembly name."
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
			l_vis: like Current
			l_uuid: UUID
		do
			l_uuid := a_target.system.uuid
			if not targets_done.has (l_uuid) then
				targets_done.force (l_uuid)
				create l_vis.make
				l_vis.set_name (name)
				a_target.process (l_vis)
				found_assemblies.append (l_vis.found_assemblies)
			end
		end



invariant
	name_set_upper: name /= Void implies name.is_equal (name.as_upper)
	found_assemblies_not_void: found_assemblies /= Void
	targets_done_not_void: targets_done /= Void

end
