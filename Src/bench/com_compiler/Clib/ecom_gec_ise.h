/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GEC_ISE_H__
#define __ECOM_GEC_ISE_H__
#ifdef __cplusplus
extern "C" {


class ecom_gec_ISE;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelException_s.h"

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

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gec_ISE
{
public:
	ecom_gec_ISE ();
	virtual ~ecom_gec_ISE () {};

	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_1( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_2( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_3( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_5( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_EXCEPTION_INTERFACE to ecom_eiffel_compiler::IEiffelException *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelException * ccom_ec_pointed_interface_7( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_EXCEPTION_INTERFACE] to ecom_eiffel_compiler::IEiffelException * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelException * * ccom_ec_pointed_cell_8( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelException * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_eiffel_compiler::IEiffelCompiler *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * ccom_ec_pointed_interface_10( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_eiffel_compiler::IEiffelCompiler * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * * ccom_ec_pointed_cell_11( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompiler * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_eiffel_compiler::IEiffelSystemBrowser *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * ccom_ec_pointed_interface_15( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * * ccom_ec_pointed_cell_16( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemBrowser * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelProjectProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * ccom_ec_pointed_interface_18( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * * ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelProjectProperties * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_INFO_INTERFACE to ecom_eiffel_compiler::IEiffelCompletionInfo *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * ccom_ec_pointed_interface_21( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_INFO_INTERFACE] to ecom_eiffel_compiler::IEiffelCompletionInfo * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * * ccom_ec_pointed_cell_22( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompletionInfo * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_GENERATOR_INTERFACE to ecom_eiffel_compiler::IEiffelHTMLDocGenerator *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * ccom_ec_pointed_interface_24( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE] to ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_26( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_31( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_32( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_33( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_34( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_36( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_eiffel_compiler::IEnumEiffelClass *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * ccom_ec_pointed_interface_40( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * * ccom_ec_pointed_cell_41( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumEiffelClass * * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_eiffel_compiler::IEnumCluster *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * ccom_ec_pointed_interface_44( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * * ccom_ec_pointed_cell_45( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumCluster * * old );


	/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_eiffel_compiler::IEnumAssembly *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * ccom_ec_pointed_interface_47( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * * ccom_ec_pointed_cell_48( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumAssembly * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClusterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * ccom_ec_pointed_interface_51( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * * ccom_ec_pointed_cell_52( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClassDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * ccom_ec_pointed_interface_54( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * * ccom_ec_pointed_cell_55( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClassDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelFeatureDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * ccom_ec_pointed_interface_57( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * * ccom_ec_pointed_cell_58( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelFeatureDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_eiffel_compiler::IEnumFeature *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * ccom_ec_pointed_interface_60( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * * ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumFeature * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_67( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_68( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_69( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_72( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_81( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_88( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_89( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_90( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_91( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_92( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_93( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_PARAMETER_INTERFACE to ecom_eiffel_compiler::IEnumParameter *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * ccom_ec_pointed_interface_95( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_eiffel_compiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * * ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumParameter * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_97( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_98( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelParameterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * ccom_ec_pointed_interface_122( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * * ccom_ec_pointed_cell_123( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelParameterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_127( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_130( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_131( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_132( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_136( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelAssemblyProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * ccom_ec_pointed_interface_140( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * * ccom_ec_pointed_cell_141( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelAssemblyProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_144( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_145( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_146( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_147( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_150( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_152( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_153( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_154( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_157( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_162( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemClusters *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * ccom_ec_pointed_interface_165( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * * ccom_ec_pointed_cell_166( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemClusters * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemExternals *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * ccom_ec_pointed_interface_168( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * * ccom_ec_pointed_cell_169( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemExternals * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_eiffel_compiler::IEiffelSystemAssemblies *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * ccom_ec_pointed_interface_171( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * * ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemAssemblies * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_173( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_174( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_175( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_176( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_177( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_178( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_179( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_181( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_182( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_eiffel_compiler::IEnumClusterProp *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * ccom_ec_pointed_interface_184( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * * ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterProp * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelClusterProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * ccom_ec_pointed_interface_187( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * * ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_190( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_194( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_eiffel_compiler::IEnumClusterExcludes *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * ccom_ec_pointed_interface_205( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * * ccom_ec_pointed_cell_206( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterExcludes * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_207( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_212( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_213( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_214( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_216( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_eiffel_compiler::IEnumIncludePaths *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * ccom_ec_pointed_interface_219( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * * ccom_ec_pointed_cell_220( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumIncludePaths * * old );


	/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_eiffel_compiler::IEnumObjectFiles *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * ccom_ec_pointed_interface_222( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * * ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumObjectFiles * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_224( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_226( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_228( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_230( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_236( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_237( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_239( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_240( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_241( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_EVENTS_INTERFACE to ecom_eiffel_compiler::IEiffelHTMLDocEvents *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocEvents * ccom_ec_pointed_interface_246( EIF_REFERENCE eif_ref );



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