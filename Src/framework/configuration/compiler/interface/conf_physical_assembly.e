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
			options,
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
		do
				-- We can't have any existing conditions as this group does not have an equivalent in the configuration file.
			create internal_conditions.make (1)
			internal_conditions.force (default_condition)
		end

	make_from_consumed (a_consumed: CONSUMED_ASSEMBLY; a_cache_path: DIRECTORY_NAME; a_target: CONF_TARGET)
			-- Create
		require
			a_consumed_not_void: a_consumed /= Void
			a_cache_path_not_void: a_cache_path /= Void
			a_target_not_void: a_target /= Void
		do
			consumed_assembly := a_consumed
			name := assembly_name.as_lower
			target := a_target
			cache_path := a_cache_path
			create location.make (a_consumed.location, a_target)
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

	cache_path: DIRECTORY_NAME
			-- Path to the metadata cache.

	dotnet_classes: HASH_TABLE [like class_type, STRING]
			-- Same as `classes' but indexed by the dotnet name.

	guid: STRING
			-- A unique id.
		do
			check
				consumed_assembly: consumed_assembly /= Void
			end
			Result := consumed_assembly.unique_id
		end

	consumed_path: DIRECTORY_NAME
			-- The path to the consumed assembly.
		do
			create Result.make_from_string (cache_path)
			Result.extend (consumed_assembly.folder_name)
		end

	date: INTEGER
			-- Date of last modification of the cached information.

	consumed_assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly as produced by the consumer.

	dependencies: HASH_TABLE [CONF_PHYSICAL_ASSEMBLY, INTEGER];
			-- Dependencies on other assemblies indexed by their assembly ID.

feature -- Access queries

	assembly_name: STRING
			-- Assembly name.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.name
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	assembly_version: STRING
			-- Assembly version.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.version
		ensure
			result_ok: Result /= Void and then not Result.is_empty
		end

	assembly_culture: STRING
			-- Assembly culture.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.culture
		ensure
			result_ok: Result /= Void
		end

	assembly_public_key_token: STRING
			-- Assembly public key token.
		require
			consumed_assembly /= Void
		do
			Result := consumed_assembly.key
		ensure
			result_ok: Result /= Void
		end

	types_info_file_location: FILE_NAME
			-- Types info file.
		require
			consumed_path_not_void: consumed_path /= Void
		do
			create Result.make_from_string (consumed_path)
			Result.set_file_name (types_info_file)
		end

	has_date_changed: BOOLEAN
			-- Did the date change?
		local
			l_date: INTEGER
		do
			l_date := file_modified_date (types_info_file_location)
			Result := (l_date = -1) or (l_date /= date)
		end

	accessible_groups: DS_HASH_SET [CONF_GROUP]
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else nothing.
		do
			if accessible_groups_cache = Void then
				if dependencies /= Void then
					from
						create accessible_groups_cache.make (dependencies.count)
						dependencies.start
					until
						dependencies.after
					loop
						accessible_groups_cache.put (dependencies.item_for_iteration)
						dependencies.forth
					end
				else
					create accessible_groups_cache.make (0)
				end
			end
			Result := accessible_groups_cache
		end

	mapping: EQUALITY_HASH_TABLE [STRING, STRING]
			-- Special classes name mapping (eg. STRING => STRING_32).
		once
				-- there are no mappings for assemblies
			create Result.make (0)
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN): LINKED_SET [like class_type]
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

	name_by_class (a_class: CONF_CLASS; a_dependencies: BOOLEAN): LINKED_SET [STRING]
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

	class_by_dotnet_name (a_class: STRING; a_dependency_index: INTEGER): like class_type
			-- Get class by dotnet name.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			classes_set: classes_set
		do
			if dependencies /= Void and then dependencies.has_key (a_dependency_index) then
				check not_void: dependencies.found_item /= Void end
				Result := dependencies.found_item.dotnet_classes.item (a_class)
			else
				Result := dotnet_classes.item (a_class)
			end
		end

	options: CONF_OPTION
			-- Options of this assembly.
		once
				-- assemblies have no options
			create Result
		end

	class_options: HASH_TABLE [CONF_OPTION, STRING]
			-- Options of classes in the assembly.
		do
				-- classes in assemblies have no options
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP
			-- Return assembly dependency with `a_name' if there is any.
		do
			if dependencies /= Void then
				from
					dependencies.start
				until
					Result /= Void or dependencies.after
				loop
					if dependencies.item_for_iteration.name.is_equal (a_name) then
						Result := dependencies.item_for_iteration
					end
					dependencies.forth
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
			date := file_modified_date (types_info_file_location)
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
		do
			if dependencies = Void then
				create dependencies.make (an_index)
			end
			dependencies.force (an_assembly, an_index)
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
