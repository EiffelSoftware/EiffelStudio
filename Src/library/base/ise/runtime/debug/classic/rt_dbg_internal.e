indexing
	description: "Internal routine for RT_DBG_ classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_INTERNAL

inherit
	ANY

	INTERNAL
		export
			{NONE} all
		end

feature -- Object access

	frozen object_field_count (obj: !ANY): INTEGER is
			-- Field_count on `obj'
		do
			Result := field_count (obj)
		end

	frozen object_records (obj: !ANY): ?ARRAYED_LIST [RT_DBG_VALUE_RECORD] is
			-- List of field records on `obj'
		local
			i, cnb: INTEGER
			r: !like object_records
		do
			cnb := object_field_count (obj)
			if cnb > 0 then
				create r.make (cnb)
				from
					i := 1
				until
					i > cnb
				loop
					r.extend (object_record (i, obj))
					i := i + 1
				end
				Result := r
			end
		end

	frozen object_is_expanded (object: ANY): BOOLEAN is
			-- Is `object' an expanded value ?
		require
			object_not_void: object /= Void
		do
			Result := c_object_is_expanded ($object)
		end

	frozen field_index_at (off: INTEGER; obj: ANY): INTEGER is
			-- Field name at offset `off' on `obj'
			--| note: heavy computing, for debug purpose only
		require
			obj /= Void
		local
			n: INTEGER
		do
			from
				n := field_count (obj)
			until
				n = 0 or Result > 0
			loop
				if off = field_offset (n, obj) then
					Result := n
				end
				n := n - 1
			end
		end

	frozen field_name_at (off: INTEGER; obj: ANY): STRING is
			-- Field name at offset `off' on `obj'
			--| note: heavy computing, for debug purpose only
		require
			obj /= Void
		local
			i: INTEGER
		do
			i := field_index_at (off, obj)
			if i > 0 then
				Result := field_name (i, obj)
			end
		end

	frozen field_at (off: INTEGER; a_field_type: NATURAL_32; object: ANY): ANY is
			-- Object attached at offset `off' field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: off >= 1
		local
			t: INTEGER
		do
			t := eif_type (a_field_type)
			inspect t
			when boolean_type then
				Result := c_boolean_field_at (off, a_field_type, $object)
			when character_8_type then
				Result := c_character_8_field_at (off, a_field_type, $object)
			when character_32_type then
				Result := c_character_32_field_at (off, a_field_type, $object)
			when natural_8_type then
				Result := c_natural_8_field_at (off, a_field_type, $object)
			when natural_16_type then
				Result := c_natural_16_field_at (off, a_field_type, $object)
			when natural_32_type then
				Result := c_natural_32_field_at (off, a_field_type, $object)
			when natural_64_type then
				Result := c_natural_64_field_at (off, a_field_type, $object)
			when integer_8_type then
				Result := c_integer_8_field_at (off, a_field_type, $object)
			when integer_16_type then
				Result := c_integer_16_field_at (off, a_field_type, $object)
			when integer_32_type then
				Result := c_integer_32_field_at (off, a_field_type, $object)
			when integer_64_type then
				Result := c_integer_64_field_at (off, a_field_type, $object)
			when real_32_type then
				Result := c_real_32_field_at (off, a_field_type, $object)
			when real_64_type then
				Result := c_real_64_field_at (off, a_field_type, $object)
			when pointer_type then
				Result := c_pointer_field_at (off, a_field_type, $object)
			when reference_type then
				Result := c_field_at (off, a_field_type, $object)
			else
			end
		end

	frozen stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32): ANY is
			-- Object attached at offset `off' field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: pos >= 1
		do
			debug ("RT_DBG_INTERNAL")
				print ("%Nstack_value_at (" + dep.out + ", " + pos.out + ", 0x" + a_rt_type.to_hex_string + ")%N")
			end
			Result := c_stack_value_at (dep, a_loc_type, pos, a_rt_type)
			debug ("RT_DBG_INTERNAL")
				print ("stack_value_at -> ")
				if Result /= Void then
					print (Result.generating_type + " = " + Result.out)
				else
					print ("Void Result")
				end
				print ("%N")
			end
		end

	frozen eif_type (a_field_type: NATURAL_32): INTEGER is
			-- EIF_ type from field type `a_field_type'
		do
			Result := c_eif_type (a_field_type)
		end

	frozen rt_dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := c_rt_dynamic_type ($object)
		ensure
			rt_dynamic_type_nonnegative: Result >= 0
		end

	frozen rt_updated_dynamic_type (tid: INTEGER): INTEGER is
			-- Updated dynamic type id from `tid'.
			-- aka: full dynamic type
			--| note: for non generic: Result = tid
		require
			tid_not_negative: tid >= 0
		external
			"C inline use %"eif_macros.h%""
		alias
			"[
			#ifdef WORKBENCH
				return RTUD($tid);
			#else
				return 0;
			#endif
			]"
		end

	frozen rt_reverse_updated_dynamic_type (fid: INTEGER): INTEGER is
			-- Reverse updated dynamic type id from `fid'.
			--| note: for non generic: Result = fid
		require
			fid_not_negative: fid >= 0
		external
			"C inline use %"eif_macros.h%""
		alias
			"[
			#ifdef WORKBENCH
				return RTID($fid);
			#else
				return 0;
			#endif
			]"
		end

feature {NONE} -- Factory

	frozen object_record (i: INTEGER; obj: !ANY): ?RT_DBG_VALUE_RECORD is
		local
			ft: INTEGER
		do
			Result := object_attribute_record (field_offset (i, obj), c_rt_field_type (i, field_type (i, obj)), obj)
			ft := field_type (i, obj)
			inspect ft
			when Integer_8_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_8]} Result.make (obj, i, ft, integer_8_field (i, obj))
			when Integer_16_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_16]} Result.make (obj, i, ft, integer_16_field (i, obj))
			when integer_32_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_32]} Result.make (obj, i, ft, integer_32_field (i, obj))
			when Integer_64_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_64]} Result.make (obj, i, ft, integer_64_field (i, obj))
			when natural_8_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_8]} Result.make (obj, i, ft, natural_8_field (i, obj))
			when natural_16_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_16]} Result.make (obj, i, ft, natural_16_field (i, obj))
			when natural_32_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_32]} Result.make (obj, i, ft, natural_32_field (i, obj))
			when natural_64_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_64]} Result.make (obj, i, ft, natural_64_field (i, obj))
			when Pointer_type then
				create {RT_DBG_FIELD_RECORD [POINTER]} Result.make (obj, i, ft, pointer_field (i, obj))
			when Reference_type then
				create {RT_DBG_FIELD_RECORD [ANY]} Result.make (obj, i, ft, field (i, obj))
			when Expanded_type then
				create {RT_DBG_FIELD_RECORD [ANY]} Result.make (obj, i, ft, field (i, obj))
			when Boolean_type then
				create {RT_DBG_FIELD_RECORD [BOOLEAN]} Result.make (obj, i, ft, boolean_field (i, obj))
			when real_32_type then
				create {RT_DBG_FIELD_RECORD [REAL_32]} Result.make (obj, i, ft, real_32_field (i, obj))
			when real_64_type then
				create {RT_DBG_FIELD_RECORD [REAL_64]} Result.make (obj, i, ft, real_64_field (i, obj))
			when character_8_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_8]} Result.make (obj, i, ft, character_8_field (i, obj))
			when character_32_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_32]} Result.make (obj, i, ft, character_32_field (i, obj))
--			when Bit_type then
--			when none_type then
			else
			end
		end

	frozen object_attribute_record (off: INTEGER; t: NATURAL_32; obj: !ANY): ?RT_DBG_VALUE_RECORD is
			-- Record for attribute of type `t' at offset `o' on object `obj'
		local
			ft: INTEGER
		do
			ft := eif_type (t)
			inspect ft
			when boolean_type then
				create {RT_DBG_ATTRIBUTE_RECORD [BOOLEAN]} Result.make (obj, off, ft, t, c_boolean_field_at (off, t, $obj))
			when character_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [CHARACTER_8]} Result.make (obj, off, ft, t, c_character_8_field_at (off, t, $obj))
			when character_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [CHARACTER_32]} Result.make (obj, off, ft, t, c_character_32_field_at (off, t, $obj))
			when Integer_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_8]} Result.make (obj, off, ft, t, c_integer_8_field_at (off, t, $obj))
			when Integer_16_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_16]} Result.make (obj, off, ft, t, c_integer_16_field_at (off, t, $obj))
			when integer_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_32]} Result.make (obj, off, ft, t, c_integer_32_field_at (off, t, $obj))
			when Integer_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_64]} Result.make (obj, off, ft, t, c_integer_64_field_at (off, t, $obj))
			when natural_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_8]} Result.make (obj, off, ft, t, c_natural_8_field_at (off, t, $obj))
			when natural_16_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_16]} Result.make (obj, off, ft, t, c_natural_16_field_at (off, t, $obj))
			when natural_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_32]} Result.make (obj, off, ft, t, c_natural_8_field_at (off, t, $obj))
			when natural_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_64]} Result.make (obj, off, ft, t, c_natural_8_field_at (off, t, $obj))
			when real_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [REAL_32]} Result.make (obj, off, ft, t, c_real_32_field_at (off, t, $obj))
			when real_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [REAL_64]} Result.make (obj, off, ft, t, c_real_64_field_at (off, t, $obj))
			when Pointer_type then
				create {RT_DBG_ATTRIBUTE_RECORD [POINTER]} Result.make (obj, off, ft, t, c_pointer_field_at (off, t, $obj))
			when Reference_type then
				create {RT_DBG_ATTRIBUTE_RECORD [ANY]} Result.make (obj, off, ft, t, c_field_at (off, t, $obj))
			when Expanded_type then
				create {RT_DBG_ATTRIBUTE_RECORD [ANY]} Result.make (obj, off, ft, t, c_field_at (off, t, $obj))
--			when Bit_type then
--			when none_type then
			else
			end
		end

	frozen object_local_record (dep: INTEGER; pos: INTEGER; t: NATURAL_32): ?RT_DBG_VALUE_RECORD is
			-- Local or Result value record.
		local
			ft: INTEGER
		do
			ft := eif_type (t)
			inspect ft
			when Boolean_type then
				create {RT_DBG_LOCAL_RECORD [BOOLEAN]} Result.make (dep, pos, ft, t)
			when character_8_type then
				create {RT_DBG_LOCAL_RECORD [CHARACTER_8]} Result.make (dep, pos, ft, t)
			when character_32_type then
				create {RT_DBG_LOCAL_RECORD [CHARACTER_32]} Result.make (dep, pos, ft, t)
			when natural_8_type then
				create {RT_DBG_LOCAL_RECORD [NATURAL_8]} Result.make (dep, pos, ft, t)
			when natural_16_type then
				create {RT_DBG_LOCAL_RECORD [NATURAL_16]} Result.make (dep, pos, ft, t)
			when natural_32_type then
				create {RT_DBG_LOCAL_RECORD [NATURAL_32]} Result.make (dep, pos, ft, t)
			when natural_64_type then
				create {RT_DBG_LOCAL_RECORD [NATURAL_64]} Result.make (dep, pos, ft, t)
			when Integer_8_type then
				create {RT_DBG_LOCAL_RECORD [INTEGER_8]} Result.make (dep, pos, ft, t)
			when Integer_16_type then
				create {RT_DBG_LOCAL_RECORD [INTEGER_16]} Result.make (dep, pos, ft, t)
			when integer_32_type then
				create {RT_DBG_LOCAL_RECORD [INTEGER_32]} Result.make (dep, pos, ft, t)
			when Integer_64_type then
				create {RT_DBG_LOCAL_RECORD [INTEGER_64]} Result.make (dep, pos, ft, t)
			when real_32_type then
				create {RT_DBG_LOCAL_RECORD [REAL_32]} Result.make (dep, pos, ft, t)
			when real_64_type then
				create {RT_DBG_LOCAL_RECORD [REAL_64]} Result.make (dep, pos, ft, t)
			when Pointer_type then
				create {RT_DBG_LOCAL_RECORD [POINTER]} Result.make (dep, pos, ft, t)
			when Reference_type then
				create {RT_DBG_LOCAL_RECORD [ANY]} Result.make (dep, pos, ft, t)
			when Expanded_type then
				create {RT_DBG_LOCAL_RECORD [ANY]} Result.make (dep, pos, ft, t)
			when Bit_type then
			when none_type then
			else
			end
			if Result /= Void then
				Result.get_value
			end
		end

feature {NONE} -- External implementation

	frozen c_object_is_expanded (object: POINTER): BOOLEAN is
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"eif_is_expanded(HEADER($object)->ov_flags)"
		end

	frozen c_eif_type (a_field_type: NATURAL_32): INTEGER is
			-- EIF_ type related to `a_field_type'
		external
			"C inline use %"eif_internal.h%""
		alias
			"ei_eif_type((uint32) $a_field_type)"
		end

	frozen c_rt_field_type (i: INTEGER; a_type_id: INTEGER): NATURAL_32 is
			-- RT field type related to `i' on `a_type_id'
		external
			"C inline use %"eif_internal.h%""
		alias
			"System(To_dtype($a_type_id)).cn_types[$i]"
		end

	frozen c_rt_dynamic_type (object: POINTER): INTEGER is
			-- Dynamic type of `object'.
		external
			"C macro signature (EIF_REFERENCE): EIF_INTEGER use %"eif_macros.h%""
		alias
			"Dtype"
		end

feature -- Get

	frozen c_boolean_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): BOOLEAN is
			-- BOOLEAN value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_BOOLEAN *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_character_8_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): CHARACTER_8 is
			-- CHARACTER_8 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_CHARACTER *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_character_32_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): CHARACTER_32 is
			-- CHARACTER_32 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_WIDE_CHAR *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_natural_8_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): NATURAL_8 is
			-- NATURAL_8 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_NATURAL_8 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_natural_16_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): NATURAL_16 is
			-- NATURAL_16 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_NATURAL_16 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_natural_32_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): NATURAL_32 is
			-- NATURAL_32 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_NATURAL_32 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_natural_64_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): NATURAL_64 is
			-- NATURAL_64 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_NATURAL_64 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_integer_8_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): INTEGER_8 is
			-- INTEGER_8 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_INTEGER_8 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_integer_16_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): INTEGER_16 is
			-- INTEGER_16 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_INTEGER_16 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_integer_32_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): INTEGER_32 is
			-- INTEGER_32 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_INTEGER_32 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_integer_64_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): INTEGER_64 is
			-- INTEGER_64 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_INTEGER_64 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_real_32_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): REAL_32 is
			-- REAL_32 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_REAL_32 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_real_64_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): REAL_64 is
			-- REAL_64 value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_REAL_64 *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_pointer_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): POINTER is
			-- POINTER value referenced at offset `off' on `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return *(EIF_POINTER *) ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

	frozen c_field_at (off: INTEGER; a_type: NATURAL_32; object: POINTER): ANY is
			-- Object value referenced at `off' offset of `object'
		external
			"C inline use %"eif_internal.h%""
		alias
			"return ei_field_at((long) $off, (uint32) $a_type, (EIF_REFERENCE) $object)"
		end

