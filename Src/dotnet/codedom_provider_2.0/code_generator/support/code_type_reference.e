indexing
	description: "Type reference in CodeDom, need to distinguish from `CODE_TYPE' because:%
					% * Can be an array (a CODE_GENERATED_TYPE cannot be an array)%
					% * Does not have code associated to it"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_REFERENCE

inherit
	CODE_SHARED_IMPORTS
		export
			{NONE} all
		redefine
			is_equal
		end

	CODE_SHARED_GENERATION_HELPERS
		redefine
			is_equal
		end

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		redefine
			is_equal
		end

	CODE_SHARED_EIFFEL_METADATA_PROVIDER
		export
			{NONE} all
		redefine
			is_equal
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		redefine
			is_equal
		end
	
	CODE_SHARED_EMPTY_ENTITIES
		export
			{NONE} all
		redefine
			is_equal
		end

create {CODE_TYPE_REFERENCE_FACTORY}
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize instance.
		require
			non_void_name: a_name /= Void
		do
			name := a_name
			create members_cache.make (8)
			search_for_members := True
		ensure
			name_set: name = a_name
		end
	
feature -- Access

	name: STRING
			-- .NET simple name
	
	namespace: STRING is
			-- .NET namespace
		do
			Result := name.substring (1, name.last_index_of ('.', name.count) - 1)
		end
	
	eiffel_name: STRING is
			-- Eiffel name
		local
			l_element_type_name: STRING
		do
			if internal_eiffel_name = Void then
				if element_type /= Void then
					l_element_type_name := element_type.eiffel_name
					create Result.make (l_element_type_name.count + 15)
					Result.append ("NATIVE_ARRAY [")
					Result.append (l_element_type_name)
					Result.append_character (']')
				else
					Resolver.search (Current)
					if Resolver.found then
						Result := Resolver.found_type.eiffel_name
					elseif dotnet_type /= Void then
						-- Not a generated type
						Result := Metadata_provider.type_eiffel_name (dotnet_type)
						if Result = Void then
							Result := Name_formatter.full_formatted_type_name (name)
						end
					else
						-- Type hasn't been generated yet, give it its Eiffel name
						Result := Name_formatter.full_formatted_type_name (name)
					end
				end
				internal_eiffel_name := Result
			else
				Result := internal_eiffel_name
			end
		ensure
			non_void_eiffel_name: Result /= Void
		end

	dotnet_type: SYSTEM_TYPE is
			-- Corresponding .NET type instance if any
			-- Log error if not found.
		require
			non_generated_type: not Resolver.is_generated (Current)
		do
			if search_for_type then
				-- Do not search for type if `element_type' calls `dotnet_type'
				search_for_type := False
				if is_custom_attribute_type then
					search_attribute_type (name)
				else
					search_type (name)
				end
				if found then
					Result := found_type
				else
					-- Maybe it's an array?
					if element_type /= Void then
						-- Special case for arrays of generated types:
						-- They are external types but cannot be retrieved through `get_type'.
						Result := {SYSTEM_TYPE}.get_type ("System.Object[]")
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_type, [name])
					end
				end

				internal_type := Result
			else
				Result := internal_type
			end
		ensure
			valid_type: Result /= Void implies Result.full_name.equals (name.to_cil)
			search_done: search_for_type = False
		end
	
	element_type: CODE_TYPE_REFERENCE is
			-- Reference to type of array elements if any
		require
			non_generated_type: not Resolver.is_generated (Current)
		local
			l_type: SYSTEM_TYPE
		do
			if search_for_element_type then
				if dotnet_type /= Void then
					l_type := dotnet_type.get_element_type
					if l_type /= Void then				
						Result := Type_reference_factory.type_reference_from_type (l_type)
					end
				end
				search_for_element_type := False
				internal_element_type := Result
			else
				Result := internal_element_type
			end
		ensure
			search_done: search_for_element_type = False
		end

	member_from_code (a_feature: CODE_FEATURE): CODE_MEMBER_REFERENCE is
			-- Reference to generated member `a_feature'.
		local
			l_routine: CODE_ROUTINE
			l_code_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
		do
			l_routine ?= a_feature
			if l_routine /= Void then
				l_code_arguments := l_routine.arguments
			end
			Result := member (a_feature.name, l_code_arguments)
		end
		
	member (a_name: STRING; a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]): CODE_MEMBER_REFERENCE is
			-- Reference to member with .NET name `a_name', arguments `a_arguments' and `is_redefined' with `a_is_redefined'.
		require
			non_void_name: a_name /= void
		local
			l_members: LIST [CODE_MEMBER_REFERENCE]
			l_member, l_uninitialized_member: CODE_MEMBER_REFERENCE
			l_parents: HASH_TABLE [CODE_PARENT, STRING]
		do
			Resolver.search (Current)
			if Resolver.found then
				members_cache.search (a_name)
				if members_cache.found then
					l_members := members_cache.found_item
					from
						l_members.start
					until
						l_members.after or Result /= Void
					loop
						l_member := l_members.item
						if l_member.is_initialized then
							if l_member.has_arguments (a_arguments) then
								Result := l_member
							end
						else
							l_uninitialized_member := l_member
						end
						l_members.forth
					end
					-- We did not find an initialized member with the corresponding arguments so
					-- if there is an uninitialized member then we initialize it with the arguments.
					if Result = Void and l_uninitialized_member /= Void then
						l_uninitialized_member.set_arguments (a_arguments)
						l_uninitialized_member.set_initialized
						Result := l_uninitialized_member
					end
				else
					-- Look in parents
					l_parents := Resolver.found_type.parents
					from
						l_parents.start
					until
						l_parents.after or Result /= Void
					loop
						Result := l_parents.item_for_iteration.type.member (a_name, a_arguments)
						l_parents.forth
					end
				end
			else
				Result := dotnet_member (a_name, a_arguments)
			end
		end

	member_from_name (a_name: STRING): CODE_MEMBER_REFERENCE is
			-- Member with name `a_name'
			-- Log warning if multiple matches found.
		require
			non_void_name: a_name /= Void
		local
			l_features: HASH_TABLE [LIST [CODE_FEATURE], STRING]
			l_parents: HASH_TABLE [CODE_PARENT, STRING]
		do
			Resolver.search (Current)
			if Resolver.found then
				l_features := Resolver.found_type.dotnet_features
				l_features.search (a_name)
				if l_features.found then
					if l_features.found_item.count > 1 then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.ambiguous_match, [a_name, name])
					end
					Result := member_from_code (l_features.found_item.first)
				else
					l_parents := Resolver.found_type.parents
					from
						l_parents.start
					until
						l_parents.after or Result /= Void
					loop
						Result := l_parents.item_for_iteration.type.member_from_name (a_name)
						l_parents.forth
					end
				end
				if Result = Void then
						-- Probably a snippet feature
					create Result.make_external (a_name, a_name, Void, Current)
				end
			else
				Result := dotnet_member_from_name (a_name)
			end
		end
	
	members: LIST [LIST [CODE_MEMBER_REFERENCE]] is
			-- All members of dotnet type
			-- Ordered by .NET name
		require
			is_external: dotnet_type /= Void
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			if search_for_members then
				l_features := Metadata_provider.all_features (dotnet_type)
				if l_features /= Void then
					from
						l_features.start
					until
						l_features.after
					loop
						add_member (l_features.item)
						l_features.forth
					end
				end
				search_for_members := False
			end
			Result := members_cache.linear_representation
		ensure
			members_searched: not search_for_members
			non_void_list: Result /= Void
			-- valid_ordering: all list items of a list item of result have the same .NET name
		end

	is_custom_attribute_type: BOOLEAN
			-- Is type for a custom attribute?
			--| Changes how .NET type is resolved

