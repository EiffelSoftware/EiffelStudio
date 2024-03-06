note
	description: "[
					These are the indexes to the tables.   
					They are in order as they will appear in the PE file (if they do appear in the PE file)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_TABLES

feature -- PDB

	tDocument: NATURAL_8 = 48 -- 0x30
		-- The Document table

	tMethodDebugInformation: NATURAL_8 = 49 -- 0x31

	tLocalScope: NATURAL_8 = 50 -- 0x32

	tLocalVariable: NATURAL_8 = 51 -- 0x33

	tLocalConstant: NATURAL_8 = 52 -- 0x34

	tImportScope: NATURAL_8 = 53 -- 0x35

	tStateMachineMethod: NATURAL_8 = 54 -- 0x36

	tCustomDebugInformation: NATURAL_8 = 55 -- 0x37

feature -- Instances

	valid (id: NATURAL_8): BOOLEAN
		do
			inspect id
			when
--				tModule,
--				tTypeRef,
--				tTypeDef,
--				tField,
--				tMethodDef,
--				tParam,
--				tInterfaceImpl,
--				tMemberRef,
--				tConstant,
--				tCustomAttribute,
--				tFieldMarshal,
--				tDeclSecurity,
--				tClassLayout,
--				tFieldLayout,
--				tStandaloneSig,
--				tEventMap,
--				tEvent,
--				tPropertyMap,
--				tProperty,
--				tMethodSemantics,
--				tMethodImpl,
--				tModuleRef,
--				tTypeSpec,
--				tImplMap,
--				tFieldRVA,
--				tAssemblyDef,
--				tAssemblyRef,
--				tFile,
--				tExportedType,
--				tManifestResource,
--				tNestedClass,
--				tGenericParam,
--				tMethodSpec,
--				tGenericParamConstraint,
				-- PDB tables ..
				tDocument,
				tMethodDebugInformation,
				tLocalScope,
				tLocalVariable,
				tLocalConstant,
				tImportScope,
				tStateMachineMethod,
				tCustomDebugInformation
			then
				Result := True
--			when tFieldPointer, tMethodPointer then
--				Result := True
			else

			end
		ensure
			class
		end

end
