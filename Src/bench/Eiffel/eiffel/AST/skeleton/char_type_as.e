indexing

	description: "Node for type CHARACTER. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_TYPE_AS

inherit
	BASIC_TYPE
		redefine
			is_equivalent
		end

	SHARED_TYPES

create
	make

feature -- Initialization

	make (w: BOOLEAN) is
			-- Create instance of CHAR_TYPE_AS. If `w' a normal character.
			-- Otherwise a wide character.
		do
			is_wide := w
		ensure
			is_wide_set: is_wide = w
		end

feature -- Property

	is_wide: BOOLEAN
			-- Is current character a wide one?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_wide = other.is_wide
		end

feature -- Access

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CHARACTER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := actual_type
		end

	actual_type: CHARACTER_A is
			-- Actual character type
		do
			if is_wide then
				Result := Wide_char_type
			else
				Result := Character_type
			end
		end

	dump: STRING is
			-- Dumped trace
		do
			if is_wide then
				Result := "WIDE_CHARACTER"
			else
				Result := "CHARACTER"
			end
		end

end -- class CHAR_TYPE_AS
