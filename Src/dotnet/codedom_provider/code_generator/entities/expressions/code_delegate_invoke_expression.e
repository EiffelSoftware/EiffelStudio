indexing 
	description: "Source code generator for delegate invoke expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_DELEGATE_INVOKE_EXPRESSION

inherit
	CODE_EXPRESSION
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `arguments'.
		do
			create arguments.make
		ensure
			non_void_arguments: arguments /= Void
		end
		
feature -- Access

	arguments: LINKED_LIST [CODE_EXPRESSION]
			-- Delegate arguments
	
	target_object: CODE_EXPRESSION
			-- Target object
			
	code: STRING is
			-- | Result := `target_object' (`arguments', ...)
			-- Eiffel code of delegate invoke expression
			-- NOT SUPPORTED YET !!!
		do
			Check
				non_void_target_object: target_object /= Void
			end
		
			create Result.make (120)
			Result.append ("must be done (EG_DELEGATE_INVOKE_EXPRESSION)")
			Result.append (target_object.code)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Opening_round_bracket)
			from
				arguments.start
				if not arguments.after then
					Result.append (arguments.item.code)
				end
				arguments.forth
			until
				arguments.after
			loop
				Result.append (Dictionary.Comma)
				Result.append (Dictionary.Space)
				Result.append (arguments.item.code)
				arguments.forth
			end
		end
		
feature -- Status Report
	
	ready: BOOLEAN is
			-- Is delegate invoke expression ready to be generated?
		do
			Result := target_object /= Void and then target_object.ready
		end

	type: TYPE is
			-- Type
		do
			Result := target_object.type
		end

feature -- Status Setting

	set_target_object (an_expression: like target_object) is
			-- Set `target_object' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			target_object := an_expression
		ensure
			target_object_set: target_object = an_expression
		end		

	add_argument (an_argument: CODE_EXPRESSION) is
			-- Add `an_argment' to `arguments'.
		require
			non_void_argument: an_argument /= Void
		do
			arguments.extend (an_argument)
		ensure
			arguments_set: arguments.has (an_argument)
		end	
		
invariant
	non_void_arguments: arguments /= Void

end -- class CODE_DELEGATE_INVOKE_EXPRESSION

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