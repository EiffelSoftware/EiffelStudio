note
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
			is_group_equivalent,
			is_readonly,
			accessible_groups,
			location,
			is_enabled
		end

create {CONF_PARSE_FACTORY}
	make,
	make_from_gac

feature {NONE} -- Initialization

	make_from_gac (a_name: READABLE_STRING_32; an_assembly_name, an_assembly_version, an_assembly_culture, an_assembly_key: READABLE_STRING_32; a_target: CONF_TARGET)
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
			create location.make ({STRING_32} "", a_target)
			is_non_local_assembly := True
		ensure
			is_valid: is_valid
		end

feature -- Status

	classes_set: BOOLEAN
			-- Are the classes set?
		do
			Result := classes /= Void
		end

	is_assembly: BOOLEAN
			-- Is this an assembly?
		once
			Result := True
		end

	is_non_local_assembly: BOOLEAN
			-- Was this assembly only specified by gac information (i.e. no location was set)?

	is_enabled (a_state: CONF_STATE): BOOLEAN
			-- Is `Current' enabled for `a_state'?
		do
			Result := a_state.is_dotnet and then Precursor (a_state)
		end

feature -- Access, stored in configuration file

	is_readonly: BOOLEAN = True
			-- Assemblies are always read only.

	location: CONF_FILE_LOCATION
			-- Location of the assembly.

	assembly_name: detachable READABLE_STRING_32
			-- Name of the assembly.

	assembly_version: detachable READABLE_STRING_32
			-- Version of the assembly.

	assembly_culture: detachable READABLE_STRING_32
			-- Culture of the assembly.

	assembly_public_key_token: detachable READABLE_STRING_32
			-- Public key of the assembly.

feature -- Access, in compiled only

	physical_assembly: detachable CONF_PHYSICAL_ASSEMBLY_INTERFACE
			-- Physical assembly that contains all the (unrenamed) classes.

feature -- Access queries

	accessible_groups: SEARCH_TABLE [CONF_GROUP]
			-- Groups that are accessible within `Current'.
		do
			if attached physical_assembly as l_physical_assembly then
				Result := l_physical_assembly.accessible_groups
			else
				create Result.make_map (0)
			end
		end

	mapping: STRING_TABLE [READABLE_STRING_32]
			-- Special classes name mapping (eg. STRING => STRING_32).
		once
				-- There are no mappings for assemblies
			create Result.make_equal (0)
		end

	class_by_name (a_class: READABLE_STRING_GENERAL; a_dependencies: BOOLEAN): LINKED_SET [like class_type]
			-- Get class by name.
		local
			l_dep: CONF_GROUP
		do
			Result := Precursor (a_class, a_dependencies)
			if a_dependencies then
				across accessible_groups as g loop
					l_dep := g.item
					if l_dep.classes_set then
						Result.append (l_dep.class_by_name (a_class, False))
					end
				end
			end
		end

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [READABLE_STRING_GENERAL]
			-- Get name in this context of `a_class' (if `a_dependencies') then we check dependencies).
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
					l_groups.forth
					if l_dep.classes_set then
						Result.append (l_dep.name_by_class (a_class, False))
					end
				end
			end
		ensure then
			Result_empty_or_one_element: Result.is_empty or Result.count = 1
		end

	options: CONF_OPTION
			-- Options of this assembly.
		once
				-- Assemblies have no options.
			Result := {CONF_OPTION}.create_from_namespace_or_latest (latest_namespace)
		end

	adapted_options: CONF_OPTION
			-- Options of this assembly adapted to the current project.
		once
			Result := options
		end

	class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options of classes in the assembly.
		do
		end

	adapted_class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options of classes in the assembly adapted to the current project.
		do
				-- Classes in assemblies have no options.
		end

	sub_group_by_name (a_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Return assembly dependency with `a_name' if there is any.
		local
			l_deps: detachable HASH_TABLE [CONF_PHYSICAL_ASSEMBLY_INTERFACE, INTEGER_32]
		do
			if attached physical_assembly as l_physical_assembly then
				l_deps := l_physical_assembly.dependencies
				if l_deps /= Void then
					from
						l_deps.start
					until
						Result /= Void or l_deps.after
					loop
						if l_deps.item_for_iteration.name.same_string_general (a_name) then
							Result := l_deps.item_for_iteration
						end
						l_deps.forth
					end
				end
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_assembly_name (a_name: like assembly_name)
			-- Set `assembly_name' to `a_name'.
		do
			assembly_name := a_name
		ensure
			assembly_name_set: assembly_name = a_name
		end

	set_assembly_version (a_version: like assembly_version)
			-- Set `assembly_version' to `a_version'.
		do
			assembly_version := a_version
		ensure
			assembly_version_set: assembly_version = a_version
		end

	set_assembly_culture (a_culture: like assembly_culture)
			-- Set `assembly_culture' to `a_culture'.
		do
			assembly_culture := a_culture
		ensure
			assembly_culture_set: assembly_culture = a_culture
		end

	set_assembly_public_key (a_public_key: like assembly_public_key_token)
			-- Set `assembly_public_key_token' to `a_public_key'.
		do
			assembly_public_key_token := a_public_key
		ensure
			assembly_public_key_token_set: assembly_public_key_token = a_public_key
		end

feature {CONF_ACCESS} -- Update, in compiled only

	set_physical_assembly (a_assembly: attached like physical_assembly)
			-- Set `physical_assembly' to `a_assembly'.
		require
			a_assembly_not_void: a_assembly /= Void
		do
			physical_assembly := a_assembly
			a_assembly.add_assembly (Current)
		ensure
			physical_assembly_set: physical_assembly = a_assembly
			physical_assembly_backlink: a_assembly.assemblies.has (Current)
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other)
			if Result and location.original_path.is_empty then
				Result := equal (assembly_name, other.assembly_name) and
					equal (assembly_version, other.assembly_version) and
					equal (assembly_culture, other.assembly_culture) and
					equal (assembly_public_key_token, other.assembly_public_key_token) and
					equal (name_prefix, other.name_prefix) and then equal (renaming, other.renaming)
			elseif Result then
				Result := equal (name_prefix, other.name_prefix) and then equal (renaming, other.renaming)
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR)
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_assembly (Current)
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
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
