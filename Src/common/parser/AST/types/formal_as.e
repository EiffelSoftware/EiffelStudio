indexing
	description: "Abstract description for formal generic type."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_AS

inherit
	TYPE_AS
		redefine
			has_formal_generic, is_loose
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: ID_AS; is_ref, is_exp: BOOLEAN) is
			-- Create a new FORMAL AST node.
		require
			n_not_void: n /= Void
		do
			name := n
			is_reference := is_ref
			is_expanded := is_exp
		ensure
			name_set: name = n
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_as (Current)
		end

feature -- Properties

	name: ID_AS
			-- Formal generic parameter name

	position: INTEGER
			-- Position of the formal parameter in the declaration
			-- array
			
	is_reference: BOOLEAN
			-- Is Current formal to be always instantiated as a reference type?
			
	is_expanded: BOOLEAN
			-- Is Current formal to be always instantiated as an expanded type?

	has_formal_generic: BOOLEAN is True
			-- Has type a formal generic parameter?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := name.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then is_reference = other.is_reference
				and then is_expanded = other.is_expanded
		end

feature -- Output

	dump: STRING is
		do
			create Result.make (12)
			Result.append ("Generic #")
			Result.append_integer (position)
		end

feature {COMPILER_EXPORTER}

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i
		end

end -- class FORMAL_AS
