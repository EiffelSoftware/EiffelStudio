using System;
namespace ISE.Runtime {

	public abstract class ANY {
		public object c_standard_clone () {
			return MemberwiseClone();
		}

		~ANY () {
		}
	}

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

		public static int generic_parameter_count (object o) {
				// Number of generic Parameter if any.
			_IGeneric gen;		
			if (o is _IGeneric) {
				gen = (_IGeneric) o;
				return gen.____count();
			} else {
				return 0;
			}
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

	[CLSCompliantAttribute (false)]
	public interface _IGeneric {
		int ____count();
	}

	public class EIFFEL_TYPES {
		public static EIFFEL_TYPE_INFO [] eiffel_types;
			// List all computed Eiffel types.
	}

	public class EIFFEL_TYPE_INFO {
	}
}

