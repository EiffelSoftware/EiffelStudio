indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "HISTORY"

deferred external class
	HISTORY

inherit
	REFLECTION_INTERFACE_SUPPORT

feature -- Basic Operations

	types_table: HASH_TABLE_ANY_INT32 is
		external
			"IL deferred signature (): HASH_TABLE_ANY_INT32 use HISTORY"
		alias
			"types_table"
		end

	search_for_type_result: EIFFEL_CLASS is
		external
			"IL deferred signature (): EIFFEL_CLASS use HISTORY"
		alias
			"search_for_type_result"
		end

	search_for_assembly_result: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use HISTORY"
		alias
			"search_for_assembly_result"
		end

	a_set_search_for_type_result (search_for_type_result2: EIFFEL_CLASS) is
		external
			"IL deferred signature (EIFFEL_CLASS): System.Void use HISTORY"
		alias
			"_set_search_for_type_result"
		end

	add_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR; an_eiffel_assembly: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR, EIFFEL_ASSEMBLY): System.Void use HISTORY"
		alias
			"add_assembly"
		end

	has_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR): BOOLEAN is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Boolean use HISTORY"
		alias
			"has_assembly"
		end

	search_for_type (a_type: TYPE) is
		external
			"IL deferred signature (System.Type): System.Void use HISTORY"
		alias
			"search_for_type"
		end

	a_set_type_found (type_found2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use HISTORY"
		alias
			"_set_type_found"
		end

	a_set_assemblies_table (assemblies_table2: HASH_TABLE_ANY_ANY) is
		external
			"IL deferred signature (HASH_TABLE_ANY_ANY): System.Void use HISTORY"
		alias
			"_set_assemblies_table"
		end

	assembly_found: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HISTORY"
		alias
			"assembly_found"
		end

	assemblies_table: HASH_TABLE_ANY_ANY is
		external
			"IL deferred signature (): HASH_TABLE_ANY_ANY use HISTORY"
		alias
			"assemblies_table"
		end

	add_type (a_type: TYPE; an_eiffel_class: EIFFEL_CLASS) is
		external
			"IL deferred signature (System.Type, EIFFEL_CLASS): System.Void use HISTORY"
		alias
			"add_type"
		end

	make is
		external
			"IL deferred signature (): System.Void use HISTORY"
		alias
			"make"
		end

	a_set_search_for_assembly_result (search_for_assembly_result2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use HISTORY"
		alias
			"_set_search_for_assembly_result"
		end

	type_found: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use HISTORY"
		alias
			"type_found"
		end

	maximum_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use HISTORY"
		alias
			"maximum_count"
		end

	search_for_assembly (a_descriptor: ASSEMBLY_DESCRIPTOR) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR): System.Void use HISTORY"
		alias
			"search_for_assembly"
		end

	a_set_types_table (types_table2: HASH_TABLE_ANY_INT32) is
		external
			"IL deferred signature (HASH_TABLE_ANY_INT32): System.Void use HISTORY"
		alias
			"_set_types_table"
		end

	a_set_assembly_found (assembly_found2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use HISTORY"
		alias
			"_set_assembly_found"
		end

	has_type (a_type: TYPE): BOOLEAN is
		external
			"IL deferred signature (System.Type): System.Boolean use HISTORY"
		alias
			"has_type"
		end

end -- class HISTORY
