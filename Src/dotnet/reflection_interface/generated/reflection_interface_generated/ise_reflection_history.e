indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.History"

external class
	ISE_REFLECTION_HISTORY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.History"
		end

feature -- Access

	frozen TypeFound: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"TypeFound"
		end

	frozen AssembliesTable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"AssembliesTable"
		end

	frozen SearchForTypeResult: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.History"
		alias
			"SearchForTypeResult"
		end

	frozen SearchForAssemblyResult: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.History"
		alias
			"SearchForAssemblyResult"
		end

	frozen AssemblyFound: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"AssemblyFound"
		end

	frozen TypesTable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"TypesTable"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.History"
		alias
			"Make"
		end

	SearchForAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.History"
		alias
			"SearchForAssembly"
		end

	MaximumCount: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.History"
		alias
			"MaximumCount"
		end

	AddAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.History"
		alias
			"AddAssembly"
		end

	SearchForType (a_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use ISE.Reflection.History"
		alias
			"SearchForType"
		end

	HasType (a_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use ISE.Reflection.History"
		alias
			"HasType"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.History"
		alias
			"_invariant"
		end

	AddType (a_type: SYSTEM_TYPE; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (System.Type, ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.History"
		alias
			"AddType"
		end

	HasAssembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Boolean use ISE.Reflection.History"
		alias
			"HasAssembly"
		end

end -- class ISE_REFLECTION_HISTORY
