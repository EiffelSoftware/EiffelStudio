indexing
	description: "[
					Matches Eiffel and .NET type names.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_TYPE_CACHE

inherit
	ECD_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ECD_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

create
	default_create

feature -- Access

	generated_type (a_type_name: STRING): ECD_GENERATED_TYPE is
			-- Generated type with name `a_type_name'
		require
			non_void_type_name: a_type_name /= Void
			valid_type_name: not a_type_name.is_empty
		do
			Generated_types.search (a_type_name)
			if Generated_types.found then
				Result := Generated_types.found_item
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Non_generated_type, [a_type_name, "generated_type", "type cache"])
			end
		end
		
	type (a_type_name: STRING): ECD_TYPE is
			-- Type with name `a_type_name'
		require
			non_void_type_name: a_type_name /= Void
			valid_type_name: not a_type_name.is_empty
		do
			Types.search (a_type_name)
			if Types.found then
				Result := Types.found_item
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_type, [a_type_name])
			end
		end
		
	eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- Eiffel type name corresponding to `a_dotnet_type_name'
			-- ex : System.Boolean -> BOOLEAN
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_namee: not a_dotnet_type_name.is_empty
		local
			l_type: TYPE
			l_external_type: ECD_EXTERNAL_TYPE
			l_cache_reflection: CACHE_REFLECTION
		do
			if Generated_types.has (a_dotnet_type_name) then
				Result := (create {NAME_FORMATTER}).full_formatted_type_name (a_dotnet_type_name)
			else
				if Types.has (a_dotnet_type_name) then
					l_external_type ?= Types.item (a_dotnet_type_name)
					if l_external_type /= Void then
						l_type := l_external_type.type
						create l_cache_reflection.make (Clr_version)
						Result := l_cache_reflection.type_name (l_type)
						if Result = Void or else Result.is_empty then
							Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_consumed_type, [a_dotnet_type_name])
							Result := a_dotnet_type_name
						end
						if not Result.is_empty then
							Result.prepend (assembly_of_type (a_dotnet_type_name).assembly_prefix)
						end
					else
						Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Non_external_type, [a_dotnet_type_name])
						Result := a_dotnet_type_name
					end
				else
					Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_type, [a_dotnet_type_name])
					Result := a_dotnet_type_name
				end
			end
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

feature -- Status Repport

	is_generated_type (a_type_name: STRING): BOOLEAN is
			-- Is type `a_type_name' declared in Codedom tree?
		require
			non_void_type_name: a_type_name /= Void
			valid_type_name: not a_type_name.is_empty
		do
			Result := Generated_types.has (a_type_name) 
		end

feature -- Basics Operations

	update_generated_type (a_generated_type: ECD_GENERATED_TYPE) is
			-- Add `a_generated_type' to `Generated_types' and `Types'.
		require
			non_void_generated_type: a_generated_type /= Void 
		do
			Generated_types.force (a_generated_type, a_generated_type.name)
			Types.force (a_generated_type, a_generated_type.name)
		ensure
			a_generated_type_set: generated_types.has_item (a_generated_type)
		end

	add_generated_type (a_generated_type_name: STRING) is
			-- Add `a_generated_type_name' to `generated_types'.
		require
			non_void_generated_type_name: a_generated_type_name /= Void
			not_empty_a_generated_type_name: not a_generated_type_name.is_empty
		local
			a_generated_type: ECD_GENERATED_TYPE
		do
			if not generated_types.has (a_generated_type_name) then
				create a_generated_type.make
				a_generated_type.set_name (a_generated_type_name)
				generated_types.put (a_generated_type, a_generated_type_name)
				Types.put (a_generated_type, a_generated_type.name)
			end
		ensure
			generated_types_set: generated_types.has (a_generated_type_name)
		end
	
	add_external_type (a_type_name: STRING) is
			-- Add `an_external_type_name' to `types'.
		require
			non_void_type_name: a_type_name /= Void
			valid_type_name: not a_type_name.is_empty
			external_type: not is_generated_type (a_type_name)
		local
			l_type: ECD_EXTERNAL_TYPE
		do
			if not Types.has (a_type_name) then
				create l_type.make
				l_type.set_name (a_type_name)
				Types.put (l_type, l_type.name)
			end
		ensure
			type_added: types.has (a_type_name)
		end

feature {NONE} -- Implementation

	assembly_of_type (a_dotnet_type_name: STRING): ECD_REFERENCED_ASSEMBLY is
 			-- Return assembly in witch is `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			l_ref_ass: ECD_REFERENCED_ASSEMBLIES
			l_assembly: ECD_REFERENCED_ASSEMBLY
		do
			if not is_generated_type (a_dotnet_type_name) then
				create l_ref_ass
				from
					l_ref_ass.Referenced_assemblies.start
				until
					l_ref_ass.Referenced_assemblies.after or Result /= Void
				loop
					l_assembly := l_ref_ass.Referenced_assemblies.item
					if l_assembly.assembly.get_type_string (a_dotnet_type_name) /= Void then
						Result := l_assembly
					end
					l_ref_ass.Referenced_assemblies.forth
				end
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.No_assembly, [a_dotnet_type_name])
			end
		ensure
			non_void_assembly: Result /= Void
		end

feature {NONE} -- Private access

	Generated_types: HASH_TABLE [ECD_GENERATED_TYPE, STRING] is
			-- Types declared in Codedom tree
			-- Value: `ECD_GENERATED_TYPE'
			-- Key: .NET type name
		once
			create Result.make (128)
		ensure
			non_void_result: Result /= Void
		end

	Types: HASH_TABLE [ECD_TYPE, STRING] is
			-- All types in Codedom tree
			-- Value: dynamically `ECD_TYPE'
			-- Key: .NET type name
		once
			create Result.make (128)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECD_TYPE_CACHE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------