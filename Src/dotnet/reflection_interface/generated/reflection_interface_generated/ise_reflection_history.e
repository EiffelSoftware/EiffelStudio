indexing
	Generator: "Eiffel Emitter 2.6b2"
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

	frozen assemblies_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"AssembliesTable"
		end

	frozen type_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"TypeFound"
		end

	frozen search_for_type_result: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.History"
		alias
			"SearchForTypeResult"
		end

	frozen assembly_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"AssemblyFound"
		end

	frozen types_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"TypesTable"
		end

	frozen search_for_assembly_result: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.History"
		alias
			"SearchForAssemblyResult"
		end

feature -- Basic Operations

	maximum_count: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.History"
		alias
			"MaximumCount"
		end

	add_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR; an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor, ISE.Reflection.EiffelAssembly): System.Void use ISE.Reflection.History"
		alias
			"AddAssembly"
		end

	search_for_type (a_type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use ISE.Reflection.History"
		alias
			"SearchForType"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.History"
		alias
			"Make"
		end

	has_type (a_type: SYSTEM_TYPE): BOOLEAN is
		external
			"IL signature (System.Type): System.Boolean use ISE.Reflection.History"
		alias
			"HasType"
		end

	add_type (a_type: SYSTEM_TYPE; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (System.Type, ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.History"
		alias
			"AddType"
		end

	search_for_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.History"
		alias
			"SearchForAssembly"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.History"
		alias
			"_invariant"
		end

	has_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Boolean use ISE.Reflection.History"
		alias
			"HasAssembly"
		end

end -- class ISE_REFLECTION_HISTORY
