indexing
	description	: "Abstract description of the body of an Eiffel feature."
	date		: "$Date$"
	revision	: "$Revision$"

class BODY_AS

inherit
	AST_EIFFEL
		redefine
			number_of_breakpoint_slots, is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like arguments; t: like type; c: like content) is
			-- Create a new BODY AST node.
		do
			arguments := a
			type := t
			content := c
		ensure
			arguments_set: arguments = a
			type_set: type = t
			content_set: content = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_body_as (Current)
		end

feature -- Attributes

	arguments: EIFFEL_LIST [TYPE_DEC_AS]
			-- List (of list) of arguments

	type: TYPE_AS
			-- Type if any

	content: CONTENT_AS
			-- Content of the body: constant or regular body

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			if arguments /= Void then
				Result := arguments.start_location
			elseif type /= Void then
				Result := type.start_location
			elseif content /= Void then
				Result := content.start_location
			else
				Result := null_location
			end
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if content /= Void then
				Result := content.end_location
			elseif type /= Void then
				Result := type.end_location
			elseif arguments /= Void then
				Result := arguments.end_location
			else
				Result := null_location
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (arguments, other.arguments) and
				equivalent (content, other.content) and
				equivalent (type, other.type)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if content /= Void then
				Result := content.number_of_breakpoint_slots
			end
		end

	number_of_precondition_slots: INTEGER is
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
			if content /= Void then
				Result := content.number_of_precondition_slots
			end
		end

	number_of_postcondition_slots: INTEGER is
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
			if content /= Void then
				Result := content.number_of_postcondition_slots
			end
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this body has instruction `i'?
		do
			if content /= Void then
				Result := content.has_instruction (i)
			else
				Result := False
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if content /= Void then
				Result := content.index_of_instruction (i)
			else
				Result := 0
			end
		end

feature -- empty body

	is_empty : BOOLEAN is
				-- Is body empty?
		do
			Result := (content = Void) or else (content.is_empty)
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
				-- Create default rescue if necessary
		require
			valid_feature_name : def_resc_name /= Void
		do
			if content /= Void then
				content.create_default_rescue (def_resc_name)
			end
		end

feature -- Type check, byte code and dead code removal

	is_unique: BOOLEAN is
		do
			Result := content /= Void and then content.is_unique
		end

feature -- New feature description
	
	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the body of current feature equivalent to 
			-- body of `other' ?
		do
			Result := equivalent (type, other.type) and then
					equivalent (arguments, other.arguments)
			if Result then
				if (content = Void) and (other.content = Void) then
				elseif (content = Void) or else (other.content = Void) then
					Result := False
				elseif (content.is_constant = other.content.is_constant) then
						-- The two objects are of the same type.
						-- There is no global typing problem.
					Result := content.is_body_equiv (other.content)
				else
					Result := False
				end
			end
		end
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the assertion of Current feature equivalent to 
			-- assertion of `other' ?
			--|Note: This test is valid since assertions are generated
			--|along with the body code. The assertions will be re-generated
			--|whenever the body has changed. Therefore it is not necessary to
			--|consider the cases in which one of the contents is a ROUTINE_AS 
			--|and the other a CONSTANT_AS (The True value is actually returned
			--|but we don't care.
			--|Non-constant attributes have a Void content. In any case 
			--|involving at least on attribute, the True value is retuned:
			--|   . If they are both attributes, the assertions are equivalent
			--|   . If only on is an attribute, we don't care since the bodies will
			--|	 not be equivalent anyway.
			--|The best way to understand all this, is to draw a two-dimensional
			--|table, for all possible combinations of the values (CONSTANT_AS,
			--|ROUTINE_AS, Void) of content and other.content)
		local
			r1, r2: ROUTINE_AS
		do
			r1 ?= content; 
			r2 ?= other.content
			if (r1 /= Void) and then (r2 /= Void) then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end

feature {BODY_AS, FEATURE_AS, BODY_MERGER, USER_CMD, CMD} -- Replication

	set_arguments (a: like arguments) is
		do
			arguments := a
		end

	set_type (t: like type) is
		do
			type := t
		end

	set_content (c: like content) is
		do
			content := c
		end
		
end -- class BODY_AS
