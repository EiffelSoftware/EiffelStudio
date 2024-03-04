note
	description: "[
				Helper class to emulate C byte assigments like.
			
				 *(int*)(result + sz) = n;
				 
				  *(longlong*)result = intValue_;
				 
				 Where `result` is defined as Byte* result
				 and Byte as typedef unsigned char Byte; /* 1 byte */
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_ARRAY_HELPER

feature -- Element Change

	put_natural_8 (a_arr: ARRAY [NATURAL_8]; a_value: NATURAL_8; a_pos: INTEGER)
			-- Put NATURAL_8 `a_value` into `a_arr` at position `a_pos`.	
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.natural_8_bytes)
			mp.put_natural_8_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			natural_8_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_natural_16 (a_arr: ARRAY [NATURAL_8]; a_value: NATURAL_16; a_pos: INTEGER)
			-- Put NATURAL_16 `a_value` into `a_arr` at position `a_pos`.	
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.natural_16_bytes)
			mp.put_natural_16_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			natural_16_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_natural_32 (a_arr: ARRAY [NATURAL_8]; a_value: NATURAL_32; a_pos: INTEGER)
			-- Put NATURAL_32 `a_value` into `a_arr` at position `a_pos`.
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.natural_32_bytes)
			mp.put_natural_32_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			natural_32_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_natural_64 (a_arr: ARRAY [NATURAL_8]; a_value: NATURAL_64; a_pos: INTEGER)
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.natural_64_bytes)
			mp.put_natural_64_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			natural_64_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_integer_8 (a_arr: ARRAY [NATURAL_8]; a_value: INTEGER_8; a_pos: INTEGER)
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.integer_8_bytes)
			mp.put_integer_8_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			integer_8_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_integer_16 (a_arr: ARRAY [NATURAL_8]; a_value: INTEGER_16; a_pos: INTEGER)
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.integer_16_bytes)
			mp.put_integer_16_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			integer_16_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_integer_32 (a_arr: ARRAY [NATURAL_8]; a_value: INTEGER_32; a_pos: INTEGER)
			-- Put INTEGER_32 `a_value` into `a_arr` at position `a_pos`.
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.integer_32_bytes)
			mp.put_integer_32_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			integer_32_at (a_arr, a_pos) = a_value
			instance_free: class
		end

	put_integer_64 (a_arr: ARRAY [NATURAL_8]; a_value: INTEGER_64; a_pos: INTEGER)
		require
			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
		local
			mp: MANAGED_POINTER
			arr_sp, sp: SPECIAL [NATURAL_8]
		do
			create mp.make ({PLATFORM}.integer_64_bytes)
			mp.put_integer_64_le (a_value, 0)
			sp := mp.read_special_natural_8 (0, mp.count)

			a_arr.grow (a_pos + sp.count)
			arr_sp := a_arr.to_special

			arr_sp.copy_data (sp, 0, a_pos, sp.count)
		ensure
			integer_64_at (a_arr, a_pos) = a_value
			instance_free: class
		end

--	put_double (a_arr: ARRAY [NATURAL_8]; a_value: REAL_64; a_pos: INTEGER)
--		require
--			valid_pos: a_pos >= 0 and then a_pos <= a_arr.upper - a_arr.lower
--		local
--			mp: MANAGED_POINTER
--			arr_sp, sp: SPECIAL [NATURAL_8]
--		do
--			create mp.make ({PLATFORM}.real_64_bytes)
--			mp.put_real_64_le (a_value, 0)
--			sp := mp.read_special_natural_8 (0, mp.count)
--
--			a_arr.grow (a_pos + sp.count)
--			arr_sp := a_arr.to_special
--
--			arr_sp.copy_data (sp, 0, a_pos, sp.count)
--		ensure
--			byte_array_to_real_64 (a_arr, a_pos) = a_value
--			instance_free: class
--		end	

feature -- Access

	natural_64_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_64
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_natural_64 (a_pos)
		ensure
			instance_free: class
		end

	natural_32_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_32
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_natural_32 (a_pos)
		ensure
			instance_free: class
		end

	natural_16_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_16
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_natural_16 (a_pos)
		ensure
			instance_free: class
		end

	natural_8_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): NATURAL_8
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_natural_8 (a_pos)
		ensure
			instance_free: class
		end

	integer_64_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): INTEGER_64
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_integer_64 (a_pos)
		ensure
			instance_free: class
		end

	integer_32_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): INTEGER_32
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_integer_32 (a_pos)
		ensure
			instance_free: class
		end

	integer_16_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): INTEGER_16
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_integer_16 (a_pos)
		ensure
			instance_free: class
		end

	integer_8_at (a_arr: ARRAY [NATURAL_8]; a_pos: INTEGER): INTEGER_8
		local
			l_mp: MANAGED_POINTER
		do
			create l_mp.make_from_array (a_arr)
			Result := l_mp.read_integer_8 (a_pos)
		ensure
			instance_free: class
		end



end
