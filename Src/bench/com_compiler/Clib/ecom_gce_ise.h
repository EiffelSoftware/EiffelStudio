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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_23( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass *  to IENUM_EIFFEL_CLASS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_25( ecom_eiffel_compiler::IEnumEiffelClass * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumEiffelClass * *  to CELL [IENUM_EIFFEL_CLASS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_26( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_26( ecom_eiffel_compiler::IEnumEiffelClass * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_27( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster *  to IENUM_CLUSTER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_29( ecom_eiffel_compiler::IEnumCluster * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumCluster * *  to CELL [IENUM_CLUSTER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_30( ecom_eiffel_compiler::IEnumCluster * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_30( ecom_eiffel_compiler::IEnumCluster * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_31( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor *  to IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_33( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor * *  to CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_34( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_34( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor *  to IEIFFEL_CLASS_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_36( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor * *  to CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_37( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_37( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor *  to IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_39( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor * *  to CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_40( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_40( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature *  to IENUM_FEATURE_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_42( ecom_eiffel_compiler::IEnumFeature * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumFeature * *  to CELL [IENUM_FEATURE_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_43( ecom_eiffel_compiler::IEnumFeature * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_43( ecom_eiffel_compiler::IEnumFeature * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_44( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_45( ULONG * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_49( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_49( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_50( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_52( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_52( SAFEARRAY *  * a_pointer );


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
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_58( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_59( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_59( BSTR * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_63( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_64( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_65( ULONG * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_71( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_71( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_72( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_73( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_73( BSTR * a_pointer );


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
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_79( ULONG * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_94( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_95( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_96( ULONG * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_99( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_99( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_100( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_101( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_102( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_102( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_103( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_103( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_104( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_105( VARIANT_BOOL * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_108( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_108( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of long *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_110( long * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_117( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters *  to IEIFFEL_SYSTEM_CLUSTERS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_119( ecom_eiffel_compiler::IEiffelSystemClusters * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemClusters * *  to CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_120( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_120( ecom_eiffel_compiler::IEiffelSystemClusters * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals *  to IEIFFEL_SYSTEM_EXTERNALS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_122( ecom_eiffel_compiler::IEiffelSystemExternals * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemExternals * *  to CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_123( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_123( ecom_eiffel_compiler::IEiffelSystemExternals * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_124( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_124( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies *  to IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_126( ecom_eiffel_compiler::IEiffelSystemAssemblies * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemAssemblies * *  to CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_127( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_127( ecom_eiffel_compiler::IEiffelSystemAssemblies * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_128( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_128( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_129( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_129( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_130( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_130( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_131( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_131( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_132( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_132( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_133( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_133( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_134( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_134( BSTR * a_pointer );


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
	Convert ecom_eiffel_compiler::IEnumClusterProp *  to IENUM_CLUSTER_PROP_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_138( ecom_eiffel_compiler::IEnumClusterProp * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterProp * *  to CELL [IENUM_CLUSTER_PROP_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_139( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_139( ecom_eiffel_compiler::IEnumClusterProp * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties *  to IEIFFEL_CLUSTER_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_141( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties * *  to CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_142( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_142( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_143( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_144( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_144( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_145( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_146( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_147( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_147( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_148( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_148( BSTR * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_155( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_156( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_157( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes *  to IENUM_CLUSTER_EXCLUDES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_159( ecom_eiffel_compiler::IEnumClusterExcludes * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumClusterExcludes * *  to CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_160( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_160( ecom_eiffel_compiler::IEnumClusterExcludes * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_161( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_161( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_162( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_163( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_164( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_165( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_166( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_166( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_167( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_168( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_169( VARIANT_BOOL * a_pointer );


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
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_172( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_173( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_173( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_174( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths *  to IENUM_INCLUDE_PATHS_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_176( ecom_eiffel_compiler::IEnumIncludePaths * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumIncludePaths * *  to CELL [IENUM_INCLUDE_PATHS_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_177( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_177( ecom_eiffel_compiler::IEnumIncludePaths * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles *  to IENUM_OBJECT_FILES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_179( ecom_eiffel_compiler::IEnumObjectFiles * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumObjectFiles * *  to CELL [IENUM_OBJECT_FILES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_180( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_180( ecom_eiffel_compiler::IEnumObjectFiles * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_181( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_181( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_182( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_183( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_183( BSTR * a_pointer );


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
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_186( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_187( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_187( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_188( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties *  to IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_190( ecom_eiffel_compiler::IEiffelAssemblyProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelAssemblyProperties * *  to CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_191( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_191( ecom_eiffel_compiler::IEiffelAssemblyProperties * * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_196( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_196( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_197( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_197( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_198( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_199( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly *  to IENUM_ASSEMBLY_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_201( ecom_eiffel_compiler::IEnumAssembly * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEnumAssembly * *  to CELL [IENUM_ASSEMBLY_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_202( ecom_eiffel_compiler::IEnumAssembly * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_202( ecom_eiffel_compiler::IEnumAssembly * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_203( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_203( BSTR * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_207( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_207( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_208( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_209( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_210( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_210( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_211( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_211( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_212( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of ULONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_213( ULONG * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_214( VARIANT_BOOL * a_pointer );



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