feature -- Change field

	set_field_at (off: INTEGER; a_type: NATURAL_32; value: ANY; object: ANY) is
		local
			a_eif_type: INTEGER
		do
debug ("RT_DBG_INTERNAL")
			print ("set_field_at (" + off.out + ", " + a_type.out + ", value, " + object.generator + ") %N")
end
			a_eif_type := eif_type (a_type)
			inspect a_eif_type
			when boolean_type then
				if {bool: BOOLEAN} value then
					c_set_boolean_field_at (off, bool, $object)
				end
			when character_8_type then
				if {c8: CHARACTER_8} value then
					c_set_character_8_field_at (off, c8, $object)
				end
			when character_32_type then
				if {c32: CHARACTER_32} value then
					c_set_character_32_field_at (off, c32, $object)
				end
			when natural_8_type then
				if {n8: NATURAL_8} value then
					c_set_natural_8_field_at (off, n8, $object)
				end
			when natural_16_type then
				if {n16: NATURAL_16} value then
					c_set_natural_16_field_at (off, n16, $object)
				end
			when natural_32_type then
				if {n32: NATURAL_32} value then
					c_set_natural_32_field_at (off, n32, $object)
				end
			when natural_64_type then
				if {n64: NATURAL_64} value then
					c_set_natural_64_field_at (off, n64, $object)
				end
			when integer_8_type then
				if {i8: INTEGER_8} value then
					c_set_integer_8_field_at (off, i8, $object)
				end
			when integer_16_type then
				if {i16: INTEGER_16} value then
					c_set_integer_16_field_at (off, i16, $object)
				end
			when integer_32_type then
				if {i32: INTEGER_32} value then
					c_set_integer_32_field_at (off, i32, $object)
				end
			when integer_64_type then
				if {i64: INTEGER_64} value then
					c_set_integer_64_field_at (off, i64, $object)
				end
			when real_32_type then
				if {r32: REAL_32} value then
					c_set_real_32_field_at (off, r32, $object)
				end
			when real_64_type then
				if {r64: REAL_64} value then
					c_set_real_64_field_at (off, r64, $object)
				end
			when pointer_type then
				if {ptr: POINTER} value then
					c_set_pointer_field_at (off, ptr, $object)
				end
			when reference_type then
				c_set_reference_field_at (off, $value, $object)
			else
			end
		end

	frozen c_set_boolean_field_at (off: INTEGER; value: BOOLEAN; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_BOOLEAN *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_BOOLEAN)($value)"
		end

	frozen c_set_character_8_field_at (off: INTEGER; value: CHARACTER_8; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_CHARACTER *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_CHARACTER)($value)"
		end

	frozen c_set_character_32_field_at (off: INTEGER; value: CHARACTER_32; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_WIDE_CHAR *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_WIDE_CHAR)($value)"
		end

	frozen c_set_natural_8_field_at (off: INTEGER; value: NATURAL_8; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_NATURAL_8 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_NATURAL_8)($value)"
		end

	frozen c_set_natural_16_field_at (off: INTEGER; value: NATURAL_16; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_NATURAL_16 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_NATURAL_16)($value)"
		end

	frozen c_set_natural_32_field_at (off: INTEGER; value: NATURAL_32; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_NATURAL_32 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_NATURAL_32)($value)"
		end

	frozen c_set_natural_64_field_at (off: INTEGER; value: NATURAL_64; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_NATURAL_64 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_NATURAL_64)($value)"
		end

	frozen c_set_integer_8_field_at (off: INTEGER; value: INTEGER_8; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_INTEGER_8 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_INTEGER_8)($value)"
		end

	frozen c_set_integer_16_field_at (off: INTEGER; value: INTEGER_16; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_INTEGER_16 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_INTEGER_16)($value)"
		end

	frozen c_set_integer_32_field_at (off: INTEGER; value: INTEGER_32; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_INTEGER_32 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_INTEGER_32)($value)"
		end

	frozen c_set_integer_64_field_at (off: INTEGER; value: INTEGER_64; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_INTEGER_64 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_INTEGER_64)($value)"
		end

	frozen c_set_real_32_field_at (off: INTEGER; value: REAL_32; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_REAL_32 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_REAL_32)($value)"
		end

	frozen c_set_real_64_field_at (off: INTEGER; value: REAL_64; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_REAL_64 *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_REAL_64)($value)"
		end

	frozen c_set_pointer_field_at (off: INTEGER; value: POINTER; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"*(EIF_POINTER *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_POINTER)($value)"
		end

	frozen c_set_reference_field_at (off: INTEGER; value: POINTER; object: POINTER) is
		external
			"C inline use %"eif_internal.h%""
		alias
			"{ RTAR($object,$value); *(EIF_REFERENCE *) ((EIF_REFERENCE)$object + (long)$off) = (EIF_REFERENCE)($value); }"
		end

feature -- Access local

	frozen c_stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32): ANY is
			-- Object value referenced at `off' offset of `object'
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				return (EIF_REFERENCE) rt_dbg_stack_value((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (uint32)$a_rt_type);
			#else
				return NULL;
			#endif
			]"
		end

