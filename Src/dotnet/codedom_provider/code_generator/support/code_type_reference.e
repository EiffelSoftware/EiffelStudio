indexing
	description: "Type reference in CodeDom, need to distinguish from `CODE_TYPE' because:%
					% * Can be an array (a CODE_GENERATED_TYPE cannot be an array)%
					% * Does not have code associated to it"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_REFERENCE

inherit
	CODE_REFERENCED_ASSEMBLIES
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
		ensure
			name_set: name = a_name
		end
	
feature -- Access

	name: STRING
			-- .NET simple name
	
	namespace: STRING
			-- .NET namespace
	
	full_name: STRING
			-- .NET full name

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
					else
						Result := Name_formatter.full_formatted_type_name (full_name)
					end
				end
				internal_eiffel_name := Result
			else
				Result := internal_eiffel_name
			end
		ensure
			non_void_eiffel_name: Result /= Void
		end

	dotnet_type: TYPE is
			-- Corresponding .NET type instance if any
			-- Log error if not found.
		require
			non_generated_type: not Resolver.is_generated (Current)
		do
			if search_for_type then
				Result := feature {TYPE}.get_type (full_name)
				if Result = Void then
					from
						referenced_assemblies.start
					until
						referenced_assemblies.after or internal_type /= Void
					loop
						Result := referenced_assemblies.item.assembly.get_type (full_name)
						referenced_assemblies.forth
					end
				end
				if Result = Void then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_type, [full_name])
				else
					internal_type := Result
				end
				search_for_type := False
			else
				Result := internal_type
			end
		ensure
			valid_type: Result /= Void implies Result.full_name.equals (full_name.to_cil)
			search_done: search_for_type = False
		end
	
	element_type: CODE_TYPE_REFERENCE is
			-- Reference to type of array elements if any
		require
			non_generated_type: not Resolver.is_generated (Current)
		local
			l_type: TYPE
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

	member_from_name (a_name: STRING): CODE_MEMBER_REFERENCE is
			-- Reference to .NET member with .NET name `a_name'.
		require
			non_void_name: a_name /= void
			external_type: not Resolver.is_generated (Current)
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			members_cache.search (a_name)
			if members_cache.found then
				if members_cache.found_item.count > 1 then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Ambiguous_match, [a_name, Current.eiffel_name + " (" + Current.full_name + ")"])
				end
				Result := members_cache.found_item.first
			else
				l_features := Metadata_provider.features (a_name, dotnet_type)
				if l_features /= Void then
					if l_features.count > 1 then
						Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Ambiguous_match, [a_name, Current.eiffel_name + " (" + Current.full_name + ")"])
					end
					Result := l_features.first
					members_cache.put (l_features, a_name)
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature, [a_name, Current.eiffel_name + " (" + Current.full_name + ")"])
					Result := Empty_member_reference
				end
			end
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
			Result := member (a_feature.name, l_code_arguments, a_feature.is_redefined)
		end
		
	member (a_name: STRING; a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]; a_is_redefined: BOOLEAN): CODE_MEMBER_REFERENCE is
			-- Reference to member with .NET name `a_name', arguments `a_arguments' and `is_redefined' with `a_is_redefined'.
		require
			non_void_name: a_name /= void
		local
			l_members, l_list: LIST [CODE_MEMBER_REFERENCE]
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_no_match: BOOLEAN
		do
			members_cache.search (a_name)
			if members_cache.found then
				l_members := members_cache.found_item
				if l_members.count = 1 then
					Result := l_members.item
				else
					from
						l_members.start
					until
						l_members.after or Result /= Void
					loop
						l_arguments := l_members.item.arguments
						if l_arguments = Void and a_arguments = Void then
							Result := l_members.item
						else
							if l_arguments /= Void and a_arguments /= Void and then l_arguments.count = a_arguments.count then
								from
									l_arguments.start
									a_arguments.start
								until
									l_arguments.after or l_no_match
								loop
									l_no_match := not a_arguments.item.variable.type.is_equal (l_arguments.item.type)
									a_arguments.forth
									l_arguments.forth
								end
								if not l_no_match then
									Result := l_members.item
								end
							end
						end
						l_members.forth
					end
					if Result = Void then
	 					create Result.make (a_name, a_arguments, Current, a_is_redefined)
	 					l_members.extend (Result)
					end
				end
			else
				create Result.make (a_name, a_arguments, Current, a_is_redefined)
				create {ARRAYED_LIST [CODE_MEMBER_REFERENCE]} l_list.make (1)
				l_list.extend (Result)
				members_cache.put (l_list, a_name)
			end
		end

feature -- Comparison

	is_equal (a_other: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := full_name.is_equal (a_other.full_name)
		ensure then
			definition: Result implies full_name.is_equal (a_other.full_name)
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

feature {NONE} -- Private Access

	search_for_type: BOOLEAN
			-- Should call to `type' trigger a search?
			
	search_for_element_type: BOOLEAN
			-- Should call to `element_type' trigger a search?

	internal_eiffel_name: STRING
			-- Cached Eiffel name

	internal_type: TYPE
			-- Cached type instance

	internal_element_type: CODE_TYPE_REFERENCE
			-- Cached element type

	members_cache: HASH_TABLE [LIST [CODE_MEMBER_REFERENCE], STRING] is
			-- Members cache
			-- Key is member .NET name
			-- Value is list of corresponding members
		once
			create Result.make (8)
		end
		
invariant
	non_void_name: name /= Void
	non_void_namespace: namespace /= Void
	non_void_full_name: full_name /= Void
	non_void_eiffel_name: eiffel_name /= Void
	generated_if_not_external: dotnet_type = Void implies Resolver.is_generated (Current)
	no_type_search_if_found: dotnet_type /= Void implies search_for_type = False
	void_type_if_search_type: search_for_type implies dotnet_type = Void
	no_element_type_search_if_found: element_type /= Void implies search_for_element_type = False
	void_element_type_if_search_type: search_for_element_type implies element_type = Void	

end -- class CODE_TYPE_REFERENCE

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