/*
indexing
	description: "Set of features needed by the Eiffel compiler and Eiffel libraries
		to work properly"
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
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
				Result = (info.____class_name ().IndexOf ("ARRAY") == 1);
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
	
}
}

