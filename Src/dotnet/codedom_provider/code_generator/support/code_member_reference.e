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
	CODE_REFERENCED_ASSEMBLIES
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_HELPERS
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

create {CODE_TYPE_REFERENCE}
	make

feature {NONE} -- Initialization

	make (a_dotnet_name: like name; a_arguments: like arguments; a_implementing_type: like implementing_type; a_is_redefined: like is_redefined) is
			-- Initialize instance.
		require
			non_void_name: a_dotnet_name /= Void
			valid_name: not a_dotnet_name.is_empty
			non_void_implementing_type: a_implementing_type /= Void
		do
			name := a_dotnet_name
			arguments := a_arguments
			implementing_type := a_implementing_type
			is_redefined := a_is_redefined
			search_for_parent := a_is_redefined
		ensure
			name_set: name = a_dotnet_name
			arguments_set: arguments = a_arguments
			implementing_type_set: implementing_type = a_implementing_type
			is_redefined_set: is_redefined = a_is_redefined
		end

feature -- Access

	name: STRING
			-- .NET simple name
	
	implementing_type: CODE_TYPE_REFERENCE
			-- Implementing type
	
	arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			-- Routine arguments
	
	is_redefined: BOOLEAN
			-- Is member overriden?

	found: BOOLEAN
			-- Was last feature lookup in hierarchy successful?
			
	found_feature: CODE_MEMBER_REFERENCE
			-- Last feature found by `search_feature_in_hierarchy'

	parent: CODE_MEMBER_REFERENCE is
			-- Parent feature
			-- Log error if not found and return Void
		require
			is_redefined: is_redefined
		local
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_dotnet_features: LIST [CODE_MEMBER_REFERENCE]
			l_type: TYPE
			l_parents: HASH_TABLE [CODE_PARENT, STRING]
		do
			if search_for_parent then
				search_for_parent := False
				Resolver.search (implementing_type)
				if Resolver.found_generated then
					l_parents := Resolver.found_generated_type.parents
					from
						l_parents.start
					until
						l_parents.after or Result /= Void
					loop
						Resolver.search (l_parents.item_for_iteration.type)
						if Resolver.found_generated then
							l_features := Resolver.found_generated_type.features
							l_features.search (eiffel_name)
							if l_features.found then
								Result := l_parents.item_for_iteration.type.member_from_code (l_features.found_item)
							end
						else
							l_type := l_parents.item_for_iteration.type.dotnet_type
							if l_type /= Void then
								l_dotnet_features := Metadata_provider.features (name, l_type)
								from
									l_dotnet_features.start
								until
									l_dotnet_features.after or Result /= Void
								loop
									if l_dotnet_features.item.eiffel_name.is_equal (eiffel_name) then
										Result := l_dotnet_features.item
									end
									l_dotnet_features.forth
								end
							end
						end
						l_parents.forth
					end
				end
				if Result = Void then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_parent, [eiffel_name + " (" + name + ") from " + implementing_type.eiffel_name + " (" + implementing_type.full_name + ")"])
				else
					internal_parent := Result
				end
			else
				Result := internal_parent
			end
		end

	eiffel_name: STRING is
			-- Eiffel name
		local
			i: INTEGER
		do
			if internal_eiffel_name = Void then
				if is_redefined then
					if parent /= Void then
						Result := parent.eiffel_name
					else
						Result := Name_formatter.formatted_feature_name (name)
					end
				else
					Result := Name_formatter.formatted_feature_name (name)
					if hierarchy_has_name (Result) then
						Result.append ("_2")
						i := 3
					end
					from
					until
						not hierarchy_has_name (Result)						
					loop
						Result.keep_head (Result.last_index_of ('_', Result.count))
						Result.append (i.out)
						i := i + 1
					end
				end
				internal_eiffel_name := Result
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
		local
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_type: TYPE
			l_arguments: NATIVE_ARRAY [TYPE]
			i: INTEGER
		do
			if internal_result_type = Void then
				Resolver.search (implementing_type)
				if Resolver.found_generated then
					l_features := Resolver.found_generated_type.features
					l_features.search (eiffel_name)
					if l_features.found then
						Result := l_features.found_item.result_type
					else
						Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature, [name, Resolver.found_generated_type.full_name])
					end
				else
					l_type := implementing_type.dotnet_type
					if l_type /= Void then
						if arguments /= Void then
							create l_arguments.make (arguments.count)
							from
								arguments.start
							until
								arguments.after
							loop
								l_arguments.put (i, arguments.item.variable.type.dotnet_type)
								arguments.forth
								i := i + 1
							end
						end
						Result := Metadata_provider.feature_type (name, l_arguments, l_type)
					end
				end
				internal_result_type := Result
			else
				Result := internal_result_type
			end
		end

feature -- Status Report

	hierarchy_has_name (a_name: STRING): BOOLEAN is
			-- Does class hierarchy containing current member
			-- have a feature with eiffel name `a_name'?
			-- Start search in parents of `implementing_type'.
		require
			non_void_name: a_name /= Void
		local
			l_type: TYPE
			l_interfaces: NATIVE_ARRAY [TYPE]
			i, l_count: INTEGER
		do
			Resolver.search (implementing_type)
			if Resolver.found_generated then
				Result := parents_have_feature (a_name, Resolver.found_generated_type.parents)
			else
				l_type := implementing_type.dotnet_type
				if l_type /= Void then
					if l_type.base_type /= Void then
						Result := dotnet_hierarchy_has_feature (a_name, l_type.base_type)
					end
					if not Result then
						l_interfaces := l_type.get_interfaces
						if l_interfaces /= Void then
							from
								l_count := l_interfaces.count
							until
								i = l_count or Result
							loop
								Result := dotnet_hierarchy_has_feature (a_name, l_interfaces.item (i))
								i := i + 1
							end
						end
					end
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_type, [implementing_type.eiffel_name + " (" + implementing_type.full_name + ")"])
				end
			end
		end

feature {NONE} -- Implementation

	parents_have_feature (a_name: STRING; a_parents: HASH_TABLE [CODE_PARENT, STRING]): BOOLEAN is
			-- Do `parents' or their ancestor have a feature with eiffel name `a_name'?
		require
			non_void_name: a_name /= Void
			non_void_parents: a_parents /= Void
		local
			l_type: CODE_GENERATED_TYPE
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_dotnet_type: TYPE
		do
			from
				a_parents.start
			until
				a_parents.after or Result
			loop
				Resolver.search (a_parents.item_for_iteration.type)
				if Resolver.found_generated then
					l_type := Resolver.found_generated_type
					l_features := l_type.features
					l_features.search (a_name)
					Result := l_features.found
					if not Result then
						Result := parents_have_feature (a_name, l_type.parents)
					end
				else
					l_dotnet_type := a_parents.item_for_iteration.type.dotnet_type
					if l_dotnet_type /= Void then
						Result := dotnet_hierarchy_has_feature (a_name, l_dotnet_type)
					else
						Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_type, [a_parents.item_for_iteration.type.eiffel_name + " (" + a_parents.item_for_iteration.type.full_name + ")"])
					end
				end
			end
		end
	
	dotnet_hierarchy_has_feature (a_name: STRING; a_type: TYPE): BOOLEAN is
			-- Do `a_type' or any base type of `a_type' have a feature with Eiffel name `a_name'?
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
			l_interfaces: NATIVE_ARRAY [TYPE]
			i, l_count: INTEGER
		do
			l_features := Metadata_provider.features (a_name, a_type)
			from
				l_features.start
			until
				l_features.after or Result
			loop
				Result := l_features.item.eiffel_name.is_equal (a_name)
				l_features.forth
			end
			if not Result then
				if a_type.base_type /= Void then
					Result := dotnet_hierarchy_has_feature (a_name, a_type.base_type)
				end
				if not Result then
					l_interfaces := a_type.get_interfaces
					if l_interfaces /= Void then
						from
							l_count := l_interfaces.count
						until
							i = l_count or Result
						loop
							Result := dotnet_hierarchy_has_feature (a_name, l_interfaces.item (i))
							i := i + 1
						end
					end
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