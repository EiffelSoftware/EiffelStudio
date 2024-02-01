note
	description: "[
					These are the indexes to the tables.   
					They are in order as they will appear in the PE file (if they do appear in the PE file)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TABLES

feature -- Creation Procedures

	tModule: NATURAL_32 = 0
			-- Assembly def

	tTypeRef: NATURAL_32 = 1
			-- References to other assemblies

	tTypeDef: NATURAL_32 = 2
			-- definitions of classes and enumerations

	tFieldPtr: NATURAL_32 = 3

	tField: NATURAL_32 = 4
			-- definitions of fields

	tMethodPtr: NATURAL_32 = 5

	tMethodDef: NATURAL_32 = 6
			-- definitions of methods once end includes both managed and unmanaged

	tParam: NATURAL_32 = 8
			-- definitions of parameters

	tInterfaceImpl: NATURAL_32 = 9

	tMemberRef: NATURAL_32 = 10
			-- references to external methods once end also the call site references for vararg-style pinvokes

	tConstant: NATURAL_32 = 11
			-- initialization constants once end we use them for enumerations but that is about it

	tCustomAttribute: NATURAL_32 = 12
			-- custom attributes once end we use it for C# style varargs but nothing else

	tFieldMarshal: NATURAL_32 = 13

	tDeclSecurity: NATURAL_32 = 14
			-- we don't use it

	tClassLayout: NATURAL_32 = 15
			-- size once end packing for classes

	tFieldLayout: NATURAL_32 = 16
			-- field offsets once end we don't use it

	tStandaloneSig: NATURAL_32 = 17
			--?? we don't use it

	tEventMap: NATURAL_32 = 18

	tEvent: NATURAL_32 = 20

	tPropertyMap: NATURAL_32 = 21

	tProperty: NATURAL_32 = 23

	tMethodSemantics: NATURAL_32 = 24

	tMethodImpl: NATURAL_32 = 25

	tModuleRef: NATURAL_32 = 26
			--?? we don't use it

	tTypeSpec: NATURAL_32 = 27
			-- we use it for referenced types not found in the typedef table

	tImplMap: NATURAL_32 = 28
			-- pinvoke DLL information

	tFieldRVA: NATURAL_32 = 29
			-- cildata RVAs for field initialized data

	tAssemblyDef: NATURAL_32 = 32
			-- our main assembly
			-- 0x20

	tAssemblyRef: NATURAL_32 = 35
			-- any external assemblies

	tFile: NATURAL_32 = 38

	tExportedType: NATURAL_32 = 39

	tManifestResource: NATURAL_32 = 40

	tNestedClass: NATURAL_32 = 41
			-- list of nested classes and their parents

	tGenericParam: NATURAL_32 = 42

	tMethodSpec: NATURAL_32 = 43

	tGenericParamConstraint: NATURAL_32 = 44



feature -- PDB tables

	tDocument: NATURAL_32 = 48
		-- The Document table


	tMethodDebugInformation: NATURAL_32 = 49


	tLocalScope: NATURAL_32 = 50


	tLocalVariable: NATURAL_32 = 51


	tLocalConstant: NATURAL_32 = 52

	tImportScope: NATURAL_32 = 53

	tStateMachineMethod: NATURAL_32 = 54

	tCustomDebugInformation: NATURAL_32 = 55


feature -- Instances

	instances: ITERABLE [NATURAL_32]
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

	index_of (a_value: NATURAL_32): NATURAL_8
			-- Index of first occurrence of item identical to `a_value'.
			-- -1 if none.
		local
			l_area: SPECIAL [NATURAL_32]
		do
			l_area := (create {ARRAYED_LIST [NATURAL_32]}.make_from_iterable ({PE_TABLES}.instances)).area
			Result := l_area.index_of (a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end

feature -- Helper

	tKnownTablesMask: NATURAL_64
			-- this is naively ignoring the various CIL tables that aren't supposed to be in the file
			-- may have to revisit that at some point.
		do
			Result := ({NATURAL_64} 1 |<< {PE_TABLES}.tModule.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tTypeRef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tTypeDef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tField.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tMethodDef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tParam.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tInterfaceImpl.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tMemberRef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tConstant.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tCustomAttribute.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tFieldMarshal.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tDeclSecurity.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tClassLayout.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tFieldLayout.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tStandaloneSig.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tEventMap.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tEvent.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tPropertyMap.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tProperty.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tMethodSemantics.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tMethodImpl.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tModuleRef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tTypeSpec.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tImplMap.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tFieldRVA.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tAssemblyDef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tAssemblyRef.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tFile.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tExportedType.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tManifestResource.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tNestedClass.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tGenericParam.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tMethodSpec.to_integer_32)
					| ({NATURAL_64} 1 |<< {PE_TABLES}.tGenericParamConstraint.to_integer_32)
		end

end
