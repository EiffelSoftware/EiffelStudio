/*-----------------------------------------------------------
Writer for generated Eiffel to C mappers class
-----------------------------------------------------------*/

#ifndef __ECOM_GEC_ISE_C_H__
#define __ECOM_GEC_ISE_C_H__
#ifdef __cplusplus
extern "C" {


class ecom_gec_ISE_c;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_rt_globals.h"

#include "ecom_eiffel_compiler_IEiffelCompiler.h"

#include "ecom_eiffel_compiler_IEiffelSystemBrowser.h"

#include "ecom_eiffel_compiler_IEiffelProjectProperties.h"

#include "ecom_eiffel_compiler_IEiffelCompletionInfo.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator.h"

#include "ecom_eiffel_compiler_IEnumEiffelClass.h"

#include "ecom_eiffel_compiler_IEnumCluster.h"

#include "ecom_eiffel_compiler_IEnumAssembly.h"

#include "ecom_eiffel_compiler_IEiffelClusterDescriptor.h"

#include "ecom_eiffel_compiler_IEiffelClassDescriptor.h"

#include "ecom_eiffel_compiler_IEiffelFeatureDescriptor.h"

#include "ecom_eiffel_compiler_IEnumFeature.h"

#include "ecom_eiffel_compiler_IEnumParameter.h"

#include "ecom_eiffel_compiler_IEiffelParameterDescriptor.h"

#include "ecom_eiffel_compiler_IEiffelAssemblyProperties.h"

#include "ecom_eiffel_compiler_IEiffelSystemClusters.h"

#include "ecom_eiffel_compiler_IEiffelSystemExternals.h"

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies.h"

#include "ecom_eiffel_compiler_IEnumClusterProp.h"

#include "ecom_eiffel_compiler_IEiffelClusterProperties.h"

#include "ecom_eiffel_compiler_IEnumClusterExcludes.h"

#include "ecom_eiffel_compiler_IEnumIncludePaths.h"

#include "ecom_eiffel_compiler_IEnumObjectFiles.h"

#include "ecom_eiffel_compiler_IEnumCompletionEntry.h"

#include "ecom_eiffel_compiler_IEiffelCompletionEntry.h"

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
class ecom_gec_ISE_c
{
public:
	ecom_gec_ISE_c ();
	virtual ~ecom_gec_ISE_c () {};

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
	Convert IEIFFEL_COMPILER_INTERFACE to ecom_eiffel_compiler::IEiffelCompiler *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * ccom_ec_pointed_interface_7( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPILER_INTERFACE] to ecom_eiffel_compiler::IEiffelCompiler * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompiler * * ccom_ec_pointed_cell_8( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompiler * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_BROWSER_INTERFACE to ecom_eiffel_compiler::IEiffelSystemBrowser *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * ccom_ec_pointed_interface_12( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_BROWSER_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemBrowser * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemBrowser * * ccom_ec_pointed_cell_13( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemBrowser * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PROJECT_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelProjectProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * ccom_ec_pointed_interface_15( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PROJECT_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelProjectProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelProjectProperties * * ccom_ec_pointed_cell_16( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelProjectProperties * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_INFO_INTERFACE to ecom_eiffel_compiler::IEiffelCompletionInfo *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * ccom_ec_pointed_interface_18( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_INFO_INTERFACE] to ecom_eiffel_compiler::IEiffelCompletionInfo * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionInfo * * ccom_ec_pointed_cell_19( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompletionInfo * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_HTMLDOC_GENERATOR_INTERFACE to ecom_eiffel_compiler::IEiffelHTMLDocGenerator *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * ccom_ec_pointed_interface_21( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_HTMLDOC_GENERATOR_INTERFACE] to ecom_eiffel_compiler::IEiffelHTMLDocGenerator * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * ccom_ec_pointed_cell_22( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_25( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_26( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_27( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_28( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_30( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_EIFFEL_CLASS_INTERFACE to ecom_eiffel_compiler::IEnumEiffelClass *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * ccom_ec_pointed_interface_34( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_EIFFEL_CLASS_INTERFACE] to ecom_eiffel_compiler::IEnumEiffelClass * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumEiffelClass * * ccom_ec_pointed_cell_35( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumEiffelClass * * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_INTERFACE to ecom_eiffel_compiler::IEnumCluster *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * ccom_ec_pointed_interface_38( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_INTERFACE] to ecom_eiffel_compiler::IEnumCluster * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCluster * * ccom_ec_pointed_cell_39( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumCluster * * old );


	/*-----------------------------------------------------------
	Convert IENUM_ASSEMBLY_INTERFACE to ecom_eiffel_compiler::IEnumAssembly *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * ccom_ec_pointed_interface_41( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_ASSEMBLY_INTERFACE] to ecom_eiffel_compiler::IEnumAssembly * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumAssembly * * ccom_ec_pointed_cell_42( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumAssembly * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClusterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * ccom_ec_pointed_interface_45( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterDescriptor * * ccom_ec_pointed_cell_46( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLASS_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelClassDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * ccom_ec_pointed_interface_48( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelClassDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClassDescriptor * * ccom_ec_pointed_cell_49( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClassDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelFeatureDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * ccom_ec_pointed_interface_51( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_FEATURE_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelFeatureDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * * ccom_ec_pointed_cell_52( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelFeatureDescriptor * * old );


	/*-----------------------------------------------------------
	Convert IENUM_FEATURE_INTERFACE to ecom_eiffel_compiler::IEnumFeature *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * ccom_ec_pointed_interface_54( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_FEATURE_INTERFACE] to ecom_eiffel_compiler::IEnumFeature * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumFeature * * ccom_ec_pointed_cell_55( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumFeature * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_56( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_57( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_62( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_63( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [ECOM_ARRAY [STRING]] to SAFEARRAY *  *.
	-----------------------------------------------------------*/
	SAFEARRAY *  * ccom_ec_pointed_cell_66( EIF_REFERENCE eif_ref, SAFEARRAY *  * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_75( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_82( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_83( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_84( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_85( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_PARAMETER_INTERFACE to ecom_eiffel_compiler::IEnumParameter *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * ccom_ec_pointed_interface_87( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_PARAMETER_INTERFACE] to ecom_eiffel_compiler::IEnumParameter * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumParameter * * ccom_ec_pointed_cell_88( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumParameter * * old );


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
	BSTR * ccom_ec_pointed_cell_113( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_114( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE to ecom_eiffel_compiler::IEiffelParameterDescriptor *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * ccom_ec_pointed_interface_117( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE] to ecom_eiffel_compiler::IEiffelParameterDescriptor * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelParameterDescriptor * * ccom_ec_pointed_cell_118( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelParameterDescriptor * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_121( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_122( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelAssemblyProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * ccom_ec_pointed_interface_135( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelAssemblyProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelAssemblyProperties * * ccom_ec_pointed_cell_136( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelAssemblyProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_139( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_140( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_141( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_142( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_148( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_CLUSTERS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemClusters *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * ccom_ec_pointed_interface_159( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_CLUSTERS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemClusters * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemClusters * * ccom_ec_pointed_cell_160( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemClusters * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_EXTERNALS_INTERFACE to ecom_eiffel_compiler::IEiffelSystemExternals *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * ccom_ec_pointed_interface_162( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_EXTERNALS_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemExternals * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemExternals * * ccom_ec_pointed_cell_163( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemExternals * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_164( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE to ecom_eiffel_compiler::IEiffelSystemAssemblies *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * ccom_ec_pointed_interface_166( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE] to ecom_eiffel_compiler::IEiffelSystemAssemblies * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelSystemAssemblies * * ccom_ec_pointed_cell_167( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelSystemAssemblies * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_168( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_169( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_170( EIF_REFERENCE eif_ref, BSTR * old );


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
	Convert IENUM_CLUSTER_PROP_INTERFACE to ecom_eiffel_compiler::IEnumClusterProp *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * ccom_ec_pointed_interface_179( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_PROP_INTERFACE] to ecom_eiffel_compiler::IEnumClusterProp * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterProp * * ccom_ec_pointed_cell_180( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterProp * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_CLUSTER_PROPERTIES_INTERFACE to ecom_eiffel_compiler::IEiffelClusterProperties *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * ccom_ec_pointed_interface_182( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE] to ecom_eiffel_compiler::IEiffelClusterProperties * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelClusterProperties * * ccom_ec_pointed_cell_183( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelClusterProperties * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_185( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_188( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_189( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_CLUSTER_EXCLUDES_INTERFACE to ecom_eiffel_compiler::IEnumClusterExcludes *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * ccom_ec_pointed_interface_200( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_CLUSTER_EXCLUDES_INTERFACE] to ecom_eiffel_compiler::IEnumClusterExcludes * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumClusterExcludes * * ccom_ec_pointed_cell_201( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumClusterExcludes * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_202( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_207( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_208( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_209( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_211( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_INCLUDE_PATHS_INTERFACE to ecom_eiffel_compiler::IEnumIncludePaths *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * ccom_ec_pointed_interface_214( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_INCLUDE_PATHS_INTERFACE] to ecom_eiffel_compiler::IEnumIncludePaths * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumIncludePaths * * ccom_ec_pointed_cell_215( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumIncludePaths * * old );


	/*-----------------------------------------------------------
	Convert IENUM_OBJECT_FILES_INTERFACE to ecom_eiffel_compiler::IEnumObjectFiles *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * ccom_ec_pointed_interface_217( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_OBJECT_FILES_INTERFACE] to ecom_eiffel_compiler::IEnumObjectFiles * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumObjectFiles * * ccom_ec_pointed_cell_218( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumObjectFiles * * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_219( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_221( EIF_REFERENCE eif_ref, BSTR * old );


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
	BSTR * ccom_ec_pointed_cell_231( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert CELL [STRING] to BSTR *.
	-----------------------------------------------------------*/
	BSTR * ccom_ec_pointed_cell_232( EIF_REFERENCE eif_ref, BSTR * old );


	/*-----------------------------------------------------------
	Convert IENUM_COMPLETION_ENTRY_INTERFACE to ecom_eiffel_compiler::IEnumCompletionEntry *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCompletionEntry * ccom_ec_pointed_interface_235( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IENUM_COMPLETION_ENTRY_INTERFACE] to ecom_eiffel_compiler::IEnumCompletionEntry * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEnumCompletionEntry * * ccom_ec_pointed_cell_236( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEnumCompletionEntry * * old );


	/*-----------------------------------------------------------
	Convert IEIFFEL_COMPLETION_ENTRY_INTERFACE to ecom_eiffel_compiler::IEiffelCompletionEntry *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionEntry * ccom_ec_pointed_interface_238( EIF_REFERENCE eif_ref );


	/*-----------------------------------------------------------
	Convert CELL [IEIFFEL_COMPLETION_ENTRY_INTERFACE] to ecom_eiffel_compiler::IEiffelCompletionEntry * *.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::IEiffelCompletionEntry * * ccom_ec_pointed_cell_239( EIF_REFERENCE eif_ref, ecom_eiffel_compiler::IEiffelCompletionEntry * * old );


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
#include "ecom_grt_globals_ISE_c.h"


#endif