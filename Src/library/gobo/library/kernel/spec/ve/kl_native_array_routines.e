indexing

	description:

		"Routines that ought to be in class NATIVE_ARRAY. %
		%A native array is a zero-based indexed sequence of values, %
		%equipped with features `put' and `item', but the clients %
		%have to keep track of `count'."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_NATIVE_ARRAY_ROUTINES [G]

obsolete

	"[041219] Use SPECIAL and KL_SPECIAL_ROUTINES instead."

inherit

	KL_IMPORTED_NATIVE_ARRAY_TYPE [G]

feature -- Initialization

	make (n: INTEGER): like NATIVE_ARRAY_TYPE is
			-- Create a new native array being able to contain `n' items.
		require
			non_negative_n: n >= 0




		do










			create Result.make (0, n - 1)

		ensure

			native_array_not_void: Result /= Void

			valid_native_array: valid_native_array (Result)
		end

feature -- Status report

	valid_native_array (an_array: like NATIVE_ARRAY_TYPE): BOOLEAN is
			-- Make sure that the lower bound of `an_array' is zero.

		require
			an_array_not_void: an_array /= Void

		do



			Result := an_array.lower = 0

		end

feature -- Resizing

	resize (an_array: like NATIVE_ARRAY_TYPE; old_size, new_size: INTEGER): like NATIVE_ARRAY_TYPE is
			-- Resize `an_array' so that it contains `n' items.
			-- Do not lose any previously entered items.
			-- Note: the returned native array  might be `an_array'
			-- or a newly created native array where items from
			-- `an_array' have been copied to.
		require

			an_array_not_void: an_array /= Void

			valid_native_array: valid_native_array (an_array)
			old_size_positive: old_size >= 0
			new_size_large_enough: new_size > old_size
		do















			Result := an_array
			if new_size > an_array.count then
				Result.resize (0, new_size - 1)
			end

		ensure

			native_array_not_void: Result /= Void

			valid_native_array: valid_native_array (Result)
		end

end
