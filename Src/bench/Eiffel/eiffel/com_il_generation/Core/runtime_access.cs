/*
indexing
	description: "Encapsulation to access internal of ISE runtime for .NET"
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.Reflection;

internal class RUNTIME {

/*
feature -- Initialization
*/

	internal static void prepare ()
		// Initialize components of ISE runtime needed for code generation.
	{
		Type ISE_class;
		AssemblyName name = new AssemblyName();

		name.Name = "ise_runtime";
		name.Version = new Version (5,2,0,0);
		name.SetPublicKeyToken (new byte[8] {0xde, 0xf2, 0x6f, 0x29, 0x6e, 0xfe, 0xf4, 0x69});
		name.CultureInfo = new System.Globalization.CultureInfo ("");
		Ise_runtime_assembly = Assembly.Load (name);

		ISE_class = Ise_runtime_assembly.GetType ("ISE.Runtime.RUN_TIME");
		Assertion_tag = ISE_class.GetField ("assertion_tag");
		In_assertion = ISE_class.GetField ("in_assertion");

		ISE_class = Ise_runtime_assembly.GetType ("ISE.Runtime.EXCEPTION_MANAGER");
		Last_exception = ISE_class.GetField ("last_exception");

		Ise_eiffel_type_info_type = Ise_runtime_assembly.GetType ("ISE.Runtime.EIFFEL_TYPE_INFO");
		Ise_type = Ise_runtime_assembly.GetType ("ISE.Runtime.TYPE");
		Ise_class_type = Ise_runtime_assembly.GetType ("ISE.Runtime.CLASS_TYPE");
		Ise_generic_type = Ise_runtime_assembly.GetType ("ISE.Runtime.GENERIC_TYPE");
		Ise_formal_type = Ise_runtime_assembly.GetType ("ISE.Runtime.FORMAL_TYPE");
		Ise_none_type = Ise_runtime_assembly.GetType ("ISE.Runtime.NONE_TYPE");
		Ise_basic_type = Ise_runtime_assembly.GetType ("ISE.Runtime.BASIC_TYPE");
		Ise_eiffel_derivation_type = Ise_runtime_assembly.GetType ("ISE.Runtime.EIFFEL_DERIVATION");
		Ise_eiffel_class_name_attr = Ise_runtime_assembly.GetType ("ISE.Runtime.EIFFEL_CLASS_NAME_ATTRIBUTE");
	}

/*
feature -- Access
*/
	internal static Assembly Ise_runtime_assembly = null;
		// Access to ISE runtime assembly.

	internal static Type Ise_eiffel_type_info_type = null;
	internal static Type Ise_type = null;
	internal static Type Ise_class_type = null;
	internal static Type Ise_generic_type = null;
	internal static Type Ise_formal_type = null;
	internal static Type Ise_none_type = null;
	internal static Type Ise_basic_type = null;
	internal static Type Ise_eiffel_derivation_type = null;
		// Interface to which all Eiffel implementation classes inherits from.

	internal static FieldInfo Assertion_tag = null;
	internal static FieldInfo In_assertion = null;
	internal static FieldInfo Last_exception = null;
		// ISE Runtime class

	internal static Type Ise_eiffel_class_name_attr = null;
		// Custom attribute to store name of Eiffel class.

} // class RUNTIME

