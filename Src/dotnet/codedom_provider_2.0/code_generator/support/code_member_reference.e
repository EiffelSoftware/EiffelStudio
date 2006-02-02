indexing
	description: "Member reference in CodeDom, need to distinguish from `CODE_MEMBER' because:%
					% * Does not have code associated to it%
					% * Corresponding CODE_MEMBER might not be initialized yet"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_MEMBER_REFERENCE

inherit
	CODE_SHARED_GENERATION_HELPERS

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_EIFFEL_METADATA_PROVIDER
		export
			{NONE} all
		end

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_STATE

create {CODE_TYPE_REFERENCE_FACTORY, CODE_STOCK_TYPE_REFERENCES}
	make

create {CODE_EIFFEL_METADATA_PROVIDER, CODE_TYPE_REFERENCE}
	make_external

feature {NONE} -- Initialization

	make (a_dotnet_name: like name; a_implementing_type: like implementing_type; a_is_redefined: like is_redefined) is
			-- Initialize instance.
		require
			non_void_name: a_dotnet_name /= Void
			valid_name: not a_dotnet_name.is_empty
			non_void_implementing_type: a_implementing_type /= Void
		do
			name := a_dotnet_name
			implementing_type := a_implementing_type
			is_redefined := a_is_redefined
			search_for_parent := a_is_redefined
		ensure
			name_set: name = a_dotnet_name
			implementing_type_set: implementing_type = a_implementing_type
			is_redefined_set: is_redefined = a_is_redefined
		end

	make_external (a_dotnet_name, a_eiffel_name: like name; a_arguments: like arguments; a_implementing_type: like implementing_type) is
			-- Initialize instance.
		require
			non_void_name: a_dotnet_name /= Void
			valid_name: not a_dotnet_name.is_empty
			non_void_eiffel_name: a_eiffel_name /= Void
			valid_eiffel_name: not a_eiffel_name.is_empty
			non_void_implementing_type: a_implementing_type /= Void
		do
			name := a_dotnet_name
			implementing_type := a_implementing_type
			internal_eiffel_name := a_eiffel_name
			arguments := a_arguments
			is_initialized := True
		ensure
			name_set: name = a_dotnet_name
			implementing_type_set: implementing_type = a_implementing_type
				eiffel_name_set: eiffel_name = a_eiffel_name
			arguments_set: arguments = a_arguments
		end
		
