indexing

	description: "Node for type INTEGER. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INT_TYPE_AS

inherit
	BASIC_TYPE
		redefine
			is_equivalent
		end

	SHARED_TYPES

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

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): INTEGER_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := actual_type
		end

	actual_type: INTEGER_A is
			-- Actual integer type
		do
			inspect size
			when 8 then Result := Integer_8_type
			when 16 then Result := Integer_16_type
			when 32 then Result := Integer_type
			when 64 then Result := Integer_64_type
			end
		end

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

end -- class INT_TYPE_AS
