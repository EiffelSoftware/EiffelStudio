note
	description: "Helper functions dependent of external stuff."
	date: "$Date$"
	revision: "$Revision$"

class
	UTIL_EXTERNALS

feature {NONE}

	character_array_from_external (array_: ARRAY [CHARACTER]; memory_: POINTER; size_: INTEGER)
			-- size given array to [1..size_] and fills it with content from 'memory_'
			-- NOTE: no way to detect if 'memory_' really references a block of size 'size_'
		require
			non_void_array: array_ /= Void
			non_null_memory: memory_ /= default_pointer
			positive_size: size_ > 0
		local
			arr: ANY
			ptr: POINTER
		do
			array_.resize (1, size_)
			arr := array_.to_c
			ptr := $arr
			ptr.memory_copy (memory_, size_)
		end -- array_to_external

	character_array_to_external (array_: ARRAY [CHARACTER]): POINTER
			-- give external routines access to the data of 'array_'
		require
			non_void_array: array_ /= Void
			non_empty_array: array_.count > 0
		local
			res: ANY
		do
			res := array_.to_c
			Result := $res
		end

	character_array_to_frozen_external (array_: ARRAY [CHARACTER]): POINTER
			-- give external routines access to the data of 'array_'
		require
			non_void_array: array_ /= Void
			non_empty_array: array_.count > 0
		do
			Result := freeze (array_.to_c)
		end

	unfreeze_array (array_: ARRAY [CHARACTER])
		local
			tmp: ANY
		do
			tmp := array_.to_c
			unfreeze ($tmp)
		end

	integer_array_to_external (array_: ARRAY [INTEGER]): POINTER
			-- give external routines access to the data of 'array_'
		require
			non_void_array: array_ /= Void
			non_empty_array: array_.count > 0
		local
			res: ANY
		do
			res := array_.to_c
			Result := $res
		end

	integer_array_to_frozen_external (array_: ARRAY [INTEGER]): POINTER
			-- give external routines access to the data of 'array_'
		require
			non_void_array: array_ /= Void
			non_empty_array: array_.count > 0
		do
			Result := freeze (array_.to_c)
		end

	unfreeze_integer_array (array_: ARRAY [INTEGER])
		local
			tmp: ANY
		do
			tmp := array_.to_c
			unfreeze ($tmp)
		end

	string_from_external (c_string_: POINTER): STRING
			-- create a new string from char*
		require
			non_null_c_string: c_string_ /= default_pointer
		do
			create Result.make_from_c (c_string_)
		end

	string_fill_from_external (c_string_: POINTER; string_: STRING)
			-- fill given string from char*
		require
			non_null_c_string: c_string_ /= default_pointer
			non_void_string: string_ /= Void
		do
			string_.from_c (c_string_)
		end

	string_to_external (string_: STRING): POINTER
			-- make the contents of 'string_' accessible for external routines
		require
			non_void_string: string_ /= Void
		local
			res: ANY
		do
			res := string_.to_c
			Result := $res
		end

	freeze (object_: ANY): POINTER
		external
			"C (EIF_OBJECT): EIF_POINTER | %"eif_hector.h%""
		alias
			"eif_freeze"
		ensure
			is_frozen: is_frozen (Result) /= 0
		end

	unfreeze (reference_: POINTER)
		require
			is_frozen: is_frozen (reference_) /= 0
		external
			"C (EIF_POINTER) | %"eif_hector.h%""
		alias
			"eif_unfreeze"
		end

	is_frozen (object_: POINTER): INTEGER
		external
			"C [macro %"eif_hector.h%"] (EIF_REFERENCE): EIF_INTEGER"
		alias
			"eif_frozen"
		end

	string_to_frozen_external (string_: STRING): POINTER
		require
			non_void_string: string_ /= Void
		do
			Result := freeze (string_.to_c)
		end

	unfreeze_string (string_: STRING)
		local
			tmp: ANY
		do
			tmp := string_.to_c
			unfreeze ($tmp)
		end

	pointer_to_object (ptr_: POINTER): detachable ANY
		do
			if ptr_ /= default_pointer then
				Result := eif_access (ptr_)
			end
		end

	object_to_pointer (obj_: ANY): POINTER
		do
			Result := $obj_
		end

	eif_access (ptr_: POINTER): ANY
		external
			"C [macro %"eif_eiffel.h%"] (void*): EIF_REFERENCE"
		alias
			"(EIF_REFERENCE)"
		end

end
