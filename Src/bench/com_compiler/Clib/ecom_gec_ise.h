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

#include "ecom_EiffelComCompiler_IEiffelException_s.h"

#include "ecom_EiffelComCompiler_IEiffelCompiler_s.h"

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser_s.h"

#include "ecom_EiffelComCompiler_IEiffelProjectProperties_s.h"

#include "ecom_EiffelComCompiler_IEiffelCompletionInfo_s.h"

#include "ecom_EiffelComCompiler_IEiffelHTMLDocGenerator_s.h"

#include "ecom_EiffelComCompiler_IEnumEiffelClass_s.h"

#include "ecom_EiffelComCompiler_IEnumCluster_s.h"

#include "ecom_EiffelComCompiler_IEnumAssembly_s.h"

#include "ecom_EiffelComCompiler_IEiffelClusterDescriptor_s.h"

#include "ecom_EiffelComCompiler_IEiffelClassDescriptor_s.h"

#include "ecom_EiffelComCompiler_IEiffelFeatureDescriptor_s.h"

#include "ecom_EiffelComCompiler_IEnumFeature_s.h"

#include "ecom_EiffelComCompiler_IEnumParameter_s.h"

#include "ecom_EiffelComCompiler_IEiffelParameterDescriptor_s.h"

#include "ecom_EiffelComCompiler_IEiffelAssemblyProperties_s.h"

#include "ecom_EiffelComCompiler_IEiffelSystemClusters_s.h"

#include "ecom_EiffelComCompiler_IEiffelSystemExternals_s.h"

#include "ecom_EiffelComCompiler_IEiffelSystemAssemblies_s.h"

#include "ecom_EiffelComCompiler_IEnumClusterProp_s.h"

#include "ecom_EiffelComCompiler_IEiffelClusterProperties_s.h"

#include "ecom_EiffelComCompiler_IEnumClusterExcludes_s.h"

#include "ecom_EiffelComCompiler_IEnumIncludePaths_s.h"

#include "ecom_EiffelComCompiler_IEnumObjectFiles_s.h"

#include "ecom_EiffelComCompiler_IEiffelHTMLDocEvents_s.h"

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
	Convert IEIFFEL_EXCEPTION_INTERFACE to ecom_EiffelComCompiler::IEiffelException *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelException * ccom_ec_pointed_interface_6( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_EXCEPTION_INTERFACE] to ecom_EiffelComCompiler::IEiffelException * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelException * * ccom_ec_pointed_cell_7( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelException * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_EiffelComCompiler::IEiffelCompiler *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompiler * ccom_ec_pointed_interface_9( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_EiffelComCompiler::IEiffelCompiler * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompiler * * ccom_ec_pointed_cell_10( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelCompiler * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemBrowser *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemBrowser * ccom_ec_pointed_interface_14( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemBrowser * * ccom_ec_pointed_cell_15( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemBrowser * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelProjectProperties *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelProjectProperties * ccom_ec_pointed_interface_17( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelProjectProperties * * ccom_ec_pointed_cell_18( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelProjectProperties * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_INFO_INTERFACE to ecom_EiffelComCompiler::IEiffelCompletionInfo *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompletionInfo * ccom_ec_pointed_interface_20( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_INFO_INTERFACE] to ecom_EiffelComCompiler::IEiffelCompletionInfo * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelCompletionInfo * * ccom_ec_pointed_cell_21( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelCompletionInfo * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_GENERATOR_INTERFACE to ecom_EiffelComCompiler::IEiffelHTMLDocGenerator *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * ccom_ec_pointed_interface_23( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * ccom_ec_pointed_cell_24( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelHTMLDocGenerator * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_EiffelComCompiler::IEnumEiffelClass *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumEiffelClass * ccom_ec_pointed_interface_39( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_EiffelComCompiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumEiffelClass * * ccom_ec_pointed_cell_40( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumEiffelClass * * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_EiffelComCompiler::IEnumCluster *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumCluster * ccom_ec_pointed_interface_43( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_EiffelComCompiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumCluster * * ccom_ec_pointed_cell_44( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumCluster * * old );


	/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_EiffelComCompiler::IEnumAssembly *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumAssembly * ccom_ec_pointed_interface_46( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_EiffelComCompiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumAssembly * * ccom_ec_pointed_cell_47( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumAssembly * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * ccom_ec_pointed_interface_50( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * * ccom_ec_pointed_cell_51( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClassDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClassDescriptor * ccom_ec_pointed_interface_53( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * ccom_ec_pointed_cell_54( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClassDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelFeatureDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ccom_ec_pointed_interface_56( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_EiffelComCompiler::IEnumFeature *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumFeature * ccom_ec_pointed_interface_59( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_EiffelComCompiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumFeature * * ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumFeature * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_65( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_71( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_80( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_87( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IENUM_PARAMETER_INTERFACE to ecom_EiffelComCompiler::IEnumParameter *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumParameter * ccom_ec_pointed_interface_94( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_EiffelComCompiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumParameter * * ccom_ec_pointed_cell_95( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumParameter * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_97( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelParameterDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * ccom_ec_pointed_interface_121( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * * ccom_ec_pointed_cell_122( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelParameterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_125( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_126( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_129( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_134( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_135( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelAssemblyProperties *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * ccom_ec_pointed_interface_139( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * * ccom_ec_pointed_cell_140( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelAssemblyProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_143( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_149( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_151( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_156( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_161( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemClusters *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemClusters * ccom_ec_pointed_interface_164( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemClusters * * ccom_ec_pointed_cell_165( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemClusters * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemExternals *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemExternals * ccom_ec_pointed_interface_167( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemExternals * * ccom_ec_pointed_cell_168( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemExternals * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemAssemblies *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * ccom_ec_pointed_interface_170( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * * ccom_ec_pointed_cell_171( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemAssemblies * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_172( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_EiffelComCompiler::IEnumClusterProp *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterProp * ccom_ec_pointed_interface_183( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterProp * * ccom_ec_pointed_cell_184( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterProp * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterProperties *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterProperties * ccom_ec_pointed_interface_187( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterProperties * * ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_194( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_EiffelComCompiler::IEnumClusterExcludes *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterExcludes * ccom_ec_pointed_interface_205( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterExcludes * * ccom_ec_pointed_cell_206( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterExcludes * * old );


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
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_EiffelComCompiler::IEnumIncludePaths *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumIncludePaths * ccom_ec_pointed_interface_219( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_EiffelComCompiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumIncludePaths * * ccom_ec_pointed_cell_220( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumIncludePaths * * old );


	/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_EiffelComCompiler::IEnumObjectFiles *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumObjectFiles * ccom_ec_pointed_interface_222( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_EiffelComCompiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumObjectFiles * * ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumObjectFiles * * old );


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
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_232( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_233( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_234( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_EVENTS_INTERFACE to ecom_EiffelComCompiler::IEiffelHTMLDocEvents *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHTMLDocEvents * ccom_ec_pointed_interface_239( EIF_REFERENCE eif_ref );



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