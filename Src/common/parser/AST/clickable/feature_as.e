indexing
	description	: "Abstract class for abstract description of Eiffel features."
	date		: "$Date$"
	revision	: "$Revision$"

class FEATURE_AS
		
inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots
		end

	COMPARABLE
		undefine
			is_equal
		end

	IDABLE

	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature, feature_name
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_names; b: like body; i: like indexes; an_id: like id; a_pos: like next_position) is
			-- Create a new FEATURE AST node.
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
			b_not_void: b /= Void
			can_have_indexes: i /= Void implies f.count = 1
			a_pos_non_negative: a_pos >= 0
		do
			feature_names := f
			body := b
			indexes := i
			id := an_id
			next_position := a_pos
		ensure
			feature_names_set: feature_names = f
			body_set: body = b
			indexes_set: indexes = i
			id_set: id = an_id
			next_position_set: next_position = a_pos
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_feature_as (Current)
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

	external_name: STRING is
			-- External name if any of current feature.
		do
			if indexes /= Void then
				Result := indexes.external_name
			end
		end

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := feature_names.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := body.end_location
			if Result.is_null then
				Result := feature_names.end_location
			end
		end
		
	next_position: INTEGER
			-- Position for the following construct after current.
			-- Useful to extract comments of an attribute
		
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

feature {COMPILER_EXPORTER} -- Setting

	set_feature_names (f: like feature_names) is
			-- Set `feature_names' to `f'
		require
			f_not_void: f /= Void
			f_not_empty: not f.is_empty
		do
			feature_names := f
		ensure
			feature_names_set: feature_names = f
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
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

	feature_name: ID_AS is
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

feature {COMPILER_EXPORTER} -- Conveniences

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
		local
			is_process_context: BOOLEAN
			other_is_process_context: BOOLEAN
		do
			Result := body.is_body_equiv (other.body)
			if Result then
				if indexes /= Void then
					is_process_context := indexes.has_global_once
				end
				if other.indexes /= Void then
					other_is_process_context := other.indexes.has_global_once
				end
				Result := is_process_context = other_is_process_context
			end
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require
			valid_body: body /= Void
		do
			Result := body.is_assertion_equiv (other.body)
		end

invariant
	feature_names_not_void: feature_names /= Void
	feature_names_not_empty: not feature_names.is_empty
	body_not_void: body /= Void
	can_have_indexing_clause: indexes /= Void implies feature_names.count = 1
	next_position_non_negative: next_position >= 0

end -- class FEATURE_AS
