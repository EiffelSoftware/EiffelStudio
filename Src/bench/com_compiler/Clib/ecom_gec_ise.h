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

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_s.h"

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

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_s.h"

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
	Convert IEIFFEL_HTML_DOCUMENTATION_GENERATOR_INTERFACE to ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * ccom_ec_pointed_interface_23( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTML_DOCUMENTATION_GENERATOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * * ccom_ec_pointed_cell_24( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_34( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_36( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_EiffelComCompiler::IEnumEiffelClass *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumEiffelClass * ccom_ec_pointed_interface_38( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_EiffelComCompiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumEiffelClass * * ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumEiffelClass * * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_EiffelComCompiler::IEnumCluster *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumCluster * ccom_ec_pointed_interface_42( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_EiffelComCompiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumCluster * * ccom_ec_pointed_cell_43( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumCluster * * old );


	/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_EiffelComCompiler::IEnumAssembly *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumAssembly * ccom_ec_pointed_interface_45( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_EiffelComCompiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumAssembly * * ccom_ec_pointed_cell_46( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumAssembly * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * ccom_ec_pointed_interface_49( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * * ccom_ec_pointed_cell_50( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelClassDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClassDescriptor * ccom_ec_pointed_interface_52( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * ccom_ec_pointed_cell_53( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClassDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelFeatureDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ccom_ec_pointed_interface_55( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * ccom_ec_pointed_cell_56( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_EiffelComCompiler::IEnumFeature *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumFeature * ccom_ec_pointed_interface_58( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_EiffelComCompiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumFeature * * ccom_ec_pointed_cell_59( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumFeature * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_60( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_61( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_64( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_70( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_79( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_86( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IENUM_PARAMETER_INTERFACE to ecom_EiffelComCompiler::IEnumParameter *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumParameter * ccom_ec_pointed_interface_93( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_EiffelComCompiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumParameter * * ccom_ec_pointed_cell_94( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumParameter * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_95( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_96( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_EiffelComCompiler::IEiffelParameterDescriptor *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * ccom_ec_pointed_interface_120( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_EiffelComCompiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * * ccom_ec_pointed_cell_121( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelParameterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_124( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_125( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_128( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_133( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_134( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelAssemblyProperties *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * ccom_ec_pointed_interface_138( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * * ccom_ec_pointed_cell_139( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelAssemblyProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_142( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_147( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_150( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_151( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_160( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemClusters *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemClusters * ccom_ec_pointed_interface_163( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemClusters * * ccom_ec_pointed_cell_164( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemClusters * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemExternals *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemExternals * ccom_ec_pointed_interface_166( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemExternals * * ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemExternals * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_EiffelComCompiler::IEiffelSystemAssemblies *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * ccom_ec_pointed_interface_169( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelSystemAssemblies * * ccom_ec_pointed_cell_170( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelSystemAssemblies * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_171( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_EiffelComCompiler::IEnumClusterProp *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterProp * ccom_ec_pointed_interface_182( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterProp * * ccom_ec_pointed_cell_183( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterProp * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_184( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_EiffelComCompiler::IEiffelClusterProperties *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterProperties * ccom_ec_pointed_interface_186( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_EiffelComCompiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelClusterProperties * * ccom_ec_pointed_cell_187( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEiffelClusterProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_192( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_193( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_EiffelComCompiler::IEnumClusterExcludes *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterExcludes * ccom_ec_pointed_interface_204( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_EiffelComCompiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumClusterExcludes * * ccom_ec_pointed_cell_205( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumClusterExcludes * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_206( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_211( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_215( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_EiffelComCompiler::IEnumIncludePaths *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumIncludePaths * ccom_ec_pointed_interface_218( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_EiffelComCompiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumIncludePaths * * ccom_ec_pointed_cell_219( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumIncludePaths * * old );


	/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_EiffelComCompiler::IEnumObjectFiles *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumObjectFiles * ccom_ec_pointed_interface_221( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_EiffelComCompiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEnumObjectFiles * * ccom_ec_pointed_cell_222( EIF_REFERENCE eif_ref, ecom_EiffelComCompiler::IEnumObjectFiles * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_223( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_225( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_227( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_229( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_231( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_232( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert ECOM_VARIANT to VARIANT *.
	-----------------------------------------------------------*/
	VARIANT * ccom_ec_pointed_record_233( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE to ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents *.
	-----------------------------------------------------------*/
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * ccom_ec_pointed_interface_235( EIF_REFERENCE eif_ref );



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