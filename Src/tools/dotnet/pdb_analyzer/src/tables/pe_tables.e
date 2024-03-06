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

	tModule: NATURAL_8 = 0x0
			-- Assembly def

	tTypeRef: NATURAL_8 = 0x1
			-- References to other assemblies

	tTypeDef: NATURAL_8 = 0x2
			-- definitions of classes and enumerations

	tFieldPointer: NATURAL_8 = 0x3
			-- UNDOCUMENTED

	tField: NATURAL_8 = 0x4
			-- definitions of fields


	tMethodPointer: NATURAL_8 = 0x5
			-- UNDOCUMENTED			

	tMethodDef: NATURAL_8 = 0x6
			-- definitions of methods once end includes both managed and unmanaged

	-- 7?

	tParam: NATURAL_8 = 0x8
			-- definitions of parameters

	tInterfaceImpl: NATURAL_8 = 0x9

	tMemberRef: NATURAL_8 = 0xA
			-- references to external methods once end also the call site references for vararg-style pinvokes

	tConstant: NATURAL_8 =  0xB
			-- initialization constants once end we use them for enumerations but that is about it

	tCustomAttribute: NATURAL_8 = 0xC
			-- custom attributes once end we use it for C# style varargs but nothing else

	tFieldMarshal: NATURAL_8 = 0xD

	tDeclSecurity: NATURAL_8 = 0xE
			-- we don't use it

	tClassLayout: NATURAL_8 = 0xF
			-- size once end packing for classes

	tFieldLayout: NATURAL_8 = 0x10
			-- field offsets once end we don't use it

	tStandaloneSig: NATURAL_8 = 0x11
			--?? we don't use it

	tEventMap: NATURAL_8 = 0x12

	-- 19?

	tEvent: NATURAL_8 = 0x14

	tPropertyMap: NATURAL_8 = 0x15

	--22?

	tProperty: NATURAL_8 = 0x17

	tMethodSemantics: NATURAL_8 = 0x18

	tMethodImpl: NATURAL_8 = 0x19

	tModuleRef: NATURAL_8 =  0x1A
			--?? we don't use it

	tTypeSpec: NATURAL_8 = 0x1B
			-- we use it for referenced types not found in the typedef table

	tImplMap: NATURAL_8 = 0x1C
			-- pinvoke DLL information

	tFieldRVA: NATURAL_8 = 0x1D
			-- cildata RVAs for field initialized data

	--30?
	--31?

	tAssemblyDef: NATURAL_8 = 0x20
			-- our main assembly
			-- 0x20

	--33?
	--34?

	tAssemblyRef: NATURAL_8 = 0x23
			-- any external assemblies

	tFile: NATURAL_8 = 0x26

	tExportedType: NATURAL_8 = 0x27

	tManifestResource: NATURAL_8 = 0x28

	tNestedClass: NATURAL_8 = 0x29
			-- list of nested classes and their parents

	tGenericParam: NATURAL_8 = 0x2A

	tMethodSpec: NATURAL_8 = 0x2B

	tGenericParamConstraint: NATURAL_8 = 0x2C

feature -- Instances

	valid (id: NATURAL_8): BOOLEAN
		do
			inspect id
			when
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
			then
				Result := True
			when tFieldPointer, tMethodPointer then
				Result := True
			else

			end
		ensure
			class
		end

end
