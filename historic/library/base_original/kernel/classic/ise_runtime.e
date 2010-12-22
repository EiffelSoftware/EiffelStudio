note
	description: "[
		Set of features to access ISE runtime functionality.
		To be used at your own risk.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_RUNTIME

feature -- Feature specific to ISE runtime.

	frozen c_standard_clone (other: POINTER): ANY
			-- New object of same dynamic type as `other'
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_copy.h%""
		alias
			"eclone"
		end

	frozen c_conforms_to (obj1, obj2: POINTER): BOOLEAN
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2'?
		external
			"C macro use %"eif_plug.h%""
		alias
			"econfg"
		end

	frozen c_same_type (obj1, obj2: POINTER): BOOLEAN
			-- Are dynamic type of object attached to `obj1' and
			-- dynamic type of object attached to `obj2' the same?
		external
			"C macro use %"eif_plug.h%""
		alias
			"estypeg"
		end

	frozen c_standard_is_equal (target, source: POINTER): BOOLEAN
			-- C external performing standard equality
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_BOOLEAN use %"eif_equal.h%""
		alias
			"eequal"
		end

	frozen c_standard_copy (source, target: POINTER)
			-- C external performing standard copy
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE) use %"eif_copy.h%""
		alias
			"ecopy"
		end

	frozen c_deep_clone (other: POINTER): ANY
			-- New object structure recursively duplicated from the one
			-- attached to `other'
		external
			"C signature (EIF_REFERENCE): EIF_REFERENCE use %"eif_copy.h%""
		alias
			"edclone"
		end

	frozen c_deep_equal (some: POINTER; other: like some): BOOLEAN
			-- Are `some' and `other' attached to recursively isomorphic
			-- object structures?
		external
			"C signature (EIF_REFERENCE, EIF_REFERENCE): EIF_BOOLEAN use %"eif_equal.h%""
		alias
			"ediso"
		end

	frozen c_tagged_out (some: POINTER): STRING
			-- Printable representation of current object
		external
			"C use %"eif_out.h%""
		end

	frozen c_generator_of_type (type_id: INTEGER): STRING
			-- Name of the generating class of current object
		external
			"C use %"eif_out.h%""
		end

	frozen c_generator (some: POINTER): STRING
			-- Name of the generating class of current object
		external
			"C macro use %"eif_out.h%""
		end

	frozen check_assert (b: BOOLEAN): BOOLEAN
		external
			"C use %"eif_copy.h%""
		alias
			"c_check_assert"
		end

 	frozen c_generating_type (obj: POINTER): STRING
 		external
 			"C macro use %"eif_gen_conf.h%""
 		alias
 			"eif_gen_typename"
 		end

 	frozen c_generating_type_of_type (type_id: INTEGER): STRING
 		external
 			"C signature (int16): EIF_REFERENCE use %"eif_gen_conf.h%""
 		alias
 			"eif_gen_typename_of_type"
 		end

	frozen sp_count (sp_obj: POINTER): INTEGER
			-- Count of special object
		external
			"C signature (EIF_REFERENCE): EIF_INTEGER use %"eif_plug.h%""
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

feature -- Internal C routines

	frozen type_id_from_name (s: POINTER): INTEGER
			-- Dynamic type whose name is represented by `s'.
		external
			"C signature (char *): EIF_INTEGER use %"eif_cecil.h%""
		alias
			"eif_type_id"
		end

	frozen dynamic_type (object: POINTER): INTEGER
			-- Dynamic type of `object'.
		external
			"C macro signature (EIF_REFERENCE): EIF_INTEGER use %"eif_macros.h%""
		alias
			"Dftype"
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

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ISE_RUNTIME
