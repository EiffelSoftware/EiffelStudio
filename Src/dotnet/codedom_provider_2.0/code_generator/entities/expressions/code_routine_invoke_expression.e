indexing 
	description: "Source code generator for method invocation expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_ROUTINE_INVOKE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_arguments: like arguments) is
			-- Initialize `routine' and `arguments'.
		require
			non_void_routine: a_routine /= Void
		do
			routine := a_routine
			arguments := a_arguments
		ensure
			routine_set: routine = a_routine
			arguments_set: arguments = a_arguments
		end
		
feature -- Access

	routine: CODE_REFERENCE_EXPRESSION
			-- Routine to invoke
			
	arguments: LIST [CODE_EXPRESSION] 
			-- Routine arguments
			
	code: STRING is
			-- | Result := "`routine'[ (`arguments',...)]"
			-- Eiffel code of routine invoke expression
		local
			l_argument: CODE_EXPRESSION
		do
			create Result.make (120)
			Result.append (routine.code)
			
			if arguments /= Void then
				from
					arguments.start
					if not arguments.after then
						l_argument := arguments.item
						if l_argument /= Void then
							Result.append (" (")
							Result.append (l_argument.code)
						end
						arguments.forth
					end
				until
					arguments.after
				loop
					l_argument := arguments.item
					if l_argument /= Void then
						Result.append (", ")
						Result.append (l_argument.code)
					end
					arguments.forth
				end
				if arguments.count > 0 then
					Result.append_character (')')
				end
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := routine.type
		end
		
invariant
	non_void_routine: routine /= Void
	
end -- class CODE_ROUTINE_INVOKE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------