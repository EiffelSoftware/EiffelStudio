/*
indexing
	description: "Set of features needed by the Eiffel compiler and Eiffel libraries
		to work properly"
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
using System.Collections;
using System.Text;
using System.Reflection;
using EiffelSoftware.Runtime.CA;
using EiffelSoftware.Runtime.Enums;
using EiffelSoftware.Runtime.Types;

namespace EiffelSoftware.Runtime {

public delegate int WEL_DISPATCHER_DELEGATE (IntPtr hwnd, int msg, int wparam, int lparam);
public delegate void WEL_ENUM_FONT_DELEGATE (IntPtr lpelf, IntPtr lpntm, int font_type, IntPtr lparam);
public delegate void WEL_ENUM_WINDOW_DELEGATE (IntPtr hwnd);
public delegate void EV_PIXMAP_IMP_DELEGATE (int error_code, int data_type, int pixmap_width,
	int pixmap_height, IntPtr rgb_data, IntPtr alpha_data);

[Serializable]
public class RUN_TIME
{
/*
feature -- Assertions
*/
	
	public static bool in_assertion ()
		// Is checking of assertions needed?
	{
		return (!internal_is_assertion_checked || internal_in_assertion);
	}

	public static void set_in_assertion (bool val)
		// Set `internal_in_assertion' with `val'.
	{
		internal_in_assertion = val;
	}

	public static bool check_assert (bool val)
		// Enable or disable checking of assertions?
	{
		bool tmp = internal_is_assertion_checked;
		internal_is_assertion_checked = val;
		return tmp;
	}

	[System.Diagnostics.DebuggerHiddenAttribute]
  	[System.Diagnostics.DebuggerStepThroughAttribute]
	public static void check_invariant (object o, bool is_final)
		// Given object `o' if it has some invariant to be checked, make
		// sure that they are checked and recursively goes to inherited
		// invariants and check them too.
	{
		EIFFEL_TYPE_INFO target;

		if (
			(!in_assertion ()) &&
			((is_final) || (is_assertion_checked (o.GetType (), ASSERTION_LEVEL_ENUM.invariant)))
		) {
			target = o as EIFFEL_TYPE_INFO;
			if (target != null) {
				set_in_assertion (true);

				invariant_checked_table = new Hashtable (10);

					// Check current invariant defined in `target'.
				target._invariant ();

				set_in_assertion (false);
			}
		}
	}

	public static bool is_invariant_checked_for (RuntimeTypeHandle type_handle)
		// Is `invariant' for type `type_handle' already processed?
	{
		bool Result = invariant_checked_table.ContainsKey (type_handle);
		if (!Result) {
			invariant_checked_table.Add (type_handle, true);
		}
		return Result;
	}

	public static string assertion_tag;
		// Tag of last checked assertion

	public static int assertion_code;
		// Code of last checked assertion

	public static void assertion_initialize (RuntimeTypeHandle type_handle)
		// Initializes runtime datastructure for assembly associated with
		// `type_handle'.
	{
		assertion_levels = new Hashtable (100);
		Assembly a = Type.GetTypeFromHandle (type_handle).Assembly;
		ASSERTION_LEVEL_ATTRIBUTE level_attribute;
		ASSERTION_LEVEL_ENUM l_common_level, l_current_level;
		bool l_computed, l_same_level;

		#if ASSERTIONS
			ASSERTIONS.CHECK ("There should be an assembly", a != null);
		#endif

		object [] cas = a.GetCustomAttributes (typeof (ASSERTION_LEVEL_ATTRIBUTE), false);
		if ((cas != null) && (cas.Length > 0)) {
			l_same_level = true;
			l_computed = false;
			l_common_level = ASSERTION_LEVEL_ENUM.no;
			foreach (object ca in cas) {
				level_attribute = (ASSERTION_LEVEL_ATTRIBUTE) ca;
				l_current_level = level_attribute.assertion_level;
				assertion_levels.Add (
					level_attribute.class_type,			// key
					l_current_level);	// value
				if (!l_computed) {
					l_common_level = l_current_level;
					l_computed = true;
				} else {
					if (l_same_level) {
						l_same_level = (l_common_level == l_current_level);
					}
				}
			}
			if (l_same_level) {
				global_assertion_level = l_common_level;
				is_global_assertion_level_set = true;
			} else {
				is_global_assertion_level_set = false;
			}
		} else {
			global_assertion_level = ASSERTION_LEVEL_ENUM.no;
			is_global_assertion_level_set = true;
		}
	}

	public static bool is_assertion_checked (Type t, ASSERTION_LEVEL_ENUM val)
		// Are assertions checked for type `t' for assertion type `val'.
		// Note that `val' is not a combination.
	{
		ASSERTION_LEVEL_ENUM type_assertion_level;
		object obj;
		bool Result;

		#if ASSERTIONS
			ASSERTIONS.CHECK ("Valid val",
				(val == ASSERTION_LEVEL_ENUM.no) ||
				(val == ASSERTION_LEVEL_ENUM.check) ||
				(val == ASSERTION_LEVEL_ENUM.require) ||
				(val == ASSERTION_LEVEL_ENUM.ensure) ||
				(val == ASSERTION_LEVEL_ENUM.loop) ||
				(val == ASSERTION_LEVEL_ENUM.invariant));
		#endif

		Result = !in_assertion();
		if (Result) {
				// Let's extract the specified assertion level for type `t'.
				// If `is_global_assertion_level_set' is set, then we can return
				// the global one.
			if (is_global_assertion_level_set) {
				return (global_assertion_level & val) == val;
			} else if ((assertion_levels != null)) {
				obj = assertion_levels [t];
				if (obj != null) {
					type_assertion_level = (ASSERTION_LEVEL_ENUM) obj;
				} else {
					type_assertion_level = ASSERTION_LEVEL_ENUM.no;
				}
			} else {
				type_assertion_level = ASSERTION_LEVEL_ENUM.no;
			}
			Result = ((type_assertion_level & val) == val);
		}
		return Result;
	}

