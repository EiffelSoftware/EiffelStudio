///////////////////////////////////////////////////////////////////////////////
// ISE.Compiler.h		: Interface definitions for COM Compiler
//
// Last commit by		: $Author$
// Date					: $Date$
// Revision				: $Revision$
//
// Notes				: Interfaces, enums and structs relating to ENViSioN! 2.0

#ifndef __ISE_COMPILER_H__
#define __ISE_COMPILER_H__

// =========================================================================
//                                                              Library GUID

#define UUID_LibEiffelCompiler					06b5d7c0-2c7d-4d1c-a98b-4599bdcdfa58

// =========================================================================
//                                                              CoClass GUID

#define UUID_CEiffelProject						5b4a07bb-ba73-4d00-b0fe-352fc4127b9e
#define UUID_CEiffelCompiler					ca54edd7-9fde-4260-9055-9ab7e92122cd
#define UUID_CEiffelCompletionInfo				bca3e550-3e39-4a44-a034-38f8b422d8df

// =========================================================================
//                                                            Interface GUID

#define UUID_IEiffelException					fc94930c-06f1-448e-a221-9c702b9df685
#define UUID_IEiffelProject						3afea5ea-1aed-489b-9e8a-e35342582b2b
#define UUID_IEiffelCompletionInfo				8630e639-edae-46b7-880b-27d68e7184fa
#define UUID_IEiffelCompletionEntry				1da1355d-24b4-49a9-9cbc-6aff6aeb6de3
#define UUID_IEiffelCompiler					51b87f1b-a2e4-4f29-8891-af2654b50b6b
#define UUID_IEiffelCompilerEvents				75b32e73-a00e-4bcf-9a7a-13d41e6359b4
#define UUID_IEiffelSystemBrowser				afb76625-6f73-442c-9cae-1b981414050d
#define UUID_IEiffelClusterDescriptor			09cc4e23-ceac-44b5-b525-61ed0cef0075
#define UUID_IEiffelClassDescriptor				db9131a8-26ca-44b5-9ee9-3a92bbbaebb0
#define UUID_IEiffelFeatureDescriptor			75550181-6a69-43d5-aa40-51eec3e2d19f
#define UUID_IEiffelProjectProperties			635bcc83-fd96-40ce-933e-5351e1b3e294
#define UUID_IEiffelClusterProperties			64f0d395-2e13-4fdf-b82a-09bfcb46beea
#define UUID_IEiffelSystemExternals				ea511e88-0ff6-407b-8956-fb416626b62a
#define UUID_IEiffelSystemAssemblies			9cf82ea0-b5f9-4110-a758-241a3bc95d52
#define UUID_IEiffelAssemblyProperties			d58175ff-7ec7-43a4-aef4-d963ec2f9641
#define UUID_IEiffelSystemClusters				cd49d55e-5467-4058-a999-1d35b905764e
#define UUID_IEnumEiffelClass					61e3d67a-4c96-49d3-8236-85765e67c315
#define UUID_IEnumCluster						7a252ad5-c033-4f33-98a2-551d8451b8c4
#define UUID_IEnumFeature						dc003e49-6c17-4be2-bd81-3d3540b738b1
#define UUID_IEnumClusterProp					c5b13566-8a44-40e1-a090-3e5cc36ca72d
#define UUID_IEnumClusterExcludes				3ec7ebb4-bb85-42fe-adc1-b301a8a0b79c
#define UUID_IEnumIncludePaths					95f826bf-331d-4f84-8053-e1b4ded312d8
#define UUID_IEnumObjectFiles					99ec369f-3cc2-4b78-a9a3-cba25388f182
#define UUID_IEnumAssembly						b8a7d9f4-b23b-45a9-b3b1-2e0e004ffb8d
#define UUID_IEnumCompletionEntry				7081edbd-9335-48d5-b75f-401f525afb76
#define UUID_IEnumParameter						e3ab1afb-730c-498f-a168-418ee482a2d7
#define UUID_IEiffelParameterDescriptor			7857e992-d5eb-434b-9d21-ec3e4ff0058f
#define UUID_IEiffelHtmlDocumentationGenerator	86270519-790f-48cb-8869-db06184f97b4
#define UUID_IEiffelHtmlDocumentationEvents		b120763e-ed26-4ded-aafb-21fa8b28e879

// =========================================================================
//                                                                 Enum GUID

#define UUID_EnumEIF_ENTITY_IMAGES					032cbd06-0f87-4022-8312-d39ba4f13400
#define UUID_EnumEIF_FEATURE_TYPES					5c676a60-6829-444a-846b-da5b9787a1fd
#define UUID_EnumEIF_EXCEPTIONS						07f5d6be-fbd7-45b9-bfdb-2ce98417d347
#define UUID_EnumEIF_PROJECT_TYPES					168468fb-dff4-46b6-aeec-de988135025b
#define UUID_EnumEIF_ASSERTIONS						af5ce2a1-488d-410d-a920-db5a4921c1c1
#define UUID_EnumEIF_CLUSTER_NAMESPACE_GENERATION	1cb05808-5b25-4dbf-b02e-0a50107a99f9
#define UUID_EnumEIF_COMPILATION_MODE				fcdaf70f-6fe8-445f-80dc-6fdf79e71356

// =========================================================================
//                                                                 Constants

#define EIFFEL_BASE_DISPID  10000

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