feature -- Change local

	rt_DLT_ARGUMENT: INTEGER = 0
			-- DLT=DebugLocalType, the type is an argument of a function

	rt_DLT_LOCALVAR: INTEGER = 1
			-- DLT=DebugLocalType, the type is a local variable inside a function

	rt_DLT_RESULT: INTEGER = 2
			-- DLT=DebugLocalType, the type is the Result of the current feature

	set_stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32; value: ANY): INTEGER is
			-- Set stack value at position `pos' on stack of depth `dep' with `value'
			--| Result is 0 is succeed, otherwise Result /= 0 implies error occurred.
		require
			a_loc_type_valid: a_loc_type = rt_DLT_LOCALVAR or a_loc_type = rt_DLT_ARGUMENT or a_loc_type = rt_DLT_RESULT
		local
			a_eif_type: INTEGER
		do
			debug ("RT_DBG_INTERNAL")
				print ("set_stack_value_at (dep=" + dep.out + ", loc_type=" + a_loc_type.out + ", pos=" + pos.out + ", type=0x" + a_rt_type.to_hex_string + ", value=")
				if value = Void then
					print ("Void) %N")
				else
					print (value.generating_type + ": " + value.out + ") %N")
				end
			end
			a_eif_type := eif_type (a_rt_type)
			inspect a_eif_type
			when boolean_type then
				if {bool: BOOLEAN} value then
					Result := c_set_boolean_stack_value (dep, a_loc_type, pos, bool)
				end
			when character_8_type then
				if {c8: CHARACTER_8} value then
					Result := c_set_character_8_stack_value (dep, a_loc_type, pos, c8)
				end
			when character_32_type then
				if {c32: CHARACTER_32} value then
					Result := c_set_character_32_stack_value (dep, a_loc_type, pos, c32)
				end
			when natural_8_type then
				if {n8: NATURAL_8} value then
					Result := c_set_natural_8_stack_value (dep, a_loc_type, pos, n8)
				end
			when natural_16_type then
				if {n16: NATURAL_16} value then
					Result := c_set_natural_16_stack_value (dep, a_loc_type, pos, n16)
				end
			when natural_32_type then
				if {n32: NATURAL_32} value then
					Result := c_set_natural_32_stack_value (dep, a_loc_type, pos, n32)
				end
			when natural_64_type then
				if {n64: NATURAL_64} value then
					Result := c_set_natural_64_stack_value (dep, a_loc_type, pos, n64)
				end
			when integer_8_type then
				if {i8: INTEGER_8} value then
					Result := c_set_integer_8_stack_value (dep, a_loc_type, pos, i8)
				end
			when integer_16_type then
				if {i16: INTEGER_16} value then
					Result := c_set_integer_16_stack_value (dep, a_loc_type, pos, i16)
				end
			when integer_32_type then
				if {i32: INTEGER_32} value then
					Result := c_set_integer_32_stack_value (dep, a_loc_type, pos, i32)
				end
			when integer_64_type then
				if {i64: INTEGER_64} value then
					Result := c_set_integer_64_stack_value (dep, a_loc_type, pos, i64)
				end
			when real_32_type then
				if {r32: REAL_32} value then
					Result := c_set_real_32_stack_value (dep, a_loc_type, pos, r32)
				end
			when real_64_type then
				if {r64: REAL_64} value then
					Result := c_set_real_64_stack_value (dep, a_loc_type, pos, r64)
				end
			when pointer_type then
				if {ptr: POINTER} value then
					Result := c_set_pointer_stack_value (dep, a_loc_type, pos, ptr)
				end
			when reference_type then
				if value /= Void then
					Result := c_set_reference_stack_value (dep, a_loc_type, pos, $value)
				else
					Result := c_set_void_stack_value (dep, a_loc_type, pos)
				end
			else
				Result := 2
			end
			debug ("RT_DBG_INTERNAL")
				print ("set_stack_value_at (dep=" + dep.out + ", loc_type=" + a_loc_type.out + ", pos=" + pos.out  +", ...) -> " + Result.out + " %N")
				print ("set_stack_value_at: check modification -> ")
				if {a: ANY} stack_value_at (dep, a_loc_type, pos, a_rt_type) then
					print (a.generating_type + ": " + a.out + "%N")
				else
					print (" Void %N" )
				end
			end

		end

	frozen c_set_boolean_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_bool: BOOLEAN): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_BOOL; a_val.it_bool = (EIF_BOOLEAN) $a_bool;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_character_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ch8: CHARACTER_8): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_CHAR; a_val.it_c1 = (EIF_CHARACTER) $a_ch8;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_character_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ch32: CHARACTER_32): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_WCHAR; a_val.it_c4 = (EIF_WIDE_CHAR) $a_ch32;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end

	frozen c_set_natural_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n8: NATURAL_8): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_UINT8; a_val.it_n1 = (EIF_NATURAL_8) $a_n8;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_natural_16_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n16: NATURAL_16): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_UINT16; a_val.it_n2 = (EIF_NATURAL_16) $a_n16;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_natural_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n32: NATURAL_32): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_UINT32; a_val.it_n4 = (EIF_NATURAL_32) $a_n32;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_natural_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n64: NATURAL_64): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_UINT64; a_val.it_n8 = (EIF_NATURAL_64) $a_n64;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end

	frozen c_set_integer_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i8: INTEGER_8): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_INT8; a_val.it_i1 = (EIF_INTEGER_8) $a_i8;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_integer_16_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i16: INTEGER_16): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_INT16; a_val.it_i2 = (EIF_INTEGER_16) $a_i16;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_integer_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i32: INTEGER_32): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_INT32; a_val.it_i4 = (EIF_INTEGER_32) $a_i32;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_integer_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i64: INTEGER_64): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_INT64; a_val.it_i8 = (EIF_INTEGER_64) $a_i64;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_real_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i32: REAL_32): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_REAL32; a_val.it_r4 = (EIF_REAL_32) $a_i32;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_real_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i64: REAL_64): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_REAL64; a_val.it_r8 = (EIF_REAL_64) $a_i64;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_pointer_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_p: POINTER): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; a_val.type = SK_POINTER; a_val.it_p = (EIF_POINTER) $a_p;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_reference_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ref: POINTER): INTEGER is
		require
			a_ref_not_null: a_ref /= Default_pointer
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; 
				a_val.type = SK_REF; 
				a_val.it_ref = (EIF_REFERENCE) &($a_ref);
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end
	frozen c_set_void_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER): INTEGER is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_TYPED_VALUE a_val; 
				a_val.type = SK_VOID; 
				a_val.it_ref = (char*) 0;
				return rt_dbg_set_stack_value ((uint32)$dep, (uint32)$a_loc_type, (uint32)$pos, (EIF_TYPED_VALUE*) &a_val);
			#else
				return 0;
			#endif
			]"
		end

