indexing

	description:

		"Eiffel dynamic types"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2007, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_DYNAMIC_TYPES

feature -- Access

	dynamic_type (i: INTEGER): ET_DYNAMIC_TYPE is
			-- Dynamic type at index `i'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		deferred
		ensure
			dynamic_type_not_void: Result /= Void
		end

	special_type: ET_DYNAMIC_TYPE is
			-- One of the SPECIAL types contained in current dynamic types
			-- if any, Void otherwise
		local
			i, nb: INTEGER
			l_type: ET_DYNAMIC_TYPE
		do
			nb := count
			from i := 1 until i > nb loop
				l_type := dynamic_type (i)
				if l_type.is_special then
					Result := l_type
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of dynamic types
		deferred
		ensure
			count_not_negative: Result >= 0
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no dynamic type?
		do
			Result := (count = 0)
		ensure
			definition: Result = (count = 0)
		end

	has_type (a_type: ET_DYNAMIC_TYPE): BOOLEAN is
			-- Do current dynamic types contain `a_type'?
		require
			a_type_not_void: a_type /= Void
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				if dynamic_type (i) = a_type then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

	has_special: BOOLEAN is
			-- Do current dynamic types contain at least one SPECIAL type?
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				if dynamic_type (i).is_special then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

	has_expanded: BOOLEAN is
			-- Do current dynamic types contain at least one expanded type?
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				if dynamic_type (i).is_expanded then
					Result := True
					i := nb + 1 -- Jump out of the loop.
				else
					i := i + 1
				end
			end
		end

end
