///////////////////////////////////////////////////////////////////////////////
// ISE_Compiler_GUID.h	: GUIDs for compiler interfaces/coclasses/enums etc...
//
// Last commit by       : $Author$
// Date                 : $Date$
// Revision             : $Revision$
//
// Notes                : Interfaces, enums and structs relating to ENViSioN! 2.0

// =========================================================================
//                                                              Library GUID

#define UUID_LIBEIFFELCOMPILER                  E1FFE1C0-2C7D-4D1C-A98B-4599BDCDFA58
#define MAJ_LIBEIFFELCOMPILER					5
#define MIN_LIBEIFFELCOMPILER					5
#define VER_LIBEIFFELCOMPILER					MAJ_LIBEIFFELCOMPILER.MIN_LIBEIFFELCOMPILER

// =========================================================================
//                                                           Proxy Stub GUID

#define UUID_EIFFELCOMPILERPS                   E1FFE10C-06F1-448E-A221-9C702B9DF685 // This GUID has to be the same as last interfaces in library!!!

// =========================================================================
//                                                              CoClass GUID

#define UUID_CEIFFELCOMPILER                    E1FFE1D7-9FDE-4260-9055-9AB7E92122CD
#define UUID_CEIFFELCOMPLETIONINFO				E1FFE150-3E39-4A44-A034-38F8B422D8DF
#define UUID_CEIFFELPROJECT                     E1FFE1BB-BA73-4D00-B0FE-352FC4127B9E
#define UUID_EIFFELHTMLDOCUMENTATIONGENERATOR	E1FFE19D-0455-4E0B-BD7D-FD9E7742761C

// =========================================================================
//                                                            Interface GUID

#define UUID_IEIFFELEXCEPTION                   E1FFE10C-06F1-448E-A221-9C702B9DF685 // Last interface in library
#define UUID_IEIFFELPROJECT                     E1FFE1EA-1AED-489B-9E8A-E35342582b2b
#define UUID_IEIFFELCOMPLETIONINFO              E1FFE139-EDAE-46B7-880B-27D68E7184fa
#define UUID_IEIFFELDEFINITIONRESULT            E1FFE1F0-F998-41E8-819D-7B802775F51F
#define UUID_IEIFFELDEFINITIONFEATURERESULT     E1FFE116-678C-403D-AB6E-C4F5254DD36D
#define UUID_IEIFFELCOMPLETIONENTRY             E1FFE15D-24B4-49A9-9CBC-6AFF6AEb6de3
#define UUID_IEIFFELCOMPILER                    E1FFE11B-A2E4-4F29-8891-AF2654B50b6b
#define UUID_IEIFFELCOMPILEREVENTS              E1FFE173-A00E-4BCF-9A7A-13D41E6359b4
#define UUID_IEIFFELSYSTEMBROWSER               E1FFE125-6F73-442C-9CAE-1B981414050d
#define UUID_IEIFFELCLUSTERDESCRIPTOR           E1FFE123-CEAC-44B5-B525-61ED0CEf0075
#define UUID_IEIFFELCLASSDESCRIPTOR             E1FFE1A8-26CA-44B5-9EE9-3A92BBBaebb0
#define UUID_IEIFFELFEATUREDESCRIPTOR           E1FFE181-6A69-43D5-AA40-51EEC3E2d19f
#define UUID_IEIFFELPROJECTPROPERTIES           E1FFE183-FD96-40CE-933E-5351E1B3E294
#define UUID_IEIFFELCLUSTERPROPERTIES           E1FFE195-2E13-4FDF-B82A-09BFCB46beea
#define UUID_IEIFFELSYSTEMEXTERNALS             E1FFE188-0FF6-407B-8956-FB416626b62a
#define UUID_IEIFFELSYSTEMASSEMBLIES            E1FFE1A0-B5F9-4110-A758-241A3BC95d52
#define UUID_IEIFFELASSEMBLYPROPERTIES          E1FFE1FF-7EC7-43A4-AEF4-D963EC2f9641
#define UUID_IEIFFELSYSTEMCLUSTERS              E1FFE15E-5467-4058-A999-1D35B905764e
#define UUID_IENUMEIFFELCLASS                   E1FFE17A-4C96-49D3-8236-85765E67c315
#define UUID_IENUMCLUSTER                       E1FFE1D5-C033-4F33-98A2-551D8451b8c4
#define UUID_IENUMFEATURE                       E1FFE149-6C17-4BE2-BD81-3D3540B738b1
#define UUID_IENUMCLUSTERPROP                   E1FFE166-8A44-40E1-A090-3E5CC36ca72d
#define UUID_IEIFFELENUMSTRING                  E1FFE11E-43E6-4654-A436-B5FA1997ea5b
#define UUID_IENUMASSEMBLY                      E1FFE1F4-B23B-45A9-B3B1-2E0E004ffb8d
#define UUID_IENUMCOMPLETIONENTRY               E1FFE1BD-9335-48D5-B75F-401F525afb76
#define UUID_IENUMPARAMETER                     E1FFE1FB-730C-498F-A168-418EE482a2d7
#define UUID_IEIFFELPARAMETERDESCRIPTOR         E1FFE192-D5EB-434B-9D21-EC3E4FF0058f
#define UUID_IEIFFELHTMLDOCUMENTATIONGENERATOR  E1FFE119-790F-48CB-8869-DB06184f97b4
#define UUID_IEIFFELHTMLDOCUMENTATIONEVENTS     E1FFE13E-ED26-4DED-AAFB-21FA8B28e879
#define UUID_IEIFFELSUPPORT						E1FFE14A-52C6-4692-B12E-49E0331E74FF
#define UUID_IEIFFELASSERTIONDESCRIPTOR			E1FFE185-EC30-4AF4-ADAA-509C7D6AF897
#define UUID_IENUMASSERTION						E1FFE1E7-B094-4C16-978C-56D480D4DDE0


