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

	tFieldPointer: NATURAL_32 = 3
			-- UNDOCUMENTED

	tField: NATURAL_32 = 4
			-- definitions of fields


	tMethodPointer: NATURAL_32 = 5
			-- UNDOCUMENTED			

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

feature -- Instances

	valid (id: NATURAL_32): BOOLEAN
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
