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
using ISE.Runtime.CA;
using ISE.Runtime.Enums;

namespace ISE.Runtime {

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
			if (o is EIFFEL_TYPE_INFO) {
				set_in_assertion (true);
				target = (EIFFEL_TYPE_INFO) o;

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

	public static void assertion_initialize (RuntimeTypeHandle type_handle)
		// Initializes runtime datastructure for assembly associated with
		// `type_handle'.
	{
		assertion_levels = new Hashtable (100);
		Assembly a = Type.GetTypeFromHandle (type_handle).Assembly;

		#if ASSERTIONS
			ASSERTIONS.CHECK ("There should be an assembly", a != null);
		#endif

		object [] cas = a.GetCustomAttributes (typeof (ASSERTION_LEVEL_ATTRIBUTE), false);
		if ((cas != null) && (cas.Length > 0)) {
			foreach (object ca in cas) {
				ASSERTION_LEVEL_ATTRIBUTE level_attribute = (ASSERTION_LEVEL_ATTRIBUTE) ca;
				assertion_levels.Add (
					level_attribute.class_type,			// key
					level_attribute.assertion_level);	// value
			}
		}
	}

	public static bool is_assertion_checked (Type t, ASSERTION_LEVEL_ENUM val)
		// Are assertions checked for type `t' for assertion type `val'.
		// Note that `val' is not a combination.
	{
		ASSERTION_LEVEL_ENUM type_assertion_level;
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
			if ((assertion_levels != null) && (assertion_levels.ContainsKey (t))) {
				type_assertion_level = (ASSERTION_LEVEL_ENUM) assertion_levels [t];
			} else {
				type_assertion_level = ASSERTION_LEVEL_ENUM.no;
			}
			Result = ((type_assertion_level & val) == val);
		}
		return Result;
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

/*
feature -- Status report
*/
	public static String generator (object o)
		// Generator class name of `o'.
	{
		if (o == null) return "NONE";

		String Result;

		if (o is EIFFEL_TYPE_INFO) {
				// This is a generated Eiffel type, we extract
				// stored type.
			Result = ((EIFFEL_TYPE_INFO) o).____class_name ();
		} else {
			Result = o.GetType().Name;
		}
		return Result;
	}

	public static String generating_type (object o)
		// Generating type name of `o'.
	{
		if (o == null) return "NONE";

		EIFFEL_DERIVATION der;
		EIFFEL_TYPE_INFO info;
		String Result;

		if (o is EIFFEL_TYPE_INFO) {
				// This is a generated Eiffel type.
			info = (EIFFEL_TYPE_INFO) o;
			der = info.____type ();
			if (der == null) {
					// Not a generic class, we extract stored name.
				Result = info.____class_name ();
			} else {
				Result = der.type_name ();
			}
		} else {
			Result = o.GetType().Name;
		}

		return Result;
	}

	public static int generic_parameter_count (object o)
		// Number of generic Parameter if any.
	{
		int Result = 0;
		if (o is EIFFEL_TYPE_INFO) {
			Result = ((EIFFEL_TYPE_INFO) o).____type ().nb_generics;
		}
		return Result;
	}

	public static Type type_of_generic_parameter (object an_obj, int pos)
		// Given an Eiffel object `an_obj', find the associated type of generic parameter
		// at position `pos'.
	{
		if (an_obj is EIFFEL_TYPE_INFO) {
			EIFFEL_TYPE_INFO l_obj = (EIFFEL_TYPE_INFO) an_obj;
			#if ASSERTIONS
				ASSERTIONS.REQUIRE ("Object not void", l_obj != null);
				ASSERTIONS.REQUIRE ("There should be some generic info", l_obj.____type() != null);
				ASSERTIONS.REQUIRE ("Valid position `pos'",
					(pos > 0) && (pos <= l_obj.____type().nb_generics));
			#endif

			EIFFEL_DERIVATION der;
			CLASS_TYPE cl_type;
			
			der = l_obj.____type ();
			cl_type = der.generics_type [pos - 1];
			return Type.GetTypeFromHandle (cl_type.type);
		} else {
			return null;
		}
	}

	public static Boolean is_eiffel_string (object o)
		// Is `o' an instance of an Eiffel STRING.
	{
		EIFFEL_DERIVATION der;
		EIFFEL_TYPE_INFO info;
		Boolean Result = false;

		if (o is EIFFEL_TYPE_INFO) {
			info = (EIFFEL_TYPE_INFO) o;
			der = info.____type ();
			if (der == null) {
					// Not a generic class, possibly a good candidate for STRING.
				Result = info.____class_name ().Equals ("STRING");
			}
		}
		return Result;
	}

	public static Boolean is_eiffel_array (object o)
		// Is `o' an instance of an Eiffel ARRAY.
	{
		EIFFEL_DERIVATION der;
		EIFFEL_TYPE_INFO info;
		Boolean Result = false;

		if (o is EIFFEL_TYPE_INFO) {
			info = (EIFFEL_TYPE_INFO) o;
			der = info.____type ();
			if (der == null) {
					// Not a generic class, possibly a good candidate for ARRAY.
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
feature -- Conformance
*/

	public static Boolean conforms_to (Object obj1, Object obj2)
		// Does dynamic type of object attached to `obj1' conform to
		// dynamic type of object attached to `obj2'?
		// Only called for Eiffel object.
	{
		return GENERIC_CONFORMANCE.conforms_to (obj1, obj2);
	}

/*
feature -- Equality
*/
	public static Boolean standard_equal (object target, object source) 
		// Is `target' equal to `source'?
		// Simple Object comparison attribute by attribute.
	{
		FieldInfo [] attributes;
		Boolean Result = false;
		Object l_attr;

#if ASSERTIONS
		ASSERTIONS.REQUIRE ("target_not_void", target != null);
		ASSERTIONS.REQUIRE ("source_not_void", source != null);
#endif

		if (target.GetType ().Equals (source.GetType ())) {
			attributes = source.GetType().GetFields (
				BindingFlags.Instance | BindingFlags.Public |
				BindingFlags.NonPublic);

			foreach (FieldInfo attribute in attributes) {
				l_attr = attribute.GetValue (source);
				if (l_attr is ValueType) {
					Result = Equals (l_attr, attribute.GetValue (target));
				} else {
					Result = l_attr == attribute.GetValue (target);
				}
				if (!Result) {
						// Force exit from loop as objects are not identical.
					return Result;
				}
			}
		}
		return Result;
	}


	public static Boolean deep_equal (object o1, object o2) 
		// Is `o1' recursively equal to `o2'?
	{
		Hashtable traversed_objects;
		Boolean Result;

		
		if (o1 == o2) {
			Result = true;
		} else if (o1 == null) {
			Result = o2 == null;
		} else {
				// `traversed_objects' is a correspondance between processed
				// objects reachable from `obj' and newly created one that
				// are reachable from `target'.
			traversed_objects = new Hashtable (100);
			
				// Add `o2' and associates it with `o1' to
				// resolve future references to `o2' into `o1'.
			traversed_objects.Add (o2, o1);

				// Performs deep traversal.
			Result = internal_deep_equal (o1, o2, traversed_objects);
		}

		return Result;
	}

/*
feature -- Type creation
*/

	public static EIFFEL_DERIVATION eiffel_type_of (string class_type_name)
		// Given `class_type_name' representing a generic class, we create its
		// associated EIFFEL_DERIVATION instance.
	{
		return null;
	}
	
/*
feature -- Duplication
*/

	public static object deep_clone (object obj)
		// New object structure recursively duplicated from
		// one attached to `other'.
	{
		Hashtable traversed_objects;
		EIFFEL_TYPE_INFO target, source;
		
#if ASSERTIONS
		ASSERTIONS.REQUIRE ("source_not_void", obj != null);
		ASSERTIONS.REQUIRE ("Valid type", obj is EIFFEL_TYPE_INFO);
#endif

		source = (EIFFEL_TYPE_INFO) obj;

			// `traversed_objects' is a correspondance between processed
			// objects reachable from `obj' and newly created one that
			// are reachable from `target'.
		traversed_objects = new Hashtable (100);
		
			// Create an empty copy of `source'.
		target = GENERIC_CONFORMANCE.create_like_object(source);

			// Add `source' and associates it with `target' to
			// resolve future references to `source' into `target'.
		traversed_objects.Add (target, source);

			// Performs deep traversal.
		internal_deep_clone (target, source, traversed_objects);

		return target;
	}

	public static void standard_copy (object target, object source)
		// Copy `source' onto `target'.
		// `target' and `source' are assumed to be non Void and of the same type.
	{
		FieldInfo [] attributes;

		attributes = source.GetType().GetFields (
			BindingFlags.Instance | BindingFlags.Public |
			BindingFlags.NonPublic);

		foreach (FieldInfo attribute in attributes) {
			attribute.SetValue (target, attribute.GetValue (source));
		}
	}

	public static object standard_clone (object obj)
		//
	{
		EIFFEL_TYPE_INFO source;

#if ASSERTIONS
		ASSERTIONS.REQUIRE ("Valid type", obj is EIFFEL_TYPE_INFO);
#endif

		source = (EIFFEL_TYPE_INFO) obj;
		return GENERIC_CONFORMANCE.create_like_object (source);
	}

/*
feature {NONE} -- Implementation
*/

	private static Boolean internal_deep_equal (Object target, Object source, Hashtable traversed_objects)
		// Is `source' recursively equal to `target'?
		// WARNING: It uses `return' in the middle of the loop to exit.
	{
		FieldInfo [] attributes;
		Object target_attribute, source_attribute;
		Array target_array, source_array;
		int i;
		Boolean Result = true;

		if (target.GetType ().Equals (source.GetType ())) {
			if (source is Array) {
				source_array = (Array) source;
				target_array = (Array) target;

				if 
					((source_array.Rank == 1) && 
					(source_array.Rank == target_array.Rank) &&
					(source_array.GetLowerBound (0) == target_array.GetLowerBound (0)) &&
					(source_array.GetUpperBound (0) == target_array.GetUpperBound (0)))
				{
					for
						(i = source_array.GetLowerBound (0);
						i > source_array.GetUpperBound (0);
						i++)
					{
						source_attribute = source_array.GetValue (i);
						target_attribute = target_array.GetValue (i);

						Result = sub_internal_deep_equal (
							source_attribute, target_attribute, traversed_objects);

						if (!Result) {
								// Force exit from loop as objects are not identical.
							return Result;
						}
					}
				} else {
					Result = source_array.Equals (target_array);
				}
			} else if (source is EIFFEL_TYPE_INFO) {
				attributes = source.GetType().GetFields (
					BindingFlags.Instance | BindingFlags.Public |
					BindingFlags.NonPublic);

				foreach (FieldInfo attribute in attributes) {
					source_attribute = attribute.GetValue (source);
					target_attribute = attribute.GetValue (target);

					Result = sub_internal_deep_equal (
						source_attribute, target_attribute, traversed_objects);

					if (!Result) {
							// Force exit from loop as objects are not identical.
						return Result;
					}
				}
			} else {
				Result = source.Equals (target);
			}
		} else {
			Result = false;
		}
		return Result;
	}

	private static Boolean sub_internal_deep_equal (
		Object source_attribute,
		Object target_attribute,
		Hashtable traversed_objects
	)
		// Compare `source_attribute' and `target_attribute' and 
		// performs or not a recursion to compare them recursively.
		// True if they match recursively, False otherwise.
	{
		Boolean Result;

		if (source_attribute == null) {
			Result = target_attribute == null;
		} else {
			if (target_attribute == null) {
				Result = false;
			} else {
				if (traversed_objects.Contains (source_attribute)) {
					if (source_attribute.GetType().IsValueType) {
						Result = 
							target_attribute.Equals (source_attribute);
					} else {
						Result =
							target_attribute == traversed_objects [source_attribute];
					}
				} else {
					traversed_objects.Add (source_attribute, target_attribute);
					Result = internal_deep_equal (target_attribute,
						source_attribute, traversed_objects);
				}
			}
		}

		return Result;
	}

	private static void internal_deep_clone (Object target, Object source, Hashtable traversed_objects)
		// Given a target and a source, copy content of source into
	{
		FieldInfo [] attributes;
		Object obj;
		Array target_array, source_array;
		int i;

		attributes = source.GetType().GetFields (
			BindingFlags.Instance | BindingFlags.Public |
			BindingFlags.NonPublic);

		foreach (FieldInfo attribute in attributes) {
			obj = attribute.GetValue (source);
			if (obj != null) {
				if (obj is EIFFEL_TYPE_INFO) {
						// Object is an Eiffel object we can continue our recursion.
					sub_internal_deep_clone (target, attribute, (EIFFEL_TYPE_INFO) obj,
						traversed_objects);
				} else {
					if (obj is StringBuilder) {
						attribute.SetValue (target, new StringBuilder (obj.ToString()));
					} else if (obj is Array) {
						source_array = (Array) obj;
						if (source_array.Rank == 1) {
							target_array = (Array) source_array.Clone();
							Array.Clear(target_array, target_array.GetLowerBound (0),
								target_array.GetUpperBound (0));
							attribute.SetValue (target, target_array);
							i = target_array.GetLowerBound (0);
							foreach (Object o in source_array) {
								if (o != null) {
									if (o is EIFFEL_TYPE_INFO) {
										sub_internal_native_array_deep_clone ( target_array,
											i, (EIFFEL_TYPE_INFO) o, traversed_objects);
									} else {
										target_array.SetValue (o, i);
									}
								}
								i = i + 1;
							}
						}
					} else {
						attribute.SetValue (target, obj);
					}
				}
			}
		}
	}

	private static void sub_internal_deep_clone (
		Object target,
		FieldInfo attribute,
		EIFFEL_TYPE_INFO source_attribute,
		Hashtable traversed_objects
	)
		// Helper feature that given a `target' object and its associated `attribute'
		// perform a deep copy of `source_attribute' and assign it back to `target'.
		// Assume arguments are not Void.
	{
		EIFFEL_TYPE_INFO target_attribute;

		if (traversed_objects.Contains (source_attribute)) {
				// We already processed `obj', we simply assign current
				// attribute to computed value.
			attribute.SetValue (target, traversed_objects [source_attribute]);
		} else {
				// Ojbect was not yet duplicated.
			target_attribute = GENERIC_CONFORMANCE.create_like_object (source_attribute);
			traversed_objects.Add (source_attribute, target_attribute);
			internal_deep_clone (target_attribute, source_attribute, traversed_objects);
			attribute.SetValue (target, target_attribute);
		}
	}

	private static void sub_internal_native_array_deep_clone (
		Array target_array,
		int i,
		EIFFEL_TYPE_INFO source_attribute,
		Hashtable traversed_objects
	)
		// Helper feature that given a `target' object and its associated `attribute'
		// perform a deep copy of `source_attribute' and assign it back to `target'.
		// Assume arguments are not Void.
	{
		EIFFEL_TYPE_INFO target_attribute;

		if (traversed_objects.Contains (source_attribute)) {
				// We already processed `obj', we simply assign current
				// attribute to computed value.
			target_array.SetValue (traversed_objects [source_attribute], i);
		} else {
				// Ojbect was not yet duplicated.
			target_attribute = GENERIC_CONFORMANCE.create_like_object (source_attribute);
			traversed_objects.Add (source_attribute, target_attribute);
			internal_deep_clone (target_attribute, source_attribute, traversed_objects);
			target_array.SetValue (target_attribute, i);
		}
	}

}
}

