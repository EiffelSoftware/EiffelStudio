indexing
	description: "Code generator for types"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_FACTORY

inherit
	CODE_MEMBER_FACTORY

	CODE_USER_DATA_KEYS
		export
			{NONE} all
		end

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_type (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- | Check whether `a_source' is expanded or deferred 
			-- | to create instance of `EG_GENERATED_TYPE' or `EXPANDED_TYPE' or `DEFERRED_TYPE'.
			-- | Set `current_type' with `a_type'
			-- | Initialize the CODE_TYPE instance with `a_source' -> Call `Initialize_type'
			-- | Set `current_type' with Void because there is no more current type
			-- | Set `last_type'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type_attributes: TYPE_ATTRIBUTES
			l_deferred: BOOLEAN
			l_frozen: BOOLEAN
			l_expanded: BOOLEAN
			l_type: CODE_GENERATED_TYPE
		do
			l_type_attributes := a_source.type_attributes
			l_deferred := l_type_attributes & feature {TYPE_ATTRIBUTES}.Interface = feature {TYPE_ATTRIBUTES}.Interface
			if not l_deferred then
				l_deferred := l_type_attributes & feature {TYPE_ATTRIBUTES}.Abstract = feature {TYPE_ATTRIBUTES}.Abstract
			end
			l_frozen := l_type_attributes & feature {TYPE_ATTRIBUTES}.Sealed = feature {TYPE_ATTRIBUTES}.Sealed
			l_expanded := not l_deferred and a_source.get_type.is_value_type
			if l_deferred then
				create {CODE_DEFERRED_TYPE} l_type.make
			end
			if l_frozen then
				if l_expanded then
					create {CODE_FROZEN_EXPANDED_TYPE} l_type.make
				else
					create {CODE_FROZEN_TYPE} l_type.make
				end
			elseif l_expanded then
				create {CODE_EXPANDED_TYPE} l_type.make
			else
				create {CODE_GENERATED_TYPE} l_type.make
			end
			set_current_type (l_type)
			initialize_type (a_source, l_type)
			set_current_type (Void)
			set_last_type (l_type)
		ensure
			non_void_last_type: last_type /= Void
			last_type_ready: last_type.ready
		end

feature {NONE} -- Type generation

	initialize_type (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_GENERATED_TYPE) is
			-- | Call successively: `initialize_type_without_parents', `initialize_type_parents', 
			-- | `initialize_type_features', `initialize_features_ids' and `resolve_conflicts'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_type: a_type /= Void
		local
			l_parents: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			initialize_type_without_parents (a_source, a_type)
			l_parents := a_source.base_types
			if l_parents /= Void and then l_parents.count > 0 then
				initialize_type_parents (a_source, a_type)
			end
			l_members := a_source.members
			if l_members /= Void and then l_members.count > 0 then
				initialize_type_features (a_source, a_type)
			end
		end
	
	initialize_type_without_parents (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_GENERATED_TYPE) is
			-- | Retrieve a_type_name and formatte it into eiffel convention.
			-- | Set codeDom.type.name with formatted type name.
			-- | Set name of `a_type_name'.
			-- | add type to `eg_types' -> call `add_type_to_eg_types'
			-- | Set comments of `a_type'

			-- Generate type from `a_source' with no parents.
		require
			non_void_source: a_source /= Void
			non_void_type: a_type /= Void
		local
			l_name: STRING
		do
			l_name := (create {NAME_FORMATTER}).full_formatted_type_name (a_source.name)
			a_source.set_name (l_name)
			a_type.set_name (l_name)
			if not Resolver.is_generated_type (l_name) then
				Resolver.add_external_type (l_name)
			end
			initialize_indexing_clause (a_source, a_type)
		end

	initialize_type_parents (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_GENERATED_TYPE) is
			-- | Use `eg_types' to set type parents.

			-- Generate type parents from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_parents: a_source.base_types.count > 0
			non_void_type: a_type /= Void
		local
			i, l_count: INTEGER
			l_parents: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			l_parent: SYSTEM_DLL_CODE_TYPE_REFERENCE 
			l_parent_name: STRING
			l_object_parent: CODE_PARENT
			l_interface_type: BOOLEAN
		do
			l_parents := a_source.base_types
			if l_parents /= Void then
				from
					l_count := l_parents.count
				until
					i = l_count
				loop
					l_parent := l_parents.item (i)
					create l_object_parent.make
					l_object_parent.set_name (l_parent.base_type)
					if not l_interface_type then
							-- hypothesis: The first parent is never an interface type
							-- All the other parents are...
						l_object_parent.add_undefine_clause (create {CODE_UNDEFINE_CLAUSE}.make ("finalize"))
						l_interface_type := True
					end
					l_object_parent.add_undefine_clause (create {CODE_UNDEFINE_CLAUSE}.make ("get_hash_code"))
					l_object_parent.add_undefine_clause (create {CODE_UNDEFINE_CLAUSE}.make ("equals"))
					l_object_parent.add_undefine_clause (create {CODE_UNDEFINE_CLAUSE}.make ("to_string"))
					a_type.add_parent (l_object_parent)
	
					if not Resolver.is_generated_type (l_parent_name) then
						Resolver.add_external_type (l_parent_name)
					end
					i := i + 1
				end
			end

				-- Add ANY as parent.
			create l_object_parent.make
			l_object_parent.set_name ("ANY")
			a_type.add_parent (l_object_parent)
		end

	initialize_type_features (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_GENERATED_TYPE) is
			-- | Call in loop `generate_member_from_dom'.

			-- Generate type features from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_features: a_source.members.count > 0
			non_void_type: a_type /= Void
		local
			i, l_count: INTEGER
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			l_members := a_source.members
			if l_members = Void then
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_members, ["type feature initialization"])
			else
				from
					l_count := l_members.count
				until
					i = l_count
				loop
					code_dom_generator.generate_member_from_dom (l_members.item (i))
					i := i + 1
				end
			end
		end

	initialize_indexing_clause (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_GENERATED_TYPE) is
			-- Initialize indexing clause of `a_type' with info of `a_source'.
		require
			non_void_a_source: a_source /= Void
			non_void_a_type: a_type /= Void
		local
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			i, l_count: INTEGER
			l_comment: SYSTEM_DLL_CODE_COMMENT
			l_indexing_clause: CODE_INDEXING_CLAUSE
			l_text: STRING
			l_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
		do
			-- Retrieve type comments.
			create l_indexing_clause.make
			l_indexing_clause.set_name ("description")
			l_comments := a_source.comments
			create l_text.make (32)
			if l_comments /= Void then
				from
					l_count := l_comments.count
				until
					i = l_count
				loop
					l_comment := l_comments.item (i).comment
					if l_comment.doc_comment then
						l_text.append (l_comment.text)
					end
					i := i + 1
				end
			else
				l_text.append ("Generated type")
			end
			l_indexing_clause.set_text (l_text)

			-- Retrieve type customs attributes.
			l_custom_attributes := a_source.custom_attributes
			if l_custom_attributes /= Void then
				from
					i := 0
					l_count := l_custom_attributes.count
				until
					i = l_count
				loop
					code_dom_generator.generate_custom_attribute_declaration (l_custom_attributes.item (i))
					l_indexing_clause.add_custom_attribute (last_custom_attribute_declaration)
					i := i + 1
				end
			end
			a_type.add_indexing_clause (l_indexing_clause)
		end

end -- class CODE_TYPE_FACTORY

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