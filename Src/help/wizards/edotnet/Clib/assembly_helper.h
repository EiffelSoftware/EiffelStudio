// Assembly_helper.h 

#ifndef __ASSEMBLY_HELPER_H__
#define __ASSEMBLY_HELPER_H__

#ifdef __cplusplus
extern "C" {
#endif

//-------------------------------------------------------------------------------------------------
// c_get_assembly_properties
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// Retrieve the properties for the assembly whose filename is `pszFilename'
//-------------------------------------------------------------------------------------------------
void RetrieveAssemblyProperties(
		void* pCurrObject, 
		char* pszFileName, 
		void (*UpdateAssemblyProperties)(void*, char*, DWORD, DWORD, DWORD, DWORD)
		);

#ifdef __cplusplus
}
#endif

#endif // __ASSEMBLY_HELPER_H__
