-- Abstract class for abstract descritpion of Eiffel features

class FEATURE_AS
		
inherit

	AST_EIFFEL
		redefine
			is_feature_obj, simple_format
		end;
--	STONABLE;
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
			--id := System.feature_counter.next;
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
			--counter: COUNTER;
		do
			--unique_values := context.unique_values;
			if unique_values = Void then
				!!unique_values.make (feature_names.count);
			--	context.set_unique_values (unique_values);
			end;
			--counter := System.current_class.unique_counter;
			from
				feature_names.start
			until
				feature_names.after
			loop
			--	unique_values.put (	counter.next,
		--							feature_names.item.internal_name)
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

	check_local_names is
			-- Check the name conflicts between local variables and
			-- feature names
		do
			body.check_local_names
		end;

	start_position, end_position: INTEGER
			-- Start and end of the text of the feature in origin file

feature -- Status report

	has_feature_name (n: FEATURE_NAME): BOOLEAN is
			-- Does this feature has the name `n'?
		local
			cur: CURSOR
		do
			cur := feature_names.cursor

			from
				feature_names.start
			until
				feature_names.after or else Result
			loop
				Result := feature_names.item >= n and feature_names.item <= n
				feature_names.forth
			end;
	
			feature_names.go_to (cur)
		end;

	is_equiv (o: like Current): BOOLEAN is
			-- Is `o' equivalent to Current?
		require
			o_exists: o /= Void
		local
			cur: CURSOR
		do
			from
				cur := o.feature_names.cursor
				Result := True
				o.feature_names.start
			until
				o.feature_names.after or else not Result
			loop
				Result := has_feature_name (o.feature_names.item)
				o.feature_names.forth
			end
			o.feature_names.go_to (cur)

			if Result then
				Result := body /= Void and then is_body_equiv (o) and is_assertion_equiv (o)
			end
		end;

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this feature has the instruction `i'?
		do
			Result := body.has_instruction (i)
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of instruction `i' in this feature.
			-- Result is `0' if not found.
		do
			Result := body.index_of_instruction (i)
		end;

feature -- Formatter

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.begin;
			ctxt.put_text_item (ti_Before_feature_declaration);
			ctxt.set_separator (ti_Comma);
			ctxt.space_between_tokens;
			--ctxt.abort_on_failure;

			if feature_names /= Void then
				feature_names.simple_format (ctxt)
			end
			if ctxt.last_was_printed then
				ctxt.commit;
				body.simple_format (ctxt);
				format_comment (ctxt);
				ctxt.next_line;
				ctxt.commit;
				ctxt.put_text_item (ti_After_feature_declaration)
			end;
		end;

	set_comment (c: EIFFEL_COMMENTS) is
		do
		end;

	format_comment (ctxt: FORMAT_CONTEXT) is
		do
		end;

	new_ast: FEATURE_AS is
		local
			rout_as: ROUTINE_AS;
		do
			rout_as ?= body.content;
			if rout_as = Void then
				Result := Current
			else
				!! Result;
				Result.set_content (Current);
				Result.set_names (feature_names);
			end;
		end;

feature {FEATURE_AS, NAMES_ADAPTER, FEATURE_AS_MERGER, USER_CMD, CMD}	-- Replication

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
