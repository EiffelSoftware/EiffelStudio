indexing
	description: "Record all features in currently analyzed type to resolve Eiffel names and types"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_FEATURE_CACHE

inherit
	ECDP_TYPE_CACHE

feature -- Status Report

	feature_type (a_name: STRING): STRING is
			-- Type of feature `a_name'
		do
			Features.search (a_name)
			if Features.found then
				Result := Features.found_item
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Feature_name_not_found, [a_name])
			end
		end

	is_feature (a_name: STRING): BOOLEAN is
			-- Is `a_name' a feature name?
		do
			Result := Features.has (a_name)
		end

feature -- Basic Operation

	add_feature (a_type_name: STRING; an_eiffel_feature_name: STRING) is
			-- Add `an_eiffel_feature_name' to `features'.
		require
			non_void_a_type_name: a_type_name /= Void
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
			not_empty_an_eiffel_feature_name: not an_eiffel_feature_name.is_empty
		do
			if not is_generated_type (a_type_name) then
				features.put (a_type_name, (create {ECDP_ENTITY_NAME_RESOLVER}).unique_entity_name (an_eiffel_feature_name))
			else
				features.put (a_type_name, an_eiffel_feature_name)
			end
		end

	initialize_features (a_type: ECDP_GENERATED_TYPE) is
			-- initialize `effeil_types.features'
			-- | clear `features' and
			-- | loop on `parents', `creation_routine', `features' of `a_type' to initialize `features'
		require
			non_void_a_type: a_type /= Void
		local
			l_attribute: ECDP_ATTRIBUTE
			l_function: ECDP_FUNCTION
			l_get_property: ECDP_PROPERTY_GETTER
			l_set_property: ECDP_PROPERTY_SETTER
			l_snippet_feature: ECDP_SNIPPET_FEATURE
			l_feature_name: STRING
		do
			features.clear_all
			
				-- parents features
			from
				a_type.parents.start
			until
				a_type.parents.after
			loop
				if is_generated_type (a_type.parents.item.name) then
					initialize_features (Generated_types.item (a_type.parents.item.name))
				else
					initialize_features_with_external (a_type.parents.item.name)
				end
				a_type.parents.forth
			end
			
				-- creation routine features of `a_type'
			from
				a_type.creation_routines.start
			until
				a_type.creation_routines.after
			loop
				add_feature ("System.Void", a_type.creation_routines.item.name)
				a_type.creation_routines.forth
			end
			
				-- attributes and features of `a_type'
			from
				a_type.features.start
			until
				a_type.features.after
			loop
				create l_feature_name.make_from_string (a_type.features.item.name)
				l_attribute ?= a_type.features.item
				if l_attribute /= Void then
					add_feature (l_attribute.type, l_attribute.name)
				else
					l_function ?= a_type.features.item
					if l_function /= Void then
						add_feature (l_function.returned_type, l_function.name)
					else
						l_get_property ?= a_type.features.item
						if l_get_property /= Void then
							add_feature (l_get_property.returned_type, "get_" + l_get_property.name)
						else
							l_set_property ?= a_type.features.item
							if l_set_property /= Void then
								add_feature (l_set_property.property_type_name, "set_" + l_set_property.name)
							else
								l_snippet_feature ?= a_type.features.item
								if l_snippet_feature /= Void then
								else
									-- procedure
									add_feature ("System.Void", a_type.features.item.name)
								end
							end
						end
					end
				end
				a_type.features.forth
			end
		end
		
	initialize_features_with_external (an_external_type_name: STRING) is
			-- Add to `Features' all features associated to `an_external_type_name'.
		require
			non_void_an_external_type_name: an_external_type_name /= Void
			not_empty_an_external_type_name: not an_external_type_name.is_empty
		local
			i: INTEGER
			l_cache_reflection: CACHE_REFLECTION
			l_constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			l_fields: ARRAY [CONSUMED_FIELD]
			l_procedures: ARRAY [CONSUMED_PROCEDURE]
			l_functions: ARRAY [CONSUMED_FUNCTION]
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_events: ARRAY [CONSUMED_EVENT]
			l_external_type: ECDP_EXTERNAL_TYPE
			l_consumed_type: CONSUMED_TYPE
		do
			l_external_type ?= Types.item (an_external_type_name)
			if l_external_type /= Void then
				create l_cache_reflection.make (Clr_version)
				l_consumed_type := l_cache_reflection.consumed_type (l_external_type.type)
				if l_consumed_type /= Void then
					from
						i := 1
						l_constructors := l_consumed_type.constructors
					until
						l_constructors = Void or else i > l_constructors.count
					loop
						add_feature ("System.Void", l_constructors.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_fields := l_consumed_type.fields
					until
						l_fields = Void or else i > l_fields.count
					loop
						add_feature (l_fields.item (i).return_type.name, l_fields.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_procedures := l_consumed_type.procedures
					until
						l_procedures = Void or else i > l_procedures.count
					loop
						add_feature ("System.Void", l_procedures.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_functions := l_consumed_type.functions
					until
						l_functions = Void or else i > l_functions.count
					loop
						add_feature (l_functions.item (i).return_type.name, l_functions.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_properties := l_consumed_type.properties
					until
						l_properties = Void or else i > l_properties.count
					loop
						if l_properties.item (i).setter /= Void then
							add_feature ("System.Void", l_properties.item (i).setter.eiffel_name)
						end
						if l_properties.item (i).getter /= Void then
							add_feature (l_properties.item (i).getter.return_type.name, l_properties.item (i).getter.eiffel_name)
						end
						i := i + 1
					end
					from
						i := 1
						l_events := l_consumed_type.events
					until
						l_events = Void or else i > l_events.count
					loop
						if l_events.item (i).adder /= Void then
							add_feature ("System.Void", l_events.item (i).adder.eiffel_name)
						end
						if l_events.item (i).remover /= Void then
							add_feature ("System.Void", l_events.item (i).remover.eiffel_name)
						end
						if l_events.item (i).raiser /= Void then
							add_feature (l_events.item (i).raiser.return_type.name, l_events.item (i).raiser.eiffel_name)
						end
						i := i + 1
					end
				else
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_consumed_type, [an_external_type_name])
				end
			end
		end

feature {NONE} -- Implementation

	Features: HASH_TABLE [STRING, STRING] is
			-- All features in current_type
			-- Value: `STRING' corresponding to Eiffel type name
			-- Key: ID corresponding to the Eiffel feature name
		once
			create Result.make (150)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECDP_FEATURE_CACHE

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
