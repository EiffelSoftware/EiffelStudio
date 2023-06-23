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

	tModule: NATURAL_8 = 0
			-- Assembly def

	tTypeRef: NATURAL_8 = 1
			-- References to other assemblies

	tTypeDef: NATURAL_8 = 2
			-- definitions of classes and enumerations

	tFieldPointer: NATURAL_8 = 3
			-- UNDOCUMENTED

	tField: NATURAL_8 = 4
			-- definitions of fields


	tMethodPointer: NATURAL_8 = 5
			-- UNDOCUMENTED			

	tMethodDef: NATURAL_8 = 6
			-- definitions of methods once end includes both managed and unmanaged

	tParam: NATURAL_8 = 8
			-- definitions of parameters

	tInterfaceImpl: NATURAL_8 = 9

	tMemberRef: NATURAL_8 = 10
			-- references to external methods once end also the call site references for vararg-style pinvokes

	tConstant: NATURAL_8 = 11
			-- initialization constants once end we use them for enumerations but that is about it

	tCustomAttribute: NATURAL_8 = 12
			-- custom attributes once end we use it for C# style varargs but nothing else

	tFieldMarshal: NATURAL_8 = 13

	tDeclSecurity: NATURAL_8 = 14
			-- we don't use it

	tClassLayout: NATURAL_8 = 15
			-- size once end packing for classes

	tFieldLayout: NATURAL_8 = 16
			-- field offsets once end we don't use it

	tStandaloneSig: NATURAL_8 = 17
			--?? we don't use it

	tEventMap: NATURAL_8 = 18

	tEvent: NATURAL_8 = 20

	tPropertyMap: NATURAL_8 = 21

	tProperty: NATURAL_8 = 23

	tMethodSemantics: NATURAL_8 = 24

	tMethodImpl: NATURAL_8 = 25

	tModuleRef: NATURAL_8 = 26
			--?? we don't use it

	tTypeSpec: NATURAL_8 = 27
			-- we use it for referenced types not found in the typedef table

	tImplMap: NATURAL_8 = 28
			-- pinvoke DLL information

	tFieldRVA: NATURAL_8 = 29
			-- cildata RVAs for field initialized data

	tAssemblyDef: NATURAL_8 = 32
			-- our main assembly
			-- 0x20

	tAssemblyRef: NATURAL_8 = 35
			-- any external assemblies

	tFile: NATURAL_8 = 38

	tExportedType: NATURAL_8 = 39

	tManifestResource: NATURAL_8 = 40

	tNestedClass: NATURAL_8 = 41
			-- list of nested classes and their parents

	tGenericParam: NATURAL_8 = 42

	tMethodSpec: NATURAL_8 = 43

	tGenericParamConstraint: NATURAL_8 = 44

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
