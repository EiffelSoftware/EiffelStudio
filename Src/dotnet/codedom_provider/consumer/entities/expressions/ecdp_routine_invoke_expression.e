indexing 
	description: "Source code generator for method invokation expressions"
	date: "$$"
	revision: "$$"
	
class
	ECDP_ROUTINE_INVOKE_EXPRESSION

inherit
	ECDP_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `routine' and `arguments'.
		do
			create arguments.make
		ensure
			non_void_arguments: arguments /= Void
		end
		
feature -- Access

	routine: ECDP_REFERENCE_EXPRESSION
			-- Routine to invoke
			
	arguments: LINKED_LIST [ECDP_EXPRESSION] 
			-- Routine arguments
			
	code: STRING is
			-- | Result := "`routine'[ (`arguments',...)]"
			-- Eiffel code of routine invoke expression
		local
			an_argument: ECDP_EXPRESSION
		do
			check
				non_void_routine: routine /= Void
			end
			
			create Result.make (120)
			routine.set_routine_arguments (arguments)
			Result.append (routine.code)
			
			from
				arguments.start
				if not arguments.after then
					an_argument := arguments.item
					if an_argument /= Void then
						Result.append (Dictionary.Space)
						Result.append (Dictionary.Opening_round_bracket)
						Result.append (an_argument.code)
					end
					arguments.forth
				end
			until
				arguments.after
			loop
				an_argument := arguments.item
				if an_argument /= Void then
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.Space)
					Result.append (an_argument.code)
				end
				arguments.forth
			end
			if arguments.count > 0 then
				Result.append (Dictionary.Closing_round_bracket)
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is routine invoke expression ready to be generated?
		do
			Result := routine.ready and arguments /= Void
		end

	type: TYPE is
			-- Type
		do
			Result := routine.type
		end

feature -- Status Setting

	set_routine (a_routine: like routine) is
			-- Set `routine' with `a_routine'.
		require
			non_void_routine: a_routine /= Void
		do
			routine := a_routine
		ensure
			routine_set: routine = a_routine
		end		

	add_argument (an_argument: ECDP_EXPRESSION) is
			-- Add `an_argument' to `arguments'.
		require
			non_void_arguments: an_argument /= Void
		do
			arguments.extend (an_argument)
		ensure
			arguments_set: arguments.has (an_argument)
		end	
		
invariant
	non_void_arguments: arguments /= Void
	
end -- class ECDP_ROUTINE_INVOKE_EXPRESSION

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