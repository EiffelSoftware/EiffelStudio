/*
indexing
	description: "Set of features from ANY applied to non-Eiffel object. Needed to enable generic container of .NET types."
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

*/
	
using System;
using System.Collections;
using System.Text;
using System.Reflection;
using EiffelSoftware.Runtime.CA;
using EiffelSoftware.Runtime.Types;

namespace EiffelSoftware.Runtime {

[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
[CLSCompliant(false)]
public class ANY {

/*
feature -- Access
*/

	public static string generator (object Current)
		// Name of Current object's generating class
		// (base class of the type of which it is a direct instance)
	{
		string Result = null;
		EIFFEL_TYPE_INFO l_current = Current as EIFFEL_TYPE_INFO;

		if (Current == null) {
			generate_call_on_void_target_exception();
		} else if (l_current != null) {
				// This is a generated Eiffel type, we extract
				// stored type.
			Result = l_current.____class_name ();
		} else {
			Result = Current.GetType().Name;
		}
		return Result;
	}

	public static string generating_type (object Current) 
		// Name of Current object's generating type
		// (type of which it is a direct instance)
	{
		string Result = null;
		RT_GENERIC_TYPE l_gen_type;
		EIFFEL_TYPE_INFO l_current = Current as EIFFEL_TYPE_INFO;

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else if (l_current != null) {
			l_gen_type = l_current.____type ();
			if (l_gen_type == null) {
					// Not a generic class, we extract stored name.
				Result = l_current.____class_name ();
			} else {
				Result = l_gen_type.type_name ();
			}
		} else {
 			Result = Current.GetType().FullName;
		}
		return Result;
	}

/*
feature -- Status report
*/

	public static bool conforms_to (object Current, object other)
		// Does type of current object conform to type
		// of `other' (as per Eiffel: The Language, chapter 13)?
	{
		bool Result = false;
		RT_GENERIC_TYPE l_current_type, l_other_type;
		EIFFEL_TYPE_INFO current_info = Current as EIFFEL_TYPE_INFO;
		EIFFEL_TYPE_INFO other_info = other as EIFFEL_TYPE_INFO;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
		#endif
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (other_info == null) {
					// `other' is not an Eiffel object, we simply check for .NET conformance
				Result = other.GetType ().IsAssignableFrom (Current.GetType ());
			} else if (current_info == null) {
					// `other' is an Eiffel object, but not `Current', therefore there is
					// no conformance. We do nothing since `Result' is already initialized to
					// false.
			} else {
				l_current_type = current_info.____type ();
				l_other_type = other_info.____type ();
				if (l_other_type == null) {
						// Parent type represented by the `other' instance
						// is not generic, therefore `Current' should directly
						// conform to the parent type.
					Result = ISE_RUNTIME.interface_type (other_info.GetType()).IsAssignableFrom (Current.GetType ());
				} else if (l_current_type == null) {
						// Parent is generic, but not type represented by
						// `Current', so let's first check if it simply
						// conforms without looking at the generic parameter.
					Result = ISE_RUNTIME.interface_type (other_info.GetType()).IsAssignableFrom (Current.GetType ());
					if (Result) {
							// It does conform, so now we have to go through
							// the parents to make sure it has the same generic
							// derivation.
							// FIXME: we should use feature `conform_to' from RT_TYPE here.
					}
				} else {
						// Both types are generic. We first check if they
						// simply conforms.
					#if ASSERTIONS
						ASSERTIONS.CHECK ("l_current_type_not_void", l_current_type != null);
						ASSERTIONS.CHECK ("l_other_type_not_void", l_other_type != null);
					#endif
					Result = ISE_RUNTIME.interface_type (other_info.GetType()).IsAssignableFrom (Current.GetType ());
					if (Result) {
						Result = l_current_type.conform_to (l_other_type);
					}
				}
			}
		}
		return Result;
	}

	public static bool same_type (object Current, object other)
		// Is type of current object identical to type of `other'?
	{
		bool Result = false;
		RT_GENERIC_TYPE l_current_type, l_other_type;
		EIFFEL_TYPE_INFO l_current;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
		#endif
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			Result = Current.GetType ().Equals (other.GetType ());
			if (Result) {
				l_current = Current as EIFFEL_TYPE_INFO;
				if (l_current != null) {
						// We perform generic conformance in case it is needed.
					l_current_type = l_current.____type();
					if (l_current_type != null) {
							// Because we already know that `Current' and `other' have
							// the same type, therefore cast to EIFFEL_TYPE_INFO is
							// going to succeed.
						l_other_type =  ((EIFFEL_TYPE_INFO) other).____type();
						#if ASSERTIONS
							ASSERTIONS.CHECK ("has_derivation", l_other_type != null);
							ASSERTIONS.CHECK ("Same base type", l_current_type.type.Equals (l_other_type.type));
						#endif
						Result = l_current_type.Equals (l_other_type);
					}
				} else {
						// It is not generic, then they definitely have the same type.
						// No need to assign Result again, as it is already holding the true value.
				}
			}
		}
#if ASSERTIONS
		ASSERTIONS.ENSURE ("definition", Result == (conforms_to (Current, other) &&
				conforms_to (other, Current)));
#endif
		return Result;
	}

/*
feature -- Comparison
*/

