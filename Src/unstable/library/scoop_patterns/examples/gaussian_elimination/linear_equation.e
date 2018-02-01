note
	description: "Contains the coefficients for a linear equation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	LINEAR_EQUATION

inherit

	ARRAYED_LIST [DOUBLE]

	CP_IMPORTABLE
		undefine
			copy, is_equal
		end

	MEMORY
		undefine
			copy, is_equal
		end

create
	make, make_filled, make_from_separate

feature {CP_DYNAMIC_TYPE_IMPORTER} -- Initialization

	make_from_separate (other: separate LINEAR_EQUATION)
			-- <Precursor>
		local
			l_count: INTEGER
		do
			l_count := other.count
			make_filled (l_count)

			collection_off
			area.base_address.memory_copy (other.area.base_address, l_count * {PLATFORM}.real_64_bytes)
			collection_on

--			from
--				idx := 1
--			until
--				idx > l_count
--			loop
--				put_i_th (other [idx], idx)
--				idx := idx + 1
--			variant
--				l_count - idx + 1
--			end
		rescue
			collection_on
		end

feature -- Mathematical operations

	subtract (scalar: DOUBLE; subtrahend: separate LINEAR_EQUATION)
			-- Subtract `scalar' times `subtrahend' from `Current'.
		require
			same_count: subtrahend.count = count
			not_equal: subtrahend /= Current
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count
			loop
				Current [i] :=  Current [i] - scalar * subtrahend [i]
				i := i + 1
			variant
				count - i + 1
			end
		end

end
