/*
indexing
	description: "Ancestor class for calling agents."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime {

public class AGENT_PROXY {
/*
feature -- Basic operations
*/
	public virtual void call (object agent, object[] open_operands)
			// Call associated routine `agent' with open arguments `open_operands'.
	{
		#if ASSERTIONS
			ASSERTIONS.CHECK ("open_operands_not_void", open_operands != null);
		#endif
	}

/*
feature -- Access
*/

	public object last_result;
			// Last result of a function call

	public object item (object agent, object[] open_operands)
			// Call associated routine `agent' with open arguments `open_operands'.
	{
		#if ASSERTIONS
			ASSERTIONS.CHECK ("open_operands_not_void", open_operands != null);
		#endif
		call (agent, open_operands);
		return last_result;
	}

/*
feature -- Settings
*/

	public virtual void set_closed_arguments (object [] closed_arguments)
			// Set current object with `closed_arguments'.
	{
	}
}
}


