indexing

	description:
			"Abstract class for abstract description of Eiffel features. %
			%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class FEATURE_AS_B
		
inherit

	FEATURE_AS
		redefine
			feature_names, body, set_unique_values, set
		end;

	AST_EIFFEL_B
		undefine
			is_feature_obj
		redefine
			type_check, byte_node, find_breakable, 
			format, fill_calls_list, replicate
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

	feature_names: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Names of feature

	body: BODY_AS_B;
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

feature -- Access

	feature_with_name (n: STRING): FEATURE_AS_B is
			-- Feature ast with internal name `n'
		local
			cur: CURSOR;
		do
			cur := feature_names.cursor;
			from
				feature_names.start
			until
				feature_names.after or else Result /= Void
			loop
				if n.is_equal (feature_names.item.internal_name) then
					Result := Current
				end;
				feature_names.forth
			end
			feature_names.go_to (cur)
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

	local_table_for_format (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
		do
			Result := body.local_table_for_format (f);
		end;

feature -- Stoning
 
	stone (reference_class: CLASS_C): FEATURE_STONE is
		local
			a_feature_i: FEATURE_I
		do
			a_feature_i := reference_class.feature_named 
								(feature_names.first.internal_name);
			!!Result.make_with_positions (a_feature_i, reference_class, start_position, 
											end_position)
		end;

feature -- Debugger
 
	find_breakable is
			-- Look for breakable instructions.
			-- Definition: a breakable instruction is an Eiffel instruction
			-- which may be followed by a breakpoint.
		do
			context.start_lines;	-- Initialize instruction FIFO stack
			body.find_breakable;	-- Traverse tree to record instructions
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		local
			comments: EIFFEL_COMMENTS;
			cont: CONTENT_AS_B;
			is_const_or_att: BOOLEAN;
		do
			ctxt.begin;
			ctxt.new_line;
			ctxt.set_separator (ti_Comma);
			ctxt.set_space_between_tokens;
			ctxt.abort_on_failure;
			ctxt.put_text_item (ti_Before_feature_declaration);
			if ctxt.has_feature_i then
					--| Should only be one feature name
				feature_names.first.main_feature_format (ctxt)
			else
				feature_names.format (ctxt)
			end;
			if not ctxt.last_was_printed then
				ctxt.rollback;
			else
				body.format (ctxt);
				if ctxt.is_short then
					ctxt.put_text_item_without_tabs (ti_After_feature_declaration)
				else
					ctxt.put_text_item_without_tabs (ti_Semi_colon);
					ctxt.put_text_item_without_tabs (ti_After_feature_declaration)
					ctxt.new_line;
				end;
					-- Print comment if the content of the body is
					-- an attribute or a constant.
				cont := body.content;
				is_const_or_att := cont = Void or else cont.is_constant;
				if is_const_or_att then
					ctxt.indent;
					ctxt.indent;
					if ctxt.is_short then
						ctxt.new_line;
					end;
					comments := ctxt.feature_comments;
					if comments /= Void then
						ctxt.put_comments (comments);
					end;
					ctxt.put_origin_comment;
					ctxt.exdent;
					ctxt.exdent;
				end;
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
			Result := clone (Current);
			Result.set_id (System.feature_counter.next);
			!!new_feature_names.make (1);
			new_feature_names.go_i_th (1);
			new_feature_names.replace (ctxt.replicated_name);
			Result.set_feature_names (new_feature_names);
			Result.set_body (body.replicate (ctxt));
		end;

feature {FEATURE_CLAUSE_AS_B, FEATURE_CLAUSE_EXPORT} -- Case storage

	storage_info: S_FEATURE_DATA is
			-- Storage information for Current
		require
			not_be_called: False
		do
		end;

feature {FEATURE_ADAPTER, CASE_RECORD_INHERIT_INFO} -- Case storage

	store_information (f: S_FEATURE_DATA) is
			-- Store current information into `f'.
		require
			valid_f: f /= Void
		local
			rout_as: ROUTINE_AS_B;
		do
			rout_as ?= body.content;
			if rout_as /= Void then
				rout_as.store_information (f)
			end
		end;

end -- class FEATURE_AS_B
