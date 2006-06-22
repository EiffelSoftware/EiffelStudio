indexing
	description: "Objects that represent an included assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ASSEMBLY

inherit
	CONF_PHYSICAL_GROUP
		redefine
			classes_set,
			make,
			process,
			is_assembly,
			class_by_name,
			name_by_class,
			options,
			is_group_equivalent,
			class_type,
			is_readonly,
			accessible_groups,
			accessible_classes,
			add_condition,
			location
		end

	CONF_FILE_DATE
		undefine
			is_equal
		end


create
	make,
	make_from_gac

feature {NONE} -- Initialization

	initialize_conditions is
			-- Restrict to platform dotnet
		local
			l_cond: CONF_CONDITION
		do
			if internal_conditions = Void then
				create l_cond.make
				l_cond.set_dotnet (True)
				add_condition (l_cond)
			else
				from
					internal_conditions.start
				until
					internal_conditions.after
				loop
					l_cond := internal_conditions.item
					l_cond.set_dotnet (True)
					internal_conditions.forth
				end
			end
		end

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create
		do
			Precursor (a_name.as_lower, a_location, a_target)
			initialize_conditions
		end

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
			initialize_conditions
			is_in_gac := True
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
			Result := classes /= Void and dotnet_classes /= Void
		end


	is_assembly: BOOLEAN is
			-- Is this an assembly?
		once
			Result := True
		end

	is_in_gac: BOOLEAN
			-- Is this assembly in gac?

	is_non_local_assembly: BOOLEAN
			-- Was this assembly only specified by gac information (i.e. no location was set)?

feature -- Access, stored in configuration file if location is empty

	location: CONF_FILE_LOCATION
			-- Assembly location.

	assembly_name: STRING
			-- Name of the assembly.

	assembly_version: STRING
			-- Version of the assembly.

	assembly_culture: STRING
			-- Culture of the assembly.

	assembly_public_key_token: STRING
			-- Public key of the assembly.

	is_readonly: BOOLEAN is True
			-- Assemblies are always read only.

feature -- Access, in compiled only

	dotnet_classes: HASH_TABLE [like class_type, STRING]
			-- Same as `classes' but indexed by the dotnet name.

	guid: STRING
			-- A unique id.

	consumed_path: STRING
			-- The path to the consumed assembly.

	dependencies: DS_HASH_SET [CONF_ASSEMBLY]
			-- Dependencies on other assemblies.

	date: INTEGER
			-- Date of last modification of the cached information.

feature -- Access queries

	accessible_groups: DS_HASH_SET [CONF_GROUP] is
			-- Groups that are accessible within `Current'.
			-- Dependencies if we have them, else nothing.
		do
			if accessible_groups_cache = Void then
				if dependencies /= Void then
					accessible_groups_cache := dependencies
				else
					create accessible_groups_cache.make (0)
				end
			end
			Result := accessible_groups_cache
		end

	accessible_classes: like classes is
			-- Classes that are accessible within `Current'.
		local
			l_groups: like accessible_groups
			l_grp: CONF_GROUP
		do
			Result := Precursor
			l_groups := accessible_groups
			from
				l_groups.start
			until
				l_groups.after
			loop
				l_grp := l_groups.item_for_iteration
				if l_grp.classes_set then
					Result.merge (l_grp.classes)
				end
				l_groups.forth
			end
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
		end

	class_by_dotnet_name (a_class: STRING; a_dependencies: BOOLEAN): ARRAYED_LIST [like class_type] is
			-- Get class by dotnet name.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			classes_set: classes_set
		local
			l_class: like class_type
			l_dep: CONF_ASSEMBLY
		do
			create Result.make (1)
			l_class := dotnet_classes.item (a_class)
			if l_class /= Void then
				Result.extend (l_class)
			end
			if a_dependencies and dependencies /= Void then
				from
					dependencies.start
				until
					dependencies.after
				loop
					l_dep := dependencies.item_for_iteration
					if l_dep.classes_set then
						Result.append (l_dep.class_by_dotnet_name (a_class, False))
					end
					dependencies.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION is
		once
				-- assemblies have no options
			create Result
		end

	sub_group_by_name (a_name: STRING): CONF_GROUP is
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

	set_is_in_gac (b: like is_in_gac) is
			-- Set `is_in_gac' to `b'.
		do
			is_in_gac := b
		ensure
			is_in_gac_set: is_in_gac = b
		end

	add_condition (a_condition: CONF_CONDITION) is
			-- Add `a_condition'.
		do
			Precursor (a_condition)
			initialize_conditions
		end

feature {CONF_ACCESS} -- Update, in compiled only

	set_target (a_target: like target) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

	set_dotnet_classes (a_classes: like dotnet_classes) is
			-- Set `dotnet_classes' to `a_classes'.
		require
			a_classes_not_void: a_classes /= Void
		do
			dotnet_classes := a_classes
		ensure
			dotnet_classes_set: dotnet_classes = a_classes
		end

	set_guid (a_guid: like guid) is
			-- Set `guid' to `a_guid'
		require
			a_guid_ok: a_guid /= Void and then not a_guid.is_empty
		do
			guid := a_guid
		ensure
			guid_set: guid = a_guid
		end

	set_consumed_path (a_path: STRING) is
			-- Set `consumed_path' to `a_path'.
		require
			a_path_not_void: a_path /= Void
		do
			consumed_path := a_path
		ensure
			consumed_path_set: consumed_path = a_path
		end

	add_dependency (an_assembly: CONF_ASSEMBLY) is
			-- Add a dependency on `an_assembly'.
		require
			an_assembly_not_void: an_assembly /= Void
		do
			if dependencies = Void then
				create dependencies.make_default
			end
			dependencies.force (an_assembly)
		end

	set_dependencies (a_dependencies: like dependencies) is
			-- Set `dependencies' to `a_dependencies'.
		do
			dependencies := a_dependencies
		end

	set_date (a_date: like date) is
			-- Set `date' to `a_date'.
		do
			date := a_date
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
					equal (assembly_public_key_token, other.assembly_public_key_token)
			end
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_assembly (Current)
		end

feature {NONE} -- Caches

	accessible_groups_cache: like accessible_groups

feature {NONE} -- Class type anchor

	class_type: CONF_CLASS;

invariant
	guid_set: classes_set implies guid /= Void and then not guid.is_empty
	consumed_path_set: classes_set implies consumed_path /= Void and then not consumed_path.is_empty

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
