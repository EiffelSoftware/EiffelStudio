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
			ctxt.put_keyword("invariant");
			ctxt.indent_one_more;
			ctxt.continue_on_failure;
			ctxt.next_line;
			ctxt.set_separator (";");
			assertion_list.format (ctxt);
			ctxt.commit;
		end;


end
