/*-----------------------------------------------------------
Writer for generated C to Eiffel mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GCE_EIF_COMPILER_H__
#define __ECOM_GCE_EIF_COMPILER_H__
#ifdef __cplusplus
extern "C" {


class ecom_gce_Eif_compiler;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompiler_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_s.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties_s.h"

#include "ecom_eiffel_compiler_IEnumEiffelClass_s.h"

#include "ecom_eiffel_compiler_IEnumCluster_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_eiffel_compiler_IEnumFeature_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals_s.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_s.h"

#include "ecom_eiffel_compiler_IEnumClusterProp_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

#include "ecom_eiffel_compiler_IEnumClusterExcludes_s.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths_s.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles_s.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties_s.h"

#include "ecom_eiffel_compiler_IEnumAssembly_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gce_Eif_compiler
{
public:
	ecom_gce_Eif_compiler ();
	virtual ~ecom_gce_Eif_compiler () {};

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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_17( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_18( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_19( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_19( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_20( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_20( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_21( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_21( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_22( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_22( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass *  to IENUM_EIFFEL_CLASS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_24( ecom_eiffel_compiler::IEnumEiffelClass * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass * *  to CELL [IENUM_EIFFEL_CLASS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_25( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_25( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_26( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster *  to IENUM_CLUSTER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_28( ecom_eiffel_compiler::IEnumCluster * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster * *  to CELL [IENUM_CLUSTER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_29( ecom_eiffel_compiler::IEnumCluster * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_29( ecom_eiffel_compiler::IEnumCluster * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_30( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor *  to IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_32( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor * *  to CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_33( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_33( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor *  to IEIFFEL_CLASS_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_35( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor * *  to CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_36( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_36( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor *  to IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_38( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor * *  to CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_39( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_39( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature *  to IENUM_FEATURE_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_41( ecom_eiffel_compiler::IEnumFeature * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature * *  to CELL [IENUM_FEATURE_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_42( ecom_eiffel_compiler::IEnumFeature * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_42( ecom_eiffel_compiler::IEnumFeature * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_43( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_44( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_45( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_45( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_46( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_46( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_47( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_47( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_48( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_48( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_49( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_51( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_51( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_52( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_53( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_54( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_55( ULONG * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_59( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_60( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_61( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_62( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_63( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_64( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_65( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_65( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_66( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_66( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_67( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_67( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_68( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_68( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_69( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_69( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_70( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_70( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_71( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_72( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_72( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_73( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_74( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_75( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_76( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_77( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_78( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_79( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_80( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_81( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_82( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_83( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_84( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_85( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_86( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_87( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_88( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_89( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_90( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_91( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_92( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_93( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_94( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_95( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_96( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_96( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_97( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_97( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_98( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_98( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_99( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_100( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_101( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_101( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_102( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_102( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_103( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_104( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_105( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_105( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_106( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_106( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_107( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_107( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of long *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_109( long * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_110( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_111( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_112( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_113( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_114( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_115( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_116( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters *  to IEIFFEL_SYSTEM_CLUSTERS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_118( ecom_eiffel_compiler::IEiffelSystemClusters * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters * *  to CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_119( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_119( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals *  to IEIFFEL_SYSTEM_EXTERNALS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_121( ecom_eiffel_compiler::IEiffelSystemExternals * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals * *  to CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_122( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_122( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_123( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_123( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies *  to IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_125( ecom_eiffel_compiler::IEiffelSystemAssemblies * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies * *  to CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_126( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_126( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp *  to IENUM_CLUSTER_PROP_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_128( ecom_eiffel_compiler::IEnumClusterProp * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp * *  to CELL [IENUM_CLUSTER_PROP_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_129( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_129( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties *  to IEIFFEL_CLUSTER_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_131( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties * *  to CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_132( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_132( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_133( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_134( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_135( ULONG * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_138( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_139( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_140( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_141( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_142( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_143( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_144( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_145( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_146( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes *  to IENUM_CLUSTER_EXCLUDES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_148( ecom_eiffel_compiler::IEnumClusterExcludes * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes * *  to CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_149( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_149( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_150( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_150( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_151( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_152( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_153( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_154( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_155( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_155( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_156( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_157( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_158( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_159( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_159( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_160( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_160( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_161( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_162( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_162( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_163( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths *  to IENUM_INCLUDE_PATHS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_165( ecom_eiffel_compiler::IEnumIncludePaths * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths * *  to CELL [IENUM_INCLUDE_PATHS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_166( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_166( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles *  to IENUM_OBJECT_FILES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_168( ecom_eiffel_compiler::IEnumObjectFiles * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles * *  to CELL [IENUM_OBJECT_FILES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_169( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_169( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_170( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_170( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_171( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_172( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_172( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_173( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_174( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_174( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_175( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_176( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_176( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_177( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties *  to IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_179( ecom_eiffel_compiler::IEiffelAssemblyProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties * *  to CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_180( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_180( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_181( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_182( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_183( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_184( VARIANT_BOOL * a_pointer );


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
	Convert ecom_eiffel_compiler::IEnumAssembly *  to IENUM_ASSEMBLY_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_188( ecom_eiffel_compiler::IEnumAssembly * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly * *  to CELL [IENUM_ASSEMBLY_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_189( ecom_eiffel_compiler::IEnumAssembly * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_189( ecom_eiffel_compiler::IEnumAssembly * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_190( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_190( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_191( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_191( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_192( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_192( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_193( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_193( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_194( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_194( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_195( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_196( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_196( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_197( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_198( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_199( VARIANT_BOOL * a_pointer );



protected:


private:


};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif