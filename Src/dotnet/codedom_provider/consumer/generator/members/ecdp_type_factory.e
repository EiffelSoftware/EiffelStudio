indexing
	-- Code code_generator for types

class
	ECDP_TYPE_FACTORY

inherit
	ECDP_MEMBER_FACTORY

create
	make

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_type (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- | Check whether `a_source' is expanded or deferred 
			-- | to create instance of `EG_GENERATED_TYPE' or `EXPANDED_TYPE' or `DEFERRED_TYPE'.
			-- | Set `current_type' with `a_type'
			-- | Initialize the ECDP_TYPE instance with `a_source' -> Call `Initialize_type'
			-- | Set `current_type' with Void because there is no more current type
			-- | Set `last_type'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			type_attributes: TYPE_ATTRIBUTES
			is_deferred: BOOLEAN
			is_frozen: BOOLEAN
			is_value_type: BOOLEAN
			is_expanded: BOOLEAN
			a_type: ECDP_GENERATED_TYPE
		do
			type_attributes := a_source.type_attributes
			is_deferred := ((type_attributes.Interface | type_attributes.abstract) = type_attributes)
			is_frozen := (type_attributes.sealed = type_attributes)
			is_value_type := a_source.get_type.is_value_type
			is_expanded := not is_deferred and is_value_type
			if is_deferred then
				create {ECDP_DEFERRED_TYPE} a_type.make
			end
			if is_frozen then
				if is_expanded then
					create {ECDP_FROZEN_EXPANDED_TYPE} a_type.make
				else
					create {ECDP_FROZEN_TYPE} a_type.make
				end
			elseif is_expanded then
				create {ECDP_EXPANDED_TYPE} a_type.make
			else
				create {ECDP_GENERATED_TYPE} a_type.make
			end
			set_current_type (a_type)
			initialize_type (a_source, a_type)
			set_current_type (Void)
			set_last_type (a_type)
		ensure
			non_void_last_type: last_type /= Void
			last_type_ready: last_type.ready
		end

feature {NONE} -- Type generation

	initialize_type (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: ECDP_GENERATED_TYPE) is
			-- | Call successively: `initialize_type_without_parents', `initialize_type_parents', 
			-- | `initialize_type_features', `initialize_features_ids' and `resolve_conflicts'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_type: a_type /= Void
		local
			parents: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			if a_source.user_data.contains (From_eiffel_code_key) then
				remove_deleted_features (a_source.members)
			end
			initialize_type_without_parents (a_source, a_type)
			parents := a_source.base_types
			if parents /= Void and then parents.count > 0 then
				initialize_type_parents (a_source, a_type)
			end
			members := a_source.members
			if members /= Void and then members.count > 0 then
				initialize_type_features (a_source, a_type)
			end
		end
	
	initialize_type_without_parents (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: ECDP_GENERATED_TYPE) is
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
			create l_name.make_from_cil (a_source.name)
			l_name := (create {NAME_FORMATTER}).full_formatted_type_name (l_name)
			a_source.set_name (l_name)
			a_type.set_name (l_name)
			if not eiffel_types.is_generated_type (l_name) then
				eiffel_types.add_external_type (l_name)
			end
			if a_source.user_data.contains (From_eiffel_code_key) then
				a_type.set_from_eiffel (True)
			end

			initialize_indexing_clause (a_source, a_type)
		end

	initialize_type_parents (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: ECDP_GENERATED_TYPE) is
			-- | Use `eg_types' to set type parents.

			-- Generate type parents from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_parents: a_source.base_types.count > 0
			non_void_type: a_type /= Void
		local
			i: INTEGER
			l_parents: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			l_parent: SYSTEM_DLL_CODE_TYPE_REFERENCE 
			l_parent_name: STRING
			l_object_parent: ECDP_PARENT
			l_interface_type: BOOLEAN
		do
			l_parents := a_source.base_types
			from
			until
				l_parents = Void or else
				i = l_parents.count
			loop
				l_parent := l_parents.item (i)
				create l_parent_name.make_from_cil (l_parent.base_type)
				create l_object_parent.make
				l_object_parent.set_name (l_parent_name)
				if not l_interface_type then
						-- hypothesis: The first parent is never an interface type
						-- All the other parents are...
					l_object_parent.add_undefine_clause (create {ECDP_UNDEFINE_CLAUSE}.make ("finalize"))
					Eiffel_types.set_parent (l_parent_name)
					l_interface_type := True
				end
				l_object_parent.add_undefine_clause (create {ECDP_UNDEFINE_CLAUSE}.make ("get_hash_code"))
				l_object_parent.add_undefine_clause (create {ECDP_UNDEFINE_CLAUSE}.make ("equals"))
				l_object_parent.add_undefine_clause (create {ECDP_UNDEFINE_CLAUSE}.make ("to_string"))
				a_type.add_parent (l_object_parent)

				if not eiffel_types.is_generated_type (l_parent_name) then
					eiffel_types.add_external_type (l_parent_name)
				end
				i := i + 1
			end

				-- Add ANY as parent.
			create l_object_parent.make
			l_object_parent.set_name ("ANY")
			a_type.add_parent (l_object_parent)
		end

	initialize_type_features (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: ECDP_GENERATED_TYPE) is
			-- | Call in loop `generate_member_from_dom'.

			-- Generate type features from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_features: a_source.members.count > 0
			non_void_type: a_type /= Void
		local
			i: INTEGER
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			l_members := a_source.members
			if l_members = Void then
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_members, ["type feature initialization"])
			else
				from
				until
					l_members = Void or else
					i = l_members.count
				loop
					code_dom_generator.generate_member_from_dom (l_members.item (i))
					i := i + 1
				end
			end
		end

	initialize_indexing_clause (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: ECDP_GENERATED_TYPE) is
			-- Initialize indexing clause of `a_type' with info of `a_source'.
		require
			non_void_a_source: a_source /= Void
			non_void_a_type: a_type /= Void
		local
			comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			i: INTEGER
			a_comment: SYSTEM_DLL_CODE_COMMENT
			an_indexing_clause: ECDP_INDEXING_CLAUSE
			text, tmp_str: STRING
			custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
		do
			create an_indexing_clause.make
			an_indexing_clause.set_name (Description_clause)

				-- Retrieve type comments.
			comments := a_source.comments
			from
				create text.make_empty
			until
				comments = Void or else
				i = comments.count
			loop
				a_comment := comments.item (i).comment
				if a_comment.doc_comment then
					create tmp_str.make_from_cil (a_comment.text)
					text.append (tmp_str)
				end
				i := i + 1
			end
			an_indexing_clause.set_text (text)

				-- Retrieve type customs attributes.
			custom_attributes := a_source.custom_attributes
			from
				i := 0
			until
				custom_attributes = Void or else
				i = custom_attributes.count
			loop
				code_dom_generator.generate_custom_attribute_declaration (custom_attributes.item (i))
				an_indexing_clause.add_custom_attribute (last_custom_attribute_declaration)
				i := i + 1
			end

			a_type.add_indexing_clause (an_indexing_clause)
		end

	Description_clause: STRING is "description"
			-- Description tag of class indexing clause

