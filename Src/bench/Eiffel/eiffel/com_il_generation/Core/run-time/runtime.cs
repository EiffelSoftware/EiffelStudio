/*
indexing
	description: "Set of features needed by the Eiffel compiler and Eiffel libraries
		to work properly"
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
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
			String Result;

			if (o is EIFFEL_TYPE_INFO) {
					// This is a generated Eiffel type.
				EIFFEL_TYPE_INFO info = (EIFFEL_TYPE_INFO) o;
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
	}

	public class EXCEPTION_MANAGER
	{
		public EXCEPTION_MANAGER()
		{
		}

		public static Exception last_exception;
				// Last raised exception in `rescue' clause.

		public static void raise (Exception e) {
			throw e;
		}

	}
}

