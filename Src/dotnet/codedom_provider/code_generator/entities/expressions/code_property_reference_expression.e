indexing 
	description: "Source code generator for property reference expressions"
	date: "$$"
	revision: "$$"

class
	CODE_PROPERTY_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_getter: like getter; a_target: like target) is
			-- Initialize instance
		require
			non_void_getter: a_getter /= Void
			non_void_target: a_target /= Void
		do
			getter := a_getter
			target := a_target
		ensure
			getter_set: getter = a_getter
			target_set: target = a_target
		end
		
feature -- Access

	getter: CODE_MEMBER_REFERENCE
			-- Name of property to reference
			
	target: CODE_EXPRESSION
			-- Target object
	
	is_set_reference: BOOLEAN
			-- get or set reference?
			
	code: STRING is
			-- | Result := "[`target_object'.]set_`property_name'" if `is_set_reference' else
			-- | OR		:= "[`target_object'.]`property_name'"
			-- | OR		:= "feature {`target_object'}.set/get_`property_name'" if typeof `target_object' is CODE_TYPE_REFERENCE_EXPRESSION
			-- Eiffel code of property reference expression
		local
			l_target_name, l_current_name: STRING
			l_type_ref_exp: CODE_TYPE_REFERENCE_EXPRESSION
		do
			create Result.make (120)
			
			l_type_ref_exp ?= target
			if l_type_ref_exp /= Void then
				Result.append ("feature {")
				Result.append (target.code)
				Result.append ("}.")
			else
				l_target_name := target.code
				
				create l_current_name.make (240)
				l_current_name.append (getter.result_type.namespace)
				l_current_name.append_character ('.')
				l_current_name.append (getter.result_type.eiffel_name)
				if 	not l_target_name.is_equal (l_current_name) and not l_target_name.is_equal ("Current") then
					Result.append (l_target_name)
					Result.append (".")
				end
			end
			if is_set_reference then
				Result.append ("set_")
			end
			Result.append (getter.eiffel_name)
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if is_set_reference then
				Result := None_type_reference
			else
				Result := getter.result_type
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
		
invariant
	non_void_getter: getter /= Void
	non_void_target: target /= Void
	
end -- class CODE_PROPERTY_REFERENCE_EXPRESSION

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