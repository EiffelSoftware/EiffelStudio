///////////////////////////////////////////////////////////////////////////////
// ISE.Compiler.h       : Interface definitions for COM Compiler
//
// Last commit by       : $Author$
// Date                 : $Date$
// Revision             : $Revision$
//
// Notes                : Interfaces, enums and structs relating to ENViSioN! 2.0

#ifndef __ISE_COMPILER_H__
#define __ISE_COMPILER_H__

// =========================================================================
//                                                              Library GUID

#define UUID_LibEiffelCompiler                  e1ffe1c0-2c7d-4d1c-a98b-4599bdcdfa58

// =========================================================================
//                                                           Proxy Stub GUID

#define UUID_EiffelCompilerPS                   e1ffe11e-43e6-4654-a436-b5fa1997ea5b // This GUID has to be the same as first interfaces IDL!!!

// =========================================================================
//                                                              CoClass GUID

#define UUID_CEiffelProject                     e1ffe1bb-ba73-4d00-b0fe-352fc4127b9e
#define UUID_CEiffelCompiler                    e1ffe1d7-9fde-4260-9055-9ab7e92122cd
#define UUID_CEiffelCompletionInfo              e1ffe150-3e39-4a44-a034-38f8b422d8df

// =========================================================================
//                                                            Interface GUID

#define UUID_IEiffelException                   e1ffe10c-06f1-448e-a221-9c702b9df685
#define UUID_IEiffelProject                     e1ffe1ea-1aed-489b-9e8a-e35342582b2b
#define UUID_IEiffelCompletionInfo              e1ffe139-edae-46b7-880b-27d68e7184fa
#define UUID_IEiffelCompletionEntry             e1ffe15d-24b4-49a9-9cbc-6aff6aeb6de3
#define UUID_IEiffelCompiler                    e1ffe11b-a2e4-4f29-8891-af2654b50b6b
#define UUID_IEiffelCompilerEvents              e1ffe173-a00e-4bcf-9a7a-13d41e6359b4
#define UUID_IEiffelSystemBrowser               e1ffe125-6f73-442c-9cae-1b981414050d
#define UUID_IEiffelClusterDescriptor           e1ffe123-ceac-44b5-b525-61ed0cef0075
#define UUID_IEiffelClassDescriptor             e1ffe1a8-26ca-44b5-9ee9-3a92bbbaebb0
#define UUID_IEiffelFeatureDescriptor           e1ffe181-6a69-43d5-aa40-51eec3e2d19f
#define UUID_IEiffelProjectProperties           e1ffe183-fd96-40ce-933e-5351e1b3e294
#define UUID_IEiffelClusterProperties           e1ffe195-2e13-4fdf-b82a-09bfcb46beea
#define UUID_IEiffelSystemExternals             e1ffe188-0ff6-407b-8956-fb416626b62a
#define UUID_IEiffelSystemAssemblies            e1ffe1a0-b5f9-4110-a758-241a3bc95d52
#define UUID_IEiffelAssemblyProperties          e1ffe1ff-7ec7-43a4-aef4-d963ec2f9641
#define UUID_IEiffelSystemClusters              e1ffe15e-5467-4058-a999-1d35b905764e
#define UUID_IEnumEiffelClass                   e1ffe17a-4c96-49d3-8236-85765e67c315
#define UUID_IEnumCluster                       e1ffe1d5-c033-4f33-98a2-551d8451b8c4
#define UUID_IEnumFeature                       e1ffe149-6c17-4be2-bd81-3d3540b738b1
#define UUID_IEnumClusterProp                   e1ffe166-8a44-40e1-a090-3e5cc36ca72d
#define UUID_IEiffelEnumString                  e1ffe11e-43e6-4654-a436-b5fa1997ea5b // This is the first interface.
#define UUID_IEnumAssembly                      e1ffe1f4-b23b-45a9-b3b1-2e0e004ffb8d
#define UUID_IEnumCompletionEntry               e1ffe1bd-9335-48d5-b75f-401f525afb76
#define UUID_IEnumParameter                     e1ffe1fb-730c-498f-a168-418ee482a2d7
#define UUID_IEiffelParameterDescriptor         e1ffe192-d5eb-434b-9d21-ec3e4ff0058f
#define UUID_IEiffelHtmlDocumentationGenerator  e1ffe119-790f-48cb-8869-db06184f97b4
#define UUID_IEiffelHtmlDocumentationEvents     e1ffe13e-ed26-4ded-aafb-21fa8b28e879

// =========================================================================
//                                                                 Enum GUID

