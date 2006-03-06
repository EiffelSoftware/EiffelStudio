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

	make (a_target: CODE_EXPRESSION; a_arguments: LIST [CODE_EXPRESSION]) is
			-- Initialize instance.
		do
			arguments := a_arguments
			target := a_target
		ensure
			arguments_set: arguments = a_arguments
			target_set: target = a_target
		end
		
feature -- Access

	arguments: LIST [CODE_EXPRESSION]
			-- Delegate arguments
	
	target: CODE_EXPRESSION
			-- Target object
			
	code: STRING is
			-- | Result := `target_object' (`arguments', ...)
			-- Eiffel code of delegate invoke expression
			-- NOT SUPPORTED YET !!!
		do
			create Result.make (120)
			Result.append ("must be done (CODE_DELEGATE_INVOKE_EXPRESSION)")
			Result.append (target.code)
			Result.append (" (")
			from
				arguments.start
				if not arguments.after then
					Result.append (arguments.item.code)
				end
				arguments.forth
			until
				arguments.after
			loop
				Result.append (", ")
				Result.append (arguments.item.code)
				arguments.forth
			end
			Result.append_character (')')
			Event_manager.raise_event ({CODE_EVENTS_IDS}.not_supported, ["delegate invoke expression"])
		end
		
feature -- Status Report
	
	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := target.type
		end
	
invariant
	non_void_arguments: arguments /= Void
	non_void_target: target /= Void

end -- class CODE_DELEGATE_INVOKE_EXPRESSION

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