/*
indexing
	description: "Set of features needed by the Eiffel compiler and Eiffel libraries
		to work properly"
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
using EiffelSoftware.Runtime.Enums;
using EiffelSoftware.Runtime.Types;

namespace EiffelSoftware.Runtime {

public delegate int WEL_DISPATCHER_DELEGATE (IntPtr hwnd, int msg, IntPtr wparam, IntPtr lparam);
public delegate void WEL_ENUM_FONT_DELEGATE (IntPtr lpelf, IntPtr lpntm, int font_type, IntPtr lparam);
public delegate void WEL_ENUM_WINDOW_DELEGATE (IntPtr hwnd);
public delegate void EV_PIXMAP_IMP_DELEGATE (int error_code, int data_type, int pixmap_width,
	int pixmap_height, IntPtr rgb_data, IntPtr alpha_data);
public delegate int WEL_RICH_EDIT_STREAM_IN_DELEGATE (IntPtr a_buffer, int a_buffer_length, IntPtr a_data_length);
public delegate int WEL_RICH_EDIT_STREAM_OUT_DELEGATE (IntPtr a_buffer, int length);
public delegate void WEL_DISK_SPACE_DELEGATE (int free_space, int total_space, int free_space_in_bytes, int total_space_in_bytes);
public delegate void EIFFEL_PROCEDURE_DELEGATE (object args);
public delegate object EIFFEL_FUNCTION_DELEGATE (object args);
public delegate void EIFFEL_EVENT_HANDLER (object sender, EIFFEL_EVENT_ARGS a);

// Generic event arguments
public class EIFFEL_EVENT_ARGS : EventArgs
{
	public EIFFEL_EVENT_ARGS(string s)
	{
		msg = s;
	}
	private string msg;
	public string Message
	{
		get { return msg; }
	}
}


[Serializable]
public sealed class ISE_RUNTIME
{

/*
feature {NONE} -- Initialization
*/

	static ISE_RUNTIME()
		// Type initializer
	{
		marked_objects = new Hashtable (500, new RT_REFERENCE_COMPARER());
		marking_mutex = new System.Threading.Mutex();
	}

