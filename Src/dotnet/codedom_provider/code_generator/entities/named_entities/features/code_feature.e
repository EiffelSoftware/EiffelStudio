indexing 
	description: "Eiffel feature"
	date: "$$"
	revision: "$$"	

deferred class
	CODE_FEATURE

inherit
	CODE_NAMED_ENTITY
		redefine
			ready
		end

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {CODE_NAMED_ENTITY}.
			-- Initialize `feature_clauses', `comments' and `implemented_type'.
		do
			default_create
			create eiffel_feature_name.make_empty
			create feature_clauses.make
			create type_feature.make_empty
			create comments.make
			create custom_attributes.make
		ensure then
			non_void_eiffel_feature_name: eiffel_feature_name /= Void
			non_void_feature_clauses: feature_clauses /= Void
			non_void_type_feature: type_feature /= Void
			non_void_comments: comments /= Void
			non_void_custom_attributes: custom_attributes /= Void
		end
		
feature -- Access

	eiffel_feature_name: STRING
			-- Eiffel feature name

	feature_clauses: LINKED_LIST [STRING]
			-- Linked_list of feature clauses
	
	type_feature: STRING
			-- Type feature (Initialization, Status report, ...)
	
	comments: LINKED_LIST [CODE_COMMENT]
			-- Feature comments
			
	custom_attributes: LINKED_LIST [CODE_ATTRIBUTE_DECLARATION]
			-- List of custom attributes.

	is_frozen: BOOLEAN
			-- Is routine frozen?

	is_constant: BOOLEAN
			-- Is routine constant?
	
	is_overloaded: BOOLEAN
			-- Is routine name overloaded?
	
	is_once_routine: BOOLEAN
			-- Is routine static (i.e is it a once routine)?
			
feature -- Status Report

	ready: BOOLEAN is
			-- Is feature ready to be generated?
		do
			Result := Precursor {CODE_NAMED_ENTITY} and comments /= Void and not type_feature.is_empty
		end

feature -- Status Setting

	set_eiffel_name (an_eiffel_name: like eiffel_feature_name) is
			-- Set `eiffel_feature_name' with `an_eiffel_name'.
		require
			non_void_an_eiffel_name: an_eiffel_name /= Void
			not_empty_an_eiffel_name: not an_eiffel_name.is_empty
		do
			eiffel_feature_name := an_eiffel_name.as_lower
		ensure
			eiffel_name_set: eiffel_feature_name = an_eiffel_name
		end

	set_type_feature (a_type: like type_feature) is
			-- Set `type_feature' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			type_feature := a_type
		ensure
			type_feature_set: type_feature = a_type
		end

	set_frozen (a_value: like is_frozen) is
			-- Set `is_frozen' with `a_value'.
		do
			is_frozen := a_value
		ensure
			is_frozen_set: is_frozen = a_value
		end

	set_constant (a_value: like is_constant) is
			-- Set `is_constant' with `a_value'.
		do
			is_constant := a_value
		ensure
			is_constant_set: is_constant = a_value
		end
		
	set_overloaded (a_value: like is_overloaded) is
			-- Set `is_overloaded' with `a_value'.
		do
			is_overloaded := a_value
		ensure
			is_overloaded_set: is_overloaded = a_value
		end

	set_once_routine (a_value: like is_once_routine) is
			-- Set `is_once_routine' with `a_value'.
		do
			is_once_routine := a_value
		ensure
			is_once_routine_set: is_once_routine = a_value
		end
		
feature -- Basic Operations
		
	add_feature_clause (a_clause: STRING) is
			-- Add `a_clause' to `feature_clauses'.
		require
			non_void_clause: a_clause /= Void
		do
			feature_clauses.extend (a_clause)
		ensure
			feature_clauses_set: feature_clauses.has (a_clause)
		end

	add_comment (a_comment: CODE_COMMENT) is
			-- Add `a_comment' to `comments'.
		require
			non_void_comment: a_comment /= Void
		do
			if not comments.has (a_comment) then
				comments.extend (a_comment)
			end
		ensure
			comment_added: comments.has (a_comment)
		end

	add_custom_attribute (a_custom_attribute: CODE_ATTRIBUTE_DECLARATION) is
			-- Add `a_custom_attribute' to `custom_attributes.
		require
			non_void_a_custom_attribute: a_custom_attribute /= Void
		do
			custom_attributes.extend (a_custom_attribute)
		ensure
			a_custom_attribute_added: custom_attributes.has (a_custom_attribute)
		end
		
		
feature {CODE_GENERATED_TYPE} -- Code Generation

	feature_clause: STRING is
			-- | loop on feature_clause
			-- | Result := "feature [{features_clause, ...}] -- `type_feature'"

			-- Corresponding feature clause 
		local
			first_element: BOOLEAN
			export_type: STRING
		do
			create Result.make (80)
			Result.append (Dictionary.Feature_keyword)
			from
				first_element := true
				feature_clauses.start
			until
				feature_clauses = Void or else
				feature_clauses.after
			loop
				export_type := feature_clauses.item
				if export_type /= void then
					if first_element then
						Result.append (Dictionary.Space)
						Result.append (Dictionary.Opening_brace_bracket)
						Result.append (Resolver.eiffel_type_name (export_type))
						first_element := false
					else
						Result.append (Dictionary.Comma)
						Result.append (Dictionary.Space)
						Result.append (Resolver.eiffel_type_name (export_type))
					end
				end
				feature_clauses.forth
			end
			if not first_element then
				Result.append (Dictionary.Closing_brace_bracket)
			end

			Result.append (Dictionary.Space)
			Result.append (Dictionary.Dashes)
			Result.append (Dictionary.Space)
			Result.append (type_feature)
			Result.append (Dictionary.New_line)
			Result.append (Dictionary.New_line)
		ensure
			not_void_result: Result /= void
		end

	indexing_clause: STRING is
			-- generate indexing, custom attributes.
		do
			create Result.make (200)
			if custom_attributes.count > 0 then
				Result.append (indent_string)
				Result.append (Dictionary.Indexing_keyword)
				Result.append (Dictionary.New_line)
				increase_tabulation
				Result.append (indent_string)
				Result.append (Dictionary.Attribute_keyword)
				Result.append (Dictionary.Colon)
				Result.append (Dictionary.Space)
				from
					custom_attributes.start
				until
					custom_attributes.after
				loop
					Result.append (custom_attributes.item.code)
					custom_attributes.forth
					if not custom_attributes.after then
						Result.append (",")
						Result.append (Dictionary.New_line)
						Result.append (Dictionary.Tab)
						Result.append (Dictionary.Tab)
					end
				end
				decrease_tabulation
				Result.append (Dictionary.New_line)
			end
		ensure
			non_void_result: Result /= Void
		end

	comments_code: STRING is
			-- Feature comments
		require
			ready: ready
		do
			increase_tabulation
			increase_tabulation
			create Result.make (160)
			from
				comments.start
			until
				comments.after
			loop
				Result.append (comments.item.code)
				comments.forth
			end				
			decrease_tabulation
			decrease_tabulation
		ensure
			comments_generated: Result /= Void and not Result.is_empty
		end

invariant
	non_void_eiffel_feature_name: eiffel_feature_name /= Void
	non_void_feature_clause: feature_clauses /= Void
	non_void_type_feature: type_feature /= Void
	non_void_comments: comments /= Void
	non_void_custom_attributes: custom_attributes /= Void
	
end -- class CODE_FEATURE
	
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