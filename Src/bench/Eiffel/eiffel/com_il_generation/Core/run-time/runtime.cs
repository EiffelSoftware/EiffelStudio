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

namespace ISE.Runtime {

	public abstract class ANY {
		public object c_standard_clone () {
			return MemberwiseClone();
		}

		~ANY () {
		}
	}

	public delegate int WEL_DISPATCHER_DELEGATE (IntPtr hwnd, int msg, int wparam, int lparam);
	public delegate void WEL_ENUM_FONT_DELEGATE (IntPtr lpelf, IntPtr lpntm, int font_type, IntPtr lparam);
	public delegate void EV_PIXMAP_IMP_DELEGATE (int error_code, int data_type, int pixmap_width,
		int pixmap_height, IntPtr rgb_data, IntPtr alpha_data);

public class RUN_TIME
{
/*
feature -- Access
*/
	public static bool in_assertion;
			// Flag used during assertion checking to make sure
			// that assertions are not checked within an assertion
			// checking.

	public static string assertion_tag;
			// Tag of last checked assertion


	public static bool is_assertion_checked = true;
			// Are assertions checked?

	public static bool check_assert (bool val) {
			// Enable or disable checking of assertions?
		bool tmp = is_assertion_checked;
		is_assertion_checked = val;
		return tmp;
	}

/*
feature -- Status report
*/
	public static String generator (object o)
		// Generator class name of `o'.
	{
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
				string_builder_info = eiffel_string_type.GetField ("$$InternalStringBuilder");
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
				native_info = eiffel_special_type.GetField ("$$NativeArray");
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
feature -- Output
*/
	public static String tagged_out (Object o) 
		// Result of call of `o.ToString()'.
	{
		return o.ToString();
	}
/*
feature -- Equality
*/
	public static Boolean deep_equal (EIFFEL_TYPE_INFO o1, EIFFEL_TYPE_INFO o2) 
		// Is `o1' recursively equal to `o2'?
	{
		Hashtable traversed_objects;
		Boolean Result;

			// `traversed_objects' is a correspondance between processed
			// objects reachable from `obj' and newly created one that
			// are reachable from `target'.
		traversed_objects = new Hashtable (100);
		
			// Add `o2' and associates it with `o1' to
			// resolve future references to `o2' into `o1'.
		traversed_objects.Add (o2, o1);

			// Performs deep traversal.
		Result = internal_deep_equal (o1, o2, traversed_objects);

		return Result;
	}

/*
feature -- Duplication
*/

	public static EIFFEL_TYPE_INFO deep_clone (EIFFEL_TYPE_INFO obj)
		// New object structure recursively duplicated from
		// one attached to `other'.
	{
		Hashtable traversed_objects;
		EIFFEL_TYPE_INFO target;
		
			// `traversed_objects' is a correspondance between processed
			// objects reachable from `obj' and newly created one that
			// are reachable from `target'.
		traversed_objects = new Hashtable (100);
		
			// Create an empty copy of `obj'.
		target = GENERIC_CONFORMANCE.create_like_object(obj);

			// Add `obj' and associates it with `target' to
			// resolve future references to `obj' into `target'.
		traversed_objects.Add (obj, target);

			// Performs deep traversal.
		internal_deep_clone (target, obj, traversed_objects);

		return target;
	}

	public static void standard_copy (EIFFEL_TYPE_INFO target, EIFFEL_TYPE_INFO source)
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

