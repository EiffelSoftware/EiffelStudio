indexing
	description: "Set of features to access ISE runtime functionality"
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_RUNTIME

feature -- Feature specific to ISE runtime.

	frozen c_standard_clone (other: POINTER): ANY is
			-- New object of same dynamic type as `other'
		external
			"C | %"eif_copy.h%""
		alias
			"eclone"
		end

	frozen c_conforms_to (obj1, obj2: POINTER): BOOLEAN is
			-- Does dynamic type of object attached to `obj1' conform to
			-- dynamic type of object attached to `obj2'?
		external
			"C [macro %"eif_plug.h%"]"
		alias
			"econfg"
		end

	frozen c_same_type (obj1, obj2: POINTER): BOOLEAN is
			-- Are dynamic type of object attached to `obj1' and
			-- dynamic type of object attached to `obj2' the same?
		external
			"C [macro %"eif_plug.h%"]"
		alias
			"estypeg"
		end

	frozen c_standard_is_equal (target, source: POINTER): BOOLEAN is
			-- C external performing standard equality
		external
			"C | %"eif_equal.h%""
		alias
			"eequal"
		end

	frozen c_standard_copy (source, target: POINTER) is
			-- C external performing standard copy
		external
			"C | %"eif_copy.h%""
		alias
			"ecopy"
		end

	frozen c_deep_clone (other: POINTER): ANY is
			-- New object structure recursively duplicated from the one
			-- attached to `other'
		external
			"C | %"eif_copy.h%""
		alias
			"edclone"
		end

	frozen c_deep_equal (some: POINTER; other: like some): BOOLEAN is
			-- Are `some' and `other' attached to recursively isomorphic
			-- object structures?
		external
			"C | %"eif_equal.h%""
		alias
			"ediso"
		end

	frozen c_tagged_out (some: ANY): STRING is
			-- Printable representation of current object
		external
			"C | %"eif_out.h%""
		end

	frozen c_generator (some: POINTER): STRING is
			-- Name of the generating class of current object
		external
			"C | %"eif_out.h%""
		end

	frozen check_assert (b: BOOLEAN): BOOLEAN is
		external
			"C | %"eif_copy.h%""
		alias
			"c_check_assert"
		end

 	frozen c_generating_type (obj: POINTER): STRING is
 		external
 			"C | %"eif_gen_conf.h%""
 		alias
 			"eif_gen_typename"
 		end

feature -- Internal C routines

	type_id_from_name (s: POINTER): INTEGER is
			-- Dynamic type whose name is represented by `s'.
		external
			"C (char *): EIF_INTEGER | %"eif_cecil.h%""
		alias
			"eif_type_id"
		end

	dynamic_type (object: POINTER): INTEGER is
			-- Dynamic type of `object'.
		external
			"C macro signature (EIF_REFERENCE): EIF_INTEGER use %"eif_macros.h%""
		alias
			"Dftype"
		end
		
end -- class ISE_RUNTIME