// =========================================================================
//                                                                 Enum GUID

#define UUID_ENUMEIF_ASSERTIONS                     E1FFE1A1-488D-410D-A920-DB5A4921C1C1
#define UUID_ENUMEIF_CLUSTER_NAMESPACE_GENERATION   E1FFE108-5B25-4DBF-B02E-0A50107A99F9
#define UUID_ENUMEIF_COMPILATION_MODE               E1FFE10F-6FE8-445F-80DC-6FDF79E71356
#define UUID_ENUMEIF_COMPLETION_LOCATION            E1FFE12F-63E4-475F-89DC-6FAF39E773F6
#define UUID_ENUMEIF_ENTITY_IMAGES                  E1FFE106-0F87-4022-8312-D39BA4F13400
#define UUID_ENUMEIF_CLASS_IMAGES					E1FFE116-1287-98FC-43AD-D3F3245AC32B
#define UUID_ENUMEIF_EXCEPTIONS                     E1FFE1BE-FBD7-45B9-BFDB-2CE98417D347
#define UUID_ENUMEIF_FEATURE_TYPES                  E1FFE160-6829-444A-846B-DA5B9787A1FD
#define UUID_ENUMEIF_PROJECT_TYPES                  E1FFE1FB-DFF4-46B6-AEEC-DE988135025B

// =========================================================================
//                                                                 Constants

#define EIFFEL_BASE_DISPID  1

// =========================================================================
//                                                             Dispatch Id's

enum
{
    // NOTE: All comment out dispatch ID's are there only for reference. They have
    // already been defined earlier on in the enum.

    // IEiffelProject dispatch ID's

    DISPID_EiffelComCompiler_RetrieveEiffelProject = EIFFEL_BASE_DISPID,
    DISPID_EiffelComCompiler_CreateEiffelProject,
    DISPID_EiffelComCompiler_GenerateNewEiffelProject,
	DISPID_EiffelComCompiler_CreateInMemoryEiffelProject,
	DISPID_EiffelComCompiler_ProjectFileName,
    DISPID_EiffelComCompiler_AceFileName,
    DISPID_EiffelComCompiler_ProjectDirectory,
    DISPID_EiffelComCompiler_IsValidProject,
    DISPID_EiffelComCompiler_LastException,
    DISPID_EiffelComCompiler_Compiler,
    DISPID_EiffelComCompiler_IsCompiled,
    DISPID_EiffelComCompiler_ProjectHasUpdated,
    DISPID_EiffelComCompiler_SystemBrowser,
    DISPID_EiffelComCompiler_ProjectProperties,
    DISPID_EiffelComCompiler_CompletionInformation,
    DISPID_EiffelComCompiler_HtmlDocumentationGenerator,
    DISPID_EiffelComCompiler_Support,

