indexing 
	description: "Source code generator for method reference expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_ROUTINE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		undefine
			is_equal
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_target: like target) is
			-- Initialize instance.
		require
			non_void_routine: a_routine /= Void
			non_void_target: a_target /= Void
		do
			routine := a_routine
			target := a_target
		ensure
			routine_set: routine = a_routine
			target_set: target = a_target
		end
		
feature -- Access

	routine: CODE_MEMBER_REFERENCE
			-- Routine name
			
	target: CODE_EXPRESSION
			-- Target expression
			
	code: STRING is
			-- | Result := "`target_object'.`routine_name'"
			-- | OR		:= "`routine_name'" if `target_object.name' is_equal "Current" or "current_type.name"
			-- | OR		:= "feature {`target_object'}.`routine_name'" if typeof `target_object' is CODE_TYPE_REFERENCE_EXPRESSION.
			
			-- | Set `dummy_variable' to true if `returned_type_routine' /= Void
			-- Eiffel code of routine reference expression
		local
			l_target_name, l_current: STRING
			l_type_ref_exp: CODE_TYPE_REFERENCE_EXPRESSION
		do
			create Result.make (120)
			if target /= Void then
				l_type_ref_exp ?= target
				if l_type_ref_exp /= Void then
					Result.append ("feature {")
					Result.append (l_type_ref_exp.code)
					Result.append ("}.")
				else
					l_target_name := target.code
					create l_current.make (routine.implementing_type.namespace.count + routine.implementing_type.name.count + 1)
					l_current.append (routine.implementing_type.namespace)
					l_current.append (".")
					l_current.append (routine.implementing_type.eiffel_name)
					if  not l_target_name.is_equal (l_current) and not l_target_name.is_equal ("Current") then
						Result.append (l_target_name)
						Result.append (".")
					end
					if routine.result_type /= Void and then not routine.result_type.full_name.is_equal ("System.Void") then
						set_dummy_variable (True) 
					end
				end
			end
			Result.append (routine.eiffel_name)
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := routine.result_type
			if Result = Void then
				Result := None_type_reference
			end
		end

invariant
	non_void_routine: routine /= Void
	non_void_target: target /= Void
	
end -- class CODE_ROUTINE_REFERENCE_EXPRESSION

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