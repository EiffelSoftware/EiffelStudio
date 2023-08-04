note
	description: "Classes in assemblies."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CLASS_ASSEMBLY

inherit
	CONF_CLASS
		redefine
			name_from_associated_file,
			group,
			is_read_only,
			is_class_assembly
		end

create {CONF_FACTORY}
	make_assembly_class

feature {NONE} -- Implementation

	make_assembly_class (a_name, a_dotnet_name: STRING; an_assembly: like group; a_position: INTEGER; a_factory: like factory)
			-- Create.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
			a_dotnet_name_ok: a_dotnet_name /= Void and then not a_dotnet_name.is_empty
			an_assembly_not_void: an_assembly /= Void
			a_position_ok: a_position >= 0
			a_factory_not_void: a_factory /= Void
		do
			group := an_assembly
			name := a_name
			dotnet_name := a_dotnet_name
			type_position := a_position
			create file_name.make_empty
			is_valid := True
			path := extract_path_from_dotnet (a_dotnet_name)
			factory := a_factory
		ensure
			is_valid: is_valid
		end

feature -- Access

	is_read_only: BOOLEAN = True
			-- A class in an assembly is always read-only.

	is_class_assembly: BOOLEAN = True
			-- We are a class in an assembly.

feature {CONF_ACCESS} -- Update

	set_group (a_group: like group)
			-- Set `group' to `a_group'.
		require
			a_group_ok: a_group /= Void and then a_group.is_valid
		do
			group := a_group
		ensure
			group_set: group = a_group
		end

	set_public_group (a_public_group: like public_group)
			-- Set `public_group' to `a_public_group'.
		require
			a_public_group_ok: a_public_group /= Void and then a_public_group.is_valid
		do
			public_group := a_public_group
		ensure
			public_group: public_group = a_public_group
		end

	name_from_associated_file: STRING
			-- Compute `renamed_name' from `name'.
		do
			Result := name
		end

	set_type_position (a_position: INTEGER)
			-- Set class type description position.
		require
			a_position_ok: a_position >= 0
		do
			type_position := a_position
		end

feature -- Access

	dotnet_name: STRING
			-- Dotnet name.

	group: CONF_PHYSICAL_ASSEMBLY
			-- The assembly this class belongs to.

	public_group: detachable CONF_PHYSICAL_ASSEMBLY
			-- The public assembly this class belongs to.

feature {NONE} -- Implementation

	extract_path_from_dotnet (a_name: STRING): STRING
			-- Extract path from a dotnet name.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
		local
			i: INTEGER
		do
			Result := a_name.twin
				-- dotnet name looks like this name1.name2.typename
			i := Result.last_index_of ('.', Result.count)
			if i > 0 then
				Result := Result.substring (1, i-1)
				Result.replace_substring_all (".", "/")
			else
				Result := ""
			end
		end

	type_position: INTEGER
			-- Position of class type description.

	type_file: IMMUTABLE_STRING_32
			-- File of class type description.
		require
			consumed_path: group.consumed_path /= Void
		do
			Result := group.consumed_path.extended (classes_file_name).name
		end

	classes_file_name: STRING = "classes.info"
			-- Directory from Assembly location where classes are located.

invariant
	dotnet_name_ok: dotnet_name /= Void and then not dotnet_name.is_empty

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
