indexing
	description: "Code generator for type members"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_MEMBER_FACTORY

inherit
	ECD_FACTORY

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_event (a_source: SYSTEM_DLL_CODE_MEMBER_EVENT) is
			-- TO BE SUPPLIED !!

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_event_manager: ECD_EVENT_MANAGER 
		do
			a_event_manager.raise_event (feature {ECD_EVENTS_IDS}.Not_implemented, ["member event"])
		end		
	
	generate_attribute (a_source: SYSTEM_DLL_CODE_MEMBER_FIELD) is
			-- | Create instance of `EG_ATTRIBUTE'.
			-- | And initialize this instance with `a_source' -> call `initialize_attribute'
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			an_attribute: ECD_ATTRIBUTE
		do
			create an_attribute.make
			initialize_attribute (a_source, an_attribute)
			set_last_feature (an_attribute)
		ensure
			non_void_last_feature: last_feature /= Void
			attribute_ready: last_feature.ready
		end

	generate_snippet_feature (a_source: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER) is
			-- | Create instance of `EG_SNIPPET_FEATURE'.
			-- | And initialize this instance with `a_source' -> call `initialize_attribute'
			-- | Set `last_feature'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_snippet_feature: ECD_SNIPPET_FEATURE
		do
			create a_snippet_feature.make
			initialize_snippet_feature (a_source, a_snippet_feature)
			current_type.add_feature (a_snippet_feature)
			set_last_feature (a_snippet_feature)
		ensure
			non_void_last_feature: last_feature /= Void
			snippet_feature_ready: last_feature.ready
		end

feature {NONE} -- Implementation

	initialize_attribute (a_source: SYSTEM_DLL_CODE_MEMBER_FIELD; an_attribute: ECD_ATTRIBUTE) is
			-- | Generate hash value from CodeDom attribute name 
			-- | and add `EG_ATTRIBUTE' in `eg_attributes' with generated value as key.
			-- | Use `eg_generated_types' to set attribute type and implemented type.
			-- | Call `generate_feature_clause (Status_report) if attribute type is BOOLEAN
			-- | else call `generate_feature_clause (Access)'.
			-- | Add `an_attribute' to `current_type'
			-- | Call `generate_comments' if any.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_attribute: an_attribute /= Void
		local
			l_type_name: STRING
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
		do
			an_attribute.set_name (a_source.name)

			create l_type_name.make_from_cil (a_source.type.base_type)
			if not Resolver.is_generated_type (l_type_name) then
				Resolver.add_external_type (l_type_name)
			end
			an_attribute.set_type (l_type_name)

			an_attribute.set_is_array_type (a_source.type.array_element_type /= Void)

			if l_type_name.is_equal ("System.Boolean") then
				an_attribute.set_type_feature (Status_report)
			else
				an_attribute.set_type_feature (Access)
			end
			
			generate_feature_clause (a_source, an_attribute)
			current_type.add_feature (an_attribute)
			
			if a_source.attributes /= Void then
				initialize_member_status (a_source.attributes, an_attribute)
			end
			
			if a_source.custom_attributes /= Void then
				initialize_custom_attributes (a_source.custom_attributes, an_attribute)
			end

			l_comments := a_source.comments
			if l_comments /= Void and then l_comments.count > 0 then
				generate_comments (a_source, an_attribute)
			end
		ensure
			current_type_set: current_type.features.has (an_attribute)
		end
		
	initialize_snippet_feature (a_source: SYSTEM_DLL_CODE_SNIPPET_TYPE_MEMBER; a_snippet_feature: ECD_SNIPPET_FEATURE) is
			-- Initialize `a_snippet_feature' with `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_current_type: current_type /= Void
			non_void_a_snippet_feature: a_snippet_feature /= Void
		local
			l_text: STRING
		do
			create l_text.make_from_cil (a_source.text)
			clean_up_text (l_text)
			if has_keyword (l_text, "inherit") then
				initialize_inheritance_clause (parent_from_snippet (l_text), l_text)
			else
				a_snippet_feature.set_value (l_text)
			end
		end

	has_keyword (a_text: STRING; a_keyword: STRING): BOOLEAN is
			-- Does `a_text' contain `a_keyword'?
		require
			non_void_text: a_text /= Void
			non_void_keyword: a_keyword /= Void
			not_empty_keyword: not a_keyword.is_empty
		local
			l_index: INTEGER
			l_char: CHARACTER
			l_text, l_keyword: STRING
		do
			l_text := a_text.as_lower
			l_text.prune_all_leading (' ')
			l_keyword := a_keyword.as_lower
			l_index := l_text.substring_index (l_keyword, 1)
			if l_index > 0 then
				Result := True
				if l_index > 1 then
					-- Check if left character is separator
					l_char := l_text.item (l_index - 1)
					Result := l_char = ' ' or l_char = '%N' or l_char = '%R' or l_char = '%T'
				end
				if Result and l_index + l_keyword.count < l_text.count then
					-- Check if right character is separator
					l_char := l_text.item (l_index + l_keyword.count)
					Result := l_char = ' ' or l_char = '%N' or l_char = '%R' or l_char = '%T'
				end
			end
		end
	
	inheritance_clause_features (a_text: STRING; a_keyword: STRING): ARRAYED_LIST [STRING] is
			-- Extract feature names from `a_text' below inheritance clause `a_keyword'.
		require
			non_void_text: a_text /= Void
			non_void_keyword: a_keyword /= Void
			text_has_keyword: has_keyword (a_text, a_keyword)
			valid_keyword: a_keyword.is_equal (a_keyword.as_lower)
		local
			l_index: INTEGER
			l_text, l_name, l_keyword: STRING
			l_stop: BOOLEAN
		do
			create Result.make (10)
			l_text := a_text.as_lower
			create l_keyword.make (a_keyword.count + 2)
			l_keyword.append_character (' ')
			l_keyword.append (a_keyword)
			l_keyword.append_character (' ')
			l_index := l_text.substring_index (l_keyword, 1)
			if l_index > 0 then				
				l_index := l_index + l_keyword.count
				from
				until
					l_stop
				loop
					from
						create l_name.make (30)
					until
						(l_index < l_text.count and then l_text.item (l_index) = ',') or else has_keyword (l_name, "redefine") or else	has_keyword (l_name, "undefine") or else has_keyword (l_name, "end")
					loop
						l_name.append_character (l_text.item (l_index)) 
						l_index := l_index + 1
					end
					
					l_stop := l_text.item (l_index) /= ','
					if l_stop then
						if l_name.item (l_name.count).is_equal ('d') then
								-- delete end keyword
							l_name.keep_head (l_name.count - (" end").count)
						else
								-- delete redefine or undefine keyword
							l_name.keep_head (l_name.count - (" redefine").count )
						end
					else
						l_index := l_index + 1
					end
					Result.extend (l_name)
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	parent_from_snippet (a_text: STRING): STRING is
			-- Parent from text of 'a_source'
		require
			text_not_void: a_text /= Void
			inheritance_snippet: has_keyword (a_text, "inherit")
 		local
			i, l_index: INTEGER
		do
			l_index := a_text.substring_index ("inherit", 1) + 8
			from
				i := l_index
			until
				i > a_text.count or else
				not (a_text.item (i).is_alpha) and
				not (a_text.item (i).is_digit) and
				not (a_text.item (i) = '_')
			loop
				i := i + 1
			end
			Result := a_text.substring (l_index, i - 1)
		ensure
			non_void_result: Result /= Void
		end

	quoted_string (a_text: STRING): STRING is
			-- Extract the first quoted string from 'text' if any.
		require
			text_not_void: a_text /= Void
			text_not_empty: not a_text.is_empty
		local
			l_start, l_end: INTEGER
		do
			l_start := a_text.substring_index ("%"", 1)
			if l_start > 0 then
				l_end := a_text.substring_index ("%"", l_start + 1)
				if l_end > 0 then
					Result := a_text.substring (l_start + 1, l_end - 1)		
				end
			end
		end

feature {NONE} -- Components initialization.

	generate_feature_clause (a_source: SYSTEM_DLL_CODE_TYPE_MEMBER; a_feature: ECD_FEATURE) is
			-- | Use `eg_generated_types' to build exports list.
			-- | Initialization (creation routines), exported to NONE
			-- | Access (attribute or function or property getter with not boolean type)
			-- | Status Report (attribute or function or property getter with boolean type)
			-- | Status Setting (property setter)
			-- | Basic Operations (procedure, root procedure or snippet feature)
			-- | Implementation exported to NONE
		require
			non_void_source: a_source /= Void
			non_void_feature: a_feature /= Void
		local
			l_routine: ECD_ROUTINE
			l_eiffel_name: STRING
			l_property_getter: ECD_PROPERTY_GETTER
			l_property_setter: ECD_PROPERTY_SETTER
		do
			if (a_source.attributes.to_integer & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.scope_mask.to_integer) = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.override.to_integer then
				l_property_getter ?= a_feature
				if l_property_getter /= Void then
					l_eiffel_name := current_type.add_redefine_clause_from_dotnet (a_feature.name, l_property_getter.arguments)
				else
					l_property_setter ?= a_feature
					if l_property_setter /= Void then
						l_eiffel_name := current_type.add_redefine_clause_from_dotnet (a_feature.name, l_property_setter.arguments)
					else
						l_routine ?= a_feature
						if l_routine /= Void then
							l_eiffel_name := current_type.add_redefine_clause_from_dotnet (a_feature.name, l_routine.arguments)
						else
							-- Attribute
							l_eiffel_name := current_type.add_redefine_clause_from_dotnet (a_feature.name, create {LINKED_LIST [ECD_PARAMETER_DECLARATION_EXPRESSION]}.make)
						end
					end
				end
				check
					valid_l_eiffel_name: l_eiffel_name /= Void and then not l_eiffel_name.is_empty
				end
				a_feature.set_eiffel_name (l_eiffel_name)
			end
		end

	generate_comments (a_source: SYSTEM_DLL_CODE_TYPE_MEMBER; a_feature: ECD_FEATURE) is
			-- | Call in loop `generate_statement_from_dom'.

			-- Generate feature comments from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_comments: a_source.comments /= Void
			not_empty_comments: a_source.comments.count > 0
			non_void_routine: a_feature /= Void
		local
			i, l_count: INTEGER
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			l_comment_statement: ECD_COMMENT_STATEMENT
		do
			l_comments := a_source.comments
			from
				l_count := l_comments.count
			until
				i = l_count
			loop
				code_dom_generator.generate_statement_from_dom (l_comments.item (i))
				l_comment_statement ?= last_statement
				if l_comment_statement /= Void then
					a_feature.add_comment (l_comment_statement.comment)
				else
					(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Failed_assignment_attempt, ["ECD_STATEMENT", "ECD_COMMENT_STATEMENT", "comments generation of "])
				end
				i := i + 1
			end

		ensure
			comments_generated: a_feature.comments /= Void and then a_feature.comments.count > 0
		end

	initialize_feature_clauses (private_implementation_type: SYSTEM_DLL_CODE_TYPE_REFERENCE; a_feature: ECD_ROUTINE) is
			-- Initialize `custom_attributes' of `a_feature'.
		require
			non_void_private_implementation: private_implementation_type /= Void
			non_void_a_feature: a_feature /= Void
		do
			code_dom_generator.generate_type_reference_from_dom (private_implementation_type)
			a_feature.add_feature_clause (last_return_type.name)
		end

	initialize_member_status (status_attributes: SYSTEM_DLL_MEMBER_ATTRIBUTES; a_feature: ECD_FEATURE) is
			-- Initialize.
		require
			non_void_status_attributes: status_attributes /= Void
			non_void_a_feature: a_feature /= Void
		local
			scope_status: SYSTEM_DLL_MEMBER_ATTRIBUTES
			access_status: SYSTEM_DLL_MEMBER_ATTRIBUTES
			l_routine: ECD_ROUTINE
		do
			scope_status := status_attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.scope_mask
			access_status := status_attributes & feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.access_mask

			a_feature.set_constant (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.const)
			if scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.abstract then
				l_routine ?= a_feature
				if l_routine /= Void then
					l_routine.set_deferred (True)
				else
					(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Failed_assignment_attempt, ["ECD_FEATURE", "ECD_ROUTINE", "member status initialization"])
				end
			end
			a_feature.set_frozen (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.final)
			a_feature.set_once_routine (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.static)
			if scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.override then
				if current_type = Void then
					(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.missing_current_type, ["member status initialization"])
				elseif a_feature.name = Void or else a_feature.name.is_empty then
					(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.missing_feature_name, ["member status initialization"])
				else
					current_type.add_redefine_clause (current_type.name, a_feature.name)
				end
			end
			a_feature.set_overloaded (scope_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.overloaded)
			if access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.private then
				a_feature.add_feature_clause ("NONE")
			end
			if 
				access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family
				or access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family_and_assembly
				or access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.family_or_assembly
				or access_status = feature {SYSTEM_DLL_MEMBER_ATTRIBUTES}.assembly
			then
				if current_type = Void then
					(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.missing_current_type, ["member status initialization"])
				else
					a_feature.add_feature_clause (current_type.name)
				end
			end
		end

	initialize_custom_attributes (custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION; a_feature: ECD_FEATURE) is
			-- Initialize `custom_attributes' of `a_feature'.
		require
			non_void_feature: a_feature /= Void
		local
			i, l_count: INTEGER
		do
			if custom_attributes /= Void then
				from
					l_count := custom_attributes.count
				until
					i = l_count
				loop
					code_dom_generator.generate_custom_attribute_declaration (custom_attributes.item (i))
					a_feature.add_custom_attribute (last_custom_attribute_declaration)
					i := i + 1
				end
			end
		end

	initialize_inheritance_clause (a_parent, a_text: STRING) is
			-- Organise the inheritance clause structure where
			-- 'text' contains the inheritance options from a piece of
			-- snippet text.
		require
			parent_not_void: a_parent /= Void
			text_not_void: a_text /= Void
			parent_valid: not a_parent.is_empty
			text_valid: not a_text.is_empty
		local
			l_feature_names: LIST [STRING]
			l_parent: ECD_PARENT
			l_parent_name, l_parent_path, l_cluster_name: STRING
		do
			clean_up_text (a_text)
			l_parent_name := parent_from_snippet (a_text).as_upper
				-- Now parse the path
			if a_text.has (':') then
				l_cluster_name := quoted_string (a_text.substring (a_text.substring_index (":", 1), a_text.substring_index (",", 1)))
				l_parent_path := quoted_string (a_text.substring (a_text.substring_index (",", 1), a_text.count))
				if l_parent_path /= Void then
			--		Ace_file.add_cluster (l_cluster_name, l_parent_path)
				end
			end

			create l_parent.make
			l_parent.set_name (l_parent_name)
			current_type.add_parent (l_parent)

				-- Now add the clause definitions to the parent
			if has_keyword (a_text, "rename") then
				l_feature_names := inheritance_clause_features (a_text, "rename")
				from
					l_feature_names.start
				until
					l_feature_names.after
				loop
					current_type.add_rename_clause (l_parent_name, l_feature_names.item, "")
					l_feature_names.forth
				end
			end
			if has_keyword (a_text, "undefine") then
				l_feature_names := inheritance_clause_features (a_text, "undefine")
				from
					l_feature_names.start
				until
					l_feature_names.after
				loop
					current_type.add_undefine_clause (l_parent_name, l_feature_names.item)
					l_feature_names.forth
				end
			end
			if has_keyword (a_text, "redefine") then
				l_feature_names := inheritance_clause_features (a_text, "redefine")
				from
					l_feature_names.start
				until
					l_feature_names.after
				loop
					current_type.add_redefine_clause (l_parent_name, l_feature_names.item)
					l_feature_names.forth
				end
			end
		end

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

	context (a_feature: ECD_FEATURE): STRING is
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

feature {NONE} -- Private Access
	
	Initialization: STRING is "Initialization"
			-- Initialization feature clause comment.

	Access: STRING is "Access"
			-- Access feature clause comment.

	Status_report: STRING is "Status Report"
			-- Status report feature clause comment.

	Status_setting: STRING is "Status Setting"
			-- Status setting feature clause comment.

	Basic_operations: STRING is "Basic Operations"
			-- Basic operations feature clause comment.

	Implementation: STRING is "Implementation"
			-- Implementation feature clause comment.
			
	Get_property_string: STRING is "Get property"
			-- Get property feature clause comment.
		
	Set_property_string: STRING is "Set property"
			-- Set property feature clause comment.

end -- class ECD_MEMBER_FACTORY

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