/*
feature -- Exceptions
*/
	public static Exception last_exception;
		// Last raised exception in `rescue' clause.

	public static void raise (Exception e)
		// Throw an exception `e'.
	{
		throw e;
	}

	public static void generate_call_on_void_target_exception ()
		// Throw System.NullReferenceException to simulate a call on void target exception
		// when first argument of static routine of ANY is Void.
	{
		throw new System.NullReferenceException ();
	}

/*
feature {NONE} -- Implementation
*/
	private static Hashtable assertion_levels;
		// HASH_TABLE [ASSERTION_LEVEL_ENUM, Type] to store for each Eiffe type
		// its associated assertion level.

/*
feature {NONE} -- Implementations: Assertions
*/

	private static Hashtable invariant_checked_table;
		// Equivalent of an HASH_TABLE [Boolean, RuntimeTypeHandle]
		// For each type we have processed, key is True.

	private static bool internal_is_assertion_checked = true;
		// Are assertions checked?

	private static bool internal_in_assertion = false;
		// Flag used during assertion checking to make sure
		// that assertions are not checked within an assertion
		// checking.

	private static ASSERTION_LEVEL_ENUM global_assertion_level = ASSERTION_LEVEL_ENUM.no;
		// Default global level of assertion checking. If `is_global_assertion_level_set'
		// then all types have the same level of assertions, therefore no need to look
		// into the `assertion_levels' table to find out if we should check the assertion
		// for a given type.

	private static bool is_global_assertion_level_set = false;
		// Is `global_assertion_level' set?

