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
		undefine
			is_equal
		end

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
			if body.is_unique then
				set_unique_values
			end;
			set_start_position;
		ensure then
			feature_names /= Void;
			body /= Void;
		end;

	set_start_position is
		do
			start_position := start_position - feature_names.first.offset
		end;

	set_unique_values is
			-- Store the values of the unique constants
			-- in the AST_CONTEXT (temporary, the hash table is
			-- stored in the CLASS_INFO at the end of pass1)
		local
			unique_values: HASH_TABLE [INTEGER, STRING];
			counter: COUNTER;
		do
			unique_values := context.unique_values;
			if unique_values = Void then
				!!unique_values.make (feature_names.count);
				context.set_unique_values (unique_values);
			end;
			counter := System.current_class.unique_counter;
			from
				feature_names.start
			until
				feature_names.after
			loop
				unique_values.put (	counter.next,
									feature_names.item.internal_name)
				feature_names.forth
			end
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

	trace is
		do
			io.error.putstring ("FEATURE_AS");
			io.error.putint (body_id);
			io.error.new_line;
			io.error.putint (end_position);
			io.error.new_line;
			io.error.putint (start_position);
			io.error.new_line;
			io.error.putstring (feature_names.first.internal_name);
			io.error.new_line;
			io.error.putint (id);
			io.error.new_line;
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
			ctxt.put_text_item (ti_Before_feature_declaration);
			ctxt.next_line;
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;
			ctxt.abort_on_failure;
				--| Should only be one feature name
			feature_names.first.main_feature_format (ctxt)
			if not ctxt.last_was_printed then
				ctxt.rollback;
				ctxt.rollback;
			else
				ctxt.commit;
				body.format (ctxt);
				ctxt.commit;
				ctxt.put_text_item (ti_After_feature_declaration)
			end;
		end;

	new_ast: FEATURE_AS is
		local
			rout_as: ROUTINE_AS;
			rout_fsas: ROUTINE_FSAS;
		do
			rout_as ?= body.content;
			if rout_as = Void then
				Result := Current
			else
				!! Result;
				Result.set_content (Current);
					!! rout_fsas;
					rout_fsas.set_precondition (rout_as.precondition);
					rout_fsas.set_locals (rout_as.locals);
					rout_fsas.set_routine_body (rout_as.routine_body); 
					rout_fsas.set_postcondition (rout_as.postcondition);
					rout_fsas.set_rescue_clause (rout_as.rescue_clause);
					rout_fsas.set_obsolete_message (rout_as.obsolete_message);
				Result.body.set_content (rout_fsas);
				Result.set_names (feature_names);
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
			Result := clone (Current);
			Result.set_id (System.feature_counter.next);
			!!new_feature_names.make (1);
			new_feature_names.go_i_th (1);
			new_feature_names.replace (ctxt.replicated_name);
			Result.set_feature_names (new_feature_names);
			Result.set_body (body.replicate (ctxt));
		end;


feature {ASSERT_SERVER, FEATURE_AS, NAMES_ADAPTER}	-- Replication

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

	set_feature_assertions (feat: FEATURE_I; a: CHAINED_ASSERT) is
		require
			valid_feat: feat /= Void;
			valid_arg2: a /= Void
		local
			rout_fsas: ROUTINE_FSAS
		do
			rout_fsas ?= body.content;	--| Cannot fail
			rout_fsas.set_feature_assertions (feat, Current, a);
		end;

feature {FEATURE_CLAUSE_AS, FEATURE_CLAUSE_EXPORT} -- Case storage

	storage_info: S_FEATURE_DATA is
			-- Storage information for Current
		require
			not_be_called: False
		do
		end;

feature {FEATURE_AS, CASE_RECORD_INHERIT_INFO} -- Case storage

	store_information (classc: CLASS_C; f: S_FEATURE_DATA) is
			-- Store current information into `f'.
		require
			valid_f: f /= Void
		local
			rout_as: ROUTINE_AS;
		do
			rout_as ?= body.content;
			if rout_as /= Void then
				rout_as.store_information (classc, f)
			end
		end;

end
