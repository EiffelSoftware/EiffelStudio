-- Abstract node produce by yacc

deferred class AST_EIFFEL

inherit

	AST_YACC;
	SHARED_WORKBENCH;
	SHARED_TYPES;
	SHARED_ERROR_HANDLER;
	SHARED_ARG_TYPES;
	SHARED_AST_CONTEXT;

feature {SERVER} -- Identity

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			-- Do nothing
		end;

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			-- Do nothing
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Recursive type check
		do
			-- Do nothing
		end;

	byte_node: BYTE_NODE is
			-- Byte node associated to node
		do
			-- Do nothing
		end;

feature -- Debugger
 
	find_breakable is
			-- Recursive traversal of the AST to record breakable points.
		do
			-- Do nothing
		end;
 
	record_break_node is
			-- Record node in instruction FIFO stack.
		do
			context.instruction_line.insert (Current);
		end

end