	public static bool is_equal (object Current, object other)
		// Is `other' attached to an object considered
		// equal to current object?
	{
		bool Result = false;
		EIFFEL_TYPE_INFO l_current = Current as EIFFEL_TYPE_INFO;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
		#endif

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else if (l_current != null) {
			Result = l_current.____is_equal (other);
		} else {
			Result = Current.Equals (other);
		}
		return Result;
	}

	public static bool standard_is_equal (object Current, object other)
		// Is `other' attached to an object of the same type
		// as current object, and field-by-field identical to it?
	{
		bool Result = false;
		FieldInfo [] l_attributes;
		object l_attr;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
		#endif
	
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
				// Optimization: if objects are the same, then they are equal.
			Result = (Current == other);
			if (!Result) {
				if (same_type (Current, other)) {
					l_attributes = other.GetType().GetFields (
						BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);

					foreach (FieldInfo attribute in l_attributes) {
						l_attr = attribute.GetValue (other);
						if (l_attr is ValueType) {
							Result = Equals (l_attr, attribute.GetValue (Current));
						} else {
							Result = (l_attr == attribute.GetValue (Current));
							if (!Result) {
									/* Special case here where we check whether or not `l_attr' corresponds
									* to the special runtime field `$$____type' used to store the generic type
									* information. If it is the case, we simply ignore it. To identify
									* it we use the name of the attribute as well as its type which needs
									* to be of type RT_GENERIC_TYPE. */
								Result = (attribute.Name.Equals ("$$____type") &&
									typeof(RT_GENERIC_TYPE).Equals (attribute.FieldType));
							}
						}
						if (!Result) {
								// Force exit from loop as objects are not identical.
							return Result;
						}
					}
				}
			}
		}
		return Result;
	}

	public static bool equal (object Current, object some, object other)
		// Are `some' and `other' either both void or attached
		// to objects considered equal?
	{
		bool Result = false;
	
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (some == null) {
				Result = (other == null);
			} else {
				Result = (other != null) && is_equal (some, other);
			}
		}
		return Result;
	}

	public static bool standard_equal (object Current, object some, object other)
		// Are `some' and `other' either both void or attached to
		// field-by-field identical objects of the same type?
		// Always uses default object comparison criterion.
	{
		bool Result = false;
	
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (some == null) {
				Result = (other == null);
			} else {
				Result = (other != null) && standard_is_equal (some, other);
			}
		}
		return Result;
	}

	public static bool deep_equal (object Current, object some, object other)
		// Are `some' and `other' either both void
		// or attached to isomorphic object structures?
	{
		bool Result = false;
		Hashtable traversed_objects;
	
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else if (some == null) {
			Result = (other == null);
		} else {
			Result = (other != null);
			if (Result) {
					// Optimization: if objects are the same, then they are equal.
				Result = other == some;
				if (!Result) {
						// `traversed_objects' is a correspondance between processed
						// objects reachable from `obj' and newly created one that
						// are reachable from `target'.
					traversed_objects = new Hashtable (100, null, new RT_REFERENCE_COMPARER ());

						// Add `other' and associates it with `some' to
						// resolve future references to `other' into `some'.
					traversed_objects.Add (other, some);

						// Performs deep traversal.
					Result = internal_deep_equal (some, other, traversed_objects);
				}
			}
		}
		return Result;
	}

