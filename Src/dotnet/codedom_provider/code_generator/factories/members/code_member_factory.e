indexing
	description: "Code generator for type members"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_MEMBER_FACTORY

inherit
	CODE_FACTORY
	
feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_event (a_source: SYSTEM_DLL_CODE_MEMBER_EVENT) is
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Not_implemented, ["member event"])
		end		
	
	generate_attribute (a_source: SYSTEM_DLL_CODE_MEMBER_FIELD) is
			-- | Create instance of `CODE_ATTRIBUTE'.
			-- | And initialize this instance with `a_source' -> call `initialize_attribute'
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_attribute: CODE_ATTRIBUTE
			l_member: CODE_MEMBER_REFERENCE
		do
			if a_source.name /= Void then
				if current_type /= Void then
					l_member := Type_reference_factory.type_reference_from_code (current_type).member (a_source.name, Void)
					check
						exists: l_member /= Void
					end
					create l_attribute.make (a_source.name, l_member.eiffel_name)
					l_attribute.set_result_type (Type_reference_factory.type_reference_from_reference (a_source.type))
					l_attribute.set_feature_kind (Access)
					set_current_feature (l_attribute)
					if a_source.attributes /= Void then
						initialize_member_status (a_source.attributes)
					end
					if a_source.custom_attributes /= Void then
						initialize_custom_attributes (a_source.custom_attributes)
					end
					if a_source.comments /= Void and then a_source.comments.count > 0 then
						initialize_comments (a_source.comments)
					end
					set_last_feature (l_attribute)
					set_current_feature (Void)
					current_type.add_feature (l_attribute)
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_current_type, [current_context])
					set_last_feature (Empty_attribute)
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature_name, [current_context])
				set_last_feature (Empty_attribute)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end

	generate_snippet_feature (a_source: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER) is
			-- | Create instance of `CODE_SNIPPET_FEATURE'.
			-- | And initialize this instance with `a_source' -> call `initialize_attribute'
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_snippet_feature: CODE_SNIPPET_FEATURE
			l_text, l_name: STRING
			l_ok: BOOLEAN
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			i: INTEGER
		do
			l_text := a_source.text
			if l_text /= Void then
				l_ok :=  l_text.as_lower.substring_index ("inherit", 1) > 0
				from
					i := 1
				until
					not l_ok or else l_text.item (i).as_lower = 'i'
				loop
					l_ok := l_text.item (i) = '%T' or l_text.item (i) = '%N' or l_text.item (i) = '%R' or l_text.item (i) = ' '
					i := i + 1
				end
				if l_ok then
					current_type.set_snippet_inherit_clause (l_text)
					set_last_feature (Empty_snippet_feature)
				else
					l_name := "snippet"
					from
						l_features := current_type.features
						l_ok := not l_features.has (l_name)
						if not l_ok then
							l_name.append ("_2")
							l_ok := not l_features.has (l_name)
							i := 3
						end
					until
						l_ok
					loop
						l_name.keep_head (l_name.last_index_of ('_', l_name.count))
						l_name.append (i.out)
						i := i + 1
					end
					create l_snippet_feature.make (l_name, l_text)
					current_type.add_feature (l_snippet_feature)
					set_last_feature (l_snippet_feature)
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_snippet_value, [current_context])
				set_last_feature (Empty_snippet_feature)
			end
		ensure
			non_void_last_feature: last_feature /= Void
		end

