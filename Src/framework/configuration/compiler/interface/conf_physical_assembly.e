note
	description: "Objects that represent an included assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_PHYSICAL_ASSEMBLY

inherit
	CONF_PHYSICAL_ASSEMBLY_INTERFACE
		redefine
			classes_set,
			is_physical_assembly,
			class_by_name,
			name_by_class,
			is_group_equivalent,
			is_readonly,
			accessible_groups,
			add_condition,
			location,
			dependencies
		end

	CONF_FILE_DATE
		export
			{NONE} all
		undefine
			is_equal
		end

	CACHE_CONSTANTS
		export
			{NONE} all
		end

create {CONF_FACTORY}
	make_from_consumed

feature {NONE} -- Initialization

	initialize_conditions
			-- Restrict to platform dotnet
		local
			c: like internal_conditions
		do
				-- We can't have any existing conditions as this group does not have an equivalent in the configuration file.
			create c.make (1)
			c.force (default_condition)
			internal_conditions := c
		end

	make_from_consumed (a_consumed: CONSUMED_ASSEMBLY; a_cache_path: PATH; a_target: CONF_TARGET)
			-- Create
		require
			a_consumed_not_void: a_consumed /= Void
			a_cache_path_not_void: a_cache_path /= Void
			a_target_not_void: a_target /= Void
		do
			consumed_assembly := a_consumed
				-- FIXME: It would be better if {CONF_GROUP}.name was a READABLE_STRING_32 instance.
			name := assembly_name.as_lower
			target := a_target
			cache_path := a_cache_path
			create location.make (a_consumed.location.name, a_target)
			create assemblies.make (0)
			initialize_conditions
				-- be default we assume that an assembly is only used as a dependency
			is_dependency := True
			is_valid := True
		ensure
			consumed_set: consumed_assembly = a_consumed
			cache_path_set: cache_path = a_cache_path
			is_dependency: is_dependency
			is_valid: is_valid
		end

feature -- Status

	classes_set: BOOLEAN
			-- Are the classes set?
		do
			Result := classes /= Void and dotnet_classes /= Void
		end

	is_physical_assembly: BOOLEAN
			-- Is this a physical assembly?
		once
			Result := True
		end

	is_in_gac: BOOLEAN
			-- Is this assembly in gac?
		do
			Result := consumed_assembly.is_in_gac
		end

	is_partially_consumed: BOOLEAN
			-- Indicates if assembly is only partially consumed
		do
			Result := consumed_assembly.has_info_only
		end

	is_dependency: BOOLEAN
			-- Indicates if assembly is only used as a dependency

	location: CONF_FILE_LOCATION
			-- Assembly location.

	is_readonly: BOOLEAN = True
			-- Assemblies are always read only.

