class ASSERT_LIST_AS

inherit
	AST_EIFFEL
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			assertions ?= yacc_arg (0)
		end

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (assertions, other.assertions)
		end

feature -- Access

	has_assertion (a: TAGGED_AS): BOOLEAN is
			-- Does current list have assertion `a'?
		local
			cur: CURSOR
		do
			cur := assertions.cursor
	
			from 
				assertions.start
			until
				assertions.after or else Result
			loop
				Result := assertions.item.is_equiv (a)
				assertions.forth
			end

			assertions.go_to (cur)
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check assertion list
		do
			if assertions /= Void then
				assertions.type_check
			end
		end

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte node associated to the assertion list
		do
			if assertions /= Void then
				Result := assertions.byte_node
			end
		end

feature -- Format

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		local
			source_cl, target_cl: CLASS_C
		do
			if assertions /= Void then
				ctxt.begin
				put_clause_keywords (ctxt)
				source_cl := ctxt.global_adapt.source_enclosing_class
				target_cl := ctxt.global_adapt.target_enclosing_class
				if source_cl /= target_cl then
					ctxt.put_space
					ctxt.put_text_item (ti_Dashdash)
					ctxt.put_space
					ctxt.put_comment_text ("from ")
					ctxt.put_classi (source_cl.lace_class)
				end
				ctxt.indent; 
				ctxt.new_line
				ctxt.set_separator (ti_Semi_colon)
				ctxt.set_new_line_between_tokens
				ctxt.continue_on_failure
				format_assertions (ctxt)
				ctxt.exdent
				if ctxt.last_was_printed then
					ctxt.set_first_assertion (false)
					ctxt.commit
				else
					ctxt.rollback
				end
			end 			
		end

	format_assertions (ctxt: FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			from
				ctxt.begin
				i := 1
				l_count := assertions.count
			until
				i > l_count 
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.begin
				ctxt.new_expression
				assertions.i_th(i).format(ctxt)
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit
				else
					ctxt.rollback
				end
				i := i + 1
			end
			if not_first then
				ctxt.exdent
				ctxt.new_line
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			if assertions /= Void then
				assertions.fill_calls_list (l)
			end
		end

	replicate (ctxt: REP_CONTEXT): like Current is 
		do
			Result := clone (Current)
			if assertions /= Void then
				Result.set_assertions (assertions.replicate (ctxt))
			end
		end


feature {NONE}
	
	put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append the assertion keywords ("require", "require else",
			-- "ensure", "ensure then" or "invariant").
		do
		end

feature {ROUTINE_AS} -- Case Storage

	storage_info: FIXED_LIST [S_TAG_DATA] is
			-- Assertion storage info for Case in the 
			-- context of class `class_c'
		require
			 valid_assertions: assertions /= Void
		local
			 ctxt: FORMAT_CONTEXT
		do
			!! Result.make_filled (assertions.count)
			!! ctxt.make_for_case
			from
				Result.start
				assertions.start
			until
				assertions.after
			loop
				Result.replace (assertions.item.storage_info (ctxt))
				Result.forth
				assertions.forth
			end
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			if assertions /= Void then
				simple_put_clause_keywords (ctxt)
				ctxt.new_line
				ctxt.set_new_line_between_tokens
				ctxt.indent
				simple_format_assertions (ctxt)
				ctxt.exdent
			end
		end

	simple_format_assertions (ctxt: FORMAT_CONTEXT) is
			-- Format assertions.
		local
			i, l_count: INTEGER
			not_first: BOOLEAN
		do
			ctxt.begin
			from
				i := 1
				l_count := assertions.count
			until
				i > l_count
			loop
				if not_first then
					ctxt.put_separator
				end
				ctxt.new_expression
				ctxt.begin
				assertions.i_th (i).simple_format(ctxt)
				ctxt.commit
				not_first := True
				i := i + 1
			end
			if l_count > 0 then
				ctxt.new_line
			end
			ctxt.commit
		end

feature {ASSERT_LIST_AS, REQUIRE_MERGER, ENSURE_MERGER} -- Replication

	set_assertions (l: like assertions) is
		do
			assertions := l
		end
	
feature {NONE}
	
	simple_put_clause_keywords (ctxt: FORMAT_CONTEXT) is
			-- Append the assertion keywords ("require", "require else",
			-- "ensure", "ensure then" or "invariant").
		do
		end

end -- class ASSERT_LIST_AS
