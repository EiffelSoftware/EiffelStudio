indexing
	description:
			"Abstract description for formal generic type. %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_AS

inherit
	TYPE
		rename
			position as text_position
		redefine
			format, simple_format
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
		end

feature {AST_FACTORY} -- Initialization

	initialize (p: INTEGER) is
			-- Create a new FORMAL AST node.
		do
			position := p
		ensure
			position_set: position = p
		end

feature -- Properties

	position: INTEGER
			-- Position of the formal parameter in the declaration
			-- array

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): FORMAL_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := actual_type
		end

	actual_type: FORMAL_A is
			-- Actual type for formal generic
		do
			!! Result
			Result.set_position (position)
		end

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
		local
			l_a: LOCAL_FEAT_ADAPTATION
			new_type: TYPE_A
		do
			l_a := ctxt.local_adapt
			if l_a /= Void then
				new_type := l_a.adapted_type (Current)
			end
			if new_type = Void then
				simple_format (ctxt)
			else
				new_type.format (ctxt)
			end
		end

feature -- Stoning
 
	associated_eiffel_class (ref_class: CLASS_C): CLASS_C is
		do  
			Result := actual_type.associated_class
		end

feature -- Output

	dump: STRING is
		do
			!! Result.make (12)
			Result.append ("Generic #")
			Result.append_integer (position)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (create {GENERIC_TEXT}.make (ctxt.formal_name (position)))
		end

feature {COMPILER_EXPORTER}

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i
		end

end -- class FORMAL_AS
