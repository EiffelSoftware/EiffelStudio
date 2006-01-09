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

	initialize (n: ID_AS; is_ref, is_exp: BOOLEAN; r_as: like reference_expanded_keyword) is
			-- Create a new FORMAL AST node.
		require
			n_not_void: n /= Void
		do
			name := n
			is_reference := is_ref
			is_expanded := is_exp
			reference_expanded_keyword := r_as
		ensure
			name_set: name = n
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
			reference_expanded_keyword_set: reference_expanded_keyword = r_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_formal_as (Current)
		end

feature -- Roundtrip

	reference_expanded_keyword: KEYWORD_AS
			-- Keyword "reference" or "expanded" associated with this structure


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

feature -- Roundtrip

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list /= Void and then reference_expanded_keyword /= Void then
					-- Roundtrip mode
				Result := reference_expanded_keyword.complete_start_location (a_list)
			else
				Result := name.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := name.complete_end_location (a_list)
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
