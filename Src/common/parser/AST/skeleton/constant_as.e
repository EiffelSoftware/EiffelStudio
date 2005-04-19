indexing
	description:
		"Abstract description of a the content of an Eiffel %
		%constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_AS

inherit
	CONTENT_AS
		redefine
			is_constant, is_unique
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (v: like value) is
			-- Create a new CONSTANT AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_constant_as (Current)
		end

feature -- Attributes

	value: ATOMIC_AS
			-- Constant value

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := value.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := value.end_location
		end

feature -- Properties

	is_constant: BOOLEAN is True
			-- Is the current content a constant one ?

	is_unique: BOOLEAN is
			-- Is the content a unique ?
		do
			Result := value.is_unique
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Access

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := equivalent (value, other.value)
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
		do
			Result := False
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this constant.
			-- Result is `0'.
		do
			Result := 0
		end

feature {CONSTANT_AS} -- Replication

	set_value (v: like value) is
		do
			value := v
		end
		
invariant
	value_not_void: value /= Void

end -- class CONSTANT_AS