feature -- Status Report

	initialized: BOOLEAN
			-- Is instance initialized?
			--| Useful for invariant coding

	has_member (a_name: STRING; a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]): BOOLEAN is
			-- Does `members_cache' contain member with name `a_name' and arguments `a_arguments'?
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_name)
			if members_cache.found then
				l_features := members_cache.found_item
				from
					l_features.start
				until
					l_features.after or Result
				loop
					Result := l_features.item.has_arguments (a_arguments)
					l_features.forth
				end
			end
		end

feature -- Element Settings 

	set_initialized (a_value: like initialized) is
			-- Set `initialized' to `a_value'.
		do
			initialized := a_value
		ensure
			initialized_set: initialized = a_value
		end

	set_custom_attribute_type is
			-- Set `is_custom_attribute_type' to `True'.
		do
			is_custom_attribute_type := True
		ensure
			is_custom_attribute_type: is_custom_attribute_type
		end

feature -- Comparison

	is_equal (a_other: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := name.is_equal (a_other.name)
		ensure then
			definition: Result implies name.is_equal (a_other.name)
		end

feature {CODE_TYPE_REFERENCE_FACTORY} -- Elements Settings

	set_eiffel_name (a_eiffel_name: like eiffel_name) is
			-- Set `eiffel_name' with `a_eiffel_name'.
		require
			non_void_eiffel_name: a_eiffel_name /= Void
		do
			internal_eiffel_name := a_eiffel_name
		ensure
			name_set: eiffel_name = a_eiffel_name
		end
	
	set_dotnet_type (a_type: like dotnet_type) is
			-- Set `dotnet_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			internal_type := a_type
		ensure
			type_set: dotnet_type = a_type
		end
		
	set_element_type (a_element_type: like element_type) is
			-- Set `element_type' with `a_element_type'.
		require
			non_void_element_type: a_element_type /= Void
		do
			internal_element_type := a_element_type
		ensure
			element_type_set: element_type = a_element_type
		end

	set_search_for_type (a_search_for_type: like search_for_type) is
			-- Set `search_for_type' with `a_search_for_type'.
		do
			search_for_type := a_search_for_type
		ensure
			search_for_type_set: search_for_type = a_search_for_type
		end
	
	set_search_for_element_type (a_search_for_element_type: like search_for_element_type) is
			-- Set `search_for_element_type' with `a_search_for_element_type'.
		do
			search_for_element_type := a_search_for_element_type
		ensure
			search_for_element_type_set: search_for_element_type = a_search_for_element_type
		end

feature {CODE_TYPE_REFERENCE_FACTORY, CODE_STOCK_TYPE_REFERENCES} -- Elements Settings

	add_member (a_member: CODE_MEMBER_REFERENCE) is
			-- Add `a_member' to members cache.
		require
			non_void_member: a_member /= Void
		local
			l_list: ARRAYED_LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_member.name)
			if members_cache.found then
				members_cache.found_item.extend (a_member)
			else
				create l_list.make (1)
				l_list.extend (a_member)
				members_cache.put (l_list, a_member.name)
			end
		end

feature {NONE} -- Implementation

	dotnet_member (a_name: STRING; a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]): CODE_MEMBER_REFERENCE is
			-- Member with name `a_name' and arguments `a_arguments'
		require
			is_external: not Resolver.is_generated (Current)
			non_void_name: a_name /= Void
		local
			l_native_arguments: NATIVE_ARRAY [SYSTEM_TYPE]
			l_list: LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_name)
			if members_cache.found then
				l_list := members_cache.found_item
				from
					l_list.start
				until
					l_list.after or Result /= Void
				loop
					if l_list.item /= Void then
						if a_arguments = Void and l_list.item.arguments = Void then
							Result := l_list.item
						elseif l_list.item.has_arguments (a_arguments) then
							Result := l_list.item
						end
					end
					l_list.forth
				end
			end
			if Result = Void and dotnet_type /= Void then
				if a_arguments /= Void then
					from
						create l_native_arguments.make (a_arguments.count)
						a_arguments.start
					until
						a_arguments.after
					loop
						l_native_arguments.put (a_arguments.index - 1, a_arguments.item.variable.type.dotnet_type)
						a_arguments.forth
					end
				end
				Result := Metadata_provider.member (dotnet_type, a_name, l_native_arguments)
				if members_cache.found then
					l_list.extend (Result)
				else
					create {ARRAYED_LIST [CODE_MEMBER_REFERENCE]} l_list.make (1)
					l_list.extend (Result)
					members_cache.put (l_list, a_name)
				end
			end
		end

	dotnet_member_from_name (a_name: STRING): CODE_MEMBER_REFERENCE is
			-- Reference to .NET member with .NET name `a_name'
		require
			non_void_name: a_name /= void
			external_type: not Resolver.is_generated (Current)
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_name)
			if members_cache.found then
				if members_cache.found_item.count > 1 then
					event_manager.raise_event ({CODE_EVENTS_IDS}.ambiguous_match, [a_name, name])
				end
				Result := members_cache.found_item.first
			elseif dotnet_type /= Void then
				l_features := Metadata_provider.features (a_name, dotnet_type)
				if l_features /= Void and then l_features.count > 0 then
					if l_features.count > 1 then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Ambiguous_match, [a_name, name])
					end
					Result := l_features.first
					members_cache.put (l_features, a_name)
				end
			end
		end

	overloaded_member_from_name (a_name: STRING): CODE_MEMBER_REFERENCE is
			-- Reference to .NET member with .NET name `a_name'
			-- Overloaded name if member is overloaded
		require
			non_void_name: a_name /= void
			external_type: not Resolver.is_generated (Current)
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_name)
			if members_cache.found then
				if members_cache.found_item.count > 1 then
					event_manager.raise_event ({CODE_EVENTS_IDS}.ambiguous_match, [a_name, name])
				end
				Result := members_cache.found_item.first
			elseif dotnet_type /= Void then
				l_features := Metadata_provider.features (a_name, dotnet_type)
				if l_features /= Void and then l_features.count > 0 then
					if l_features.count > 1 then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Ambiguous_match, [a_name, name])
					end
					Result := l_features.first
					members_cache.put (l_features, a_name)
				end
			end
		end

