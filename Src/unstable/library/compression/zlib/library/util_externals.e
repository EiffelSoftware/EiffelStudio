note
	description: "Helper functions dependent of external stuff."
	date: "$Date$"
	revision: "$Revision$"

class
	UTIL_EXTERNALS

feature -- Operations

	character_array_from_external (a_array: ARRAY [CHARACTER]; a_memory: POINTER; a_size: INTEGER)
			-- size given array to [1..a_size] and fills it with content from 'a_memory'
			-- NOTE: no way to detect if 'a_memory' really references a block of size 'a_size'
		require
			non_void_array: a_array /= Void
			non_null_memory: a_memory /= default_pointer
			positive_size: a_size > 0
		local
			arr: ANY
			ptr: POINTER
		do
			a_array.conservative_resize_with_default (create {CHARACTER}, 1, a_size)
			arr := a_array.to_c
			ptr := $arr
			ptr.memory_copy (a_memory, a_size)
		ensure
			class
		end

	character_array_to_external (a_array: ARRAY [CHARACTER]): POINTER
			-- give external routines access to the data of 'a_array'
		require
			non_void_array: a_array /= Void
			non_empty_array: a_array.count > 0
		local
			res: ANY
		do
			res := a_array.to_c
			Result := $res
		ensure
			class
		end

	character_array_to_frozen_external (a_array: ARRAY [CHARACTER]): POINTER
			-- give external routines access to the data of 'a_array'
		require
			non_void_array: a_array /= Void
			non_empty_array: a_array.count > 0
		do
			Result := freeze (a_array.to_c)
		ensure
			class
		end

	unfreeze_array (a_array: ARRAY [CHARACTER])
		local
			tmp: ANY
		do
			tmp := a_array.to_c
			unfreeze ($tmp)
		ensure
			class
		end

	integer_array_to_external (a_array: ARRAY [INTEGER]): POINTER
			-- give external routines access to the data of 'a_array'
		require
			non_void_array: a_array /= Void
			non_empty_array: a_array.count > 0
		local
			res: ANY
		do
			res := a_array.to_c
			Result := $res
		ensure
			class
		end

	integer_array_to_frozen_external (a_array: ARRAY [INTEGER]): POINTER
			-- give external routines access to the data of 'a_array'
		require
			non_void_array: a_array /= Void
			non_empty_array: a_array.count > 0
		do
			Result := freeze (a_array.to_c)
		ensure
			class
		end

	unfreeze_integer_array (a_array: ARRAY [INTEGER])
		local
			tmp: ANY
		do
			tmp := a_array.to_c
			unfreeze ($tmp)
		ensure
			class
		end

	string_from_external (a_cstring: POINTER): STRING
			-- create a new string from char*
		require
			non_null_c_string: a_cstring /= default_pointer
		do
			create Result.make_from_c (a_cstring)
		ensure
			class
		end

	string_fill_from_external (a_cstring: POINTER; a_string: STRING)
			-- fill given string from char*
		require
			non_null_c_string: a_cstring /= default_pointer
			non_void_string: a_string /= Void
		do
			a_string.from_c (a_cstring)
		ensure
			class
		end

	string_to_external (a_string: STRING): POINTER
			-- make the contents of 'a_string' accessible for external routines
		require
			non_void_string: a_string /= Void
		local
			res: ANY
		do
			res := a_string.to_c
			Result := $res
		ensure
			class
		end

	freeze (a_object: ANY): POINTER
		external
			"C (EIF_OBJECT): EIF_POINTER | %"eif_hector.h%""
		alias
			"eif_freeze"
		ensure
			is_frozen: is_frozen (Result) /= 0
			class
		end

	unfreeze (a_reference: POINTER)
		require
			is_frozen: is_frozen (a_reference) /= 0
		external
			"C (EIF_POINTER) | %"eif_hector.h%""
		alias
			"eif_unfreeze"
		ensure
			class
		end

	is_frozen (a_object: POINTER): INTEGER
		external
			"C [macro %"eif_hector.h%"] (EIF_REFERENCE): EIF_INTEGER"
		alias
			"eif_frozen"
		ensure
			class
		end

	string_to_frozen_external (a_string: STRING): POINTER
		require
			non_void_string: a_string /= Void
		do
			Result := freeze (a_string.to_c)
		ensure
			class
		end

	unfreeze_string (a_string: STRING)
		local
			tmp: ANY
		do
			tmp := a_string.to_c
			unfreeze ($tmp)
		ensure
			class
		end

	pointer_to_object (a_ptr: POINTER): detachable ANY
		do
			if a_ptr /= default_pointer then
				Result := eif_access (a_ptr)
			end
		ensure
			class
		end

	object_to_pointer (a_obj: ANY): POINTER
		do
			Result := $a_obj
		ensure
			class
		end

	eif_access (a_ptr: POINTER): ANY
		external
			"C [macro %"eif_eiffel.h%"] (void*): EIF_REFERENCE"
		alias
			"(EIF_REFERENCE)"
		ensure
			class
		end

end