feature -- Access

	is_initialized: BOOLEAN
			-- Is instance fully initialized (i.e. are arguments set?)?

	is_redefined: BOOLEAN
			-- Is member a redefinition?

	name: STRING
			-- .NET simple name
	
	implementing_type: CODE_TYPE_REFERENCE
			-- Implementing type
	
	arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			-- Routine arguments

	parent: CODE_MEMBER_REFERENCE is
			-- Parent feature
			-- Log error if not found.
		require
			is_redefined: is_redefined
			initialized: is_initialized
			not_external: Resolver.is_generated (implementing_type)
		do
			if search_for_parent then
				search_for_parent := False
				internal_parent := parent_in_type (implementing_type)
				if internal_parent = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_parent, [name + " from " + implementing_type.name])
				end
			end
			Result := internal_parent
		end
	
	overloaded_eiffel_name: STRING is
			-- Overloaded eiffel name
		require
			is_external: not Resolver.is_generated (implementing_type)
		local
			l_type: SYSTEM_TYPE
		do
			l_type := implementing_type.dotnet_type
			if l_type /= Void then
				Result := Metadata_provider.feature_overloaded_eiffel_name (name, l_type)
			end
			if Result = Void then
				Result := Name_formatter.formatted_feature_name (name)
			end
		end
		
	eiffel_name: STRING is
			-- Eiffel name
		require
			initialized: is_initialized
		local
			l_type: SYSTEM_TYPE
		do
			if internal_eiffel_name = Void then
				if Resolver.is_generated (implementing_type) then
					if is_redefined and then parent /= Void then
						Result := parent.eiffel_name
					else
						Result := Name_formatter.valid_variable_name (name)
					end
				else
					l_type := implementing_type.dotnet_type
					if l_type /= Void then
						Result := Metadata_provider.feature_eiffel_name (name, native_arguments, l_type)
					end
					if Result = Void then
						Result := Name_formatter.valid_variable_name (name)
					end
				end
				internal_eiffel_name := Result.as_lower
			else
				Result := internal_eiffel_name
			end
		ensure
			non_void_eiffel_name: Result /= Void
		end

	result_type: CODE_TYPE_REFERENCE is
			-- Return type if any
			-- This should be called after the feature has been added to the
			-- generated type if not an external routine.
		require
			initialized: is_initialized
		local
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_type: SYSTEM_TYPE
		do
			if internal_result_type = Void then
				Resolver.search (implementing_type)
				if Resolver.found then
					l_features := Resolver.found_type.features
					l_features.search (eiffel_name)
					if l_features.found then
						Result := l_features.found_item.result_type
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [name, Resolver.found_type.name])
						Result := None_type_reference
					end
				else
					l_type := implementing_type.dotnet_type
					if l_type /= Void then
						Result := Metadata_provider.feature_type (name, native_arguments, l_type)
					else
						Result := None_type_reference
					end
				end
				internal_result_type := Result
			else
				Result := internal_result_type
			end
		end

	parent_type_with_homonym: CODE_TYPE_REFERENCE
			-- Type with homonym feature
			-- Set by `hierarchy_has_name'.

feature -- Status Report

	has_arguments (a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]): BOOLEAN is
			-- Does member have arguments `a_arguments'?
		require
			initialized: is_initialized
		local
			l_stop: BOOLEAN
		do
			if arguments = Void then
				Result := a_arguments = Void or else a_arguments.count = 0
			else
				Result := a_arguments = arguments
				if not Result then
					if a_arguments = Void then
						Result := arguments.count = 0
					elseif arguments.count = a_arguments.count then
						from
							arguments.start
							a_arguments.start
						until
							a_arguments.after or l_stop
						loop
							l_stop := not arguments.item.variable.type.is_equal (a_arguments.item.variable.type)
							a_arguments.forth				
							arguments.forth
						end
						Result := not l_stop
					end
				end
			end
		end