    // IEiffelProjectProperties dispatch ID's

    DISPID_EiffelComCompiler_SystemName,
    DISPID_EiffelComCompiler_RootClassName,
    DISPID_EiffelComCompiler_CreationRoutine,
    DISPID_EiffelComCompiler_NamespaceGeneration,
    DISPID_EiffelComCompiler_DefaultNamespace,
    DISPID_EiffelComCompiler_ProjectType,
    DISPID_EiffelComCompiler_TargetClrVersion,
    DISPID_EiffelComCompiler_DotNetNamingConvention,
    DISPID_EiffelComCompiler_GenerateDebugInfo,
    DISPID_EiffelComCompiler_PrecompiledLibrary,
    DISPID_EiffelComCompiler_Assertions,
    DISPID_EiffelComCompiler_Clusters,
    DISPID_EiffelComCompiler_Externals,
    DISPID_EiffelComCompiler_Assemblies,
    DISPID_EiffelComCompiler_Title,
    DISPID_EiffelComCompiler_Description,
    DISPID_EiffelComCompiler_Company,
    DISPID_EiffelComCompiler_Product,
    DISPID_EiffelComCompiler_Version,
    DISPID_EiffelComCompiler_Trademark,
    DISPID_EiffelComCompiler_Copyright,
    DISPID_EiffelComCompiler_Culture,
    DISPID_EiffelComCompiler_KeyFileName,
    DISPID_EiffelComCompiler_WorkingDirectory,
    DISPID_EiffelComCompiler_MetadataCachePath,
    DISPID_EiffelComCompiler_Apply,

    // IEiffelCompiler dispatch ID's

    DISPID_EiffelComCompiler_CompilerVersion,
    DISPID_EiffelComCompiler_HasSignableGeneration,
    DISPID_EiffelComCompiler_CanRun,
    DISPID_EiffelComCompiler_Compile,
    DISPID_EiffelComCompiler_CompileToPipe,
    DISPID_EiffelComCompiler_WasCompilationSuccessful,
    DISPID_EiffelComCompiler_FreezingOccurred,
    DISPID_EiffelComCompiler_FreezeCommandName,
    DISPID_EiffelComCompiler_FreezeCommandArguments,
    DISPID_EiffelComCompiler_RemoveFileLocks,
    DISPID_EiffelComCompiler_DisplayWarnings,
    DISPID_EiffelComCompiler_DiscardAssertions,
    DISPID_EiffelComCompiler_GenerateMsilKeyFileName,
	DISPID_EiffelComCompiler_SetQuickFinalization,

    // IEiffelCompilerEvents dispatch ID's

    DISPID_EiffelComCompiler_BeginCompile,
    DISPID_EiffelComCompiler_BeginDegree,
    DISPID_EiffelComCompiler_EndCompile,
    DISPID_EiffelComCompiler_ShouldContinue,
    DISPID_EiffelComCompiler_OutputString,
    DISPID_EiffelComCompiler_OutputError,
    DISPID_EiffelComCompiler_OutputWarning,

	// IEiffelDefinitionResult dispatch ID's

	DISPID_EiffelComCompiler_ModuleName,
	DISPID_EiffelComCompiler_Namespace,
	DISPID_EiffelComCompiler_ClassDescriptor,

	// IEiffelDefinitionFeatureResult dispatch ID's

	DISPID_EiffelComCompiler_FeatureDescriptor,

    // IEiffelCompletionInfo dispatch ID's

    DISPID_EiffelComCompiler_AddLocal,
    DISPID_EiffelComCompiler_AddArgument,
    DISPID_EiffelComCompiler_FlushLocals,
    DISPID_EiffelComCompiler_FlushArguments,
    DISPID_EiffelComCompiler_TargetClasses,
    DISPID_EiffelComCompiler_TargetFeatures,
    DISPID_EiffelComCompiler_TargetFeature,
    DISPID_EiffelComCompiler_FindClassDefinition,
    DISPID_EiffelComCompiler_FindFeatureDefinition,
    DISPID_EiffelComCompiler_FlushCompletionFeatures,
    DISPID_EiffelComCompiler_InitializeFeature,
    DISPID_EiffelComCompiler_SetupRenameTables,

