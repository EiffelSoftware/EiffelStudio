indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	get_type_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.History"
		alias
			"get_TypeFound"
		end

	frozen a_internal_assemblies_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"_internal_AssembliesTable"
		end

	frozen a_internal_search_for_type_result: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL field signature :ISE.Reflection.EiffelClass use ISE.Reflection.History"
		alias
			"_internal_SearchForTypeResult"
		end

	frozen a_internal_types_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL field signature :System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"_internal_TypesTable"
		end

	frozen a_internal_assembly_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"_internal_AssemblyFound"
		end

	get_assembly_found: BOOLEAN is
		external
			"IL signature (): System.Boolean use ISE.Reflection.History"
		alias
			"get_AssemblyFound"
		end

	get_types_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"get_TypesTable"
		end

	get_search_for_assembly_result: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (): ISE.Reflection.EiffelAssembly use ISE.Reflection.History"
		alias
			"get_SearchForAssemblyResult"
		end

	get_assemblies_table: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL signature (): System.Collections.Hashtable use ISE.Reflection.History"
		alias
			"get_AssembliesTable"
		end

	frozen a_internal_search_for_assembly_result: ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL field signature :ISE.Reflection.EiffelAssembly use ISE.Reflection.History"
		alias
			"_internal_SearchForAssemblyResult"
		end

	frozen a_internal_type_found: BOOLEAN is
		external
			"IL field signature :System.Boolean use ISE.Reflection.History"
		alias
			"_internal_TypeFound"
		end

	get_search_for_type_result: ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (): ISE.Reflection.EiffelClass use ISE.Reflection.History"
		alias
			"get_SearchForTypeResult"
		end

feature -- Basic Operations

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

	maximum_count: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.History"
		alias
			"MaximumCount"
		end

	search_for_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.History"
		alias
			"SearchForAssembly"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_HISTORY) is
		external
			"IL static signature (ISE.Reflection.History): System.Void use ISE.Reflection.History"
		alias
			"_invariant"
		end

	add_type (a_type: SYSTEM_TYPE; an_eiffel_class: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (System.Type, ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.History"
		alias
			"AddType"
		end

	has_assembly (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): BOOLEAN is
		external
			"IL signature (ISE.Reflection.AssemblyDescriptor): System.Boolean use ISE.Reflection.History"
		alias
			"HasAssembly"
		end

end -- class ISE_REFLECTION_HISTORY
