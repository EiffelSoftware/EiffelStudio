indexing
	description: "Eiffel representation of CodeDom assign statement"
	date: "$$"
	revision: "$$"	

class
	ECDP_ASSIGN_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `target' and `source'.
		do
		end
		
feature -- Access

	target: ECDP_EXPRESSION
			-- Assignment target
	
	source: ECDP_EXPRESSION
			-- Assignment source

	is_property_assignement: BOOLEAN
			-- is property assignement?

	code: STRING is
			-- | Result := "`target' := `source'"
			-- | OR 	:= "`target' := `source'" if `source' is `EG_CAST_EXPRESSION'.
			-- | OR		:= "`target'(`source')" if `is_property_assignement'.
			-- | OR		:= "`source.expression'" if `source' is `EG_OBJECT_CREATE_EXPRESSION' or `EG_ARRAY_CREATE_EXPRESSION'.
			-- | Set `new_line' to false
			-- Eiffel code of assign statement
		local
			cast: ECDP_CAST_EXPRESSION
			create_expression: ECDP_OBJECT_CREATE_EXPRESSION
			create_array_expression: ECDP_ARRAY_CREATE_EXPRESSION
		do
			check
				non_void_source: source /= Void
				non_void_target: target /= Void
			end
			
			create Result.make (120)
			Result.append (Indent_string)
			set_new_line (false)
			if is_property_assignement then
				Result.append (target.code)
				Result.append (Dictionary.space)
				Result.append (Dictionary.Opening_round_bracket)
				Result.append (source.code)
				Result.append (Dictionary.Closing_round_bracket)
			else
				cast ?= source
				if cast /= Void then
					Result.append (target.code)
					Result.append (" := ")
					Result.append (source.code)
				else
					create_expression ?= source
					if create_expression /= Void then
						create_expression.set_object_created (target.code)
						Result.append (create_expression.code)
					else
						create_array_expression ?= source
						if create_array_expression /= Void then
							create_array_expression.set_array_creation_feature (target.code)
							Result.append (create_array_expression.code)
						else	
							Result.append (target.code)
							Result.append (Dictionary.space)
							Result.append (Dictionary.Colon)
							Result.append (Dictionary.equal_keyword)
							Result.append (Dictionary.space)
							Result.append (source.code)
						end
					end
				end
			end
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is assign statement ready to be generated?
		do
			Result := target /= Void and then target.ready and source /= Void and then source.ready
		end

feature -- Status Setting

	set_is_property_assignement (a_bool: like is_property_assignement) is
			-- Set `is_property_assignement' with `a_bool'.
		do
			is_property_assignement := a_bool
		ensure
			is_property_assignement_set: is_property_assignement = a_bool
		end		

	set_target (a_target: like target) is
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end		

	set_source (a_source: like source) is
			-- Set `source' with `a_source'.
		require
			non_void_source: a_source /= Void
		do
			source := a_source
		ensure
			source_set: source = a_source
		end

end -- class ECDP_ASSIGN_STATEMENT

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