/*
feature -- Redirection to feature of ANY class
*/
	public static bool conforms_to (Object obj1, Object obj2)
		// Does dynamic type of object attached to `obj1' conform to
		// dynamic type of object attached to `obj2'?
	{
		return ANY.conforms_to (obj1, obj2);
	}

	public static object clone (object Current, object other)
		// Void if `other' is void; otherwise new object
		// equal to `other'
		//
		// For non-void `other', `clone' calls `copy';
		// to change copying/cloning semantics, redefine `copy'.
	{
		return ANY.clone (Current, other);
	}

	public static void copy (object Current, object other)
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.
	{
		ANY.copy (Current, other);
	}

	public static object deep_clone (object Current, object other)
		// Obsolete use `deep_twin' instead.
	{
		return ANY.deep_clone (Current, other);
	}

	public static void deep_copy (object Current, object other)
		// Effect equivalent to that of:
		//		`copy' (`other' . `deep_twin')
	{
		ANY.deep_copy (Current, other);
	}

	public static bool deep_equal (object Current, object some, object other)
		// Are `some' and `other' either both void
		// or attached to isomorphic object structures?
	{
		return ANY.deep_equal (Current, some, other);
	}

	public static object deep_twin (object Current)
		// New object structure recursively duplicated from Current.
	{
		return ANY.deep_twin (Current);
	}

	public static bool equal (object Current, object some, object other)
		// Are `some' and `other' either both void or attached
		// to objects considered equal?
	{
		return ANY.equal (Current, some, other);
	}

	public static String generator (object o)
		// Generator class name of `o'.
	{
		return ANY.generator (o);
	}

	public static String generating_type (object o)
		// Generating type name of `o'.
	{
		return ANY.generating_type (o);
	}

	public static bool is_equal (object Current, object other)
		// Is `other' attached to an object considered
		// equal to current object?
	{
		return ANY.is_equal (Current, other);
	}

	public static String @out (object o)
		// `out' of `o'
	{
		return ANY.@out (o);
	}

	public static bool same_type (object Current, object other)
		// Is type of current object identical to type of `other'?
	{
		return ANY.same_type (Current, other);
	}

	public static object standard_clone (object Current, object other)
		// Void if `other' is void; otherwise new object
		// field-by-field identical to `other'.
		// Always uses default copying semantics.
	{
		return ANY.standard_clone (Current, other);
	}

	public static void standard_copy (object Current, object other)
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.
	{
		ANY.standard_copy (Current, other);
	}

	public static bool standard_equal (object Current, object some, object other)
		// Are `some' and `other' either both void or attached to
		// field-by-field identical objects of the same type?
		// Always uses default object comparison criterion.
	{
		return ANY.standard_equal (Current, some, other);
	}

	public static bool standard_is_equal (object Current, object other)
		// Is `other' attached to an object of the same type
		// as current object, and field-by-field identical to it?
	{
		return ANY.standard_is_equal (Current, other);
	}

	public static object standard_twin (object Current)
		// New object field-by-field identical to `other'.
		// Always uses default copying semantics.
	{
		return ANY.standard_twin (Current);
	}

	public static String tagged_out (object o)
		// `out' of `o'
	{
		return ANY.tagged_out (o);
	}

	public static object twin (object Current)
		// New object equal to `Current'
		// `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
	{
		return ANY.twin (Current);
	}
