indexing
	description: "[
					Matches Eiffel and .NET type names.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_CACHE

inherit
	CODE_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_REFERENCED_ASSEMBLIES
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_CONTEXT
		export
			{NONE} all
		end

create
	default_create

feature -- Access

	found_type: CODE_TYPE
			-- Last type found with `search'

	found_generated_type: CODE_GENERATED_TYPE
			-- Last generated type found with `search'

feature -- Status Repport

	has (a_type: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is type `a_type' in cache?
		do
			Result := Types.has (a_type.full_name)
		end
		
	is_generated (a_type: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is type `a_type_name' declared in Codedom tree?
		require
			non_void_type: a_type /= Void
		do
			Result := Generated_types.has (a_type.full_name)
		end

	found: BOOLEAN
			-- Was last call to `search' successful?

	found_generated: BOOLEAN
			-- Did last search yield a generated type?

feature -- Basics Operations

	search (a_type: CODE_TYPE_REFERENCE) is
			-- Search for type `a_type' in caches.
			-- Set `found', `found_generated', `found_type' and `found_generated_type' accordingly.
		require
			non_void_type: a_type /= Void
		do
			Generated_types.search (a_type.full_name)
			found_generated := Generated_types.found
			if found_generated then
				found := True
				found_type := Generated_types.found_item
				found_generated_type := Generated_types.found_item
			else
				Types.search (a_type.full_name)
				found := Types.found
				if found then
					found_type := Types.found_item
				end
			end
		end

feature -- Element Settings

	add_generated_type (a_type: CODE_TYPE_REFERENCE) is
			-- Add `a_type' to `generated_types'.
		require
			non_void_generated_type: a_type /= Void
		local
			a_generated_type: CODE_GENERATED_TYPE
		do
			create a_generated_type.make (a_type)
			Generated_types.force (a_generated_type, a_type.full_name)
			Types.force (a_generated_type, a_type.full_name)
			if Types.found then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Type_in_cache, [a_type.full_name])
			end
		ensure
			generated_types_set: generated_types.has (a_type.full_name)
		end
	
	add_external_type (a_type: CODE_TYPE_REFERENCE) is
			-- Add `an_external_type_name' to `types'.
		require
			non_void_type: a_type /= Void
		local
			l_dotnet_type: TYPE
		do
			l_dotnet_type := a_type.dotnet_type
			if l_dotnet_type /= Void then
				Types.force (create {CODE_EXTERNAL_TYPE}.make (a_type), a_type.full_name)
				if Types.found then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Type_in_cache, [a_type.full_name])
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_type, [a_type.full_name])
			end
		end

feature {NONE} -- Private access

	Generated_types: HASH_TABLE [CODE_GENERATED_TYPE, STRING] is
			-- Types declared in Codedom tree
			-- Value: `CODE_GENERATED_TYPE'
			-- Key: .NET full type name
		once
			create Result.make (128)
			Result.compare_objects
		ensure
			non_void_generated_types: Result /= Void
		end

	Types: HASH_TABLE [CODE_TYPE, STRING] is
			-- All types referenced by Codedom tree
			-- Value: dynamically `CODE_TYPE'
			-- Key: .NET full type name
		once
			create Result.make (128)
			Result.compare_objects
		ensure
			non_void_types: Result /= Void
		end

invariant
	non_void_types: Types /= Void
	non_void_types: Generated_types /= Void
	found_type_if_found: found implies found_type /= Void
	found_generated: found_generated implies found_generated_type /= Void
	found_generated_iff_found: (found_generated implies found) and (not found implies not found_generated)

end -- class CODE_TYPE_CACHE

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