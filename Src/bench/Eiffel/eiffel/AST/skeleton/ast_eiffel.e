indexing
	description: "Abstract node produce by yacc. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

deferred class AST_EIFFEL

inherit
	SHARED_ERROR_HANDLER

	SHARED_TEXT_ITEMS
	
	SHARED_WORKBENCH

	SHARED_AST_CONTEXT

	COMPILER_EXPORTER

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (body only)
		do
			-- Return 0 by default
		end

feature {AST_EIFFEL, COMPILER_EXPORTER} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		deferred
		end

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

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text according to context.
		require
			valid_ctxt: ctxt /= Void
		do
			simple_format (ctxt)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		require
			arg_non_void: other /= Void
			same_type: same_type (other)
		deferred
		end

	frozen equivalent (o1, o2: AST_EIFFEL): BOOLEAN is
			-- Are `o1' and `o2' equivalent ?
			-- this feature is similar to `deep_equal'
			-- but ARRAYs and STRINGs are processed correctly
			-- (`deep_equal' will compare the size of the `area')
		do
			if o1 = Void then
				Result := o2 = Void
			else
				Result := o2 /= Void and then o2.same_type (o1) and then
					o1.is_equivalent (o2)
			end
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

feature {SERVER} -- Identity

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			-- Do nothing
		end

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			-- Do nothing
		end

	position: INTEGER is
			-- position of the item in text
		do
			Result := -1
				-- treated as unknown
		end

	line_number : INTEGER is
			-- line of the item in the source text
		do
			Result := -1
				-- treated as unknown
		end

end -- class AST_EIFFEL