    // IEiffelHtmlDocumentationGenerator dispatch ID's

    DISPID_EiffelComCompiler_AddIncludedCluster,
    DISPID_EiffelComCompiler_RemoveIncludedCluster,
    DISPID_EiffelComCompiler_StartGeneration,
    DISPID_EiffelComCompiler_AdviseStatusCallback,
    DISPID_EiffelComCompiler_UnadviseStatusCallback,

    // IEiffelHtmlDocumentationEvents dispatch ID's

    DISPID_EiffelComCompiler_NotifyInitalizingDocumentation,
    DISPID_EiffelComCompiler_NotifyPercentageComplete,
    DISPID_EiffelComCompiler_OutputHeader,
    // DISPID_EiffelComCompiler_OutputString,
    DISPID_EiffelComCompiler_OutputClassDocumentMessage,
    // DISPID_EiffelComCompiler_ShouldContinue,

    // IEiffelSystemBrowser dispatch ID's

    DISPID_EiffelComCompiler_SystemClasses,
    DISPID_EiffelComCompiler_ClassCount,
    DISPID_EiffelComCompiler_SystemClusters,
    DISPID_EiffelComCompiler_ExternalClusters,
    // DISPID_EiffelComCompiler_Assemblies,
    DISPID_EiffelComCompiler_ClusterCount,
    DISPID_EiffelComCompiler_RootCluster,
    DISPID_EiffelComCompiler_ClusterDescriptor,
    //DISPID_EiffelComCompiler_ClassDescriptor,
    //DISPID_EiffelComCompiler_FeatureDescriptor,
    DISPID_EiffelComCompiler_SearchClasses,
    DISPID_EiffelComCompiler_SearchFeatures,
    DISPID_EiffelComCompiler_DescriptionFromDotnetType,
    DISPID_EiffelComCompiler_DescriptionFromDotnetFeature,

    // IEnumCluster dispatch ID's

    DISPID_EiffelComCompiler_Next,
    DISPID_EiffelComCompiler_Skip,
    DISPID_EiffelComCompiler_Reset,
    DISPID_EiffelComCompiler_Clone,
    DISPID_EiffelComCompiler_IthItem,
    DISPID_EiffelComCompiler_Count,

    // IEiffelClusterDescriptor dispatch ID's

    DISPID_EiffelComCompiler_Name,
    // DISPID_EiffelComCompiler_Description,
    DISPID_EiffelComCompiler_ToolTip,
    DISPID_EiffelComCompiler_Classes,
    // DISPID_EiffelComCompiler_ClassCount,
    // DISPID_EiffelComCompiler_Clusters,
    // DISPID_EiffelComCompiler_ClusterCount,
    DISPID_EiffelComCompiler_ClusterPath,
    DISPID_EiffelComCompiler_RelativePath,
    DISPID_EiffelComCompiler_IsOverrideCluster,
    DISPID_EiffelComCompiler_IsLibrary,
    DISPID_EiffelComCompiler_Parent,

    // IEnumEiffelClass dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelClassDescriptor dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    // DISPID_EiffelComCompiler_Description,
    DISPID_EiffelComCompiler_Summary,
    DISPID_EiffelComCompiler_ExternalName,
    // DISPID_EiffelComCompiler_ToolTip,
    DISPID_EiffelComCompiler_IsInSystem,
    DISPID_EiffelComCompiler_FeatureNames,
    DISPID_EiffelComCompiler_Features,
    DISPID_EiffelComCompiler_FeatureCount,
    DISPID_EiffelComCompiler_FlatFeatures,
    DISPID_EiffelComCompiler_FlatFeatureCount,
    DISPID_EiffelComCompiler_InheritedFeatures,
    DISPID_EiffelComCompiler_InheritedFeatureCount,
    DISPID_EiffelComCompiler_CreationRoutines,
    DISPID_EiffelComCompiler_CreationRoutineCount,
    DISPID_EiffelComCompiler_Clients,
    DISPID_EiffelComCompiler_ClientCount,
    DISPID_EiffelComCompiler_Suppliers,
    DISPID_EiffelComCompiler_SupplierCount,
    DISPID_EiffelComCompiler_Ancestors,
    DISPID_EiffelComCompiler_AncestorCount,
    DISPID_EiffelComCompiler_Descendants,
    DISPID_EiffelComCompiler_DescendantCount,
    DISPID_EiffelComCompiler_ClassPath,
    DISPID_EiffelComCompiler_IsDeferred,
    DISPID_EiffelComCompiler_IsExternal,
    DISPID_EiffelComCompiler_IsTrueExternal,
    DISPID_EiffelComCompiler_IsGeneric,
    // DISPID_EiffelComCompiler_IsLibrary,
    DISPID_EiffelComCompiler_IsExpanded,
    DISPID_EiffelComCompiler_IsFrozen,
    DISPID_EiffelComCompiler_MemberOf,

