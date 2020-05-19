note
	description: "Internal routine for RT_DBG_ classes"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	RT_DBG_INTERNAL

inherit
	REFLECTOR_CONSTANTS

feature -- Object access

	frozen object_field_count (obj: ANY): INTEGER
			-- Field_count on `obj'
		require
			obj_attached: obj /= Void
		do
			reflected_object.set_object (obj)
			Result := reflected_object.field_count
		end

	frozen object_records (obj: ANY): detachable ARRAYED_LIST [RT_DBG_VALUE_RECORD]
			-- List of field records on `obj'
		require
			obj_attached: obj /= Void
		local
			i, cnb: INTEGER
			l_records: like object_records
		do
			cnb := object_field_count (obj)
			if cnb > 0 then
				create l_records.make (cnb)
				from
					i := 1
				until
					i > cnb
				loop
					if attached {like object_record} object_record (i, obj) as r then
						l_records.extend (r)
					end
					i := i + 1
				end
				Result := l_records
			end
		end

	frozen object_is_expanded (object: ANY): BOOLEAN
			-- Is `object' an expanded value ?
		require
			object_not_void: object /= Void
		do
			Result := c_object_is_expanded ($object)
		end

	frozen field_index_at (off: INTEGER; obj: ANY): INTEGER
			-- Field name at offset `off' on `obj'
			--| note: heavy computing, for debug purpose only
		require
			obj /= Void
		local
			n: INTEGER
			l_reflected_object: like reflected_object
		do
			from
				l_reflected_object := reflected_object
				l_reflected_object.set_object (obj)
				n := l_reflected_object.field_count
			until
				n = 0 or Result > 0
			loop
				if off = l_reflected_object.field_offset (n) then
					Result := n
				end
				n := n - 1
			end
		end

	frozen field_name_at (off: INTEGER; obj: ANY): detachable STRING
			-- Field name at offset `off' on `obj'
			--| note: heavy computing, for debug purpose only
		require
			obj /= Void
		local
			i: INTEGER
		do
			i := field_index_at (off, obj)
			if i > 0 then
				reflected_object.set_object (obj)
				Result := reflected_object.field_name (i)
			end
		end

	frozen field_at (off: INTEGER; a_field_type: NATURAL_32; object: ANY): detachable ANY
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
				Result := {ISE_RUNTIME}.boolean_field_at (off, $object, 0)
			when character_8_type then
				Result := {ISE_RUNTIME}.character_8_field_at (off, $object, 0)
			when character_32_type then
				Result := {ISE_RUNTIME}.character_32_field_at (off, $object, 0)
			when natural_8_type then
				Result := {ISE_RUNTIME}.natural_8_field_at (off, $object, 0)
			when natural_16_type then
				Result := {ISE_RUNTIME}.natural_16_field_at (off, $object, 0)
			when natural_32_type then
				Result := {ISE_RUNTIME}.natural_32_field_at (off, $object, 0)
			when natural_64_type then
				Result := {ISE_RUNTIME}.natural_64_field_at (off, $object, 0)
			when integer_8_type then
				Result := {ISE_RUNTIME}.integer_8_field_at (off, $object, 0)
			when integer_16_type then
				Result := {ISE_RUNTIME}.integer_16_field_at (off, $object, 0)
			when integer_32_type then
				Result := {ISE_RUNTIME}.integer_32_field_at (off, $object, 0)
			when integer_64_type then
				Result := {ISE_RUNTIME}.integer_64_field_at (off, $object, 0)
			when real_32_type then
				Result := {ISE_RUNTIME}.real_32_field_at (off, $object, 0)
			when real_64_type then
				Result := {ISE_RUNTIME}.real_64_field_at (off, $object, 0)
			when pointer_type then
				Result := {ISE_RUNTIME}.pointer_field_at (off, $object, 0)
			when reference_type then
				Result := {ISE_RUNTIME}.reference_field_at (off, $object, 0)
			else
			end
		end

	frozen stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32): detachable ANY
			-- Object attached at offset `off' field of `object'
			-- (directly or through a reference)
		require
			index_large_enough: pos >= 1
		do
			debug ("RT_DBG_INTERNAL")
				print ({STRING} "%Nstack_value_at (" + dep.out + ", " + pos.out + ", 0x" + a_rt_type.to_hex_string + ")%N")
			end
			Result := c_stack_value_at (dep, a_loc_type, pos, a_rt_type)
			debug ("RT_DBG_INTERNAL")
				print ("stack_value_at -> ")
				if Result /= Void then
					print (Result.generating_type.name_32 + " = " + Result.out)
				else
					print ("Void Result")
				end
				print ("%N")
			end
		end

	frozen eif_type (a_field_type: NATURAL_32): INTEGER
			-- EIF_ type from field type `a_field_type'
		do
			Result := c_eif_type (a_field_type)
		end

	frozen rt_dynamic_type (object: ANY): INTEGER
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := c_rt_dynamic_type ($object)
		ensure
			rt_dynamic_type_nonnegative: Result >= 0
		end

feature {NONE} -- Factory

	frozen object_record (i: INTEGER; obj: ANY): detachable RT_DBG_VALUE_RECORD
		require
			obj_attached: obj /= Void
		local
			ft: INTEGER
			l_reflected_object: like reflected_object
		do
			l_reflected_object := reflected_object
			l_reflected_object.set_object (obj)
			ft := l_reflected_object.field_type (i)
			Result := object_attribute_record (l_reflected_object.field_offset (i), c_rt_field_type (i, ft), obj)
			inspect ft
			when Integer_8_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_8]} Result.make (obj, i, ft, l_reflected_object.integer_8_field (i))
			when Integer_16_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_16]} Result.make (obj, i, ft, l_reflected_object.integer_16_field (i))
			when integer_32_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_32]} Result.make (obj, i, ft, l_reflected_object.integer_32_field (i))
			when Integer_64_type then
				create {RT_DBG_FIELD_RECORD [INTEGER_64]} Result.make (obj, i, ft, l_reflected_object.integer_64_field (i))
			when natural_8_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_8]} Result.make (obj, i, ft, l_reflected_object.natural_8_field (i))
			when natural_16_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_16]} Result.make (obj, i, ft, l_reflected_object.natural_16_field (i))
			when natural_32_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_32]} Result.make (obj, i, ft, l_reflected_object.natural_32_field (i))
			when natural_64_type then
				create {RT_DBG_FIELD_RECORD [NATURAL_64]} Result.make (obj, i, ft, l_reflected_object.natural_64_field (i))
			when Pointer_type then
				create {RT_DBG_FIELD_RECORD [POINTER]} Result.make (obj, i, ft, l_reflected_object.pointer_field (i))
			when Reference_type then
				create {RT_DBG_FIELD_RECORD [detachable ANY]} Result.make (obj, i, ft, l_reflected_object.reference_field (i))
			when Expanded_type then
				create {RT_DBG_FIELD_RECORD [detachable ANY]} Result.make (obj, i, ft, l_reflected_object.field (i))
			when Boolean_type then
				create {RT_DBG_FIELD_RECORD [BOOLEAN]} Result.make (obj, i, ft, l_reflected_object.boolean_field (i))
			when real_32_type then
				create {RT_DBG_FIELD_RECORD [REAL_32]} Result.make (obj, i, ft, l_reflected_object.real_32_field (i))
			when real_64_type then
				create {RT_DBG_FIELD_RECORD [REAL_64]} Result.make (obj, i, ft, l_reflected_object.real_64_field (i))
			when character_8_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_8]} Result.make (obj, i, ft, l_reflected_object.character_8_field (i))
			when character_32_type then
				create {RT_DBG_FIELD_RECORD [CHARACTER_32]} Result.make (obj, i, ft, l_reflected_object.character_32_field (i))
--			when none_type then
			else
			end
		end

	frozen object_attribute_record (off: INTEGER; t: NATURAL_32; obj: ANY): detachable RT_DBG_VALUE_RECORD
			-- Record for attribute of type `t' at offset `o' on object `obj'
		require
			obj_attached: obj /= Void
		local
			ft: INTEGER
			l_reflected_object: REFLECTED_REFERENCE_OBJECT
		do
			ft := eif_type (t)
			inspect ft
			when boolean_type then
				create {RT_DBG_ATTRIBUTE_RECORD [BOOLEAN]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.boolean_field_at (off, $obj, 0))
			when character_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [CHARACTER_8]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.character_8_field_at (off, $obj, 0))
			when character_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [CHARACTER_32]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.character_32_field_at (off, $obj, 0))
			when Integer_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_8]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.integer_8_field_at (off, $obj, 0))
			when Integer_16_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_16]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.integer_16_field_at (off, $obj, 0))
			when integer_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_32]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.integer_32_field_at (off, $obj, 0))
			when Integer_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [INTEGER_64]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.integer_64_field_at (off, $obj, 0))
			when natural_8_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_8]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.natural_8_field_at (off, $obj, 0))
			when natural_16_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_16]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.natural_16_field_at (off, $obj, 0))
			when natural_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_32]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.natural_8_field_at (off, $obj, 0))
			when natural_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [NATURAL_64]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.natural_8_field_at (off, $obj, 0))
			when real_32_type then
				create {RT_DBG_ATTRIBUTE_RECORD [REAL_32]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.real_32_field_at (off, $obj, 0))
			when real_64_type then
				create {RT_DBG_ATTRIBUTE_RECORD [REAL_64]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.real_64_field_at (off, $obj, 0))
			when Pointer_type then
				create {RT_DBG_ATTRIBUTE_RECORD [POINTER]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.pointer_field_at (off, $obj, 0))
			when Reference_type then
				create {RT_DBG_ATTRIBUTE_RECORD [ANY]} Result.make (obj, off, ft, t, {ISE_RUNTIME}.reference_field_at (off, $obj, 0))
			when Expanded_type then
				create l_reflected_object.make_for_expanded_field_at (obj, off)
				create {RT_DBG_ATTRIBUTE_RECORD [ANY]} Result.make (obj, off, ft, t, l_reflected_object.object)
--			when none_type then
			else
			end
		end

	frozen object_local_record (dep: INTEGER; pos: INTEGER; t: NATURAL_32): detachable RT_DBG_VALUE_RECORD
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
			when none_type then
			else
			end
			if Result /= Void then
				Result.get_value
			end
		end

feature {NONE} -- External implementation

	frozen c_object_is_expanded (object: POINTER): BOOLEAN
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"eif_is_expanded(HEADER($object)->ov_flags)"
		end

	frozen c_eif_type (a_field_type: NATURAL_32): INTEGER
			-- EIF_ type related to `a_field_type'
		external
			"C inline use %"eif_internal.h%""
		alias
			"ei_eif_type((uint32) $a_field_type)"
		end

	frozen c_rt_field_type (i: INTEGER; a_type_id: INTEGER): NATURAL_32
			-- RT field type related to `i' on `a_type_id'
		external
			"C inline use %"eif_internal.h%""
		alias
			"System(To_dtype($a_type_id)).cn_types[$i]"
		end

	frozen c_rt_dynamic_type (object: POINTER): INTEGER
			-- Dynamic type of `object'.
		external
			"C macro signature (EIF_REFERENCE): EIF_INTEGER use %"eif_macros.h%""
		alias
			"Dtype"
		end

feature -- Change field

	set_field_at (off: INTEGER; a_type: NATURAL_32; value: detachable ANY; object: ANY)
		require
			object_attached: object /= Void
		local
			a_eif_type: INTEGER
		do
debug ("RT_DBG_INTERNAL")
			print ({STRING_32} "set_field_at (" + off.out + ", " + a_type.out + ", value, " + object.generator + ") %N")
end
			a_eif_type := eif_type (a_type)
			inspect a_eif_type
			when boolean_type then
				if attached {BOOLEAN} value as bool then
					{ISE_RUNTIME}.set_boolean_field_at (off, $object, 0, bool)
				end
			when character_8_type then
				if attached {CHARACTER_8} value as c8 then
					{ISE_RUNTIME}.set_character_8_field_at (off, $object, 0, c8)
				end
			when character_32_type then
				if attached {CHARACTER_32} value as c32 then
					{ISE_RUNTIME}.set_character_32_field_at (off, $object, 0, c32)
				end
			when natural_8_type then
				if attached {NATURAL_8} value as n8 then
					{ISE_RUNTIME}.set_natural_8_field_at (off, $object, 0, n8)
				end
			when natural_16_type then
				if attached {NATURAL_16} value as n16 then
					{ISE_RUNTIME}.set_natural_16_field_at (off, $object, 0, n16)
				end
			when natural_32_type then
				if attached {NATURAL_32} value as n32 then
					{ISE_RUNTIME}.set_natural_32_field_at (off, $object, 0, n32)
				end
			when natural_64_type then
				if attached {NATURAL_64} value as n64 then
					{ISE_RUNTIME}.set_natural_64_field_at (off, $object, 0, n64)
				end
			when integer_8_type then
				if attached {INTEGER_8} value as i8 then
					{ISE_RUNTIME}.set_integer_8_field_at (off, $object, 0, i8)
				end
			when integer_16_type then
				if attached {INTEGER_16} value as i16 then
					{ISE_RUNTIME}.set_integer_16_field_at (off, $object, 0, i16)
				end
			when integer_32_type then
				if attached {INTEGER_32} value as i32 then
					{ISE_RUNTIME}.set_integer_32_field_at (off, $object, 0, i32)
				end
			when integer_64_type then
				if attached {INTEGER_64} value as i64 then
					{ISE_RUNTIME}.set_integer_64_field_at (off, $object, 0, i64)
				end
			when real_32_type then
				if attached {REAL_32} value as r32 then
					{ISE_RUNTIME}.set_real_32_field_at (off, $object, 0, r32)
				end
			when real_64_type then
				if attached {REAL_64} value as r64 then
					{ISE_RUNTIME}.set_real_64_field_at (off, $object, 0, r64)
				end
			when pointer_type then
				if attached {POINTER} value as ptr then
					{ISE_RUNTIME}.set_pointer_field_at (off, $object, 0, ptr)
				end
			when reference_type then
				{ISE_RUNTIME}.set_reference_field_at (off, $object, 0, value)
			else
			end
		end

feature -- Access local

	frozen c_stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32): detachable ANY
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

	set_stack_value_at (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_rt_type: NATURAL_32; value: detachable ANY): INTEGER
			-- Set stack value at position `pos' on stack of depth `dep' with `value'
			--| Result is 0 is succeed, otherwise Result /= 0 implies error occurred.
		require
			a_loc_type_valid: a_loc_type = rt_DLT_LOCALVAR or a_loc_type = rt_DLT_ARGUMENT or a_loc_type = rt_DLT_RESULT
		local
			a_eif_type: INTEGER
		do
			debug ("RT_DBG_INTERNAL")
				print ({STRING} "set_stack_value_at (dep=" + dep.out + ", loc_type=" + a_loc_type.out + ", pos=" + pos.out + ", type=0x" + a_rt_type.to_hex_string + ", value=")
				if value = Void then
					print ("Void) %N")
				else
					print (value.generating_type.name_32 + ": " + value.out + ") %N")
				end
			end
			a_eif_type := eif_type (a_rt_type)
			inspect a_eif_type
			when boolean_type then
				if attached {BOOLEAN} value as bool then
					Result := c_set_boolean_stack_value (dep, a_loc_type, pos, bool)
				end
			when character_8_type then
				if attached {CHARACTER_8} value as c8 then
					Result := c_set_character_8_stack_value (dep, a_loc_type, pos, c8)
				end
			when character_32_type then
				if attached {CHARACTER_32} value as c32 then
					Result := c_set_character_32_stack_value (dep, a_loc_type, pos, c32)
				end
			when natural_8_type then
				if attached {NATURAL_8} value as n8 then
					Result := c_set_natural_8_stack_value (dep, a_loc_type, pos, n8)
				end
			when natural_16_type then
				if attached {NATURAL_16} value as n16 then
					Result := c_set_natural_16_stack_value (dep, a_loc_type, pos, n16)
				end
			when natural_32_type then
				if attached {NATURAL_32} value as n32 then
					Result := c_set_natural_32_stack_value (dep, a_loc_type, pos, n32)
				end
			when natural_64_type then
				if attached {NATURAL_64} value as n64 then
					Result := c_set_natural_64_stack_value (dep, a_loc_type, pos, n64)
				end
			when integer_8_type then
				if attached {INTEGER_8} value as i8 then
					Result := c_set_integer_8_stack_value (dep, a_loc_type, pos, i8)
				end
			when integer_16_type then
				if attached {INTEGER_16} value as i16 then
					Result := c_set_integer_16_stack_value (dep, a_loc_type, pos, i16)
				end
			when integer_32_type then
				if attached {INTEGER_32} value as i32 then
					Result := c_set_integer_32_stack_value (dep, a_loc_type, pos, i32)
				end
			when integer_64_type then
				if attached {INTEGER_64} value as i64 then
					Result := c_set_integer_64_stack_value (dep, a_loc_type, pos, i64)
				end
			when real_32_type then
				if attached {REAL_32} value as r32 then
					Result := c_set_real_32_stack_value (dep, a_loc_type, pos, r32)
				end
			when real_64_type then
				if attached {REAL_64} value as r64 then
					Result := c_set_real_64_stack_value (dep, a_loc_type, pos, r64)
				end
			when pointer_type then
				if attached {POINTER} value as ptr then
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
				print ({STRING} "set_stack_value_at (dep=" + dep.out + ", loc_type=" + a_loc_type.out + ", pos=" + pos.out  +", ...) -> " + Result.out + " %N")
				print ("set_stack_value_at: check modification -> ")
				if attached stack_value_at (dep, a_loc_type, pos, a_rt_type) as a then
					print (a.generating_type.name_32 + ": " + a.out + "%N")
				else
					print (" Void %N" )
				end
			end
		end

	frozen c_set_boolean_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_bool: BOOLEAN): INTEGER
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
	frozen c_set_character_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ch8: CHARACTER_8): INTEGER
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
	frozen c_set_character_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ch32: CHARACTER_32): INTEGER
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

	frozen c_set_natural_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n8: NATURAL_8): INTEGER
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
	frozen c_set_natural_16_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n16: NATURAL_16): INTEGER
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
	frozen c_set_natural_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n32: NATURAL_32): INTEGER
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
	frozen c_set_natural_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_n64: NATURAL_64): INTEGER
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

	frozen c_set_integer_8_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i8: INTEGER_8): INTEGER
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
	frozen c_set_integer_16_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i16: INTEGER_16): INTEGER
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
	frozen c_set_integer_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i32: INTEGER_32): INTEGER
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
	frozen c_set_integer_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i64: INTEGER_64): INTEGER
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
	frozen c_set_real_32_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i32: REAL_32): INTEGER
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
	frozen c_set_real_64_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_i64: REAL_64): INTEGER
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
	frozen c_set_pointer_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_p: POINTER): INTEGER
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
	frozen c_set_reference_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER; a_ref: POINTER): INTEGER
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
	frozen c_set_void_stack_value (dep: INTEGER; a_loc_type: INTEGER; pos: INTEGER): INTEGER
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

	c_rt_set_is_inside_rt_eiffel_code (v: INTEGER)
		external
			"C inline use %"eif_debug.h%""
		alias
			"[
			#ifdef WORKBENCH
				EIF_GET_CONTEXT; is_inside_rt_eiffel_code = $v;
			#endif
			]"
		end

	test_locals (dep: INTEGER; loc_pos: INTEGER; val: ANY; a_rt_type: NATURAL_32)
		local
			s: STRING_32
			retried: BOOLEAN
		do
			if not retried then
				c_rt_set_is_inside_rt_eiffel_code (1);
				s := "----------------------------------%N"
				s.append ({STRING_32} "Loc #" + loc_pos.out + "(stack depth=" + dep.out + ")")
				if val /= Void then
					s.append (": should be " + val.generating_type.name_32)
				end
				s.append ("%N")
				print (s)
--				s.wipe_out
				s.append (" -> ")
				if attached stack_value_at (dep, rt_DLT_LOCALVAR, loc_pos, a_rt_type) as a then
					s.append (a.generating_type.name_32 + "=" + a.out)
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

	test_set_local (dep: INTEGER; loc_pos: INTEGER; val: ANY; a_rt_type: NATURAL_32)
		local
			s: STRING_32
			r: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				c_rt_set_is_inside_rt_eiffel_code (1);
				s := "----------------------------------%N"
				s.append ({STRING_32} "SetLoc #" + loc_pos.out + "(stack depth=" + dep.out + ")")
				if val /= Void then
					s.append (": value " + val.generating_type.name_32)
				else
					s.append (": value Void")
				end
				s.append ("%N")
				print (s)

				r := set_stack_value_at (dep, rt_DLT_LOCALVAR, loc_pos, a_rt_type, val)

				s.append (" -> ")
				s.append ({STRING_32} "Result = " + r.out)
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

feature {NONE} -- Implementation

	reflected_object: REFLECTED_REFERENCE_OBJECT
			-- To enable object introspection.
		once
			create Result.make (Current)
		end

	reflector: REFLECTOR
			-- To enable type discovery
		once
			create Result
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
