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

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties_s.h"

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
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser *  to IEIFFEL_SYSTEM_BROWSER_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_11( ecom_eiffel_compiler::IEiffelSystemBrowser * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelSystemBrowser * *  to CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_12( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_12( ecom_eiffel_compiler::IEiffelSystemBrowser * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties *  to IEIFFEL_PROJECT_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_14( ecom_eiffel_compiler::IEiffelProjectProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelProjectProperties * *  to CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_15( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_15( ecom_eiffel_compiler::IEiffelProjectProperties * * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_16( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_18( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_18( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_19( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_21( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_21( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_22( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor *  to IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_24( ecom_eiffel_compiler::IEiffelClusterDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterDescriptor * *  to CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_25( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_25( ecom_eiffel_compiler::IEiffelClusterDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor *  to IEIFFEL_CLASS_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_27( ecom_eiffel_compiler::IEiffelClassDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClassDescriptor * *  to CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_28( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_28( ecom_eiffel_compiler::IEiffelClassDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor *  to IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_30( ecom_eiffel_compiler::IEiffelFeatureDescriptor * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelFeatureDescriptor * *  to CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_31( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_31( ecom_eiffel_compiler::IEiffelFeatureDescriptor * * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_32( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_32( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_33( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_33( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_34( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_35( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_36( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_37( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_38( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_38( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_39( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_39( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_40( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_40( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_41( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_41( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_43( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_43( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_44( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_45( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_46( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_47( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_48( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_49( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_50( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_51( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_52( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_53( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_54( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_55( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_56( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_56( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_57( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_58( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_59( VARIANT_BOOL * a_pointer );


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
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_62( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_62( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_63( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_63( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_64( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_64( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_65( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_65( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_66( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_67( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_67( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_68( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_69( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_70( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_71( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_72( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_73( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_74( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_75( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_76( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_77( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_78( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Free memory of LONG *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_79( LONG * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_81( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_81( SAFEARRAY *  * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_95( VARIANT_BOOL * a_pointer );


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
	Free memory of long *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_100( long * a_pointer );


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
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_109( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert VARIANT *  to ECOM_VARIANT.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_record_110( VARIANT * a_record_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties *  to IEIFFEL_CLUSTER_PROPERTIES_INTERFACE.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_interface_112( ecom_eiffel_compiler::IEiffelClusterProperties * a_interface_pointer );


	/*-----------------------------------------------------------
	Convert ecom_eiffel_compiler::IEiffelClusterProperties * *  to CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_113( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_113( ecom_eiffel_compiler::IEiffelClusterProperties * * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_115( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_115( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_116( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_116( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Convert BSTR *  to CELL [STRING].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_117( BSTR * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of BSTR *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_117( BSTR * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_118( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_119( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_120( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_121( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_122( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_123( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_124( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_125( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_126( VARIANT_BOOL * a_pointer );


	/*-----------------------------------------------------------
	Convert SAFEARRAY *  *  to CELL [ECOM_ARRAY [STRING]].
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_ce_pointed_cell_128( SAFEARRAY *  * a_pointer, EIF_OBJECT an_object );


	/*-----------------------------------------------------------
	Free memory of SAFEARRAY *  *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_128( SAFEARRAY *  * a_pointer );


	/*-----------------------------------------------------------
	Free memory of VARIANT_BOOL *.
	-----------------------------------------------------------*/
	void ccom_free_memory_pointed_129( VARIANT_BOOL * a_pointer );



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