feature {NONE} -- Visual Studio Implementation

-- FIXME Raphael: VS specific implementation should not be here
	remove_deleted_features (members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION) is
			-- Remove fields from the TextDocument
			-- removed from the code DOM since last parsing of the class.
		require
			non_void_members: members /= Void
--		local
--			l_field: SYSTEM_DLL_CODE_MEMBER_FIELD
--			l_parsed_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
--			i, j: INTEGER
--			l_member_removed: BOOLEAN
--			l_text_selection: TEXT_SELECTION
--			l_start, l_end, l_text_offset: INTEGER
--			l_removed_code: STRING
		do
--			l_parsed_members := members_mapping.members
--			check
--				non_void_parsed_members: l_parsed_members /= Void
--			end
--
--				-- Loop on previous members.
--			from
--				i := 0
--			until
--				i = l_parsed_members.count
--			loop
--				l_field ?= l_parsed_members.item (i)
--				if l_field /= Void then
--					-- Loop on members to find if it has been removed.
--					from
--						j := 0
--						l_member_removed := True
--					until
--						j = members.count or not l_member_removed
--					loop
--						if l_field.name.equals (members.item (j).name) then
--							-- check that both are field or method
--							-- check return type
--							-- check attributes
--							l_member_removed := False
--						end
--						j := j + 1
--					end
--	
--						-- Remove member from TextDocument.
--					if l_member_removed and members_mapping.output_available then
--						l_text_selection := members_mapping.output.selection
--						check
--							non_void_selection: l_text_selection /= Void
--							non_void_start_position: l_field.user_data.contains (Start_position)
--							non_void_end_position: l_field.user_data.contains (End_position)
--						end
--						l_start ?= l_field.user_data.item (Start_position)
--						l_end ?= l_field.user_data.item (End_position)
--						check
--							positive_positions: 0 <= l_start and l_start < l_end
--						end
--						l_text_offset := Members_mapping.text_offset (l_start)
--							-- Set the selection taking care of text decalage
--						l_text_selection.move_to_absolute_offset (l_text_offset + l_start, False)
--						l_text_selection.move_to_absolute_offset (l_text_offset + l_end, True)
--						debug
--							create l_removed_code.make_from_cil (l_text_selection.text)
--						end
--							-- Delete the selection
--						l_text_selection.delete (-1)
--							-- Set text offset
--						Members_mapping.add_text_offset (l_start, (l_start - l_end))
--					end
--				end
--				i := i + 1
--			end
		end

end -- class ECDP_MEMBER_FACTORY

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