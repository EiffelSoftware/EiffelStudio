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
	internal static CustomAttributeBuilder debugger_step_through_attr {
		// Once: Predefined Custom attribute to force debugger
		// to skip certain routines.
		get {
			if (internal_debugger_step_through_attr == null) {
				Type type = Type.GetType ("System.Diagnostics.DebuggerStepThroughAttribute");
				ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
				internal_debugger_step_through_attr =
					new CustomAttributeBuilder (constructor, new object [0] {});
			}
			return internal_debugger_step_through_attr;
		}
	}

	internal static CustomAttributeBuilder debugger_hidden_attr {
		// Once: Predefined Custom attribute to force debugger
		// to hide certain routines.
		get {
			if (internal_debugger_hidden_attr == null) {
				Type type = Type.GetType ("System.Diagnostics.DebuggerHiddenAttribute");
				ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
				internal_debugger_hidden_attr =
					new CustomAttributeBuilder (constructor, new object [0] {});
			}
			return internal_debugger_hidden_attr;
		}
	}

	internal static CustomAttributeBuilder suppress_check_attr {
		// Once: Predefined Custom attribute to force .net runtime
		// not to perform a stack walk when calling a C external.
		get {
			if (internal_suppress_check_attr == null) {
				Type type = Type.GetType ("System.Security.SuppressUnmanagedCodeSecurityAttribute");
				ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
				internal_suppress_check_attr =
					new CustomAttributeBuilder (constructor, new object [0] {});
			}
			return internal_suppress_check_attr;
		}
	}

	internal static CustomAttributeBuilder not_cls_compliant_attr {
		// Once: Predefined Custom attribute to tell .NET runtime
		// that current member that holds the CA is not CLS compliant.
		get {
			if (internal_not_cls_compliant_attr == null) {
				Type type = Type.GetType ("System.CLSCompliantAttribute");
				ConstructorInfo constructor = type.GetConstructor (
					new Type [1] {Type.GetType ("System.Boolean")});
				internal_not_cls_compliant_attr =
					new CustomAttributeBuilder (constructor, new object [1] {false});
			}
			return internal_not_cls_compliant_attr;
		}
	}

	internal static CustomAttributeBuilder eiffel_class_name_attr (String name)
		// Predefined Custom attribute to store in metadata real
		// eiffel class name.
	{
		Type type = RUNTIME.Ise_eiffel_class_name_attr;
        ConstructorInfo constructor = RUNTIME.Ise_eiffel_class_name_attr.GetConstructor (
				new Type [1] {Type.GetType ("System.String")});

		return new CustomAttributeBuilder (constructor, new object [1] {name});
	}

/*
feature {NONE} -- Implementation
*/
	private static CustomAttributeBuilder internal_debugger_step_through_attr;
	private static CustomAttributeBuilder internal_debugger_hidden_attr;
		// Debugger CAs to hide dummy callbacks routine

	private static CustomAttributeBuilder internal_suppress_check_attr;
		// To speed up access to C externals.

	private static CustomAttributeBuilder internal_not_cls_compliant_attr;
		// Mark current member to be not CLS compliant.

} // end of CA

} // end of namespace 
