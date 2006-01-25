indexing
	description: "AST rout body Visitor."
	
deferred class
	CODE_AST_ROUT_BODY_VISITOR

inherit
	AST_VISITOR
	CODE_SUPPORT
	
feature {AST_YACC} -- Implementation

	process_external_as (l_as: EXTERNAL_AS) is
			-- Process `l_as'.
		do
		end

	process_deferred_as (l_as: DEFERRED_AS) is
			-- Process `l_as'.
		do
		end

	process_do_as (l_as: DO_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.compound /= Void then
				from
					l_as.compound.start
				until
					l_as.compound.after
				loop
					analyse_statement (l_current_routine, l_as.compound.item)
					l_as.compound.forth
				end
			end
		end

	process_once_as (l_as: ONCE_AS) is
			-- Process `l_as'.
		local
			l_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD
		do
			l_current_routine ?= current_element
			check
				non_void_l_current_routine: l_current_routine /= Void
			end
			if l_as.compound /= Void then
				from
					l_as.compound.start
				until
					l_as.compound.after
				loop
					analyse_statement (l_current_routine, l_as.compound.item)
					l_as.compound.forth
				end
			end
		end

feature {NONE} -- Implementation

	analyse_statement (a_current_routine: SYSTEM_DLL_CODE_MEMBER_METHOD; a_statement: INSTRUCTION_AS) is
			-- analyse statement.
		require
			non_void_a_current_routine: a_current_routine /= Void
		local
			l_statement: SYSTEM_DLL_CODE_STATEMENT
			l_expression: SYSTEM_DLL_CODE_EXPRESSION
			retried: BOOLEAN
		do
			if not retried then
				set_last_element_created (Void)
				a_statement.process (Visitor)

				l_statement ?= last_element_created
				if l_statement /= Void then
					added := a_current_routine.statements.add_code_statement (l_statement)
				else
					l_expression ?= last_element_created
					if l_expression /= Void then
						added := a_current_routine.statements.add_code_expression (l_expression)
					end
				end
			end
		rescue
			Event_manager.process_exception
			retried := True
			retry
		end

end -- CODE_AST_ROUT_BODY_VISITOR
