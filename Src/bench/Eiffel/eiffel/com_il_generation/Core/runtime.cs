namespace ISE.Runtime
{
    using System;

    public class RUN_TIME
    {
        public RUN_TIME()
		{
		}

		public static bool in_assertion;
				// Flag used during assertion checking to make sure
				// that assertions are not checked within an assertion
				// checking.

		public static string assertion_tag;
				// Tag of last checked assertion


		public static bool is_assertion_checked = true;

		public static bool check_assert (bool val) {
			bool tmp = is_assertion_checked;
			is_assertion_checked = val;
			return tmp;
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
