indexing
	description:
			"Abstract description for formal generic type. %
			%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_AS

inherit
	TYPE_AS
		rename
			start_position as text_position
		redefine
			format, simple_format, has_formal_generic, is_loose
		end

	CLICKABLE_AST
		redefine
			is_class, associated_eiffel_class
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

	name: ID_AS
			-- Formal generic parameter name

	position: INTEGER
			-- Position of the formal parameter in the declaration
			-- array
			
	is_reference: BOOLEAN
			-- Is Current formal to be always instantiated as a reference type?
			
	is_expanded: BOOLEAN
			-- Is Current formal to be always instantiated as an expanded type?

	is_class: BOOLEAN is True
			-- Does the Current AST represent a class?

	has_formal_generic: BOOLEAN is True
			-- Has type a formal generic parameter?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then is_reference = other.is_reference
				and then is_expanded = other.is_expanded
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
			create Result.make (is_reference, is_expanded, position)
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
 
	associated_eiffel_class (ref_class: CLASS_I): CLASS_I is
		do  
			Result := actual_type.associated_class.lace_class
		end

feature -- Output

	dump: STRING is
		do
			create Result.make (12)
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
