indexing
	description: "Classes in assemblies."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLASS_ASSEMBLY

inherit
	CONF_CLASS
		redefine
			set_name,
			check_changed,
			group
		end

create
	make_assembly_class

feature {NONE} -- Implementation

	make_assembly_class (a_name, a_dotnet_name: STRING; an_assembly: CONF_ASSEMBLY; a_position: INTEGER) is
			-- Create.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
			a_dotnet_name_ok: a_dotnet_name /= Void and then not a_dotnet_name.is_empty
			an_assembly_not_void: an_assembly /= Void
			a_position_ok: a_position >= 0
		do
			group := an_assembly
			name := a_name
			dotnet_name := a_dotnet_name
			type_position := a_position
			set_name
			create file_name.make_empty
			create path.make_empty
		end

feature {CONF_ACCESS} -- Update

		set_name is
				-- Compute `renamed_name' from `name'.
			require else
				name_set: name /= Void and then not name.is_empty
			local
				l_renamings: HASH_TABLE [STRING, STRING]
				l_old_name: like renamed_name
			do
				l_old_name := renamed_name
				renamed_name := name.twin
				l_renamings := group.renaming
				if l_renamings /= Void and then l_renamings.has (name) then
					renamed_name := l_renamings.item (name)
				end
				if group.name_prefix /= Void then
					renamed_name.prepend (group.name_prefix)
				end
					-- if applicable, add new entry and remove old
				if group.classes /= Void and then l_old_name /= Void and then group.classes.has (l_old_name) then
					is_renamed := True
					group.classes.remove (l_old_name)
					group.classes.force (Current, renamed_name)
				end
			end

		set_type_position (a_position: INTEGER) is
				-- Set class type description position.
			require
				a_position_ok: a_position >= 0
			do
				type_position := a_position
			end

		check_changed is
				-- Check if `Current' has changed.
			do
				is_modified := group.is_modified
			end

feature -- Access

	dotnet_name: STRING
			-- Dotnet name.

	group: CONF_ASSEMBLY
			-- The assembly this class belongs to.

feature {NONE} -- Implementation

	type_position: INTEGER
			-- Position of class type description.

	type_file: STRING is
			-- File of class type description.
		require
			consumed_path: group.consumed_path /= Void
		do
			Result := group.consumed_path.twin
			Result.append_character (operating_environment.directory_separator)
			Result.append (classes_file_name)
		end

	classes_file_name: STRING is "classes.info"
			-- Directory from Assembly location where classes are located.

invariant
	dotnet_name_ok: dotnet_name /= Void and then not dotnet_name.is_empty

end
