indexing

	description: "Description of class invariant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class INVARIANT_AS_B

inherit

	INVARIANT_AS
		redefine
			assertion_list
		end;

	AST_EIFFEL_B
		undefine
			is_invariant_obj
		redefine
			is_invariant_obj, type_check, byte_node, format
		end;

	IDABLE

feature -- Attribute

	id: CLASS_ID;
			-- Class id of the class to which current is the invariant
			-- description

	assertion_list: EIFFEL_LIST_B [TAGGED_AS_B];
			-- Assertion list

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

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.continue_on_failure;
			ctxt.set_separator (ti_Semi_colon);
			ctxt.set_new_line_between_tokens;
			if assertion_list /= Void then
				format_assertions (ctxt);
			end;
			if ctxt.last_was_printed then
				ctxt.commit;
			else
				ctxt.rollback
			end
		end;

	format_assertions (ctxt: FORMAT_CONTEXT_B) is
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
				assertion_list.i_th (i).format(ctxt);
				if ctxt.last_was_printed then
					not_first := True
					ctxt.commit;
				else
					ctxt.rollback;
				end;
				i := i + 1
			end;
			if not_first then
				ctxt.exdent;
				ctxt.commit
			else
				ctxt.rollback
			end
		end

feature -- Case Storage

	storage_info: FIXED_LIST [S_TAG_DATA] is
			-- Storage information for Current in the
			-- context class `classc'.
		require
			valid_assertions: assertion_list /= Void
		local	
			ctxt: FORMAT_CONTEXT;
		do
			!! Result.make (assertion_list.count);
			!! ctxt.make_for_case;
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

feature -- Status setting

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

end -- class INVARIANT_AS_B
