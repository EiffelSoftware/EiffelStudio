class ASSERT_LIST_AS

inherit

	AST_EIFFEL
		redefine
			type_check, byte_node, format,
			fill_calls_list, replicate
		end

feature -- Attributes

	assertions: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Initialization

	set is
			-- Yacc initialization
		do
			assertions ?= yacc_arg (0);
		end

feature -- Type check, byte code, dead code removal and formatter

	type_check is
			-- Type check assertion list
		do
			if assertions /= Void then
				assertions.type_check;
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Byte node associated to the assertion list
		do
			if assertions /= Void then
				Result := assertions.byte_node;
			end;
		end;

feature -- Incrementality

	reset is
		do
			if assertions /= Void then
				assertions.start
			end;
		end;

feature -- Format

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		local
			source_cl, target_cl: CLASS_C;
		do
			if assertions /= void then
				ctxt.begin;
				ctxt.next_line;
				ctxt.put_keyword (clause_name (ctxt));
				if not ctxt.troff_format then
					source_cl := ctxt.format.global_types.source_class;
					target_cl := ctxt.format.global_types.target_class;
					if source_cl /= target_cl then
						ctxt.put_string (" -- from ");
						ctxt.put_class_name (source_cl);
					end;
				end;
				ctxt.indent_one_more; 
				ctxt.next_line;
				ctxt.set_separator (";");
				ctxt.separator_is_special;
				ctxt.new_line_between_tokens;
				ctxt.continue_on_failure;
				format_assertions (ctxt);
				if ctxt.last_was_printed then
					ctxt.set_first_assertion (false);
					ctxt.commit;
				else
					ctxt.rollback;
				end;
			end 			
		end;

	format_assertions (ctxt: FORMAT_CONTEXT) is
		local
			i, l_count: INTEGER;
			not_first: BOOLEAN
		do
			from
				ctxt.begin;
				i := 1;
				l_count := assertions.count;
			until
				i > l_count 
			loop
				ctxt.begin;
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				assertions.i_th(i).format(ctxt);
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit;
				else
					ctxt.rollback;
				end;
				i := i + 1
			end;
			if not_first then
				ctxt.indent_one_less;
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature	-- Replication

	fill_calls_list (l: CALLS_LIST) is
		do
			if assertions /= void then
				assertions.fill_calls_list (l)
			end
		end;

	replicate (ctxt: REP_CONTEXT): like Current is 
		do
			Result := clone (Current);
			if assertions /= void then
				Result.set_assertions (assertions.replicate (ctxt));
			end;
		end;


feature {ASSERT_LIST_AS} -- Replication

	set_assertions (l: like assertions) is
		do
			assertions := l
		end;
	
feature {NONE}
	
	clause_name (ctxt: FORMAT_CONTEXT): STRING is
			-- name of the assertion: require, require else, ensure, 
			-- ensure then, invariant
		do
		end;

feature {ROUTINE_AS} -- Case Storage

	storage_info (classc: CLASS_C): FIXED_LIST [S_ASSERTION_DATA] is
			-- Assertion storage info for Case in the 
			-- context of class `class_c'
		require
			 valid_assertions: assertions /= Void
		local
			 ctxt: FORMAT_CONTEXT;
		do
			!! Result.make (assertions.count);
			!! ctxt.make_for_case (classc);
			from
				Result.start
				assertions.start
			until
				assertions.after
			loop
				Result.replace (assertions.item.storage_info (ctxt));
				Result.forth;
				assertions.forth
			end
		end;

end
