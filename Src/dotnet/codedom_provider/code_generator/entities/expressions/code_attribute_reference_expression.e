indexing 
	description: "Source code generator for attribute reference"
	date: "$$"
	revision: "$$"

class
	CODE_ATTRIBUTE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_SHARED_GENERATION_HELPERS
		undefine
			is_equal
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

	attribute: CODE_MEMBER_REFERENCE
			-- Attribute

	target: CODE_EXPRESSION
			-- Target expression

	code: STRING is
			-- | Result := "feature {`target'}.`attribut_name'"
			-- | OR		:= "`attribut_name'" if `target_object.name' is_equal "Current" or "current_namespace.current_class"
			-- Eiffel code of attribute reference expression
		local
			l_reference_expression: CODE_TYPE_REFERENCE_EXPRESSION
			l_this_expression: CODE_THIS_REFERENCE_EXPRESSION
		do
			create Result.make (80)

			l_reference_expression ?= target
			if l_reference_expression /= Void then
				l_this_expression ?= target				
				if l_this_expression = Void then
					if not l_reference_expression.referenced_type.full_name.is_equal (current_type.full_name) then
						Result.append ("feature {")
						Result.append (target.code)
						Result.append ("}.")
					end
				end
			end

			Result.append (attribute.eiffel_name)
		end

feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := attribute.result_type
		end

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