/*
feature -- Status report
*/
	public static int generic_parameter_count (object o)
		// Number of generic Parameter if any.
	{
		int Result = 0;
		EIFFEL_TYPE_INFO l_object = o as EIFFEL_TYPE_INFO;
		if (l_object != null) {
			Result = l_object.____type ().count;
		}
		return Result;
	}

	public static Type type_of_generic_parameter (object an_obj, int pos)
		// Given an Eiffel object `an_obj', find the associated type of generic parameter
		// at position `pos'.
	{
		EIFFEL_TYPE_INFO l_object = an_obj as EIFFEL_TYPE_INFO;
		INTERFACE_TYPE_ATTRIBUTE generic_type;
		object[] l_attributes;
		GENERIC_TYPE l_gen_type;
		CLASS_TYPE cl_type;
		Type Result = null;

		if (l_object != null) {
			#if ASSERTIONS
				ASSERTIONS.REQUIRE ("Has  generic info", l_object.____type() != null);
				ASSERTIONS.REQUIRE ("Valid position `pos'",
					(pos > 0) && (pos <= l_object.____type().count));
			#endif

			l_gen_type = l_object.____type ();
			cl_type = (CLASS_TYPE) l_gen_type.generics [pos - 1];
			if (!cl_type.is_basic ()) {
				if (cl_type.type.Value != (System.IntPtr) 0) {
					Result = Type.GetTypeFromHandle (cl_type.type);
					l_attributes = Result.GetCustomAttributes (
						typeof (INTERFACE_TYPE_ATTRIBUTE), false);
					#if ASSERTIONS
						ASSERTIONS.CHECK ("l_attributes not null", l_attributes != null);
					#endif
					if (l_attributes.Length > 0) {
						generic_type = (INTERFACE_TYPE_ATTRIBUTE) l_attributes [0];
						Result = generic_type.class_type;
					}
				} else {
						/* Generic parameter is of type NONE, so we return an instance
						 * of NONE_TYPE as associated type. It is mostly there to fix
						 * assertions violations in TUPLE when one of the elements of
						 * a manifest tuple is `Void'. */
					#if ASSERTIONS
						ASSERTIONS.CHECK ("Is NONE type.", cl_type is NONE_TYPE);
					#endif
					Result = typeof(NONE_TYPE);
				}
			} else {
				Result = Type.GetTypeFromHandle (cl_type.type);
			}
		}
		return Result;
	}

	public static Boolean is_eiffel_string (object o)
		// Is `o' an instance of an Eiffel STRING.
	{
		GENERIC_TYPE l_gen_type;
		EIFFEL_TYPE_INFO info = o as EIFFEL_TYPE_INFO;
		Boolean Result = false;

		if (info != null) {
			l_gen_type = info.____type ();
			if (l_gen_type == null) {
					// Not a generic class, possibly a good candidate for STRING.
				Result = info.____class_name ().Equals ("STRING");
			}
		}
		return Result;
	}

	public static Boolean is_eiffel_array (object o)
		// Is `o' an instance of an Eiffel ARRAY.
	{
		GENERIC_TYPE l_gen_type;
		EIFFEL_TYPE_INFO info = o as EIFFEL_TYPE_INFO;
		Boolean Result = false;

		if (info != null) {
			l_gen_type = info.____type ();
			if (l_gen_type != null) {
					// A generic class, possibly a good candidate for ARRAY.
				Result = info.____class_name ().Equals ("ARRAY");
			}
		}
		return Result;
	}

	public static String eiffel_string (object o)
		// System.String representation of `o' if it is an Eiffel STRING instance.
	{
		String Result = null;
		Type eiffel_string_type;
		FieldInfo string_builder_info;
		StringBuilder builder;

		if (is_eiffel_string (o)) {
			eiffel_string_type = o.GetType();	
			string_builder_info = eiffel_string_type.GetField ("$$internal_string_builder");
			if (string_builder_info == null) {
				string_builder_info = eiffel_string_type.GetField ("$$internalStringBuilder");
			}
			builder = (StringBuilder) string_builder_info.GetValue (o);
			Result = "\"" + builder.ToString() + "\"";
		}

		return Result;
	}

	public static Array eiffel_array (object o)
		// System.Array representation of `o' if it is an Eiffel ARRAY instance.
	{
		Array Result = null;
		Type eiffel_array_type, eiffel_special_type;
		FieldInfo area_info, native_info;
		Object special;

		if (is_eiffel_array (o)) {
				// Get SPECIAL object
			eiffel_array_type = o.GetType();	
			area_info = eiffel_array_type.GetField ("$$area");
			if (area_info == null) {
				area_info = eiffel_array_type.GetField ("$$Area");
			}
			special = area_info.GetValue (o);

				// Get System.Array
			eiffel_special_type = special.GetType();
			native_info = eiffel_special_type.GetField ("$$native_array");
			if (native_info == null) {
				native_info = eiffel_special_type.GetField ("native_array");
				if (native_info == null) {
					native_info = eiffel_special_type.GetField ("$$nativeArray");
					if (native_info == null) {
						native_info = eiffel_special_type.GetField ("nativeArray");
					}
				}
			}
			Result = (Array) native_info.GetValue (special);
		}

		return Result;
	}

/*
feature -- Hash code
*/
	public static Int32 hash_code (Object o) 
		// Result of call of `o.GetHashCode()'.
	{
		return o.GetHashCode();
	}

/*
feature -- Type creation
*/

	public static GENERIC_TYPE eiffel_type_of (string class_type_name)
		// Given `class_type_name' representing a generic class, we create its
		// associated GENERIC_TYPE instance.
	{
		return null;
	}
	
/*
feature -- Duplication
*/

	public static object standard_clone (object obj)
		//
	{
#if ASSERTIONS
		ASSERTIONS.REQUIRE ("Valid type", obj is EIFFEL_TYPE_INFO);
#endif
		return GENERIC_CONFORMANCE.create_like_object ((EIFFEL_TYPE_INFO) obj);
	}

}
}

