-- Abstract class for abstract descritpion of Eiffel features

class FEATURE_AS
		
inherit

	AST_EIFFEL
		redefine
			is_feature_obj, type_check, byte_node,
			find_breakable, format,
			fill_calls_list, replicate
		end;
	IDABLE
		rename
			id as body_id,
			set_id as set_body_id
		end;
	STONABLE;
	COMPARABLE

feature -- Attributes

	body_id: INTEGER;
			-- Id for the feature server

	id: INTEGER;
			-- Id of the current instance used by the temporary AST
			-- server.

	feature_names: EIFFEL_LIST [FEATURE_NAME];
			-- Names of feature


	body: BODY_AS;
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

feature -- Initialization
 
	set is
			-- Yacc initialization
		do
			feature_names ?= yacc_arg (0);
			body ?= yacc_arg (1);
            start_position := yacc_int_arg (0);
            end_position := yacc_int_arg (1);
			id := System.feature_counter.next;
		ensure then
			feature_names /= Void;
			body /= Void;
		end;


	set_names (names: like feature_names) is
		do
			feature_names := names;
		end;

	set_content (other: like Current) is
		require
			good_argument: other /= void
		do
			body := other.body;
			start_position := other.start_position;
			end_position := other.end_position;
			id := other.id;
		end;

feature -- Conveniences

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	is_feature_obj: BOOLEAN is
			-- Is the current object an instance of FEATURE_AS ?
		do
			Result := True;
		end;

	infix "<" (other: like Current): BOOLEAN is
		do	
			Result := feature_names.first < other.feature_names.first;
		end;

feature -- Incrementality

	equiv (other: like Current): BOOLEAN is 
			-- Is the current feature equivalent to `other' ?
		do
			Result := deep_equal (body, other.body);
		end;

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_body_equiv (other.body);
		end;
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_assertion_equiv (other.body);
		end;

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check on body
		do
				-- Initialization of the context stack
			context.begin_expression;
				-- Type check
			body.type_check;
		end;

	check_local_names is
			-- Check the name conflicts between local variables and
			-- feature names
		do
			body.check_local_names
		end;

	byte_node: BYTE_CODE is
			-- Byte code of the feature
		do
				-- Intialization of the access line, multi-type line
				-- and interval line
			context.start_lines;

			Result := body.byte_node;
		end;

	new_feature: FEATURE_I is
			-- New Eiffel feature description
		do
			Result := body.new_feature;
		end;

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
		do
			Result := body.local_table (f);
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): FEATURE_STONE is
		local
			a_feature_i: FEATURE_I
		do
			a_feature_i := reference_class.feature_named (feature_names.first.internal_name);
			!!Result.make (a_feature_i, reference_class, start_position, end_position)
		end;

	start_position, end_position: INTEGER
			-- Start and end of the text of the feature in origin file


feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
			-- Definition: a breakable instruction is an Eiffel instruction
			-- which may be followed by a breakpoint.
		do
			context.start_lines;	-- Initialize instruction FIFO stack
			body.find_breakable;	-- Traverse tree to record instructions
		end;

feature -- Formatter

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.begin;
			ctxt.set_separator(",");
			ctxt.no_new_line_between_tokens;
			ctxt.abort_on_failure;
			feature_names.format (ctxt);
			if not ctxt.last_was_printed then
				ctxt.rollback;
				ctxt.rollback;
			else
				ctxt.commit;
				body.format (ctxt);
				ctxt.commit;
			end;
		end;

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			body.fill_calls_list (l);
		end;

	replicate (ctxt: REP_CONTEXT): like Current is
			  -- Adapt to replication.
		local
			new_feature_names: like feature_names;
		do
			Result := twin;
			Result.set_id (System.feature_counter.next);
			!!new_feature_names.make (1);
			new_feature_names.go_i_th (1);
			new_feature_names.replace (ctxt.replicated_name);
			Result.set_feature_names (new_feature_names);
			Result.set_body (body.replicate (ctxt));
		end;


feature {FEATURE_AS}	-- Replication

	set_feature_names (f: like feature_names) is
		do
			feature_names := f
		end;

	set_body (b: like body) is
		do
			body := b
		end;				

	set_id (i: like id) is
		do
			id := i
		end;				

end
