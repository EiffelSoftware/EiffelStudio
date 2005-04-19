indexing
	description	: "Abstract description of the content of a standard %
				  %feature. Version for Bench."
	date		: "$Date$"
	revision	: "$Revision$"

class ROUTINE_AS

inherit
	CONTENT_AS
		redefine
			is_require_else, is_ensure_then,
			has_rescue, has_precondition, has_postcondition,
			create_default_rescue, is_empty,
			number_of_precondition_slots,
			number_of_postcondition_slots,
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like obsolete_message; pr: like precondition;
		l: like locals; b: like routine_body; po: like postcondition;
		r: like rescue_clause; p: INTEGER; ek: like end_keyword;
		oms_count: like once_manifest_string_count) is
			-- Create a new ROUTINE AST node.
		require
			b_not_void: b /= Void
			ek_not_void: ek /= Void
			valid_oms_count: oms_count >= 0
		do
			obsolete_message := o
			precondition := pr
			locals := l
			routine_body := b
			postcondition := po
			rescue_clause := r
			body_start_position := p
			end_keyword := ek
			once_manifest_string_count := oms_count
		ensure
			obsolete_message_set: obsolete_message = o
			precondition_set: precondition = pr
			locals_set: locals = l
			routine_body_set: routine_body = b
			postcondition_set: postcondition = po
			rescue_clause_set: rescue_clause = r
			body_start_position_set: body_start_position = p
			end_keyword_set: end_keyword = ek
			once_manifest_string_count_set: once_manifest_string_count = oms_count
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_routine_as (Current)
		end

feature -- Attributes

	body_start_position: INTEGER
			-- Position at the start of the main body (after the comments)
			
	obsolete_message: STRING_AS
			-- Obsolete clause message
			-- (Void if was not present)

	precondition: REQUIRE_AS
			-- Precondition list

	locals: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local declarations

	routine_body: ROUT_BODY_AS
			-- Routine body

	postcondition: ENSURE_AS
			-- Routine postconditions

	rescue_clause: EIFFEL_LIST [INSTRUCTION_AS]
			-- Rescue compound

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings in precondition,
			-- body, postcondition and rescue clause

	end_keyword: LOCATION_AS
			-- Location for `end' keyword

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if obsolete_message /= Void then
				Result := obsolete_message.start_location
			elseif precondition /= Void then
				Result := precondition.start_location
			elseif locals /= Void then
				Result := locals.start_location
			else
				Result := routine_body.start_location
				if Result.is_null then
					Result := end_keyword
				end
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := end_keyword
		end

feature -- Properties

	is_require_else: BOOLEAN is
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
			--|Note: It is valid to not include a precondition in 
			--|a redefined feature (it is equivalent to "require else False")
		do
			Result := precondition = Void or else precondition.is_else
		end

	is_ensure_then: BOOLEAN is
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
			--|Note: It is valid to not include a postcondition in 
			--|a redefined feature (it is equivalent to "ensure then True"
		do
			Result := postcondition = Void or else postcondition.is_then
		end

	has_precondition: BOOLEAN is
			-- Has the routine content a preconditions ?
		do
			Result := not (	precondition = Void
							or else
							precondition.assertions = Void)
		end

	has_postcondition: BOOLEAN is
			-- Has the routine content postconditions ?
		do
			Result := not (	postcondition = Void
							or else
							postcondition.assertions = Void)
		end

	has_rescue: BOOLEAN is
			-- Has the routine a non-empty rescue clause ?
		do
			Result := (rescue_clause /= Void) and then
					  not rescue_clause.is_empty
		end

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			Result := routine_body.is_deferred
		end

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			Result := routine_body.is_once
		end

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			Result := routine_body.is_external
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST (pre/post condition
			-- included but the ones inherited)
		do
				-- At least one stoppoint, the one corresponding
				-- to the feature end.
			Result := 1 

				-- Add the body stop points
			if routine_body /= Void then
				Result := Result + routine_body.number_of_breakpoint_slots
			end

				-- Add the rescue stop points
			if has_rescue then
				Result := Result + rescue_clause.number_of_breakpoint_slots
			end

				-- Add the pre/postconditions slots
			Result := Result + number_of_precondition_slots + number_of_postcondition_slots
		end

	number_of_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
			if has_precondition then
				Result := precondition.number_of_breakpoint_slots
			end
		end

	number_of_postcondition_slots: INTEGER is
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
			if has_postcondition then
				Result := postcondition.number_of_breakpoint_slots
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this routine has instruction `i'?
		do
			Result := routine_body.has_instruction (i)
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this routine.
		do	
			Result := routine_body.index_of_instruction (i)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_body_equiv (other) and is_assertion_equiv (other)
		end

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		do
			Result := equivalent (routine_body, other.routine_body) and then
				equivalent (locals, other.locals) and then
				equivalent (rescue_clause, other.rescue_clause) and then
				equivalent (obsolete_message, other.obsolete_message)
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the current feature equivalent to `other' ?
		require else
			valid_other: other /= Void
		do
			Result := equivalent (precondition, other.precondition) and then
				equivalent (postcondition, other.postcondition)
		end

feature -- test for empty body

	is_empty : BOOLEAN is
		do
			Result := (routine_body = Void) or else (routine_body.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
		local
			def_resc_id   : ID_AS
			def_resc_call : ACCESS_ID_AS
			def_resc_instr: INSTR_CALL_AS
		do
			if rescue_clause = Void and then
			   not (routine_body.is_deferred or routine_body.is_external) then
				create def_resc_id.initialize (def_resc_name)
				def_resc_id.set_position (end_keyword.line, end_keyword.column, 
					end_keyword.position, end_keyword.location_count)				
				create def_resc_call.initialize (def_resc_id, Void)
				create def_resc_instr.initialize (def_resc_call)
				create rescue_clause.make (1)
				rescue_clause.extend (def_resc_instr)
			end
		end

invariant
	routine_body_not_void: routine_body /= Void
	end_keyword_not_void: end_keyword /= Void

end -- class ROUTINE_AS