	// IEiffelAssertionDescriptor dispatch ID's

	DISPID_EiffelComCompiler_Tag,
	DISPID_EiffelComCompiler_Expressions,


    // IEnumFeature dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelFeatureDescriptor dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    // DISPID_EiffelComCompiler_ExternalName,
    DISPID_EiffelComCompiler_WrittenClass,
    DISPID_EiffelComCompiler_EvaluatedClass,
    DISPID_EiffelComCompiler_Signature,
    // DISPID_EiffelComCompiler_Description,
	//DISPID_EiffelComCompiler_Summary,
    DISPID_EiffelComCompiler_Parameters,
    DISPID_EiffelComCompiler_ReturnType,
    DISPID_EiffelComCompiler_Exports,
    DISPID_EiffelComCompiler_FeatureLocation,
    DISPID_EiffelComCompiler_AllCallers,
    DISPID_EiffelComCompiler_AllCallersCount,
    DISPID_EiffelComCompiler_LocalCallers,
    DISPID_EiffelComCompiler_LocalCallersCount,
    DISPID_EiffelComCompiler_DescendantCallers,
    DISPID_EiffelComCompiler_DescendantCallersCount,
    DISPID_EiffelComCompiler_Implementers,
    DISPID_EiffelComCompiler_ImplementersCount,
    DISPID_EiffelComCompiler_AncestorVersions,
    DISPID_EiffelComCompiler_AncestorVersionsCount,
    DISPID_EiffelComCompiler_DescendantVersions,
    DISPID_EiffelComCompiler_DescendantVersionsCount,
    DISPID_EiffelComCompiler_ExportedToAll,
    DISPID_EiffelComCompiler_IsOnce,
    // DISPID_EiffelComCompiler_IsExternal,
    // DISPID_EiffelComCompiler_IsDeferred,
    DISPID_EiffelComCompiler_IsConstant,
    //DISPID_EiffelComCompiler_IsFrozen,
    DISPID_EiffelComCompiler_IsInfix,
    DISPID_EiffelComCompiler_IsPrefix,
    DISPID_EiffelComCompiler_IsAttribute,
    DISPID_EiffelComCompiler_IsProcedure,
    DISPID_EiffelComCompiler_IsFunction,
    DISPID_EiffelComCompiler_IsUnique,
    DISPID_EiffelComCompiler_IsObsolete,
    DISPID_EiffelComCompiler_ObsoleteMessage,
    DISPID_EiffelComCompiler_HasPrecondition,
	DISPID_EiffelComCompiler_Postconditions,
    DISPID_EiffelComCompiler_HasPostcondition,
    DISPID_EiffelComCompiler_Preconditions,

    // IEnumParameter dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelParameterDescriptor dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    DISPID_EiffelComCompiler_Type,
    DISPID_EiffelComCompiler_Display,

    // IEiffelSystemClusters dispatch ID's

    DISPID_EiffelComCompiler_GetClusterTree,
    DISPID_EiffelComCompiler_GetAllClusters,
    DISPID_EiffelComCompiler_GetClusterFullName,
    DISPID_EiffelComCompiler_GetClusterFullNamespace,
    DISPID_EiffelComCompiler_GetClusterProperties,
    DISPID_EiffelComCompiler_GetClusterPropertiesById,
    DISPID_EiffelComCompiler_ChangeClusterName,
    DISPID_EiffelComCompiler_AddCluster,
    DISPID_EiffelComCompiler_RemoveCluster,
    DISPID_EiffelComCompiler_StoreClusters,
    DISPID_EiffelComCompiler_IsClusterNameAvailable,
    DISPID_EiffelComCompiler_IsValidClusterName,

