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
			feature_names, body, set,
			associated_feature_name
		end;

	AST_EIFFEL_B
		undefine
			is_feature_obj
		redefine
			type_check, byte_node, find_breakable, 
			format, fill_calls_list, replicate
		end;
	COMPARABLE
		undefine
			is_equal
		end;
	IDABLE
		rename
			id as body_id,
			set_id as set_body_id
		end

feature -- Access

	feature_names: EIFFEL_LIST_B [FEATURE_NAME_B];
			-- Names of feature

	body: BODY_AS_B;
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

	body_id: BODY_ID;
			-- Body id

	id: FEATURE_AS_ID
			-- Id of the current instance used by the temporary AST server

feature -- Initialization
 
	set is
			-- Yacc initialization
		do
			feature_names ?= yacc_arg (0);
			body ?= yacc_arg (1);
			start_position := yacc_int_arg (0);
			end_position := yacc_int_arg (1);
			id := System.feature_as_counter.next_id;
			if body.is_unique then
				System.current_class.set_has_unique
			end;
			set_start_position;
		ensure then
			feature_names /= Void;
			body /= Void;
		end;

	set_body_id (i: BODY_ID) is
			-- Set `body_id' to `i'.
		do
			body_id := i
		end;

	set_id (i: like id) is
			-- Set `id' to `i'.
		do
			id := i
		end;

feature -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		do
			if body.is_unique then
				from
					feature_names.start
				until
					feature_names.after
				loop
					values.put (counter.next, feature_names.item.internal_name)
					feature_names.forth
				end
			end
		end;

feature -- empty body

	empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (body = Void) or else (body.empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
				-- Create default rescue if necessary
		require
			valid_feature_name : def_resc_name /= Void
		do
			if body /= Void then
				body.create_default_rescue (def_resc_name)
			end
		end

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
 
	associated_feature_name: STRING is
		do
			Result := feature_names.first.internal_name
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
				if ctxt.is_feature_short then
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
					if ctxt.is_feature_short then
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
			Result.set_id (System.feature_as_counter.next_id);
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