feature -- Access, in compiled only

	cache_path: PATH
			-- Path to the metadata cache.

	dotnet_classes: detachable STRING_TABLE [like class_type]
			-- Same as `classes' but indexed by the dotnet name.

	guid: READABLE_STRING_32
			-- A unique id.
		do
			check
				consumed_assembly: consumed_assembly /= Void
			end
			Result := consumed_assembly.unique_id
		end

	consumed_path: PATH
			-- The path to the consumed assembly.
		do
			Result := cache_path.extended (consumed_assembly.folder_name)
		end

	date: INTEGER
			-- Date of last modification of the cached information.

	consumed_assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly as produced by the consumer.

	dependencies: detachable HASH_TABLE [CONF_PHYSICAL_ASSEMBLY, INTEGER];
			-- Dependencies on other assemblies indexed by their assembly ID.

feature -- Access queries

	assembly_name: READABLE_STRING_32
			-- Assembly name.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.name
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	assembly_version: READABLE_STRING_32
			-- Assembly version.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.version
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	assembly_culture: READABLE_STRING_32
			-- Assembly culture.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.culture
		ensure
			result_ok: Result /= Void
		end

	assembly_public_key_token: READABLE_STRING_32
			-- Assembly public key token.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.key
		ensure
			result_ok: Result /= Void
		end

	types_info_file_location: PATH
			-- Types info file.
		require
			consumed_path_not_void: consumed_path /= Void
		do
			Result := consumed_path.extended (types_info_file)
		end

	has_date_changed: BOOLEAN
			-- Did the date change?
		local
			l_date: INTEGER
		do
			l_date := file_modified_date (types_info_file_location.name)
			Result := (l_date = -1) or (l_date /= date)
		end

	accessible_groups: SEARCH_TABLE [CONF_GROUP]
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else nothing.
		local
			l_accessible_groups_cache: like accessible_groups_cache
		do
			l_accessible_groups_cache := accessible_groups_cache
			if l_accessible_groups_cache = Void then
				if attached dependencies as l_dependencies then
					from
						create l_accessible_groups_cache.make_map (l_dependencies.count)
						l_dependencies.start
					until
						l_dependencies.after
					loop
						l_accessible_groups_cache.put (l_dependencies.item_for_iteration)
						l_dependencies.forth
					end
				else
					create l_accessible_groups_cache.make_map (0)
				end
				accessible_groups_cache := l_accessible_groups_cache
			end
			Result := l_accessible_groups_cache
		end

	mapping: STRING_TABLE [READABLE_STRING_32]
			-- Special classes name mapping (eg. "STRING" => "STRING_32").
		once
				-- there are no mappings for assemblies
			create Result.make_equal (0)
		end

	class_by_name (a_class: READABLE_STRING_GENERAL; a_dependencies: BOOLEAN): LINKED_SET [like class_type]
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

	class_by_dotnet_name (a_class: STRING; a_dependency_index: INTEGER): detachable like class_type
			-- Get class by dotnet name.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			classes_set: classes_set
		local
			d: like dotnet_classes
		do
			if
				attached dependencies as l_dependencies and then
				attached l_dependencies.item (a_dependency_index) as l_found_item
			then
				d := l_found_item.dotnet_classes
			else
				d := dotnet_classes
			end

			if attached d then
				Result := d.item (a_class)
			end
		end

	options: CONF_OPTION
			-- Options of this assembly.
		once
				-- Assemblies have no options.
			Result := {CONF_OPTION}.create_from_namespace_or_latest (latest_namespace)
				-- But we have to treat classes as void-safe, as otherwise
				-- nothing from an assembly can be used in a void-safe project.
			Result.void_safety.put_index ({CONF_OPTION}.void_safety_index_all)
		end

	adapted_options: CONF_OPTION
			-- Options of this assembly adapted to the current project.
		once
			Result := options
		end

	class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options of classes in the assembly.
		do
				-- classes in assemblies have no options
		end

	adapted_class_options: detachable STRING_TABLE [CONF_OPTION]
			-- Options of classes in the assembly adapted to the current project.
		do
				-- Classes in assemblies have no options.
		end

	sub_group_by_name (a_name: READABLE_STRING_GENERAL): detachable CONF_GROUP
			-- Return assembly dependency with `a_name' if there is any.
		do
			if attached dependencies as ds then
				across
					ds as d
				until
					attached Result
				loop
					if d.name.same_string_general (a_name) then
						Result := d
					end
				end
			end
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	add_condition (a_condition: CONF_CONDITION)
			-- Add `a_condition'.
		do
			check
				should_not_get_called: False
			end
		end

feature {CONF_ACCESS} -- Update, in compiled only

	set_target (a_target: like target)
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

	set_consumed_assembly (a_consumed: like consumed_assembly)
			-- Set `consumed_assembly' to `a_consumed'.
		require
			a_consumed_not_void: a_consumed /= Void
		do
			consumed_assembly := a_consumed
		ensure
			consumed_assembly_set: consumed_assembly = a_consumed
		end

	set_date
			-- Set `date' to the last modification timestamp.
		do
			date := file_modified_date (types_info_file_location.name)
		ensure
			not_date_changed: not has_date_changed
		end

	set_dotnet_classes (a_classes: like dotnet_classes)
			-- Set `dotnet_classes' to `a_classes'.
		require
			a_classes_not_void: a_classes /= Void
		do
			dotnet_classes := a_classes
		ensure
			dotnet_classes_set: dotnet_classes = a_classes
		end

	add_dependency (an_assembly: CONF_PHYSICAL_ASSEMBLY; an_index: INTEGER)
			-- Add a dependency on `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		local
			d: like dependencies
		do
			d := dependencies
			if not attached d then
				create d.make (an_index)
				dependencies := d
			end
			d.force (an_assembly, an_index)
		end

	set_dependencies (a_dependencies: like dependencies)
			-- Set `dependencies' to `a_dependencies'.
		do
			dependencies := a_dependencies
		end

	set_is_dependency (a_dependency: like is_dependency)
			-- Set `is_dependency' to `a_dependency'
		do
			is_dependency := a_dependency
		ensure
			is_dependency_set: is_dependency = a_dependency
		end

	reset_assemblies
			-- Reset `assemblies' for incremental recompilation.
		do
			assemblies.wipe_out
		ensure
			assemblies_wiped: assemblies.is_empty
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := guid.is_equal (other.guid)
		end

feature {NONE} -- Implementation

	default_condition: CONF_CONDITION
			-- Default condition that restricts assemblies to .NET
		once
			create Result.make
			Result.set_dotnet (True)
		ensure
			Result_not_void: Result /= Void
		end

invariant
	cache_path_set: cache_path /= Void
	consumed_assembly_set: consumed_assembly /= Void
	consumed_path_set: classes_set implies consumed_path /= Void and then not consumed_path.is_empty
	assemblies_not_void: assemblies /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
