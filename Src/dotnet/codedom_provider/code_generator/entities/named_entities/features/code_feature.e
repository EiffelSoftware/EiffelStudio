indexing 
	description: "Eiffel feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"	

deferred class
	CODE_FEATURE

inherit
	CODE_NAMED_ENTITY

feature {NONE} -- Initialization

	make (a_name, a_eiffel_name: STRING) is
			-- Initialize lists.
		require
			non_void_name: a_name /= Void
			non_void_eiffel_name: a_eiffel_name /= Void
		do
			name := a_name
			eiffel_name := a_eiffel_name
			create {ARRAYED_LIST [CODE_TYPE_REFERENCE]} feature_clauses.make (1)
			create {ARRAYED_LIST [CODE_COMMENT]} comments.make (1)
			create {ARRAYED_LIST [CODE_ATTRIBUTE_DECLARATION]} custom_attributes.make (1)
		ensure
			eiffel_name_set: eiffel_name = a_eiffel_name
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel feature name

	result_type: CODE_TYPE_REFERENCE
			-- Routine result type if any

	feature_clauses: LIST [CODE_TYPE_REFERENCE]
			-- Types to which feature is exported
	
	feature_kind: STRING
			-- Feature kind (Initialization, Status report, ...)
	
	comments: LIST [CODE_COMMENT]
			-- Feature comments
			
	custom_attributes: LIST [CODE_ATTRIBUTE_DECLARATION]
			-- List of custom attributes.

	is_frozen: BOOLEAN
			-- Is routine frozen?

	is_constant: BOOLEAN
			-- Is routine constant?
	
	is_overloaded: BOOLEAN
			-- Is routine name overloaded?
	
	is_once_routine: BOOLEAN
			-- Is routine static?

	is_deferred: BOOLEAN
			-- Is routine deferred?

	is_redefined: BOOLEAN
			-- Is routine overwritten?

feature -- Element Settings

	set_eiffel_name (a_name: like eiffel_name) is
			-- Set `eiffel_name' with `a_name'
		require
			non_void_name: a_name /= Void
			in_code_analysis: current_state = Code_analysis
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name = a_name
		end
		
	set_result_type (a_type: like result_type) is
			-- Set `result_type' with `a_type'
		require
			non_void_type: a_type /= Void
			in_code_analysis: current_state = Code_analysis
		do
			result_type := a_type
		ensure
			result_type_set: result_type = a_type
		end

	set_feature_kind (a_kind: like feature_kind) is
			-- Set `feature_kind' with `a_kind'.
		require
			non_void_kind: a_kind /= Void
			in_code_analysis: current_state = Code_analysis
		do
			feature_kind := a_kind
		ensure
			feature_kind_set: feature_kind = a_kind
		end

	set_frozen (a_value: like is_frozen) is
			-- Set `is_frozen' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_frozen := a_value
		ensure
			is_frozen_set: is_frozen = a_value
		end

	set_constant (a_value: like is_constant) is
			-- Set `is_constant' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_constant := a_value
		ensure
			is_constant_set: is_constant = a_value
		end
		
	set_overloaded (a_value: like is_overloaded) is
			-- Set `is_overloaded' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_overloaded := a_value
		ensure
			is_overloaded_set: is_overloaded = a_value
		end

	set_once_routine (a_value: like is_once_routine) is
			-- Set `is_once_routine' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_once_routine := a_value
		ensure
			is_once_routine_set: is_once_routine = a_value
		end
		
	add_feature_clause (a_clause: CODE_TYPE_REFERENCE) is
			-- Add `a_clause' to `feature_clauses'.
		require
			non_void_clause: a_clause /= Void
			in_code_analysis: current_state = Code_analysis
		do
			feature_clauses.extend (a_clause)
		ensure
			feature_clauses_set: feature_clauses.has (a_clause)
		end

	add_comment (a_comment: CODE_COMMENT) is
			-- Add `a_comment' to `comments'.
		require
			non_void_comment: a_comment /= Void
			in_code_analysis: current_state = Code_analysis
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
			in_code_analysis: current_state = Code_analysis
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
		require
			in_code_generation: current_state = Code_generation
		do
			create Result.make (80)
			Result.append ("feature")
			from
				feature_clauses.start
				if not feature_clauses.after then
					Result.append (" {")
					Result.append (feature_clauses.item.eiffel_name)
					feature_clauses.forth
				end
			until
				feature_clauses.after
			loop
				Result.append (", ")
				Result.append (feature_clauses.item.eiffel_name)
				feature_clauses.forth
			end
			if feature_clauses.count > 0 then
				Result.append_character ('}')
			end
			if feature_kind /= Void then
				Result.append (" -- ")
				Result.append (feature_kind)
				Result.append ("%N%N")
			end
		ensure
			not_void_feature_clause: Result /= void
			valid_feature_clause: Result.substring_index ("feature", 1) = 1
		end

	indexing_clause: STRING is
			-- generate indexing, custom attributes.
		require
			in_code_generation: current_state = Code_generation
		do
			if custom_attributes.count > 0 then
				create Result.make (200)
				Result.append (indent_string)
				Result.append ("indexing%N")
				increase_tabulation
				Result.append (indent_string)
				Result.append ("metadata: ")
				from
					custom_attributes.start
					Result.append (custom_attributes.item.code)
					custom_attributes.forth
				until
					custom_attributes.after
				loop
					Result.append (", ")
					Result.append (custom_attributes.item.code)
					custom_attributes.forth
				end
				decrease_tabulation
				Result.append_character ('%N')
			else
				create Result.make_empty
			end
		ensure
			non_void_result: Result /= Void
		end

	comments_code: STRING is
			-- Feature comments
		require
			in_code_generation: current_state = Code_generation
		do
			if not comments.is_empty then
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
			else
				create Result.make_empty
			end
		ensure
			comments_generated: Result /= Void
		end

invariant
	non_void_comments: comments /= Void
	non_void_custom_attributes: custom_attributes /= Void
	non_void_feature_clauses: feature_clauses /= Void
	non_void_eiffel_name: eiffel_name /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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