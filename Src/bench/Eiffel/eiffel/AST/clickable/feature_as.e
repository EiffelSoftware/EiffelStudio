indexing
	description	: "Abstract class for abstract description of Eiffel features. %
				  %Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class FEATURE_AS
		
inherit
	AST_EIFFEL
		redefine
			type_check, byte_node,
			format, fill_calls_list, replicate,
			is_feature_obj, number_of_breakpoint_slots
		end

	COMPARABLE
		undefine
			is_equal
		end

	IDABLE
		rename
			id as body_index,
			set_id as set_body_index
		end

	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature, associated_feature_name
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: like feature_names; b: like body; i: like indexes; s, e: INTEGER) is
			-- Create a new FEATURE AST node.
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
			b_not_void: b /= Void
			can_have_indexes: i /= Void implies f.count = 1
		do
			feature_names := f
			body := b
			indexes := i
			start_position := s
			end_position := e
			id := System.feature_as_counter.next_id
			if body.is_unique then
				System.current_class.set_has_unique
			end
			set_start_position
		ensure
			feature_names_set: feature_names = f
			body_set: body = b
			indexes_set: indexes = i
		end

feature {NONE} -- Initialization
 
	set_start_position is
		do
			--| No need to test whether feature_names is empty, because the class is
			--| FEATURE_AS and there is allwas at least one feature name
			start_position := start_position - feature_names.first.offset
		end

feature -- Access

	feature_names: EIFFEL_LIST [FEATURE_NAME]
			-- Names of feature

	body: BODY_AS
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

	indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for IL to specify `custom attributes' and `alias' name.

	id: INTEGER
			-- Id of the current instance used by the temporary AST server

	start_position, end_position: INTEGER
			-- Start and end of the text of the feature in origin file

	external_name: STRING is
			-- External name if any of current feature.
		require
			il_generation: System.il_generation
		do
			if indexes /= Void then
				Result := indexes.external_name
			end
		end
		
feature -- Property

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	is_attribute: BOOLEAN is
			-- Does Current AST represent an attribute?
		do
			Result := body.content = Void
		end

	is_function: BOOLEAN is
			-- Does Current AST represent a function?
		do
			Result := body.type /= Void and not is_attribute
		end

	is_deferred: BOOLEAN is
			-- Does Current AST represent a deferred feature?
		require
			body_has_content: body.content /= Void
		local
			rout: ROUT_BODY_AS
			routine_as: ROUTINE_AS
		do
			routine_as ?= body.content
			if routine_as /= Void then
				rout := routine_as.routine_body
				if rout /= Void then
					Result := rout.is_deferred
				end
			end
		end