feature -- Element Settings

	add_argument (a_argument: CODE_PARAMETER_DECLARATION_EXPRESSION) is
			-- Add `a_argument' to list of arguments
		require
			not_initialized: not is_initialized
			non_void_argument: a_argument /= Void
		do
			if arguments = Void then
				create {ARRAYED_LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]} arguments.make (4)
			end
			arguments.extend (a_argument)
		ensure
			argument_added: arguments.has (a_argument)
		end
	
	set_arguments (a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]) is
			-- Set `arguments' with `a_arguments'.
		require
			not_initialized: not is_initialized
		do
			arguments := a_arguments
		ensure
			arguments_set: arguments = a_arguments
		end
	
	set_initialized is
			-- Set `is_initialized' to True.
		require
			not_initialized: not is_initialized
		do
			is_initialized := True
		ensure
			initialized: is_initialized
		end
		
feature {NONE} -- Implementation

	parent_in_type (a_type: CODE_TYPE_REFERENCE): CODE_MEMBER_REFERENCE is
			-- Parent in type `a_type'
			--| Do not use `eiffel_name' as `eiffel_name' uses `parent_in_type'.
		require
			non_void_type: a_type /= Void
			initialized: is_initialized
		local
			l_features: HASH_TABLE [LIST [CODE_FEATURE], STRING]
			l_found_features: LIST [CODE_FEATURE]
			l_type: SYSTEM_TYPE
			l_parents: HASH_TABLE [CODE_PARENT, STRING]
			l_parent_type: CODE_TYPE_REFERENCE
		do
			Resolver.search (a_type)
			if Resolver.found then
				l_parents := Resolver.found_type.parents
				from
					l_parents.start
				until
					l_parents.after or Result /= Void
				loop
					l_parent_type := l_parents.item_for_iteration.type
					Resolver.search (l_parent_type)
					if Resolver.found then
						l_features := Resolver.found_type.dotnet_features
						l_features.search (name)
						if l_features.found then
							l_found_features := l_features.found_item
							from
								l_found_features.start
							until
								l_found_features.after or Result /= Void
							loop
								if same_arguments (l_found_features.item) then
									Result := l_parent_type.member_from_code (l_found_features.item)
								end
								l_found_features.forth
							end
						end
						if Result = Void then
							l_parents := Resolver.found_type.parents
							from
								l_parents.start
							until
								l_parents.after or Result /= Void
							loop
								Result := parent_in_type (l_parents.item_for_iteration.type)
								l_parents.forth
							end
						end
					else
						l_type := l_parent_type.dotnet_type
						if l_type /= Void then
							Result := parent_feature_from_dotnet_type (l_type)
							if Result = Void then
								Result := parent_in_dotnet_type (l_type)
							end
						end
					end
					l_parents.forth
				end
			else
				l_type := implementing_type.dotnet_type
				if l_type /= Void then
					Result := parent_in_dotnet_type (l_type)
				end
			end
		end

	parent_in_dotnet_type (a_type: SYSTEM_TYPE): CODE_MEMBER_REFERENCE is
			-- Parent feature in `a_type' and parents of `a_type'
		require
			non_void_type: a_type /= Void
			initialized: is_initialized
		local
			l_interfaces: NATIVE_ARRAY [SYSTEM_TYPE]
			l_base_type: SYSTEM_TYPE
			i, l_count: INTEGER
		do
			l_base_type := a_type.base_type
			if l_base_type /= Void then
				Result := parent_feature_from_dotnet_type (l_base_type)
			end
			if Result = Void then
				l_interfaces := a_type.get_interfaces
				if l_interfaces /= Void then
					from
						l_count := l_interfaces.count
					until
						i = l_count
					loop
						Result := parent_feature_from_dotnet_type (l_interfaces.item (i))
						i := i + 1
					end
				end
			end
			if Result = Void then
				if l_base_type /= Void then
					Result := parent_in_dotnet_type (l_base_type)
				end
				if Result = Void then
					if l_interfaces /= Void then
						from
							i := 0
						until
							i = l_count
						loop
							Result := parent_in_dotnet_type (l_interfaces.item (i))
							i := i + 1
						end
					end
				end
			end
		end
		
	parent_feature_from_dotnet_type (a_type: SYSTEM_TYPE): CODE_MEMBER_REFERENCE is
			-- Feature with same .NET name and same arguments as `Current' in `a_type' if any
		require
			non_void_type: a_type /= Void
			initialized: is_initialized
		local
			l_dotnet_features: LIST [CODE_MEMBER_REFERENCE]
		do
			l_dotnet_features := Metadata_provider.features (name, a_type)
			if l_dotnet_features /= Void then
				from
					l_dotnet_features.start
				until
					l_dotnet_features.after or Result /= Void
				loop
					if has_arguments (l_dotnet_features.item.arguments) then
						Result := l_dotnet_features.item
					end
					l_dotnet_features.forth
				end
			end
		ensure
			valid_parent_feature: Result /= Void implies Result.name.is_equal (name) and has_arguments (Result.arguments)
		end
		
	same_arguments (a_feature: CODE_FEATURE): BOOLEAN is
			-- Does `a_feature' have same arguments as `Current'?
		require
			non_void_feature: a_feature /= Void
			initialized: is_initialized
		local
			l_routine: CODE_ROUTINE
			l_attribute: CODE_ATTRIBUTE
		do
			l_routine ?= a_feature
			if l_routine /= Void then
				Result := has_arguments (l_routine.arguments)
			else
				l_attribute ?= a_feature
				if l_attribute /= Void then
					Result := arguments = Void or else arguments.count = 0
				end
			end
		end
	
	native_arguments: NATIVE_ARRAY [SYSTEM_TYPE] is
			-- Arguments types
		require
			is_dotnet: not Resolver.is_generated (implementing_type)
			initialized: is_initialized
		local
			i: INTEGER
		do
			if arguments /= Void then
				create Result.make (arguments.count)
				from
					arguments.start
				until
					arguments.after
				loop
					Result.put (i, arguments.item.variable.type.dotnet_type)
					arguments.forth
					i := i + 1
				end
			end
		end

feature {NONE} -- Private Access

	internal_eiffel_name: STRING
			-- Cached Eiffel name
	
	internal_result_type: CODE_TYPE_REFERENCE
			-- Cached return type

	internal_parent: CODE_MEMBER_REFERENCE
			-- Cached parent

	search_for_parent: BOOLEAN
			-- Should `parent' trigger a search?

invariant
	non_void_name: name /= Void
	non_void_implementing_type: implementing_type /= Void

end -- class CODE_MEMBER_REFERENCE

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