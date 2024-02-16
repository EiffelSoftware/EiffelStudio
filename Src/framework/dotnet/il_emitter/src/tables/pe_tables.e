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

	tModule: NATURAL_32 = 0 -- 0x00
			-- Assembly def

	tTypeRef: NATURAL_32 = 1 -- 0x01
			-- References to other assemblies

	tTypeDef: NATURAL_32 = 2 -- 0x02
			-- definitions of classes and enumerations

	tFieldPtr: NATURAL_32 = 3 -- 0x03

	tField: NATURAL_32 = 4 -- 0x04
			-- definitions of fields

	tMethodPtr: NATURAL_32 = 5 -- 0x05

	tMethodDef: NATURAL_32 = 6 -- 0x06
			-- definitions of methods once end includes both managed and unmanaged

	tParam: NATURAL_32 = 8 -- 0x08
			-- definitions of parameters

	tInterfaceImpl: NATURAL_32 = 9 -- 0x09

	tMemberRef: NATURAL_32 = 10 -- 0x0A
			-- references to external methods once end also the call site references for vararg-style pinvokes

	tConstant: NATURAL_32 = 11 -- 0x0B
			-- initialization constants once end we use them for enumerations but that is about it

	tCustomAttribute: NATURAL_32 = 12 -- 0x0C
			-- custom attributes once end we use it for C# style varargs but nothing else

	tFieldMarshal: NATURAL_32 = 13 -- 0x0D

	tDeclSecurity: NATURAL_32 = 14 -- 0x0E
			-- we don't use it

	tClassLayout: NATURAL_32 = 15 -- 0x0F
			-- size once end packing for classes

	tFieldLayout: NATURAL_32 = 16 -- 0x10
			-- field offsets once end we don't use it

	tStandaloneSig: NATURAL_32 = 17 -- 0x11
			--?? we don't use it

	tEventMap: NATURAL_32 = 18 -- 0x12

	tEvent: NATURAL_32 = 20 -- 0x14

	tPropertyMap: NATURAL_32 = 21 -- 0x15

	tProperty: NATURAL_32 = 23 -- 0x17

	tMethodSemantics: NATURAL_32 = 24 -- 0x18

	tMethodImpl: NATURAL_32 = 25 -- 0x19

	tModuleRef: NATURAL_32 = 26 -- 0x1A
			--?? we don't use it

	tTypeSpec: NATURAL_32 = 27 -- 0x!B
			-- we use it for referenced types not found in the typedef table

	tImplMap: NATURAL_32 = 28 -- 0x1C
			-- pinvoke DLL information

	tFieldRVA: NATURAL_32 = 29 -- 0x1D
			-- cildata RVAs for field initialized data

	tAssemblyDef: NATURAL_32 = 32 -- 0x20
			-- our main assembly

	tAssemblyRef: NATURAL_32 = 35 -- 0x23
			-- any external assemblies

	tFile: NATURAL_32 = 38 -- 0x26

	tExportedType: NATURAL_32 = 39 -- 0x27

	tManifestResource: NATURAL_32 = 40 -- 0x28

	tNestedClass: NATURAL_32 = 41 -- 0x29
			-- list of nested classes and their parents

	tGenericParam: NATURAL_32 = 42 -- 0x2A

	tMethodSpec: NATURAL_32 = 43 -- 0x2B

	tGenericParamConstraint: NATURAL_32 = 44 -- 0x2C

feature -- Instances

	instances: ITERABLE [NATURAL_32]
			-- All known indexes to PE_TABLES.
		do
			Result := <<
					tModule,
					tTypeRef,
					tTypeDef,
					tField,
					tMethodDef,
					tParam,
					tInterfaceImpl,
					tMemberRef,
					tConstant,
					tCustomAttribute,
					tFieldMarshal,
					tDeclSecurity,
					tClassLayout,
					tFieldLayout,
					tStandaloneSig,
					tEventMap,
					tEvent,
					tPropertyMap,
					tProperty,
					tMethodSemantics,
					tMethodImpl,
					tModuleRef,
					tTypeSpec,
					tImplMap,
					tFieldRVA,
					tAssemblyDef,
					tAssemblyRef,
					tFile,
					tExportedType,
					tManifestResource,
					tNestedClass,
					tGenericParam,
					tMethodSpec,
					tGenericParamConstraint
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
			l_area := (create {ARRAYED_LIST [NATURAL_32]}.make_from_iterable (instances)).area
			Result := l_area.index_of (a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end

feature -- Helper

	tKnownTablesMask: NATURAL_64
			-- this is naively ignoring the various CIL tables that aren't supposed to be in the file
			-- may have to revisit that at some point.
		do
			Result := ({NATURAL_64} 1 |<< tModule.to_integer_32)
					| ({NATURAL_64} 1 |<< tTypeRef.to_integer_32)
					| ({NATURAL_64} 1 |<< tTypeDef.to_integer_32)
					| ({NATURAL_64} 1 |<< tField.to_integer_32)
					| ({NATURAL_64} 1 |<< tMethodDef.to_integer_32)
					| ({NATURAL_64} 1 |<< tParam.to_integer_32)
					| ({NATURAL_64} 1 |<< tInterfaceImpl.to_integer_32)
					| ({NATURAL_64} 1 |<< tMemberRef.to_integer_32)
					| ({NATURAL_64} 1 |<< tConstant.to_integer_32)
					| ({NATURAL_64} 1 |<< tCustomAttribute.to_integer_32)
					| ({NATURAL_64} 1 |<< tFieldMarshal.to_integer_32)
					| ({NATURAL_64} 1 |<< tDeclSecurity.to_integer_32)
					| ({NATURAL_64} 1 |<< tClassLayout.to_integer_32)
					| ({NATURAL_64} 1 |<< tFieldLayout.to_integer_32)
					| ({NATURAL_64} 1 |<< tStandaloneSig.to_integer_32)
					| ({NATURAL_64} 1 |<< tEventMap.to_integer_32)
					| ({NATURAL_64} 1 |<< tEvent.to_integer_32)
					| ({NATURAL_64} 1 |<< tPropertyMap.to_integer_32)
					| ({NATURAL_64} 1 |<< tProperty.to_integer_32)
					| ({NATURAL_64} 1 |<< tMethodSemantics.to_integer_32)
					| ({NATURAL_64} 1 |<< tMethodImpl.to_integer_32)
					| ({NATURAL_64} 1 |<< tModuleRef.to_integer_32)
					| ({NATURAL_64} 1 |<< tTypeSpec.to_integer_32)
					| ({NATURAL_64} 1 |<< tImplMap.to_integer_32)
					| ({NATURAL_64} 1 |<< tFieldRVA.to_integer_32)
					| ({NATURAL_64} 1 |<< tAssemblyDef.to_integer_32)
					| ({NATURAL_64} 1 |<< tAssemblyRef.to_integer_32)
					| ({NATURAL_64} 1 |<< tFile.to_integer_32)
					| ({NATURAL_64} 1 |<< tExportedType.to_integer_32)
					| ({NATURAL_64} 1 |<< tManifestResource.to_integer_32)
					| ({NATURAL_64} 1 |<< tNestedClass.to_integer_32)
					| ({NATURAL_64} 1 |<< tGenericParam.to_integer_32)
					| ({NATURAL_64} 1 |<< tMethodSpec.to_integer_32)
					| ({NATURAL_64} 1 |<< tGenericParamConstraint.to_integer_32)
		end

end
