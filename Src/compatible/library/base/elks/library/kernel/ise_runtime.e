note
	description: "[
		Set of features to access ISE runtime functionality.
		To be used at your own risk.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_RUNTIME

feature -- Feature specific to ISE runtime.

	frozen c_generator_of_type (type_id: INTEGER): STRING
			-- Name of the generating class of current object
		external
			"C use %"eif_out.h%""
		end

	frozen check_assert (b: BOOLEAN): BOOLEAN
		external
			"C use %"eif_copy.h%""
		alias
			"c_check_assert"
		end

 	frozen c_generating_type_of_type (type_id: INTEGER): STRING
 		external
 			"C signature (int16): EIF_REFERENCE use %"eif_gen_conf.h%""
 		alias
 			"eif_gen_typename_of_type"
 		end

	frozen in_assertion: BOOLEAN
			-- Are we currently checking some assertions?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				GTCX;	/* Needed in multithreaded mode as `in_assertion' is a per-thread data. */
				return EIF_TEST(in_assertion!=0);
			]"
		end

	frozen once_objects (a_result_type: INTEGER): SPECIAL [ANY]
			-- Once objects initialized in current system.
			-- `a_result_type' is the dynamic type of `SPECIAL [ANY]'.
		external
			"C signature (EIF_INTEGER): EIF_REFERENCE use %"eif_memory_analyzer.h%""
		alias
			"eif_once_objects_of_result_type"
		end

feature -- Internal C routines

	frozen type_id_from_name (s: POINTER): INTEGER
			-- Dynamic type whose name is represented by `s'.
		external
			"C signature (char *): EIF_INTEGER use %"eif_cecil.h%""
		alias
			"eif_type_id"
		end

	frozen dynamic_type (object: ANY): INTEGER
			-- Dynamic type of `object'.
		external
			"built_in static"
		end

	frozen pre_ecma_mapping_status: BOOLEAN
			-- Do we map old name to new name by default?
		external
			"C inline use %"eif_cecil.h%""
		alias
			"return eif_pre_ecma_mapping();"
		end

	frozen set_pre_ecma_mapping (v: BOOLEAN)
			-- Set `pre_ecma_mapping_status' with `v'.
		external
			"C inline use %"eif_cecil.h%""
		alias
			"eif_set_pre_ecma_mapping($v)"
		end

	frozen is_attached_type (a_type: INTEGER): BOOLEAN
			-- Is `a_type' an attached type?
		external
			"C inline  use %"eif_gen_conf.h%""
		alias
			"return eif_is_attached_type((EIF_TYPE_INDEX) $a_type)"
		end

	frozen detachable_type (a_type: INTEGER): INTEGER
			-- Detachable version of `a_type'
		external
			"C inline  use %"eif_gen_conf.h%""
		alias
			"return eif_non_attached_type((EIF_TYPE_INDEX) $a_type)"
		end

	frozen attached_type (a_type: INTEGER): INTEGER
			-- Attached version of `a_type'
		external
			"C inline  use %"eif_gen_conf.h%""
		alias
			"return eif_attached_type((EIF_TYPE_INDEX) $a_type)"
		end

end
