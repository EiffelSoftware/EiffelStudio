indexing
	description: "Objects that represent an included assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ASSEMBLY

inherit
	CONF_VIRTUAL_GROUP
		redefine
			classes_set,
			process,
			is_assembly,
			class_by_name,
			name_by_class,
			options,
			is_group_equivalent,
			class_type,
			is_readonly,
			accessible_groups,
			location
		end

create {CONF_PARSE_FACTORY}
	make,
	make_from_gac

feature {NONE} -- Initialization

	make_from_gac (a_name, an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_key: STRING; a_target: CONF_TARGET) is
			-- Create.
		require
			a_name_not_void: a_name /= Void
			an_assembly_name_not_void: an_assembly_name /= Void
			an_assembly_version_not_void: an_assembly_version /= Void
			an_assembly_culture_not_void: an_assembly_culture /= Void
			an_assembly_key_not_void: an_assembly_key /= Void
			a_target_not_void: a_target /= Void
		do
			target := a_target
			is_valid := True
			set_name (a_name.as_lower)
			assembly_name := an_assembly_name
			assembly_version := an_assembly_version
			assembly_culture := an_assembly_culture
			assembly_public_key_token := an_assembly_key
			create location.make ("", a_target)
			is_non_local_assembly := True
		ensure
			is_valid: is_valid
		end

feature -- Status

	classes_set: BOOLEAN is
			-- Are the classes set?
		do
			Result := classes /= Void
		end

	is_assembly: BOOLEAN is
			-- Is this an assembly?
		once
			Result := True
		end

	is_non_local_assembly: BOOLEAN
			-- Was this assembly only specified by gac information (i.e. no location was set)?

feature -- Access, stored in configuration file

	is_readonly: BOOLEAN is True
			-- Assemblies are always read only.

	location: CONF_FILE_LOCATION
			-- Location of the assembly.

	assembly_name: STRING
			-- Name of the assembly.

	assembly_version: STRING
			-- Version of the assembly.

	assembly_culture: STRING
			-- Culture of the assembly.

	assembly_public_key_token: STRING
			-- Public key of the assembly.

feature -- Access, in compiled only

	physical_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE
			-- Physical assembly that contains all the (unrenamed) classes.

feature -- Access queries

	accessible_groups: DS_HASH_SET [CONF_GROUP] is
			-- Groups that are accessible within `Current'.
		do
			Result := physical_assembly.accessible_groups
		end

	mapping: EQUALITY_HASH_TABLE [STRING, STRING] is
			-- Special classes name mapping (eg. STRING => STRING_32).
		once
				-- There are no mappings for assemblies
			create Result.make (0)
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [like class_type] is
			-- Get class by name.
		local
			l_dep: CONF_GROUP
			l_groups: like accessible_groups
		do
			Result := Precursor (a_class, a_dependencies)
			if a_dependencies then
				l_groups := accessible_groups
				from
					l_groups.start
				until
					l_groups.after
				loop
					l_dep := l_groups.item_for_iteration
					if l_dep.classes_set then
						Result.append (l_dep.class_by_name (a_class, False))
					end
					l_groups.forth
				end
			end
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [STRING] is
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
		local
			l_dep: CONF_GROUP
			l_groups: like accessible_groups
			l_cursor: DS_HASH_SET_CURSOR [CONF_GROUP]
		do
			Result := Precursor (a_class, a_dependencies)
			if a_dependencies then
				l_groups := accessible_groups
				l_cursor := l_groups.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_dep := l_cursor.item
					l_cursor.forth
					if l_dep.classes_set then
						Result.append (l_dep.name_by_class (a_class, False))
					end
				end
			end
		ensure then
			Result_empty_or_one_element: Result.is_empty or Result.count = 1
		end

	options: CONF_OPTION is
			-- Options of this assembly.
		once
				-- assemblies have no options
			create Result
		end

	class_options: HASH_TABLE [CONF_OPTION, STRING]
			-- Options of classes in the assembly.
		once
				-- classes in assemblies have no options
			create Result.make (0)
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP is
			-- Return assembly dependency with `a_name' if there is any.
		local
			l_deps: HASH_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE, INTEGER_32]
		do
			if physical_assembly /= Void then
				l_deps := physical_assembly.dependencies
			end
			if l_deps /= Void then
				from
					l_deps.start
				until
					Result /= Void or l_deps.after
				loop
					if l_deps.item_for_iteration.name.is_equal (a_name) then
						Result := l_deps.item_for_iteration
					end
					l_deps.forth
				end
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_assembly_name (a_name: like assembly_name) is
			-- Set `assembly_name' to `a_name'.
		do
			assembly_name := a_name
		ensure
			assembly_name_set: assembly_name = a_name
		end

	set_assembly_version (a_version: like assembly_version) is
			-- Set `assembly_version' to `a_version'.
		do
			assembly_version := a_version
		ensure
			assembly_version_set: assembly_version = a_version
		end

	set_assembly_culture (a_culture: like assembly_culture) is
			-- Set `assembly_culture' to `a_culture'.
		do
			assembly_culture := a_culture
		ensure
			assembly_culture_set: assembly_culture = a_culture
		end

	set_assembly_public_key (a_public_key: like assembly_public_key_token) is
			-- Set `assembly_public_key_token' to `a_public_key'.
		do
			assembly_public_key_token := a_public_key
		ensure
			assembly_public_key_token_set: assembly_public_key_token = a_public_key
		end

feature {CONF_ACCESS} -- Update, in compiled only

	set_physical_assembly (a_assembly: like physical_assembly) is
			-- Set `physical_assembly' to `a_assembly'.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			physical_assembly := a_assembly
			physical_assembly.add_assembly (Current)
		ensure
			physical_assembly_set: physical_assembly = a_assembly
			physical_assembly_backlink: physical_assembly.assemblies.has (Current)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other)
			if Result and location.original_path.is_empty then
				Result := equal (assembly_name, other.assembly_name) and
					equal (assembly_version, other.assembly_version) and
					equal (assembly_culture, other.assembly_culture) and
					equal (assembly_public_key_token, other.assembly_public_key_token) and
					equal (name_prefix, other.name_prefix) and then equal (renaming, other.renaming)
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_assembly (Current)
		end

feature {NONE} -- Type anchors

	class_type: CONF_CLASS;
			-- Class type anchor

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
