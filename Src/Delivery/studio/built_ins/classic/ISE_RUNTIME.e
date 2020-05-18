class 
	ISE_RUNTIME

feature -- Feature specific to ISE runtime.

	generator_of_type (a_type_id: INTEGER): STRING
			-- Name of the generating class of current object
		external
			"C inline use %"eif_out.h%""
		alias
			"return c_generator_of_type(eif_decoded_type($a_type_id));"
		end

	generator_8_of_type (a_type_id: INTEGER): STRING_8
			-- Name of the generating class of current object
		external
			"C inline use %"eif_out.h%""
		alias
			"return c_generator_of_type(eif_decoded_type($a_type_id));"
		end

	check_assert (b: BOOLEAN): BOOLEAN
		external
			"C use %"eif_copy.h%""
		alias
			"c_check_assert"
		end

	in_assertion: BOOLEAN
			-- Are we currently checking some assertions?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				GTCX;	/* Needed in multithreaded mode as `in_assertion' is a per-thread data. */
				return EIF_TEST(in_assertion!=0);
			]"
		end

	once_objects (a_result_type_id: INTEGER): SPECIAL [ANY]
			-- Once objects initialized in current system.
			-- `a_result_type_id' is the dynamic type of `SPECIAL [ANY]'.
		external
			"C inline use %"eif_memory_analyzer.h%""
		alias
			"return eif_once_objects_of_result_type(eif_decoded_type($a_result_type_id));"
		end

feature -- Internal C routines

	type_id_from_name (s: POINTER): INTEGER
			-- Dynamic type whose name is represented by `s'.
		external
			"C signature (char *): EIF_INTEGER use %"eif_cecil.h%""
		alias
			"eif_type_id"
		end

	pre_ecma_mapping_status: BOOLEAN
			-- Do we map old name to new name by default?
		external
			"C inline use %"eif_cecil.h%""
		alias
			"return eif_pre_ecma_mapping();"
		end

	set_pre_ecma_mapping (v: BOOLEAN)
			-- Set `pre_ecma_mapping_status' with `v'.
		external
			"C inline use %"eif_cecil.h%""
		alias
			"eif_set_pre_ecma_mapping($v)"
		end

	storable_version_of_type (a_type_id: INTEGER): detachable STRING_8
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				const char *l_version = System(To_dtype(eif_decoded_type($a_type_id).id)).cn_version;
				if (l_version && (l_version[0] != (char) 0)) {
					return RTMS(l_version);
				} else {
					return NULL;
				}
			]"
		end

	compiler_version: INTEGER
		external
			"C macro use %"eif_project.h%""
		alias
			"egc_compiler_tag"
		end

feature -- Object marking

	lock_marking
		external
			"C blocking use %"eif_traverse.h%""
		alias
			"eif_lock_marking"
		end

	unlock_marking
		external
			"C use %"eif_traverse.h%""
		alias
			"eif_unlock_marking"
		end		
	
end	
