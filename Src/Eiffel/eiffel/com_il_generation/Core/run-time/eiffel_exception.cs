/*
indexing
	description: "Type of all Eiffel exceptions."
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
using System.Runtime.Serialization;

namespace EiffelSoftware.Runtime {

[Serializable]
public class EIFFEL_EXCEPTION: ApplicationException {
/*
feature -- Initialization
*/
	public EIFFEL_EXCEPTION (SerializationInfo info, StreamingContext context) : base (info, context)
		// New instance for ISerializable conformance.
	{
	}

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

	public EIFFEL_EXCEPTION (int a_code, string a_tag, Exception an_inner_exception) : base (exception_message (a_code, a_tag), an_inner_exception)
		// New instance with `code' set to `a_code' and `tag' with `a_tag'
		// and `InnerException' set to `an_inner_exception'.
	{
		code = a_code;
		tag = a_tag;
		#if ASSERTIONS
			ASSERTIONS.ENSURE ("code_set", code == a_code);
			ASSERTIONS.ENSURE ("tag_set", tag == a_tag);
			ASSERTIONS.ENSURE ("InnerException_set", InnerException == an_inner_exception);
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