    // IEnumClusterProp dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelClusterProperties dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    // DISPID_EiffelComCompiler_ClusterPath,
    DISPID_EiffelComCompiler_Override,
    // DISPID_EiffelComCompiler_IsLibrary,
    DISPID_EiffelComCompiler_All,
    DISPID_EiffelComCompiler_UseSystemDefault,
    DISPID_EiffelComCompiler_EvaluateRequireByDefault,
    DISPID_EiffelComCompiler_EvaluateEnsureByDefault,
    DISPID_EiffelComCompiler_EvaluateCheckByDefault,
    DISPID_EiffelComCompiler_EvaluateLoopByDefault,
    DISPID_EiffelComCompiler_EvaluateInvariantByDefault,
    DISPID_EiffelComCompiler_SetAssertions,
    DISPID_EiffelComCompiler_Excluded,
    DISPID_EiffelComCompiler_AddExclude,
    DISPID_EiffelComCompiler_RemoveExclude,
    DISPID_EiffelComCompiler_ParentName,
    DISPID_EiffelComCompiler_HasParent,
    DISPID_EiffelComCompiler_Subclusters,
    DISPID_EiffelComCompiler_HasChildren,
    DISPID_EiffelComCompiler_ClusterId,
    DISPID_EiffelComCompiler_IsEiffelLibrary,
    DISPID_EiffelComCompiler_ExpandedClusterPath,
    DISPID_EiffelComCompiler_ClusterNamespace,
    DISPID_EiffelComCompiler_AddVisible,
    DISPID_EiffelComCompiler_RemoveVisible,

    // IEnumClusterExcludes dispatch ID's

    // DISPID_EiffelComCompiler_Next
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelSystemExternals dispatch ID's

    DISPID_EiffelComCompiler_AddIncludePath,
    DISPID_EiffelComCompiler_RemoveIncludePath,
    DISPID_EiffelComCompiler_ReplaceIncludePath,
    DISPID_EiffelComCompiler_IncludePaths,
    DISPID_EiffelComCompiler_AddObjectFile,
    DISPID_EiffelComCompiler_RemoveObjectFile,
    DISPID_EiffelComCompiler_ReplaceObjectFile,
    DISPID_EiffelComCompiler_ObjectFiles,
    DISPID_EiffelComCompiler_AddDotnetResource,
    DISPID_EiffelComCompiler_RemoveDotnetResource,
    DISPID_EiffelComCompiler_ReplaceDotnetResource,
    DISPID_EiffelComCompiler_DotnetResources,
    DISPID_EiffelComCompiler_Store,

    // IEnumIncludePaths dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEnumObjectFiles dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelSystemAssemblies dispatch ID's

    DISPID_EiffelComCompiler_FlushAssemblies,
    DISPID_EiffelComCompiler_AddAssembly,
    DISPID_EiffelComCompiler_AddFusionAssembly,
    // DISPID_EiffelComCompiler_Assemblies,
    // DISPID_EiffelComCompiler_LastException,
    // DISPID_EiffelComCompiler_Store,

    // IEnumAssembly dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelAssemblyProperties dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    // DISPID_EiffelComCompiler_Version,
    // DISPID_EiffelComCompiler_Culture,
    DISPID_EiffelComCompiler_PublicKeyToken,
    DISPID_EiffelComCompiler_IsLocal,
    DISPID_EiffelComCompiler_ClusterName,
    DISPID_EiffelComCompiler_Prefix,
    DISPID_EiffelComCompiler_IsPrefixReadOnly,

    // IEiffelException dispatch ID's

    DISPID_EiffelComCompiler_InnerException,
    DISPID_EiffelComCompiler_Message,
    DISPID_EiffelComCompiler_ExceptionCode,

    // IEiffelSupport dispatch ID's
    DISPID_EiffelComCompiler_ExpandPath,
    DISPID_EiffelComCompiler_EiffelClassNameToDotnetName,
	DISPID_EiffelComCompiler_GetProcessId
};

//|--------------------------------------------------------------------
//| EiffelEnvision: A Visual Studio .NET plugin from Eiffel Software.
//| Copyright (C) 2001-2005 Eiffel Software
//| Eiffel Software Confidential
//| All rights reserved. Duplication and distribution prohibited.
//|
//| Eiffel Software
//| 356 Storke Road, Goleta, CA 93117 USA
//| http://www.eiffel.com
//|--------------------------------------------------------------------