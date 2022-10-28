note
	description: "[
					These are the indexes to the tables.   They are in order as they will appear
			    	in the PE file (if they do appear in the PE file)
		]"
	date: "$Date$"
	revision: "$Revision$"

once class
	PE_TABLES

create
	tModule, -- Assembly def
	tTypeRef, -- References to other assemblies
	tTypeDef, -- definitions of classes and enumerations
	tField, -- definitions of fields
	tMethodDef, -- definitions of methods, includes both managed and unmanaged
	tParam, -- definitions of parameters
	tInterfaceImpl,
	tMemberRef, -- references to external methods, also the call site references for vararg-style pinvokes
	tConstant, -- initialization constants, we use them for enumerations but that is about it
	tCustomAttribute, -- custom attributes, we use it for C# style varargs but nothing else
	tFieldMarshal,
	tDeclSecurity, -- we don't use it
	tClassLayout, -- size, packing for classes
	tFieldLayout, -- field offsets, we don't use it
	tStandaloneSig, --?? we don't use it
	tEventMap,
	tEvent,
	tPropertyMap,
	tProperty,
	tMethodSemantics,
	tMethodImpl,
	tModuleRef, -- references to external modules
	tTypeSpec, -- we use it for referenced types not found in the typedef table
	tImplMap, -- pinvoke DLL information
	tFieldRVA, -- cildata RVAs for field initialized data
	tAssemblyDef, -- our main assembly
	tAssemblyRef, -- any external assemblies
	tFile,
	tExportedType,
	tManifestResource,
	tNestedClass, -- list of nested classes and their parents
	tGenericParam,
	tMethodSpec,
	tGenericParamConstraint

feature {NONE} -- Creation Procedures

	tModule
			-- Assembly def
		once value := 0 end

	tTypeRef
			-- References to other assemblies
		once value := 1 end

	tTypeDef
			-- definitions of classes and enumerations
		once value := 2 end

	tField
			-- definitions of fields
		once value := 4 end

	tMethodDef
			-- definitions of methods once end includes both managed and unmanaged
		once value := 6 end

	tParam
			-- definitions of parameters
		once value := 8 end

	tInterfaceImpl once value := 9 end

	tMemberRef
			-- references to external methods once end also the call site references for vararg-style pinvokes
		once value := 10 end

	tConstant
			-- initialization constants once end we use them for enumerations but that is about it
		once value := 11 end

	tCustomAttribute
			-- custom attributes once end we use it for C# style varargs but nothing else
		once value := 12 end

	tFieldMarshal once value := 13 end

	tDeclSecurity
			-- we don't use it
		once value := 14 end

	tClassLayout
			-- size once end packing for classes
		once value := 15 end

	tFieldLayout
			-- field offsets once end we don't use it
		once value := 16 end

	tStandaloneSig
			--?? we don't use it
		once value := 17 end

	tEventMap once value := 18 end
	tEvent once value := 20 end
	tPropertyMap once value := 21 end
	tProperty once value := 23 end
	tMethodSemantics once value := 24 end
	tMethodImpl once value := 25 end

	tModuleRef
			--?? we don't use it
		once value := 26 end

	tTypeSpec
			-- we use it for referenced types not found in the typedef table
		once value := 27 end

	tImplMap
			-- pinvoke DLL information
		once value := 28 end

	tFieldRVA
			-- cildata RVAs for field initialized data
		once value := 29 end

	tAssemblyDef
			-- our main assembly
		once value := 32 end

	tAssemblyRef
			-- any external assemblies
		once value := 35 end

	tFile once value := 38 end
	tExportedType once value := 39 end
	tManifestResource once value := 40 end

	tNestedClass
			-- list of nested classes and their parents
		once value := 41 end

	tGenericParam once value := 42 end
	tMethodSpec once value := 43 end
	tGenericParamConstraint once value := 44 end

feature -- Value	

	value: NATURAL

feature -- Instances

	instances: ITERABLE [PE_TABLES]
			-- All known indexes to PE_TABLES.
		do
			Result := <<
					{PE_TABLES}.tModule,
					{PE_TABLES}.tTypeRef,
					{PE_TABLES}.tTypeDef,
					{PE_TABLES}.tField,
					{PE_TABLES}.tMethodDef,
					{PE_TABLES}.tParam,
					{PE_TABLES}.tInterfaceImpl,
					{PE_TABLES}.tMemberRef,
					{PE_TABLES}.tConstant,
					{PE_TABLES}.tCustomAttribute,
					{PE_TABLES}.tFieldMarshal,
					{PE_TABLES}.tDeclSecurity,
					{PE_TABLES}.tClassLayout,
					{PE_TABLES}.tFieldLayout,
					{PE_TABLES}.tStandaloneSig,
					{PE_TABLES}.tEventMap,
					{PE_TABLES}.tEvent,
					{PE_TABLES}.tPropertyMap,
					{PE_TABLES}.tProperty,
					{PE_TABLES}.tMethodSemantics,
					{PE_TABLES}.tMethodImpl,
					{PE_TABLES}.tModuleRef,
					{PE_TABLES}.tTypeSpec,
					{PE_TABLES}.tImplMap,
					{PE_TABLES}.tFieldRVA,
					{PE_TABLES}.tAssemblyDef,
					{PE_TABLES}.tAssemblyRef,
					{PE_TABLES}.tFile,
					{PE_TABLES}.tExportedType,
					{PE_TABLES}.tManifestResource,
					{PE_TABLES}.tNestedClass,
					{PE_TABLES}.tGenericParam,
					{PE_TABLES}.tMethodSpec,
					{PE_TABLES}.tGenericParamConstraint
				>>
		ensure
			instance_free: class
		end

	index_of (a_value: PE_TABLES): NATURAL_8
			-- Index of first occurrence of item identical to `a_value'.
			-- -1 if none.
		local
			l_area: SPECIAL [PE_TABLES]
		do
			l_area := (create {ARRAYED_LIST [PE_TABLES]}.make_from_iterable ({PE_TABLES}.instances)).area
			Result := l_area.index_of (a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end

end
