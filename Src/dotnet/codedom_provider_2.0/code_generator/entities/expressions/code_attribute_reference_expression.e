indexing 
	description: "Source code generator for attribute reference"
	date: "$$"
	revision: "$$"

class
	CODE_ATTRIBUTE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_attribute: like attribute; a_target: like target) is
			-- Initialize instance.
		require
			non_void_attribute: a_attribute /= Void
			non_void_target: a_target /= Void
		do
			attribute := a_attribute
			target := a_target
		ensure
			attribute_set: attribute = a_attribute
			target_set: target = a_target
		end

feature -- Access

	attribute: STRING
			-- Attribute

	target: CODE_EXPRESSION
			-- Target expression

	is_set_reference: BOOLEAN
			-- get or set reference?
	
	is_in_current: BOOLEAN is
			-- Is field in type currently generated?
		local
			l_this_expression: CODE_THIS_REFERENCE_EXPRESSION
			l_type_reference: CODE_TYPE_REFERENCE_EXPRESSION
		do
			l_this_expression ?= target
			Result := l_this_expression /= Void
			if not Result then
				l_type_reference ?= target
				Result := l_type_reference /= Void and then is_current_generated_type (l_type_reference.type)
			end
		end

	code: STRING is
			-- | Result := "feature {`target'}.`attribut_name'"
			-- | OR		:= "`attribut_name'" if `target_object.name' is_equal "Current" or "current_namespace.current_class"
			-- | OR     := `set_attribute_name' if `is_set_reference' and not `target_object.name' is_equal "Current" or "current_namespace.current_class"
			-- Eiffel code of attribute reference expression
		local
			l_type_reference: CODE_TYPE_REFERENCE_EXPRESSION
			l_name: STRING
		do
			create Result.make (80)
			if not is_in_current then
				l_type_reference ?= target
				if l_type_reference /= Void then
					Result.append ("feature {")
					Result.append (target.code)
					Result.append ("}.")
				else
					Result.append (target.code)
					Result.append_character ('.')
				end
			end
			if is_in_current or not is_set_reference then
				if member /= Void then	
					l_name := member.eiffel_name
				else
					l_name := Name_formatter.formatted_feature_name (attribute)
				end
			else
				if setter /= Void then
					l_name := setter.eiffel_name
				else
					l_name := "set_" + Name_formatter.formatted_feature_name (attribute)
				end
			end
			Result.append (l_name)
		end

feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if member /= Void then
				Result := member.Result_type
			else
				Result := Object_type_reference
			end
		end

feature {CODE_STATEMENT_FACTORY} -- Element Settings

	set_is_set_reference (a_is_set_reference: like is_set_reference) is
			-- Set `is_set_reference' with `a_is_set_reference'.
		do
			is_set_reference := a_is_set_reference
		ensure
			is_set_reference_set: is_set_reference = a_is_set_reference
		end

feature {NONE} -- Implementation

	member: CODE_MEMBER_REFERENCE is
			-- Corresponding member
		do
			if not member_searched then
				internal_member := target.type.member (attribute, Void)
				if internal_member = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [attribute, target.type.name])
				end
				member_searched := True
			end
			Result := internal_member
		end
	
	setter: CODE_MEMBER_REFERENCE is
			-- Corresponding member setter
		do
			if not setter_searched then
				internal_setter := target.type.member_from_name ("set_" + attribute)
				if internal_setter = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, ["set_" + attribute, target.type.name])
				end
				setter_searched := True
			end
			Result := internal_setter
		end
	
	internal_member: CODE_MEMBER_REFERENCE
			-- Cache for `member'

	internal_setter: CODE_MEMBER_REFERENCE
			-- Cache for `setter'

	member_searched: BOOLEAN
			-- Was `member' called?

	setter_searched: BOOLEAN
			-- Was `setter' called?

invariant
	non_void_attribute: attribute /= Void
	non_void_target: target /= Void
	
end -- class CODE_ATTRIBUTE_REFERENCE_EXPRESSION

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