indexing
	description: 
		"AST representation of type CHARACTER."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_TYPE_AS

inherit
	BASIC_TYPE
		redefine
			is_equivalent
		end

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
			
feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_char_type_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_wide = other.is_wide
		end

feature -- Output

	dump: STRING is "CHARACTER"
			-- Dumped trace

end -- class CHAR_TYPE_AS
