indexing
	description: "Objects that represent an included assembly"
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
			options,
			is_group_equivalent
		end

	CONF_FILE_DATE
		undefine
			is_equal
		end


create
	make,
	make_from_gac

feature {NONE} -- Initialization

	make (a_name: like name; a_location: like location; a_target: CONF_TARGET) is
			-- Create
		do
			Precursor (a_name, a_location, a_target)
			enable (pf_dotnet, build_all)
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
			enable (pf_dotnet, build_all)
			is_in_gac := True
			target := a_target
			set_name (a_name)
			assembly_name := an_assembly_name
			assembly_version := an_assembly_version
			assembly_culture := an_assembly_culture
			assembly_public_key_token := an_assembly_key
			create location.make_from_full_path ("", a_target)
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

feature -- Access, stored in configuration file if location is empty

	assembly_name: STRING
			-- Name of the assembly.

	assembly_version: STRING
			-- Version of the assembly.

	assembly_culture: STRING
			-- Culture of the assembly.

	assembly_public_key_token: STRING
			-- Public key of the assembly.

feature -- Access, in compiled only

	dotnet_classes: HASH_TABLE [like class_type, STRING]
			-- Same as `classes' but indexed by the dotnet name.

	guid: STRING
			-- A unique id.

	consumed_path: STRING
			-- The path to the consumed assembly.

	dependencies: LINKED_SET [CONF_ASSEMBLY]
			-- Dependencies on other assemblies.

	application_target: CONF_TARGET
			-- The application target.

	date: INTEGER
			-- Date of last modification of the cached information.

	is_modified: BOOLEAN
			-- Has the assembly been modified?

feature -- Access queries

	is_used_library: BOOLEAN is
			-- The application target.
			-- Access queries
		do
			Result := application_target /= target
		end

	class_by_name (a_class: STRING; a_dependencies: BOOLEAN; a_platform, a_build: INTEGER): LINKED_SET [like class_type] is
			-- Get class by name.
		local
			l_dep: CONF_ASSEMBLY
		do
			Result := Precursor (a_class, a_dependencies, a_platform, a_build)
			if a_dependencies and dependencies /= Void then
				from
					dependencies.start
				until
					dependencies.after
				loop
					l_dep := dependencies.item
					if l_dep.is_enabled (a_platform, a_build) then
						Result.append (l_dep.class_by_name (a_class, False, a_platform, a_build))
					end
					dependencies.forth
				end
			end
		end

	class_by_dotnet_name (a_class: STRING; a_dependencies: BOOLEAN; a_platform, a_build: INTEGER): ARRAYED_LIST [like class_type] is
			-- Get class by dotnet name.
		require
			a_class_ok: a_class /= Void and then not a_class.is_empty
			classes_set: classes_set
			a_platform_valid: valid_platform (a_platform)
			a_build_valid: valid_build (a_build)
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
					l_dep := dependencies.item
					if l_dep.is_enabled (a_platform, a_build) then
						Result.append (l_dep.class_by_dotnet_name (a_class, False, a_platform, a_build))
					end
					dependencies.forth
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	options: CONF_OPTION is
		local
			l_assemblies: HASH_TABLE [CONF_ASSEMBLY, STRING]
			l_assembly: CONF_ASSEMBLY
			l_uuid: STRING
			l_options: CONF_OPTION
		do
			if is_used_library then
				from
					l_uuid := guid
					l_assemblies := application_target.assemblies
					l_assemblies.start
				until
					l_options /= Void or l_assemblies.after
				loop
					l_assembly := l_assemblies.item_for_iteration
					if l_assembly.guid = l_uuid then
						l_options := l_assembly.options
					end
					l_assemblies.forth
				end
				if l_options /= Void then
					Result := l_options
				else
					Result := application_target.options
				end
			else
				if internal_options /= Void then
					Result := internal_options
				else
					create Result
				end

				Result.merge (target.options)
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
				create dependencies.make
			end
			dependencies.force (an_assembly)
		end

	set_dependencies (a_dependencies: like dependencies) is
			-- Set `dependencies' to `a_dependencies'.
		do
			dependencies := a_dependencies
		end

	set_application_target (a_target: CONF_TARGET) is
			-- Set `application_target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
		do
			application_target := a_target
		ensure
			application_target_set: application_target = a_target
		end

	set_date (a_date: like date) is
			-- Set `date' to `a_date'.
		do
			date := a_date
		end


	check_changed is
			-- Check if the cached information of the assembly have changed.
		require
			consumed_path_ok: consumed_path /= void and then not consumed_path.is_empty
		local
			l_str: ANY
			l_date: INTEGER
		do
			l_str := consumed_path.to_c
			eif_date ($l_str, $l_date)
			if date /= l_date then
				date := l_date
				is_modified := True
			else
				is_modified := False
			end
		end

feature -- Equality

	is_group_equivalent (other: like Current): BOOLEAN is
			-- Is `other' and `Current' the same with respect to the group layout?
		do
			Result := Precursor (other) and then equal (assembly_name, other.assembly_name) and then
					equal (assembly_version, other.assembly_version) and then
					equal (assembly_culture, other.assembly_culture) and then
					equal (assembly_public_key_token, other.assembly_public_key_token)
		end

feature -- Visit

	process (a_visitor: CONF_VISITOR) is
			-- Process `a_visitor'.
		do
			Precursor (a_visitor)
			a_visitor.process_assembly (Current)
		end

feature {NONE} -- Class type anchor

	class_type: CONF_CLASS

end