feature {NONE} -- Components initialization.

	initialize_comments (a_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate feature comments from `a_source'.
		require
			non_void_feature: current_feature /= Void
			non_void_comments: a_comments /= Void
		local
			i, l_count: INTEGER
			l_comment_statement: CODE_COMMENT_STATEMENT
		do
			from
				l_count := a_comments.count
			until
				i = l_count
			loop
				code_dom_generator.generate_statement_from_dom (a_comments.item (i))
				l_comment_statement ?= last_statement
				if l_comment_statement /= Void then
					current_feature.add_comment (l_comment_statement.comment)
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Failed_assignment_attempt, ["CODE_STATEMENT", "CODE_COMMENT_STATEMENT", "comments generation of "])
				end
				i := i + 1
			end
		end

	initialize_statements (a_statements: SYSTEM_DLL_CODE_STATEMENT_COLLECTION) is
			-- | Call in loop `generate_statement_from_dom'.
			-- Generate feature statements from `a_source'.
		require
			non_void_routine: current_routine /= Void
			non_void_statements: a_statements /= Void
		local
			i, l_count: INTEGER
		do
			from
				l_count := a_statements.count
			until
				i = l_count
			loop
				code_dom_generator.generate_statement_from_dom (a_statements.item (i))
				if last_statement /= Void then
					current_routine.add_statement (last_statement)
				end
				i := i + 1
			end
		end

	initialize_member_status (status_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES) is
			-- Initialize current feature with `status_attribute'.
		require
			non_void_status_attributes: status_attributes /= Void
			non_void_feature: current_feature /= Void
		local
			scope_status: SYSTEM_DLL_MEMBER_ATTRIBUTES
			access_status: SYSTEM_DLL_MEMBER_ATTRIBUTES
			l_routine: CODE_ROUTINE
			l_static: BOOLEAN
		do
			scope_status := status_attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.scope_mask
			access_status := status_attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.access_mask

			current_feature.set_constant (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.const)
			if scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.abstract then
				l_routine ?= current_feature
				if l_routine /= Void then
					l_routine.set_deferred (True)
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Failed_assignment_attempt, ["CODE_FEATURE", "CODE_ROUTINE", "member status initialization"])
				end
			end
			current_feature.set_frozen (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.final)
			l_static := scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.static
			current_feature.set_once_routine (l_static)
			current_feature.set_frozen (l_static)
			current_feature.set_overloaded (scope_status & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.overloaded = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.overloaded)
			if access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.private then
				current_feature.add_feature_clause (None_type_reference)
			end
			if 
				access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family
				or access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family_and_assembly
				or access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family_or_assembly
			then
				if current_type = Void then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.missing_current_type, ["member status initialization"])
				else
					current_feature.add_feature_clause (Type_reference_factory.type_reference_from_code (current_type))
				end
			end
		end

	initialize_custom_attributes (a_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION) is
			-- Initialize custom attributes of current feature.
		require
			non_void_custom_attributes: a_custom_attributes /= Void
		local
			i, l_count: INTEGER
		do
			from
				l_count := a_custom_attributes.count
			until
				i = l_count
			loop
				code_dom_generator.generate_custom_attribute_declaration (a_custom_attributes.item (i))
				current_feature.add_custom_attribute (last_custom_attribute_declaration)
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	clean_up_text (a_text: STRING) is
			-- Cleanup `a_text' by removing leading spaces and
			-- replacing all tabs and newline characters with
			-- spaces.
		require
			non_void_text: a_text /= Void
		do
			a_text.replace_substring_all ("%T", " ")
			a_text.replace_substring_all ("%N", " ")
			a_text.replace_substring_all ("%R", " ")
			a_text.prune_all_leading (' ')
		ensure
			cleaned: not a_text.has ('%T') and not a_text.has ('%R') and not a_text.has ('%N')
		end

	context (a_feature: CODE_FEATURE): STRING is
			-- Contextual information for `a_feature'
		do
			if current_type /= Void and a_feature.name /= Void then
				Result := "routine " + a_feature.name + " from " + current_type.name
			elseif a_feature.name /= Void then
				Result := "routine " + a_feature.name + " from unknown type"
			elseif current_type /= Void then
				Result := "unknown routine from " + current_type.name
			else
				Result := "unknown routine from unknown type"
			end
		end

end -- class CODE_MEMBER_FACTORY

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