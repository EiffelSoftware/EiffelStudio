indexing
	description: 
		"AST represenation of an Eiffel feature."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent, location
		end
	COMPARABLE
		undefine
			is_equal
		end
	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature
		end

feature {AST_FACTORY} -- Initialization

	initialize (f: like feature_names; b: like body; i: like indexes; l, s, e: INTEGER) is
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
--			id := System.feature_as_counter.next_id
--			if body.is_unique then
--				System.current_class.set_has_unique
--			end
			create location.reset
			location.set_line_number (l)
			location.set_start_position (s)
			location.set_end_position (e)
			set_start_position
			set_end_position
		ensure
			feature_names_set: feature_names = f
			body_set: body = b
			indexes_set: indexes = i
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_as (Current)
		end

feature {NONE} -- Initialization
 
	set_start_position is
		do
			--| No need to test whether feature_names is empty, because the class is
			--| FEATURE_AS and there is allwas at least one feature name
			location.set_start_position (location.start_position - feature_names.first.offset)
		end

	set_end_position is
		do
			--| No need to test whether feature_names is empty, because the class is
			--| FEATURE_AS and there is allwas at least one feature name
			location.set_end_position (location.end_position + feature_names.first.end_offset)
		end

feature -- Access

	feature_names: EIFFEL_LIST [FEATURE_NAME]
			-- Names of feature

	location: TOKEN_LOCATION
			-- Location of current feature.

	body: BODY_AS
			-- Feature body: this attribute will be compared during
			-- second pass of the compiler in order to see if a feature
			-- has change of body.

	indexes: INDEXING_CLAUSE_AS
			-- Indexing clause for IL to specify `custom attributes' and `alias' name.

--	id: INTEGER
--			-- Id of the current instance used by the temporary AST server
--
--	external_name: STRING is
--			-- External name if any of current feature.
--		require
----			il_generation: System.il_generation
--		do
--			if indexes /= Void then
--				Result := indexes.external_name
--			end
--		end
		
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

--feature -- Setting
--
--	set_id (i: like id) is
--			-- Set `id' to `i'.
--		do
--			id := i
--		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
-- FIXME: see is_equiv
			Result := equivalent (body, other.body) and
				equivalent (feature_names, other.feature_names)
		end

feature -- Access

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

	custom_attributes: EIFFEL_LIST [CUSTOM_ATTRIBUTE_AS] is
			-- Custom attributes of current class if any.
		do
			if indexes /= Void then
				Result := indexes.custom_attributes
			end
		end

feature -- empty body

	is_empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (body = Void) or else (body.is_empty)
		end

feature {NONE} -- Implementation

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

--feature -- default rescue
--
--	create_default_rescue (def_resc_name : STRING) is
--				-- Create default rescue if necessary
--		require
--			valid_feature_name : def_resc_name /= Void
--		do
--			if body /= Void then
--				body.create_default_rescue (def_resc_name)
--			end
--		end

--feature {COMPILER_EXPORTER, AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		local
--			c: EIFFEL_COMMENTS;
--			cont: CONTENT_AS;
--			is_const_or_att: BOOLEAN	
--		do
--			c := ctxt.eiffel_file.current_feature_comments;
--			ctxt.set_feature_comments (c);
--			if feature_names /= Void then
--				ctxt.set_separator (ti_Comma);
--				ctxt.set_space_between_tokens;
--				feature_names.simple_format (ctxt)
--			end
--			body.simple_format (ctxt);
--			cont := body.content;
--			is_const_or_att := cont = Void or else cont.is_constant;
--			if is_const_or_att and then c /= Void then
--				ctxt.new_line;
--				ctxt.indent;
--				ctxt.indent;
--				ctxt.put_comments (c);
--				ctxt.exdent;
--				ctxt.exdent;
--			else
--				ctxt.new_line;
--			end
--		end

--feature {COMPILER_EXPORTER} -- Initialization
-- 
--	set_names (names: like feature_names) is
--		do
--			feature_names := names;
--		end
--
--	set_content (other: like Current) is
--		require
--			good_argument: other /= void
--		do
--			body := other.body;
--			start_position := other.start_position;
--			end_position := other.end_position
--		end
--
--	trace is
--		do
--			io.error.putstring ("FEATURE_AS");
--			io.error.putint (end_position);
--			io.error.new_line;
--			io.error.putint (start_position);
--			io.error.new_line;
--			io.error.putstring (feature_names.first.internal_name);
--			io.error.new_line
--		end
--
--feature {COMPILER_EXPORTER} -- Conveniences
--
--	is_feature_obj: BOOLEAN is True
--			-- Is the current object an instance of FEATURE_AS ?
--


feature

	infix "<" (other: like Current): BOOLEAN is
		do	
			if feature_names = Void then
				Result := False
			elseif other.feature_names = Void then
				Result := True
			else
				Result := feature_names.first < other.feature_names.first;
			end
		end
--
--feature {COMPILER_EXPORTER} -- Incrementality
--
--	is_body_equiv (other: like Current): BOOLEAN is
--			-- Is the current feature equivalent to `other' ?
--		require
--			valid_body: body /= Void
--		do
--			Result := body.is_body_equiv (other.body);
--		end
-- 
--	is_assertion_equiv (other: like Current): BOOLEAN is
--			-- Is the current feature equivalent to `other' ?
--		require
--			valid_body: body /= Void
--		do
--			Result := body.is_assertion_equiv (other.body);
--		end
--
--	check_local_names is
--			-- Check the name conflicts between local variables and
--			-- feature names
--		do
--			body.check_local_names
--		end
--
--feature --{COMPILER_EXPORTER} -- Setting
--
--	set_feature_names (f: like feature_names) is
--			-- Set `feature_names' to `f'
--		do
--			feature_names := f
--		end
--
--	set_body (b: like body) is
--			-- Set `body' to `b'
--		do
--			body := b
--		end				
--
--	update_positions (sp: like start_position; ep: like end_position) is
--			-- Set `start_position' to `sp' and `end_position' to `ep'
--		do
--			start_position := sp
--			end_position := ep
--		ensure
--			start_position_set: start_position = sp
--			end_position_set: end_position = ep
--		end
--
--	update_positions_with_offset (offset: INTEGER) is
--			-- Add `offset' to `start_position' and `end_position'
--			-- reflect the fact that current feature is not at the 
--			-- same position in the source file.
--			--| `offset' may be positive as well as negative.
--		do
--			start_position := start_position + offset
--			end_position := end_position + offset
--		ensure
--			start_position_set: start_position = old start_position + offset
--			end_position_set: end_position = old end_position + offset
--		end

end -- class FEATURE_AS
