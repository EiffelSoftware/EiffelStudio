-- Class INTEGER_REF

class INTEGER_REF_B 

inherit
	CLASS_REF_B
		rename
			make as basic_make
		end

create
	make
	
feature -- Initialization

	make (l: CLASS_I; n: INTEGER) is
			-- Creation of basic class
		require
			good_argument: l /= Void
			valid_n: n = 8 or n = 16 or n =32 or n = 64
		do
			basic_make (l)
			size := n
		ensure
			size_set: size = n
		end

feature -- Property

	size: INTEGER
			-- `size' in bits of current representation of INTEGER.
	
feature 

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class
			-- Ensure it is an INTEGER of `size' bits
		local
			i: INTEGER_DESC
		do
			Result := desc.is_integer
			if Result then
				i ?= desc
				Result := i.size = size
			end
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end