feature -- Testing

	c_rt_set_is_inside_rt_eiffel_code (v: INTEGER) is
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_GET_CONTEXT; is_inside_rt_eiffel_code = $v;
			#endif
			]"
		end

	test_locals (dep: INTEGER; loc_pos: INTEGER; val: ANY; a_rt_type: NATURAL_32) is
		local
			s: STRING
			a: ANY
			retried: BOOLEAN
		do
			if not retried then
				c_rt_set_is_inside_rt_eiffel_code (1);
				s := "----------------------------------%N"
				s.append ("Loc #" + loc_pos.out + "(stack depth=" + dep.out + ")")
				if val /= Void then
					s.append (": should be " + val.generating_type)
				end
				s.append ("%N")
				print (s)
--				s.wipe_out

				a := stack_value_at (dep, rt_DLT_LOCALVAR, loc_pos, a_rt_type)

				s.append (" -> ")
				if a /= Void then
					s.append (a.generating_type + "=" + a.out)
				else
					s.append ("Void object")
				end
				s.append ("%N")
				print (s)
				c_rt_set_is_inside_rt_eiffel_code (0);
			else
				print ("Rescued%N")
				c_rt_set_is_inside_rt_eiffel_code (0);
			end
		rescue
			retried := True
			retry
		end

	test_set_local (dep: INTEGER; loc_pos: INTEGER; val: ANY; a_rt_type: NATURAL_32) is
		local
			s: STRING
			r: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				c_rt_set_is_inside_rt_eiffel_code (1);
				s := "----------------------------------%N"
				s.append ("SetLoc #" + loc_pos.out + "(stack depth=" + dep.out + ")")
				if val /= Void then
					s.append (": value " + val.generating_type)
				else
					s.append (": value Void")
				end
				s.append ("%N")
				print (s)

				r := set_stack_value_at (dep, rt_DLT_LOCALVAR, loc_pos, a_rt_type, val)

				s.append (" -> ")
				s.append ("Result = " + r.out)
				s.append ("%N")
				print (s)
				c_rt_set_is_inside_rt_eiffel_code (0);
			else
				print ("Rescued%N")
				c_rt_set_is_inside_rt_eiffel_code (0);
			end
		rescue
			retried := True
			retry
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