/*
feature -- Assertions
*/
	
	public static bool in_assertion ()
		// Is checking of assertions needed?
	{
		return (internal_is_assertion_skipped || internal_in_assertion);
	}


	public static void set_in_assertion (bool val)
		// Set `internal_in_assertion' with `val'.
	{
		internal_in_assertion = val;
	}

	public static bool in_precondition()
		// Is checking precondition?
	{
		return internal_in_precondition;
	}

	public static void set_in_precondition(bool val)
	   // set `in_precondition' with `val'
	{
		internal_in_precondition = val;
	}

	public static bool invariant_entry ()
		// Is entry invariant checking?
	{
		return internal_invariant_entry;
	}

	public static bool check_assert (bool val)
		// Enable or disable checking of assertions?
	{
		bool tmp = !internal_is_assertion_skipped;
		internal_is_assertion_skipped = !val;
		return tmp;
	}

	[System.Diagnostics.DebuggerHiddenAttribute]
  	[System.Diagnostics.DebuggerStepThroughAttribute]
	public static void check_invariant (object o, bool entry)
		// Given object `o' if it has some invariant to be checked, make
		// sure that they are checked and recursively goes to inherited
		// invariants and check them too.
	{
		EIFFEL_TYPE_INFO target;
		bool o_entry;

		o_entry = internal_invariant_entry;
		internal_invariant_entry = entry;
		if (
			(!in_assertion()) &&
			(o != null && is_assertion_checked(o.GetType(), ASSERTION_LEVEL_ENUM.invariant, false))
		)
		{
			target = o as EIFFEL_TYPE_INFO;
			if (target != null)
			{
				set_in_assertion(true);

				invariant_checked_table = new Hashtable(10);

				// Check current invariant defined in `target'.
				target._invariant();

				set_in_assertion(false);
			}
		}
		internal_invariant_entry = o_entry;
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

	[ThreadStatic]
	public static string assertion_tag;
		// Tag of last checked assertion

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

		try {
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
		} catch {
			global_assertion_level = ASSERTION_LEVEL_ENUM.no;
			is_global_assertion_level_set = true;
		}
	}

	public static bool is_assertion_checked (Type t, ASSERTION_LEVEL_ENUM val, bool saved_caller_supplier_precondition)
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
			if (val == ASSERTION_LEVEL_ENUM.require && saved_caller_supplier_precondition) {
				Result = true;
			} else {
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
		}
		return Result;
	}

	public static bool save_supplier_precondition (Type t)
		// Are supplier preconditions checked for type `t'.
	{
		ASSERTION_LEVEL_ENUM type_assertion_level;
		object obj;
		bool Result = caller_supplier_precondition;

			// Let's extract the specified assertion level for type `t'.
			// If `is_global_assertion_level_set' is set, then we can return
			// the global one.
		if (is_global_assertion_level_set) {
			caller_supplier_precondition = 
				(global_assertion_level & ASSERTION_LEVEL_ENUM.supplier_precond ) == ASSERTION_LEVEL_ENUM.supplier_precond;
			return Result;
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
		caller_supplier_precondition = 
			((type_assertion_level & ASSERTION_LEVEL_ENUM.supplier_precond ) == ASSERTION_LEVEL_ENUM.supplier_precond);
		return Result;
	}

	public static void restore_supplier_precondition (bool val)
	{
		caller_supplier_precondition = val;
	}

/*
feature -- Exceptions
*/

	public static Exception last_exception
	  // Last raised exception in `rescue' clause.
	{
		get
		{
			return _last_exception;
		}
		set
		{
			_last_exception = exception_manager.compute_last_exception(value);
		}
	}

	public static void restore_last_exception(Exception ex)
		// Restore value of `last_exception'.
	{
		_last_exception = ex;
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static void enter_rescue()
		// Enter a rescue clause, we increase the rescue level
	{
		_rescue_level++;
	}

	public static bool exception_from_rescue ()
		// Exception was raised in rescue clause?
	{
		return (rescue_level > 1);
	}

	[ThreadStatic]
	private static Exception _last_exception;
		// Store exception object per thread.

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static RT_EXCEPTION_MANAGER exception_manager
		// Exception manager
		// The exception manager instance might not exist, when the entry point is not executed.
		// The normal situation is assemblies generated by ISE compiler are used by other systems.
		// In this case, we try to locate the associated type among all loaded assemblies and initialize such.
	{
		get
		{
			if (_exception_manager != null)
			{
				return _exception_manager;
			}
			else
			{
				_exception_manager = create_exception_manager();
				return _exception_manager;
			}
		}
		set
		{
			_exception_manager = value;
		}
	}

	private static RT_EXCEPTION_MANAGER _exception_manager;
		// Hold the object for `exception_manager' attribute.

	private static RT_EXCEPTION_MANAGER create_exception_manager()
		// Looks for type ISE_EXCEPTION_MANAGER in all loaded assemblies,
		// and create the instance of it.
	{
		Assembly [] l_assemblies = AppDomain.CurrentDomain.GetAssemblies();
		Type l_t = null;

		foreach (Assembly l_ass in l_assemblies)
		{
			l_t = l_ass.GetType("EiffelSoftware.Library.Base.Kernel.Dotnet.Impl.IseExceptionManager");
			if (l_t == null)
			{
				l_t = l_ass.GetType("EiffelSoftware.Library.Base.kernel.dotnet.Impl.ISE_EXCEPTION_MANAGER");
			}
			if (l_t != null)
			{
				break;
			}
		}
		object l_o = Activator.CreateInstance(l_t);
		return l_o as RT_EXCEPTION_MANAGER;
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	private static Type getTypeOfAssertionViolation ()
	{
		Assembly [] l_assemblies = AppDomain.CurrentDomain.GetAssemblies();
		Type l_t = null;

		foreach (Assembly l_ass in l_assemblies)
		{
			l_t = l_ass.GetType("EiffelSoftware.Library.Base.kernel.exceptions.AssertionViolation");
			if (l_t == null)
			{
				l_t = l_ass.GetType("EiffelSoftware.Library.Base.kernel.exceptions.ASSERTION_VIOLATION");
			}
			if (l_t != null)
			{
				break;
			}
		}
		return l_t;
	}
	
	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static bool is_ignore_contract_violation_once;
			//Should next/current contract violation be ignored?

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static void set_ignore_contract_violation_once (bool a_bool)
			//Set `is_ignore_contract_violation_once' with `a_bool'
	{
		is_ignore_contract_violation_once = a_bool;
	}

	public static void raise (Exception e)
		// Throw an exception `e'.
	{
		try{
			throw e;
		}catch (Exception a_e)
		{
			if (!is_ignore_contract_violation_once)
			{
				throw;
			}else
			{	
				//reset flag first
				is_ignore_contract_violation_once = false;

				Type l_t = getTypeOfAssertionViolation();
				if (a_e.GetType().IsSubclassOf(l_t))
				{
					// Do nothing, just ignore it
				}
				else
				{
					throw;
				}
			}
		}
	}

	public static void generate_call_on_void_target_exception ()
		// Throw VOID_TARGET
		// when first argument of static routine of ANY is Void.
	{
		raise_code(exception_manager.Void_call_target(), "");
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	internal static void raise_precondition(string msg)
		// Throw PRECONDITION_VIOLATION
		// when first argument of static routine of ANY is Void.
	{
		raise_code(exception_manager.Precondition(), msg);
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	internal static void raise_postcondition(string msg)
		// Throw POSTCONDITION_VIOLATION
		// when first argument of static routine of ANY is Void.
	{
		raise_code(exception_manager.Postcondition(), msg);
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE (false)]
	internal static void raise_check(string msg)
		// Throw CHECK_VIOLATION
		// when first argument of static routine of ANY is Void.
	{
		raise_code(exception_manager.Check_instruction(), msg);
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static void raise_code(int e_code, string msg)
		// Raise Eiffel code exception of code `e_code'.
	{
		exception_manager.internal_raise(e_code, msg);
	}

	public static void raise_old(Exception ex)
		// Raise Eiffel code exception of code `e_code'.
	{
		exception_manager.internal_raise_old(ex);
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static void rethrow (bool for_once)
		//Throw unhandled exception at the end of rescue clause.
	{
		exception_manager.throw_last_exception(_last_exception, for_once);
	}

	[EIFFEL_CONSUMABLE_ATTRIBUTE(false)]
	public static int rescue_level
		// Record number of levels in rescue clause.
	{
		get
		{
			return _rescue_level;
		}
		set
		{
			_rescue_level = value;
		}
	}

	[ThreadStatic]
	private static int _rescue_level;
		// Record number of levels in rescue clause.

/*
feature {NONE} -- RT Extension
*/

	[ThreadStatic]
	public static RT_EXTENSION_I rt_extension_object;
		// RT_EXTENSION object
	
/*
feature {NONE} -- Implementation
*/
	private static Hashtable assertion_levels;
		// HASH_TABLE [ASSERTION_LEVEL_ENUM, Type] to store for each Eiffe type
		// its associated assertion level.

/*
feature {NONE} -- Implementations: Assertions
*/

	[ThreadStatic]
	private static Hashtable invariant_checked_table;
		// Equivalent of an HASH_TABLE [Boolean, RuntimeTypeHandle]
		// For each type we have processed, key is True.

	[ThreadStatic]
	private static bool internal_is_assertion_skipped = false;
		// Are assertions skipped?

	[ThreadStatic]
	private static bool internal_in_assertion = false;
		// Flag used during assertion checking to make sure
		// that assertions are not checked within an assertion
		// checking.

	[ThreadStatic]
	private static bool internal_invariant_entry = false;
		// Flag if invariant checking is the entry of a routine.

	[ThreadStatic]
	private static bool internal_in_precondition = false;
	// Flag if in precondition checking.
	
	[ThreadStatic]
	private static bool caller_supplier_precondition = false;
		// Flag used to detect whether the caller has supplier
		// preconditions enabled.

	private static ASSERTION_LEVEL_ENUM global_assertion_level = ASSERTION_LEVEL_ENUM.no;
		// Default global level of assertion checking. If `is_global_assertion_level_set'
		// then all types have the same level of assertions, therefore no need to look
		// into the `assertion_levels' table to find out if we should check the assertion
		// for a given type.

	private static bool is_global_assertion_level_set = false;
		// Is `global_assertion_level' set?

/*
feature -- Builtin implementations for Eiffel classes, see Eiffel classes for comments
*/
	private static System.Threading.Mutex identified_mutex = new System.Threading.Mutex();
		// Synchronization object for all IDENTIFIED_ROUTINES operations.
	private static System.Collections.Generic.List<WeakReference> identified_list = new System.Collections.Generic.List<WeakReference>(50);
		// List holding the IDENTIFIED objects. Synchronized access using `identified_mutex'.

	public static int builtin_IDENTIFIED_CONTROLLER_object_id_stack_size (object Current) {
		int Result;
		identified_mutex.WaitOne();
		Result = identified_list.Capacity / 1000  + 1;
		identified_mutex.ReleaseMutex();
		return Result;
	}
	public static void builtin_IDENTIFIED_CONTROLLER_extend_object_id_stack (object Current, int nb_chunks) {
		identified_mutex.WaitOne();
		identified_list.Capacity = identified_list.Capacity + nb_chunks * 1000;
		identified_mutex.ReleaseMutex();
	}
	public static object builtin_IDENTIFIED_ROUTINES_eif_id_object (int an_id)
		   // Return object associated with `an_id' if ANY, Void otherwise.
	{
		object Result = null;
		identified_mutex.WaitOne();
		if (an_id > 0 && an_id <= identified_list.Count) {
			WeakReference wr = identified_list [an_id - 1];
			if (wr != null) {
				Result = wr.Target;
				if (Result == null) {
						// Object has been collected, let's get rid of the associated weak reference
					identified_list [an_id - 1] = null;
				}
			}
		}
		identified_mutex.ReleaseMutex();
		return Result;
	}

	public static int builtin_IDENTIFIED_ROUTINES_eif_object_id (object an_object)
		   // Compute new ID for object `an_object'.
	{
		int Result;
		identified_mutex.WaitOne();
		identified_list.Add(new WeakReference(an_object));
		Result = identified_list.Count;
		identified_mutex.ReleaseMutex();
		return Result;
	}

	public static void builtin_IDENTIFIED_ROUTINES_eif_object_id_free (int an_id)
		   // Free the entry `an_id'.
	{
		identified_mutex.WaitOne();
		if (an_id <= identified_list.Count) {
			identified_list [an_id - 1] = null;
		}
		identified_mutex.ReleaseMutex();
	}

	public static bool builtin_PLATFORM_is_thread_capable () {
		return true;
	}
	public static bool builtin_PLATFORM_is_scoop_capable () {
		return false;
	}
	public static bool builtin_PLATFORM_is_dotnet () {
		return true;
	}
	public static bool builtin_PLATFORM_is_windows () {
		return true;
	}
	public static bool builtin_PLATFORM_is_unix () {
		return false;
	}
	public static bool builtin_PLATFORM_is_vms () {
		return false;
	}
	public static bool builtin_PLATFORM_is_mac () {
		return false;
	}
	public static bool builtin_PLATFORM_is_vxworks () {
		return false;
	}
	public static bool builtin_PLATFORM_is_64_bits () {
		return IntPtr.Size == 8;
	}
	public static int builtin_PLATFORM_boolean_bytes () {
		return 1;
	}
	public static int builtin_PLATFORM_character_bytes () {
		return 1;
	}
	public static int builtin_PLATFORM_wide_character_bytes () {
		return 4;
	}
	public static int builtin_PLATFORM_integer_bytes () {
		return 4;
	}
	public static int builtin_PLATFORM_real_bytes () {
		return 4;
	}
	public static int builtin_PLATFORM_double_bytes () {
		return 8;
	}
	public static int builtin_PLATFORM_pointer_bytes () {
		return System.Runtime.InteropServices.Marshal.SizeOf(typeof(IntPtr));
	}


	public static float builtin_REAL_32_REF_nan () {
		return System.Single.NaN;
	}
	public static float builtin_REAL_32_REF_negative_infinity () {
		return System.Single.NegativeInfinity;
	}
	public static float builtin_REAL_32_REF_positive_infinity () {
		return System.Single.PositiveInfinity;
	}

	public static double builtin_REAL_64_REF_nan () {
		return System.Double.NaN;
	}
	public static double builtin_REAL_64_REF_negative_infinity () {
		return System.Double.NegativeInfinity;
	}
	public static double builtin_REAL_64_REF_positive_infinity () {
		return System.Double.PositiveInfinity;
	}

	public static int builtin_IDENTIFIED_ROUTINES_eif_current_object_id(object Current){
		return builtin_IDENTIFIED_ROUTINES_eif_object_id (Current);
	}
	public static bool builtin_IDENTIFIED_ROUTINES_eif_is_object_id_of_current(object Current, int an_id) {
		return builtin_IDENTIFIED_ROUTINES_eif_id_object(an_id) == Current;
	}

/*
feature -- IEEE comparisons of REAL_32 and REAL_64
*/
// Disabling warning is necessary
#pragma warning disable 1718

	public static bool is_equal_real_32 (float d1, float d2) {
		return (d1 == d1 ? d1 == d2 : d2 != d2);
	}

	public static bool is_less_real_32 (float d1, float d2) {
		return (d1 == d1 ? d1 < d2 : d2 == d2);
	}

	public static bool is_less_equal_real_32 (float d1, float d2) {
		return (d1 == d1 ? d1 <= d2 : true);
	}

	public static bool is_greater_real_32 (float d1, float d2) {
		return (d2 == d2 ? d1 > d2 : d1 == d1);
	}

	public static bool is_greater_equal_real_32 (float d1, float d2) {
		return (d2 == d2 ? d1 >= d2 : true);
	}

	public static bool is_equal_real_64 (double d1, double d2) {
		return (d1 == d1 ? d1 == d2 : d2 != d2);
	}

	public static bool is_less_real_64 (double d1, double d2) {
		return (d1 == d1 ? d1 < d2 : d2 == d2);
	}

	public static bool is_less_equal_real_64 (double d1, double d2) {
		return (d1 == d1 ? d1 <= d2 : true);
	}

	public static bool is_greater_real_64 (double d1, double d2) {
		return (d2 == d2 ? d1 > d2 : d1 == d1);
	}

	public static bool is_greater_equal_real_64 (double d1, double d2) {
		return (d2 == d2 ? d1 >= d2 : true);
	}

	public static float min_real_32 (float i, float j) {
		return (is_less_equal_real_32(i, j) ? i : j);
	}
	public static double min_real_64 (double i, double j) {
		return (is_less_equal_real_64(i, j) ? i : j);
	}
	public static float max_real_32 (float i, float j) {
		return (is_greater_equal_real_32(i, j) ? i : j);
	}
	public static double max_real_64 (double i, double j) {
		return (is_greater_equal_real_64(i, j) ? i : j);
	}
	public static int three_way_comparison_real_32 (float i, float j) {
		return (is_less_real_32(i, j) ? -1 : is_less_real_32(j, i) ? 1 : 0);
	}
	public static int three_way_comparison_real_64 (double i, double j) {
		return (is_less_real_64(i, j) ? -1 : is_less_real_64(j, i) ? 1 : 0);
	}

#pragma warning restore 1718
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

	public static bool is_deep_equal (object Current, object other)
		// Are `Current' and `other' attached to isomorphic object structures?
	{
		return ANY.deep_equal (Current, Current, other);
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
feature -- Object creation
*/

	public static object create_type (RT_CLASS_TYPE a_type)
		// Create new instance of `a_type'.
	{
			// Create new object of type `a_type'.
			// Properly initializes `Result'.
		return GENERIC_CONFORMANCE.create_instance
			(Type.GetTypeFromHandle (a_type.type),
			a_type as RT_GENERIC_TYPE);
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

	public static Type interface_type (Type a_type)
		// Given a type `a_type' retrieves its associated interface type if any (i.e. only
		// it is an Eiffel type).
		// Used for conformance because the .NET routine `GetType()' will always return
		// the implementation type and it cannot be used for conformance because two implementation
		// classes do not conform even if their interfaces do.
	{
		object [] l_attributes;
		Type result;

		#if ASSERTIONS
			ASSERTIONS.REQUIRE ("a_type not null", a_type != null);
		#endif

		result = interface_type_mapping [a_type] as Type;
		if (result == null) {
			l_attributes = a_type.GetCustomAttributes (typeof (RT_INTERFACE_TYPE_ATTRIBUTE), false);
			if (l_attributes != null && l_attributes.Length > 0) {
				result = ((RT_INTERFACE_TYPE_ATTRIBUTE) l_attributes [0]).class_type;
			} else {
				l_attributes = a_type.GetCustomAttributes (typeof (INTERFACE_TYPE_ATTRIBUTE), false);
				if (l_attributes != null && l_attributes.Length > 0) {
					result = ((INTERFACE_TYPE_ATTRIBUTE) l_attributes [0]).class_type;
				} else {
					result = a_type;
				}
			}
			interface_type_mapping [a_type] = result;
		}
		return result;
	}

	private static Hashtable interface_type_mapping = new Hashtable (100);
		// Mapping between implementation types and interface types.

	public static RT_GENERIC_TYPE generic_type (object an_obj)
		// Given an Eiffel object `an_obj' retrieves its associated type if any.
	{
		EIFFEL_TYPE_INFO l_object = an_obj as EIFFEL_TYPE_INFO;
		
		if (l_object != null) {
			return l_object.____type ();
		} else {
			return null;
		}
	}

	public static RT_CLASS_TYPE type_of_generic (object an_obj, int pos)
		// Given an Eiffel object `an_obj', find the associated type of generic parameter
		// at position `pos'.
	{
		EIFFEL_TYPE_INFO l_object = an_obj as EIFFEL_TYPE_INFO;

		if (l_object != null) {
			#if ASSERTIONS
				ASSERTIONS.REQUIRE ("Has  generic info", l_object.____type() != null);
				ASSERTIONS.REQUIRE ("Valid position `pos'",
					(pos > 0) && (pos <= l_object.____type().count));
				ASSERTIONS.REQUIRE ("valid element type", l_object.____type().generics [pos - 1] is RT_CLASS_TYPE);
			#endif

			return (RT_CLASS_TYPE) (l_object.____type ().generics [pos - 1]);
		} else {
			return null;
		}
	}

	public static object attempted_on_type (Type a_type, object obj)
		// Given an dotnet type `a_type` , return `obj` if it is an instance of that type.
	{
		if (a_type != null && a_type.IsInstanceOfType (obj)) {
			return obj;
		}
		return null;
	}

	public static object attempted_on_rt_type (object current, RT_TYPE a_rt_type, object obj)
		// return `obj` if it is an instance of `a_rt_type`, or
		// of type associated with position of formal type for `current` object.
	{
		Type t = null;

		if (a_rt_type is RT_CLASS_TYPE) {
			RT_CLASS_TYPE cl_t = a_rt_type as RT_CLASS_TYPE;
			t = cl_t.dotnet_type();
		} else if (a_rt_type is RT_FORMAL_TYPE) {
			RT_FORMAL_TYPE f_t = a_rt_type as RT_FORMAL_TYPE;
			t = type_of_generic_parameter (current, f_t.position);
		}
		return attempted_on_type (t,obj);
	}	

//FIXME: to remove when TUPLE is updated not to use this routine anymore.
	public static Type type_of_generic_parameter (object an_obj, int pos)
		// Given an Eiffel object `an_obj', find the associated type of generic parameter
		// at position `pos'.
	{
		EIFFEL_TYPE_INFO l_object = an_obj as EIFFEL_TYPE_INFO;
		RT_GENERIC_TYPE l_gen_type;
		RT_CLASS_TYPE cl_type;
		Type Result = null;

		if (l_object != null) {
			#if ASSERTIONS
				ASSERTIONS.REQUIRE ("Has  generic info", l_object.____type() != null);
				ASSERTIONS.REQUIRE ("Valid position `pos'",
					(pos > 0) && (pos <= l_object.____type().count));
			#endif

			l_gen_type = l_object.____type ();
			cl_type = (RT_CLASS_TYPE) l_gen_type.generics [pos - 1];
			if (!cl_type.is_basic ()) {
				if (cl_type.type.Value != (System.IntPtr) 0) {
					Result = interface_type (Type.GetTypeFromHandle (cl_type.type));
				} else {
						/* Generic parameter is of type NONE, so we return an instance
						 * of RT_NONE_TYPE as associated type. It is mostly there to fix
						 * assertions violations in TUPLE when one of the elements of
						 * a manifest tuple is `Void'. */
					#if ASSERTIONS
						ASSERTIONS.CHECK ("Is NONE type.", cl_type is RT_NONE_TYPE);
					#endif
					Result = typeof(RT_NONE_TYPE);
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
		RT_GENERIC_TYPE l_gen_type;
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
		RT_GENERIC_TYPE l_gen_type;
		EIFFEL_TYPE_INFO info = o as EIFFEL_TYPE_INFO;
		Boolean Result = false;

		if (info != null) {
			l_gen_type = info.____type ();
			if (l_gen_type != null) {
					// A generic class, possibly a good candidate for ARRAY.
				Result = l_gen_type.class_name ().Equals ("ARRAY");
			}
		}
		return Result;
	}

	public static String eiffel_string (object o)
		// System.String representation of `o' if it is an Eiffel STRING instance.
	{
		String Result = null;

		if (is_eiffel_string (o)) {
			Result = "\"" + o.ToString () + "\"";
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
			native_info = eiffel_special_type.GetField ("$$internal_native_array");
			if (native_info == null) {
				native_info = eiffel_special_type.GetField ("internal_native_array");
				if (native_info == null) {
					native_info = eiffel_special_type.GetField ("$$internalNativeArray");
					if (native_info == null) {
						native_info = eiffel_special_type.GetField ("internalNativeArray");
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

/*
feature -- Marking
*/

	public static bool is_object_marked (object obj)
			// Is `obj' marked?
			// Note that `marking_mutex' should be owned to safely call this routine.
	{
		return marked_objects.Contains(obj);
	}

	public static void mark_object (object obj)
		// Mark object `obj'.
		// Note that `marking_mutex' should be owned to safely call this routine.
	{
		marked_objects.Add(obj, obj);
	}

	public static void unmark_object(object obj)
		// Mark object `obj'.
		// Note that `marking_mutex' should be owned to safely call this routine.
	{
		marked_objects.Remove(obj);
	}

	public static void lock_marking ()
		// Get a lock for `mark_object', `unmark_object' and `is_object_marked' so that they can
		// be safely executed.
	{
		marking_mutex.WaitOne();
	}

	public static void unlock_marking ()
		// Release a lock for `mark_object', `unmark_object' and `is_object_marked' so that marking
		// routines can be executed from another thread.
	{
		marking_mutex.ReleaseMutex();
	}

	private static Hashtable marked_objects;
			// Store all marked objects.

	private static System.Threading.Mutex marking_mutex;
			// Mutex used to mark objects in `marked_objects'.

/*
feature -- Introspection
*/

	public static int field_bit_size (int i, object obj)
		// BIT size of the `i'-th field of `obj' assuming it is a BIT instance.
	{
			// BIT types are not implemented on .NET
		return 0;
	}
	
	[CLSCompliant(false)]
	public static ulong object_size (object obj)
		// Physical size of an object.
	{
		#if ASSERTIONS
			ASSERTIONS.REQUIRE("obj not void", obj != null);
		#endif

		return (ulong) System.Runtime.InteropServices.Marshal.SizeOf(obj.GetType());
	}

	public static void set_field_of_expanded (object root_object, FieldInfo [] a_fields, FieldInfo a_field, object val)
		// Set `a_field' with `val', an attribute reachable from `root_object' using `a_fields' as a path to
		// reach it.
	{
		TypedReference t = TypedReference.MakeTypedReference(root_object, a_fields);
		a_field.SetValueDirect(t, val);
	}

	public static object field_of_expanded (object root_object, FieldInfo [] a_fields, FieldInfo a_field)
		// Get value of `a_field', an attribute reachable from `root_object' using `a_fields' as a path to
		// reach it.
	{
		TypedReference t = TypedReference.MakeTypedReference(root_object, a_fields);
		return a_field.GetValueDirect(t);
	}
}
}