/*
feature -- Duplication
*/
	public static object twin (object Current)
		// New object equal to `Current'
		// `twin' calls `copy'; to change copying/twining semantics, redefine `copy'.
	{
		object Result = null;
		bool l_check_assert;

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			l_check_assert = ISE_RUNTIME.check_assert (false);
			Result = GENERIC_CONFORMANCE.create_like_object (Current);
			copy (Result, Current);
			l_check_assert = ISE_RUNTIME.check_assert (l_check_assert);
		}
		return Result;
	}
	
	public static void copy (object Current, object other)
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.
	{
		EIFFEL_TYPE_INFO l_current = Current as EIFFEL_TYPE_INFO;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
			ASSERTIONS.REQUIRE ("same_type", same_type (Current, other));
		#endif

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (l_current != null) {
				l_current.____copy (other);
			} else {
				internal_standard_copy (Current, other);
			}
		}
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("is_equal", is_equal (Current, other));
		#endif
	}

	public static void standard_copy (object Current, object other)
		// Update current object using fields of object attached
		// to `other', so as to yield equal objects.
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
			ASSERTIONS.REQUIRE ("same_type", same_type (Current, other));
		#endif
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			internal_standard_copy (Current, other);
		}
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("is_equal", standard_is_equal (Current, other));
		#endif
	}

	public static object clone (object Current, object other)
		// Void if `other' is void; otherwise new object
		// equal to `other'
		//
		// For non-void `other', `clone' calls `copy';
		// to change copying/cloning semantics, redefine `copy'.
	{
		object Result = null;
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (other != null) {
				Result = twin (other);
			}
		}
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("equal", equal (Current, Result, other));
		#endif

		return Result;
	}

	public static object standard_clone (object Current, object other)
		// Void if `other' is void; otherwise new object
		// field-by-field identical to `other'.
		// Always uses default copying semantics.
	{
		object Result = null;
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (other != null) {
				Result = standard_twin (other);
			}
		}
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("standard_equal", standard_equal (Current, Result, other));
		#endif

		return Result;
	}

	public static object standard_twin (object Current)
		// New object field-by-field identical to `other'.
		// Always uses default copying semantics.
	{
		object Result = null;
		bool l_check_assert;
		EIFFEL_TYPE_INFO l_current = Current as EIFFEL_TYPE_INFO;

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			if (l_current != null) {
					// For Eiffel object we can use our efficient implementation
					// which is using `MemberwiseClone'.
				Result = l_current.____standard_twin ();
			} else {
					// For .NET object, we have to do it the slow way, allocate
					// a new object, and then copy field by field.
				l_check_assert = ISE_RUNTIME.check_assert (false);
				Result = GENERIC_CONFORMANCE.create_like_object (Current);
				internal_standard_copy (Result, Current);
				l_check_assert = ISE_RUNTIME.check_assert (l_check_assert);
			}
		}

		#if ASSERTIONS
			ASSERTIONS.ENSURE ("standard_twin_not_void", Result != null);
			ASSERTIONS.ENSURE ("standard_equal", standard_equal (Current, Result, Current));
		#endif

		return Result;
	}
		
	public static object deep_twin (object Current)
		// New object structure recursively duplicated from Current.
	{
		object Result = null;
		Hashtable traversed_objects;

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
				// `traversed_objects' is a correspondance between processed
				// objects reachable from `obj' and newly created one that
				// are reachable from `Result'.
			traversed_objects = new Hashtable (100);
			
				// Create an empty copy of `Current'.
			Result = GENERIC_CONFORMANCE.create_like_object(Current);

				// Add `Current' and associates it with `Result' to
				// resolve future references to `Current' into `Result'.
			traversed_objects.Add (Current, Result);

				// Performs deep traversal.
			internal_deep_twin (Result, Current, traversed_objects);
		}

		#if ASSERTIONS
			ASSERTIONS.ENSURE ("deep_equal", deep_equal (Current, Result, Current));
		#endif

		return Result;
	}

	public static object deep_clone (object Current, object other)
		// Void if `other' is void: otherwise, new object structure
		// recursively duplicated from the one attached to `other'
	{
		object Result = null;
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else if (other != null) {
			Result = deep_twin (other);
		}

		#if ASSERTIONS
			ASSERTIONS.ENSURE ("deep_equal", deep_equal (Current, other, Result));
		#endif

		return Result;
	}

	public static void deep_copy (object Current, object other)
		// Effect equivalent to that of:
		//		`copy' (`other' . `deep_twin')
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("other_not_void", other != null);
		#endif

		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			copy (Current, deep_twin (other));
		}

		#if ASSERTIONS
			ASSERTIONS.ENSURE ("deep_equal", deep_equal (Current, Current, other));
		#endif
	}
/*
feature -- Output
*/

	public static string @out (object Current)
		// New string containing terse printable representation
		// of current object
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("Not an Eiffel object", !(Current is EIFFEL_TYPE_INFO));
		#endif
		return tagged_out(Current);
	}

	public static string tagged_out (object Current)
		// New string containing terse printable representation
		// of current object
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("Not an Eiffel object", !(Current is EIFFEL_TYPE_INFO));
		#endif
		string Result = null;
		if (Current == null) {
			generate_call_on_void_target_exception ();
		} else {
			Result = Current.ToString ();
		}
		return Result;
	}

/*
feature {NONE} -- Implementation
*/
	private static void generate_call_on_void_target_exception ()
		// Throw System.NullReferenceException to simulate a call on void target exception
		// when first argument of static routine of ANY is Void.
	{
		throw new System.NullReferenceException ();
	}

