indexing
	description: 
		"AST representation of a formal generic type."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_AS

inherit
	EIFFEL_TYPE

	CLICKABLE_AST
		redefine
			is_class
		end

feature {AST_FACTORY} -- Initialization

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

	is_reference: BOOLEAN
			-- Is Current formal to be always instantiated as a reference type?
			
	is_expanded: BOOLEAN
			-- Is Current formal to be always instantiated as an expanded type?

	name: ID_AS
			-- Formal generic parameter name

	position: INTEGER
			-- Position of the formal parameter in the declaration
			-- array

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

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
			create Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_string (ctxt.formal_name (position))
--		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end

end -- class FORMAL_AS
