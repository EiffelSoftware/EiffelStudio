indexing
	description: 
		"AST representation for type INTEGER."
	date: "$Date$"
	revision: "$Revision$"

class
	INT_TYPE_AS

inherit
	BASIC_TYPE
		redefine
			is_equivalent
		end

create
	make

feature -- Initialization

	make (n: INTEGER) is
			-- Create instance of INT_TYPE_AS with `n' bits representation.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n
		ensure
			size_set: size = n
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_int_type_as (Current)
		end

feature -- Property

	size: INTEGER
			-- `size' in bits of current INTEGER.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := size = other.size
		end

feature -- Access

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (10)
			Result.append ("INTEGER")
			if size /= 32 then
				Result.extend ('_')
				Result.append_integer (size)
			end
		end

end -- class INT_TYPE_AS_M