/*
feature {NONE} -- Implementation: standard_copy
*/
	private static void internal_standard_copy (object target, object source)
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
feature {NONE} -- Implementation: Deep equality
*/

	private static bool internal_deep_equal (
		object target,
		object source,
		Hashtable traversed_objects
	)
		// Is `source' recursively equal to `target'?
		// WARNING: It uses `return' in the middle of the loop to exit.
	{
		FieldInfo [] attributes;
		object target_attribute, source_attribute;
		Array target_array, source_array;
		int i;
		bool Result = true;

		if (same_type (target, source)) {
			if (source is Array) {
				source_array = (Array) source;
				target_array = (Array) target;

				if 
					((source_array.Rank == 1) && 
					(source_array.Rank == target_array.Rank) && 
					(source_array.Length == target_array.Length) &&
					(source_array.GetLowerBound (0) == target_array.GetLowerBound (0)) &&
					(source_array.GetUpperBound (0) == target_array.GetUpperBound (0)))
				{
					if (source_array.Length == 0) {
							// Nothing to compare so they are equal.
						Result = true;
					} else {
						Type attribute_type = source_array.GetType ().GetElementType ();
						for
							(i = source_array.GetLowerBound (0);
							i <= source_array.GetUpperBound (0);
							i++)
						{
							source_attribute = source_array.GetValue (i);
							target_attribute = target_array.GetValue (i);

							Result = sub_internal_deep_equal (attribute_type,
								source_attribute, target_attribute, traversed_objects);

							if (!Result) {
									// Force exit from loop as objects are not identical.
								return Result;
							}
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

						// Do not compare the ____type field which is of type RT_TYPE.
						// The reason is that it may fail on instances of `RT_GEN_TYPE'
						// where `has_formal_flag' is different because it has not yet been
						// evaluated (for example objects created via INTERNAL).
						// FIXME: we should store a `type_id' instead in the object for which
						// comparison will always make sense.
					if (!(source_attribute is RT_TYPE)) {
						Result = sub_internal_deep_equal (attribute.FieldType,
							source_attribute, target_attribute, traversed_objects);

						if (!Result) {
								// Force exit from loop as objects are not identical.
							return Result;
						}
					}
				}
			} else {
					// Bug in `System.Text.StringBuilder' with `Equals' which is
					// not redefined properly.
					// FIXME: Manu 12/22/2003: Maybe we should perform a recursion
					// on .NET object too, not just on Eiffel objects.
				if (source is StringBuilder) {
					Result = ((StringBuilder) source).Equals ((StringBuilder) target);
				} else {
					Result = source.Equals (target);
				}
			}
		} else {
			Result = false;
		}
		return Result;
	}

	private static bool sub_internal_deep_equal (
		Type attribute_type,
		object source_attribute,
		object target_attribute,
		Hashtable traversed_objects
	)
		// Compare `source_attribute' and `target_attribute' and 
		// performs or not a recursion to compare them recursively.
		// True if they match recursively, False otherwise.
	{
		bool Result;

		if (source_attribute == null) {
			Result = target_attribute == null;
		} else if (target_attribute == null) {
			Result = false;
		} else if (attribute_type.IsValueType) {
				// Continue deep equality test for Eiffel types
			if (source_attribute is EIFFEL_TYPE_INFO) {
				Result = internal_deep_equal (source_attribute, target_attribute, traversed_objects);
			} else {
				Result = target_attribute.Equals (source_attribute);
			}
		} else if (traversed_objects.Contains (source_attribute)) {
			Result = target_attribute == traversed_objects [source_attribute];
		} else {
			traversed_objects.Add (source_attribute, target_attribute);
			Result = internal_deep_equal (target_attribute, source_attribute, traversed_objects);
		}

		return Result;
	}

/*
feature {NONE} -- Implementation: deep cloning
*/

	private static void internal_deep_twin (Object target, Object source, Hashtable traversed_objects)
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
					sub_internal_deep_twin (target, attribute, (EIFFEL_TYPE_INFO) obj,
						traversed_objects);
				} else {
					if (obj is StringBuilder) {
						attribute.SetValue (target, new StringBuilder (obj.ToString()));
					} else if (obj is Array) {
						source_array = (Array) obj;
						if (source_array.Rank == 1) {
							target_array = (Array) source_array.Clone();
							if (source_array.Length > 0) {
								Array.Clear(target_array, target_array.GetLowerBound (0),
									target_array.GetUpperBound (0));
							}
							attribute.SetValue (target, target_array);
							i = target_array.GetLowerBound (0);
							foreach (Object o in source_array) {
								if (o != null) {
									if (o is EIFFEL_TYPE_INFO) {
										sub_internal_native_array_deep_twin ( target_array,
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

	private static void sub_internal_deep_twin (
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
			internal_deep_twin (target_attribute, source_attribute, traversed_objects);
			attribute.SetValue (target, target_attribute);
		}
	}

	private static void sub_internal_native_array_deep_twin (
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
			internal_deep_twin (target_attribute, source_attribute, traversed_objects);
			target_array.SetValue (target_attribute, i);
		}
	}


}

}

