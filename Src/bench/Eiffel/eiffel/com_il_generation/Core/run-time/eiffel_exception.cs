/*
indexing
	description: "Type of all Eiffel exceptions."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;
namespace EiffelSoftware.Runtime {

[Serializable]
public class EIFFEL_EXCEPTION: ApplicationException {
/*
feature -- Initialization
*/
	public EIFFEL_EXCEPTION (int a_code, string a_tag) : base (exception_message (a_code, a_tag))
		// New instance with `code' set to `a_code' and `tag' with `a_tag'.
	{
		code = a_code;
		tag = a_tag;
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("code_set", code == a_code);
			ASSERTIONS.ENSURE ("tag_set", tag == a_tag);
		#endif
	}
/*
feature -- Access
*/
	public int code;
		// Code of current exception

	public string tag;
		// Tag of current exception

/*
feature {NONE} -- Implementation
*/

	private static string exception_message (int a_code, string a_tag)
	{
		string result = null;

		switch (a_code) {
			case Void_call_target: result = "Feature call on void target."; break;
			case No_more_memory: result = " No more memory."; break;
			case Precondition: result = "Precondition violation."; break;
			case Postcondition: result = "Postcondition violation."; break;
			case Floating_point_exception: result = "Floating point exception."; break;
			case Class_invariant: result = "Class invariant violated."; break;
			case Check_instruction: result = "Assertion violated."; break;
			case Routine_failure: result = "Routine failure."; break;
			case Incorrect_inspect_value: result = "Unmatched inspect value."; break;
			case Loop_variant: result = "Non-decreasing loop variant or negative value reached."; break;
			case Loop_invariant: result = "Loop invariant violated."; break;
			case Signal_exception: result = "Operating system signal."; break;
			case Rescue_exception: result = "Exception in rescue clause."; break;
			case External_exception: result = "External event."; break;
			case Void_assigned_to_expanded: result = "Void assigned to expanded."; break;
			case Io_exception: result = "I/O error."; break;
			case Operating_system_exception: result = "Operating system error."; break;
			case Retrieve_exception: result = "Retrieval error."; break;
			case Developer_exception: result = "Developer exception."; break;
			case Runtime_io_exception: result = "Runtime I/O error."; break;
			case Com_exception: result = "COM error."; break;
			case Runtime_check_exception: result = "Runtime check violated."; break;
			default: break;
		}

		if (result != null) {
			result = "Code: " + a_code + " (" + result + ")";
		} else {
			result = "Code: " + a_code;
		}
		if (a_tag != null) {
			result = result + " Tag: " + a_tag;
		}
		return result;
	}

/*
feature {NONE} -- Constants
*/

	private const int Void_call_target = 1;
	private const int No_more_memory = 2;
	private const int Precondition = 3;
	private const int Postcondition = 4;
	private const int Floating_point_exception = 5;
	private const int Class_invariant = 6;
	private const int Check_instruction = 7;
	private const int Routine_failure = 8;
	private const int Incorrect_inspect_value = 9;
	private const int Loop_variant = 10;
	private const int Loop_invariant = 11;
	private const int Signal_exception = 12;
	private const int Rescue_exception = 14;
	private const int External_exception = 18;
	private const int Void_assigned_to_expanded = 19;
	private const int Io_exception = 21;
	private const int Operating_system_exception = 22;
	private const int Retrieve_exception = 23;
	private const int Developer_exception = 24;
	private const int Runtime_io_exception = 27;
	private const int Com_exception = 28;
	private const int Runtime_check_exception = 29;

}
}
