-- Description of class invariant

class INVARIANT_AS

inherit

	AST_EIFFEL
		redefine
			is_invariant_obj, type_check, byte_node, format
		end;
	IDABLE;

feature -- Identity

	id: INTEGER;
			-- Class id of the class to which current is the invariant
			-- description

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

feature -- Information

	assertion_list: EIFFEL_LIST [TAGGED_AS];
			-- Assertion list

feature -- Initialization

	set is
			-- Initialization routine
		do
			assertion_list ?= yacc_arg (0);
		end;

feature -- Conveniences

	is_invariant_obj: BOOLEAN is
			-- Is the current object an instance of INVARIANT_AS ?
		do
			Result := True;
		end;

feature -- Type check and byte code

	type_check is
			-- Type check invariant clause
		do
			if assertion_list /= Void then
					-- Set the access id analysis level to `level2': only
				   -- features are taken into account.
				context.begin_expression;
				context.set_level2 (True);
				assertion_list.type_check;
					-- Reset the level
				context.set_level2 (False);
				context.pop (1);
			end;
		end;

	byte_node: BYTE_LIST [BYTE_NODE] is
			-- Invariant byte code
		do
			if assertion_list /= Void then
					-- Intialization of the access line
				context.access_line.start;

				Result := assertion_list.byte_node;
			end;
		end;

	
feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_before_invariant;
			ctxt.put_keyword("invariant");
			ctxt.indent_one_more;
			ctxt.continue_on_failure;
			ctxt.next_line;
			ctxt.set_separator (";");
			ctxt.separator_is_special;
			ctxt.new_line_between_tokens;
			if assertion_list /= Void then
				format_assertions (ctxt);
			end;
			if ctxt.last_was_printed then
				ctxt.commit;
				ctxt.put_after_invariant
			else
				ctxt.rollback
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
				l_count := assertion_list.count;
			until
				i > l_count
			loop
				ctxt.begin;
				if not_first then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				assertion_list.i_th(i).format(ctxt);
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

feature -- Case Storage

	storage_info (classc: CLASS_C): FIXED_LIST [S_ASSERTION_DATA] is
			-- Storage information for Current in the
			-- context class `classc'.
		require
			valid_assertions: assertion_list /= Void
		local	
			ctxt: FORMAT_CONTEXT;
		do
			!! Result.make (assertion_list.count);
			!! ctxt.make_for_case (classc);
			from
				Result.start;
				assertion_list.start
			until
				assertion_list.after
			loop
				Result.replace (assertion_list.item.storage_info (ctxt));
				Result.forth;
				assertion_list.forth
			end
		end;

end