#define UUID_EnumEIF_ENTITY_IMAGES                  e1ffe106-0f87-4022-8312-d39ba4f13400
#define UUID_EnumEIF_FEATURE_TYPES                  e1ffe160-6829-444a-846b-da5b9787a1fd
#define UUID_EnumEIF_EXCEPTIONS                     e1ffe1be-fbd7-45b9-bfdb-2ce98417d347
#define UUID_EnumEIF_PROJECT_TYPES                  e1ffe1fb-dff4-46b6-aeec-de988135025b
#define UUID_EnumEIF_ASSERTIONS                     e1ffe1a1-488d-410d-a920-db5a4921c1c1
#define UUID_EnumEIF_CLUSTER_NAMESPACE_GENERATION   e1ffe108-5b25-4dbf-b02e-0a50107a99f9
#define UUID_EnumEIF_COMPILATION_MODE               e1ffe10f-6fe8-445f-80dc-6fdf79e71356
#define UUID_EnumEIF_COMPLETION_LOCATION            e1ffe12f-63e4-475f-89dc-6faf39e773f6

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
    DISPID_EiffelComCompiler_ExpandPath,
    DISPID_EiffelComCompiler_GenerateMsilKeyFileName,

    // IEiffelCompilerEvents dispatch ID's

    DISPID_EiffelComCompiler_BeginCompile,
    DISPID_EiffelComCompiler_BeginDegree,
    DISPID_EiffelComCompiler_EndCompile,
    DISPID_EiffelComCompiler_ShouldContinue,
    DISPID_EiffelComCompiler_OutputString,
    DISPID_EiffelComCompiler_OutputError,
    DISPID_EiffelComCompiler_OutputWarning,

    // IEiffelCompletionInfo dispatch ID's

    DISPID_EiffelComCompiler_AddLocal,
    DISPID_EiffelComCompiler_AddArgument,
    DISPID_EiffelComCompiler_TargetFeatures,
    DISPID_EiffelComCompiler_TargetFeature,
    DISPID_EiffelComCompiler_ParseSourceForExpr,
    DISPID_EiffelComCompiler_FindDefinition,
    DISPID_EiffelComCompiler_FindInheritedDefinition,
    DISPID_EiffelComCompiler_FlushCompletionFeatures,
    DISPID_EiffelComCompiler_InitializeFeature,
    DISPID_EiffelComCompiler_SetupRenameTables,

    // IEiffelHtmlDocumentationGenerator dispatch ID's

    DISPID_EiffelComCompiler_AddExcludedCluster,
    DISPID_EiffelComCompiler_RemoveExcludedCluster,
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
    DISPID_EiffelComCompiler_ClassDescriptor,
    DISPID_EiffelComCompiler_FeatureDescriptor,
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
    DISPID_EiffelComCompiler_IsGeneric,
    // DISPID_EiffelComCompiler_IsLibrary,

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
    DISPID_EiffelComCompiler_Parameters,
    DISPID_EiffelComCompiler_ReturnType,
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
    DISPID_EiffelComCompiler_IsFrozen,
    DISPID_EiffelComCompiler_IsInfix,
    DISPID_EiffelComCompiler_IsPrefix,
    DISPID_EiffelComCompiler_IsAttribute,
    DISPID_EiffelComCompiler_IsProcedure,
    DISPID_EiffelComCompiler_IsFunction,
    DISPID_EiffelComCompiler_IsUnique,
    DISPID_EiffelComCompiler_IsObsolete,
    DISPID_EiffelComCompiler_HasPrecondition,
    DISPID_EiffelComCompiler_HasPostcondition,

    // IEnumParameter dispatch ID's

    // DISPID_EiffelComCompiler_Next,
    // DISPID_EiffelComCompiler_Skip,
    // DISPID_EiffelComCompiler_Reset,
    // DISPID_EiffelComCompiler_Clone,
    // DISPID_EiffelComCompiler_IthItem,
    // DISPID_EiffelComCompiler_Count,

    // IEiffelParameterDescriptor dispatch ID's

    // DISPID_EiffelComCompiler_Name,
    DISPID_EiffelComCompiler_Display,

    // IEiffelSystemClusters dispatch ID's

    DISPID_EiffelComCompiler_GetClusterTree,
    DISPID_EiffelComCompiler_GetAllClusters,
    DISPID_EiffelComCompiler_GetClusterFullName,
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
    DISPID_EiffelComCompiler_ExceptionCode
};


#endif

//|--------------------------------------------------------------------
//| Eiffel ENViSioN!: A Visual Studio .NET plugin from Eiffel Software.
//| Copyright (C) 2001-2003 Eiffel Software
//| Eiffel Software Confidential
//| All rights reserved. Duplication and distribution prohibited.
//|
//| Eiffel Software
//| 356 Storke Road, Goleta, CA 93117 USA
//| http://www.eiffel.com
//|--------------------------------------------------------------------