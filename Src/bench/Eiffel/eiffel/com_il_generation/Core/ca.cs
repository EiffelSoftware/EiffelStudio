/*
indexing
	description: "Precomputed Custom Attributes used during IL code generation"
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.InteropServices;

namespace ISE.Compiler {

internal class CA
{
	// Debugger CAs to hide dummy callbacks routine
	internal static CustomAttributeBuilder internal_debugger_step_through_attr;
	internal static CustomAttributeBuilder internal_debugger_hidden_attr;
	internal static CustomAttributeBuilder internal_suppress_check_attr;

	internal static CustomAttributeBuilder debugger_step_through_attr ()
		// Once: Predefined Custom attribute to force debugger
		// to skip certain routines.
	{
		if (internal_debugger_step_through_attr == null) {
			Type type = Type.GetType ("System.Diagnostics.DebuggerStepThroughAttribute");
			ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
			internal_debugger_step_through_attr =
				new CustomAttributeBuilder (constructor, new object [0] {});
		}
		return internal_debugger_step_through_attr;
	}

	internal static CustomAttributeBuilder debugger_hidden_attr ()
		// Once: Predefined Custom attribute to force debugger
		// to hide certain routines.
	{
		if (internal_debugger_hidden_attr == null) {
			Type type = Type.GetType ("System.Diagnostics.DebuggerHiddenAttribute");
			ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
			internal_debugger_hidden_attr =
				new CustomAttributeBuilder (constructor, new object [0] {});
		}
		return internal_debugger_hidden_attr;
	}

	internal static CustomAttributeBuilder suppress_check_attr ()
		// Once: Predefined Custom attribute to force .net runtime
		// not to perform a stack walk when calling a C external.
	{
		if (internal_suppress_check_attr == null) {
			Type type = Type.GetType ("System.Security.SuppressUnmanagedCodeSecurityAttribute");
			ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
			internal_suppress_check_attr =
				new CustomAttributeBuilder (constructor, new object [0] {});
		}
		return internal_suppress_check_attr;
	}

} // end of CA

} // end of namespace 