feature -- Setting

	set_id (i: like id) is
			-- Set `id' to `i'.
		do
			id := i
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
-- FIXME: see is_equiv
			Result := equivalent (body, other.body) and
				equivalent (feature_names, other.feature_names)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (inherited pre/postconditions
			-- are not taken into account)
		do
				-- Traverse tree to get the number of slots
			Result := body.number_of_breakpoint_slots
		end

	number_of_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
				-- Traverse tree
			Result := body.number_of_precondition_slots
		end

	number_of_postcondition_slots: INTEGER is
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
				-- Traverse tree
			Result := body.number_of_postcondition_slots
		end

	feature_name: STRING is
			-- Feature name representing AST 
		do
			Result := feature_names.first.internal_name
		end

	feature_with_name (n: STRING): FEATURE_AS is
			-- Feature ast with internal name `n'
		local
			cur: CURSOR
		do
			cur := feature_names.cursor
			from
				feature_names.start
			until
				feature_names.after or else Result /= Void
			loop
				if n.is_equal (feature_names.item.internal_name) then
					Result := Current
				end
				feature_names.forth
			end
			feature_names.go_to (cur)
		end

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
			end
	
			feature_names.go_to (cur)
		end

	is_equiv (other: like Current): BOOLEAN is
			-- Is `other' equivalent to Current?
		require
			other_exists: other /= Void
		local
			cur: CURSOR
		do
			from
				cur := other.feature_names.cursor
				Result := True
				other.feature_names.start
			until
				other.feature_names.after or else not Result
			loop
				Result := has_feature_name (other.feature_names.item)
				other.feature_names.forth
			end
			other.feature_names.go_to (cur)

			if Result then
				Result := body /= Void and then is_body_equiv (other) and is_assertion_equiv (other)
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this feature has the instruction `i'?
		do
			Result := body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of instruction `i' in this feature.
			-- Result is `0' if not found.
		do
			Result := body.index_of_instruction (i)
		end

	custom_attribute: EIFFEL_LIST [CREATION_EXPR_AS] is
			-- Custom attribute of current class if any.
		do
			if indexes /= Void then
				Result := indexes.custom_attribute
			end
		end

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
		end

feature -- empty body

	is_empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (body = Void) or else (body.is_empty)
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
			context.begin_expression
				-- Type check
			body.type_check
		end

	check_local_names is
			-- Check the name conflicts between local variables and
			-- feature names
		do
			body.check_local_names
		end

	byte_node: BYTE_CODE is
			-- Byte code of the feature
		do
				-- Intialization of the access line, multi-type line
				-- and interval line
			context.start_lines
			context.set_has_loop (False)
			Result := body.byte_node
			Result.set_has_loop (context.has_loop)
		end

	new_feature: FEATURE_I is
			-- New Eiffel feature description
		do
			Result := body.new_feature
		end

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
		do
			Result := body.local_table (f)
		end

	local_table_for_format (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
		do
			Result := body.local_table_for_format (f)
		end

feature {COMPILER_EXPORTER} -- Conveniences

	is_feature_obj: BOOLEAN is True
			-- Is the current object an instance of FEATURE_AS ?

	infix "<" (other: like Current): BOOLEAN is
		do	
			if feature_names = Void then
				Result := False
			elseif other.feature_names = Void then
				Result := True
			else
				Result := feature_names.first < other.feature_names.first
			end
		end

feature {COMPILER_EXPORTER} -- Incrementality

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_body_equiv (other.body)
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_assertion_equiv (other.body)
		end

feature -- Stoning
 
	associated_feature_name: STRING is
		do
			Result := feature_names.first.internal_name
		end

feature -- Debugger
 
	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			comments: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN
			feature_dec: FEATURE_DEC_ITEM
		do
			ctxt.begin
			ctxt.new_line
			ctxt.set_separator (ti_Comma)
			ctxt.set_space_between_tokens
			ctxt.abort_on_failure
			create feature_dec.make (feature_names.first.associated_feature_name)
			feature_dec.set_before
			ctxt.put_text_item (feature_dec)
			if ctxt.has_feature_i then
					--| Should only be one feature name
				feature_names.first.main_feature_format (ctxt)
			else
				feature_names.format (ctxt)
			end
			if not ctxt.last_was_printed then
				ctxt.rollback
			else
				body.format (ctxt)
				create feature_dec.make (feature_names.first.associated_feature_name)
				feature_dec.set_after
				ctxt.put_text_item_without_tabs (feature_dec)
				if not ctxt.is_feature_short then
					ctxt.new_line
				end
					-- Print comment if the content of the body is
					-- an attribute or a constant.
				cont := body.content
				is_const_or_att := cont = Void or else cont.is_constant
				if is_const_or_att then
					ctxt.indent
					ctxt.indent
					if ctxt.is_feature_short then
						ctxt.new_line
					end
					comments := ctxt.feature_comments
					if comments /= Void then
						ctxt.put_comments (comments)
					end
					ctxt.put_origin_comment
					ctxt.exdent
					ctxt.exdent
				end
				ctxt.commit
			end
		end

feature -- Replication

	fill_calls_list (l: CALLS_LIST) is
			-- find calls to Current
		do
			body.fill_calls_list (l)
		end

	replicate (ctxt: REP_CONTEXT): like Current is
			  -- Adapt to replication.
		local
			new_feature_names: like feature_names
		do
			Result := clone (Current)
			Result.set_id (System.feature_as_counter.next_id)
			!! new_feature_names.make (1)
			new_feature_names.extend (ctxt.replicated_name)
			Result.set_feature_names (new_feature_names)
			Result.set_body (body.replicate (ctxt))
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_names (f: like feature_names) is
			-- Set `feature_names' to `f'
		do
			feature_names := f
		end

	set_body (b: like body) is
			-- Set `body' to `b'
		do
			body := b
		end;				

	update_positions (sp: like start_position; ep: like end_position) is
			-- Set `start_position' to `sp' and `end_position' to `ep'
		do
			start_position := sp
			end_position := ep
		ensure
			start_position_set: start_position = sp
			end_position_set: end_position = ep
		end

	update_positions_with_offset (offset: INTEGER) is
			-- Add `offset' to `start_position' and `end_position'
			-- reflect the fact that current feature is not at the 
			-- same position in the source file.
			--| `offset' may be positive as well as negative.
		do
			start_position := start_position + offset
			end_position := end_position + offset
		ensure
			start_position_set: start_position = old start_position + offset
			end_position_set: end_position = old end_position + offset
		end

feature {COMPILER_EXPORTER, AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			c: EIFFEL_COMMENTS
			cont: CONTENT_AS
			is_const_or_att: BOOLEAN	
		do
			c := ctxt.eiffel_file.current_feature_comments
			ctxt.set_feature_comments (c)
			if feature_names /= Void then
				ctxt.set_separator (ti_Comma)
				ctxt.set_space_between_tokens
				feature_names.simple_format (ctxt)
			end
			body.simple_format (ctxt)
			cont := body.content
			is_const_or_att := cont = Void or else cont.is_constant
			if is_const_or_att and then c /= Void then
				ctxt.new_line
				ctxt.indent
				ctxt.indent
				ctxt.put_comments (c)
				ctxt.exdent
				ctxt.exdent
			else
				ctxt.new_line
			end
		end

feature {COMPILER_EXPORTER} -- Initialization
 
	set_names (names: like feature_names) is
		do
			feature_names := names
		end

	set_content (other: like Current) is
		require
			good_argument: other /= Void
		do
			body := other.body
			start_position := other.start_position
			end_position := other.end_position
		end

	trace is
		do
			io.error.putstring ("FEATURE_AS")
			io.error.putint (end_position)
			io.error.new_line
			io.error.putint (start_position)
			io.error.new_line
			io.error.putstring (feature_names.first.internal_name)
			io.error.new_line
		end

invariant
	can_have_indexing_clause: indexes /= Void implies feature_names.count = 1

end -- class FEATURE_AS
