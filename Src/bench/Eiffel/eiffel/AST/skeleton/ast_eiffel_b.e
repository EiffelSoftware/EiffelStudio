indexing
	description: "Abstract node produce by yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_EIFFEL_B

inherit
	AST_EIFFEL
		undefine
			number_of_stop_points
		end

	SHARED_WORKBENCH

	SHARED_AST_CONTEXT

	COMPILER_EXPORTER

feature -- Type check, byte code and dead code removal

	type_check is
			-- Recursive type check
		do
			-- Do nothing
		end

	byte_node: BYTE_NODE is
			-- Byte node associated to node
		do
			-- Do nothing
		end

feature -- Debugger
 
	find_breakable is
			-- Recursive traversal of the AST to record breakable points.
		do
			-- Do nothing
		end
 
	record_break_node is
			-- Record node in instruction FIFO stack.
		do
			context.instruction_line.insert (Current);
		end

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconsitute text according to context.
		require
			valid_ctxt: ctxt /= Void
		do
			simple_format (ctxt)
		end
		
feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			-- Do nothing
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			-- adapt to replication
		do
			Result := clone (Current)
		end
		
end -- class AST_YACC_B