feature {NONE} -- Private Access

	search_for_type: BOOLEAN
			-- Should call to `type' trigger a search?
			
	search_for_element_type: BOOLEAN
			-- Should call to `element_type' trigger a search?

	search_for_members: BOOLEAN
			-- Should call to `members' trigger a search?

	internal_eiffel_name: STRING
			-- Cached Eiffel name

	internal_type: SYSTEM_TYPE
			-- Cached type instance

	internal_element_type: CODE_TYPE_REFERENCE
			-- Cached element type

	members_cache: HASH_TABLE [LIST [CODE_MEMBER_REFERENCE], STRING]
			-- Members cache
			-- Key is member .NET name
			-- Value is list of corresponding members
	
invariant
	non_void_name: name /= Void
	non_void_namespace: initialized implies namespace /= Void
	non_void_eiffel_name: initialized implies eiffel_name /= Void
	non_void_members_cache: members_cache /= Void
	generated_if_not_external: initialized implies (dotnet_type = Void implies Resolver.is_generated (Current))
	no_type_search_if_found: initialized implies (dotnet_type /= Void implies search_for_type = False)
	void_type_if_search_type: initialized implies (search_for_type implies dotnet_type = Void)
	no_element_type_search_if_found: initialized implies (element_type /= Void implies search_for_element_type = False)
	void_element_type_if_search_type: initialized implies (search_for_element_type implies element_type = Void)

end -- class CODE_TYPE_REFERENCE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------