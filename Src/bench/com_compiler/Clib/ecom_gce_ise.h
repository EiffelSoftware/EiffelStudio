/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GCE_ISE_H__
#define __ECOM_GCE_ISE_H__
#ifdef __cplusplus
extern "C" {


class ecom_gce_ISE;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_s.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_s.h"

#include "ecom_eiffel_compiler_IEnumEiffelClass_s.h"

#include "ecom_eiffel_compiler_IEnumCluster_s.h"

#include "ecom_eiffel_compiler_IEnumAssembly_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumFeature_s.h"

#include "ecom_eiffel_compiler_IEnumParameter_s.h"

#include "ecom_eiffel_compiler_IEiffelParameterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#include "ecom_eiffel_compiler_IEnumClusterProp_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

#include "ecom_eiffel_compiler_IEnumClusterExcludes_s.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths_s.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles_s.h"

#include "ecom_eiffel_compiler_IEnumCompletionEntry_s.h"

#include "ecom_eiffel_compiler_IEiffelCompletionEntry_s.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gce_ISE
{
public:
	ecom_gce_ISE ();
	virtual ~ecom_gce_ISE () {};

	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_1( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_1( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_2( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_2( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_3( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_3( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_4( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_5( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_5( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompiler *  to IEIFFEL_COMPILER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_7( ecom_eiffel_compiler::IEiffelCompiler * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompiler * *  to CELL [IEIFFEL_COMPILER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompiler * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_8( ecom_eiffel_compiler::IEiffelCompiler * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_9( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_10( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser *  to IEIFFEL_SYSTEM_BROWSER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_12( ecom_eiffel_compiler::IEiffelSystemBrowser * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser * *  to CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_13( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_13( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties *  to IEIFFEL_PROJECT_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_15( ecom_eiffel_compiler::IEiffelProjectProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties * *  to CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_16( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_16( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionInfo *  to IEIFFEL_COMPLETION_INFO_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_18( ecom_eiffel_compiler::IEiffelCompletionInfo * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionInfo * *  to CELL [IEIFFEL_COMPLETION_INFO_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_19( ecom_eiffel_compiler::IEiffelCompletionInfo * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompletionInfo * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_19( ecom_eiffel_compiler::IEiffelCompletionInfo * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocGenerator *  to IEIFFEL_HTMLDOC_GENERATOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_21( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *  to CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_22( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_22( ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_23( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_24( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_25( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_25( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_26( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_26( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_27( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_27( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_28( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_28( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_29( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_29( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_30( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass *  to IENUM_EIFFEL_CLASS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_32( ecom_eiffel_compiler::IEnumEiffelClass * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass * *  to CELL [IENUM_EIFFEL_CLASS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_33( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_33( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_34( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster *  to IENUM_CLUSTER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_36( ecom_eiffel_compiler::IEnumCluster * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster * *  to CELL [IENUM_CLUSTER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_37( ecom_eiffel_compiler::IEnumCluster * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_37( ecom_eiffel_compiler::IEnumCluster * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly *  to IENUM_ASSEMBLY_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_39( ecom_eiffel_compiler::IEnumAssembly * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly * *  to CELL [IENUM_ASSEMBLY_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_40( ecom_eiffel_compiler::IEnumAssembly * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_40( ecom_eiffel_compiler::IEnumAssembly * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_41( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor *  to IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_43( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor * *  to CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_44( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_44( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor *  to IEIFFEL_CLASS_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_46( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor * *  to CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_47( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_47( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor *  to IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_49( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor * *  to CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_50( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_50( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature *  to IENUM_FEATURE_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_52( ecom_eiffel_compiler::IEnumFeature * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature * *  to CELL [IENUM_FEATURE_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_53( ecom_eiffel_compiler::IEnumFeature * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_53( ecom_eiffel_compiler::IEnumFeature * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_54( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_54( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_55( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_55( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_56( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_57( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_58( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_58( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_59( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_59( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_60( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_60( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_61( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_61( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_62( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_64( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_64( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_65( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_66( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_67( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_68( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_69( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_70( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_71( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_71( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_72( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_73( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_74( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_75( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_76( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_77( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_78( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_78( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_79( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_79( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_80( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_80( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_81( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_81( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumParameter *  to IENUM_PARAMETER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_83( ecom_eiffel_compiler::IEnumParameter * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumParameter * *  to CELL [IENUM_PARAMETER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_84( ecom_eiffel_compiler::IEnumParameter * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_84( ecom_eiffel_compiler::IEnumParameter * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_85( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_85( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_86( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_86( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_87( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_88( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_89( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_90( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_91( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_92( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_93( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_94( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_95( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_96( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_97( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_98( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_99( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_100( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_101( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_102( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_103( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_104( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_105( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_106( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_107( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_108( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_109( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_109( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_110( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_110( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_111( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelParameterDescriptor *  to IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_113( ecom_eiffel_compiler::IEiffelParameterDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelParameterDescriptor * *  to CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_114( ecom_eiffel_compiler::IEiffelParameterDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_114( ecom_eiffel_compiler::IEiffelParameterDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_115( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_116( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_117( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_117( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_118( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_118( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_119( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_120( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_121( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_121( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_122( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_122( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_123( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_123( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_124( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_125( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_126( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_126( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_127( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_127( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_128( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_129( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties *  to IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_131( ecom_eiffel_compiler::IEiffelAssemblyProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties * *  to CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_132( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_132( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_133( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_134( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_135( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_135( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_136( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_136( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_137( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_137( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_138( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_138( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_139( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_140( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_141( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_141( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_142( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_142( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_143( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_143( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_144( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_144( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_145( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_145( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of long *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_147( long * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_148( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_149( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_150( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_151( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_152( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_153( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_154( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters *  to IEIFFEL_SYSTEM_CLUSTERS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_156( ecom_eiffel_compiler::IEiffelSystemClusters * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters * *  to CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_157( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_157( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals *  to IEIFFEL_SYSTEM_EXTERNALS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_159( ecom_eiffel_compiler::IEiffelSystemExternals * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals * *  to CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_160( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_160( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_161( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_161( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies *  to IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_163( ecom_eiffel_compiler::IEiffelSystemAssemblies * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies * *  to CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_164( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_164( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_165( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_165( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_166( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_166( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_167( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_167( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_168( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_168( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_169( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_169( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_170( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_170( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_171( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_171( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_172( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_172( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_173( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_173( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_174( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_174( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp *  to IENUM_CLUSTER_PROP_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_176( ecom_eiffel_compiler::IEnumClusterProp * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp * *  to CELL [IENUM_CLUSTER_PROP_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_177( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_177( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties *  to IEIFFEL_CLUSTER_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_179( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties * *  to CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_180( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_180( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_181( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_182( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_182( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_183( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_184( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_185( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_185( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_186( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_186( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_187( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_188( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_189( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_190( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_191( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_192( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_193( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_194( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_195( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes *  to IENUM_CLUSTER_EXCLUDES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_197( ecom_eiffel_compiler::IEnumClusterExcludes * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes * *  to CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_198( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_198( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_199( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_199( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_200( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_201( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_202( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_203( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_204( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_204( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_205( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_205( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_206( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_206( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_207( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_208( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_208( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_209( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths *  to IENUM_INCLUDE_PATHS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_211( ecom_eiffel_compiler::IEnumIncludePaths * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths * *  to CELL [IENUM_INCLUDE_PATHS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_212( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_212( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles *  to IENUM_OBJECT_FILES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_214( ecom_eiffel_compiler::IEnumObjectFiles * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles * *  to CELL [IENUM_OBJECT_FILES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_215( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_215( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_216( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_216( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_217( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_218( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_218( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_219( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_220( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_220( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_221( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_222( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_222( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_223( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_224( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_225( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_226( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_227( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_228( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_228( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_229( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_229( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_230( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_231( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCompletionEntry *  to IENUM_COMPLETION_ENTRY_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_233( ecom_eiffel_compiler::IEnumCompletionEntry * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCompletionEntry * *  to CELL [IENUM_COMPLETION_ENTRY_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_234( ecom_eiffel_compiler::IEnumCompletionEntry * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCompletionEntry * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_234( ecom_eiffel_compiler::IEnumCompletionEntry * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionEntry *  to IEIFFEL_COMPLETION_ENTRY_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_236( ecom_eiffel_compiler::IEiffelCompletionEntry * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelCompletionEntry * *  to CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_237( ecom_eiffel_compiler::IEiffelCompletionEntry * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelCompletionEntry * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_237( ecom_eiffel_compiler::IEiffelCompletionEntry * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_238( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_239( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_240( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_241( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_242( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelHTMLDocEvents *  to IEIFFEL_HTMLDOC_EVENTS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_244( ecom_eiffel_compiler::IEiffelHTMLDocEvents * a_interface_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_245( VARIANT_BOOL * a_pointer );



protected:


private:


};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE.h"


#endif