#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers
#include <stdio.h>
#include "cor.h"
#include "assembly_helper.h" // This include

//-------------------------------------------------------------------------------------------------
// GetAssemblyProperties
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// Retrieve the properties for the assembly whose filename is `pszFilename'
//-------------------------------------------------------------------------------------------------
bool GetAssemblyProperties(
		const char* pszFilename,
		char* pszAssemblyName,
		ULONG chAssemblyName,
		unsigned short* pusMajor, 
		unsigned short* pusMinor,
		unsigned short* pusRevision,
		unsigned short* pusBuild
		)
	{
	int nDesiredSize = MultiByteToWideChar(
		CP_ACP,			// code page
		0,				// character-type options
		pszFilename,	// string to map
		-1,				// number of bytes in string
		NULL,			// wide-character buffer
		0);				// size of buffer
	LPWSTR pwszAssemblyFilename = new WCHAR[nDesiredSize];
	MultiByteToWideChar(
		CP_ACP,					// code page
		0,						// character-type options
		pszFilename,			// string to map
		-1,						// number of bytes in string
		pwszAssemblyFilename,	// wide-character buffer
		nDesiredSize);			// size of buffer

	HRESULT hr = CoInitialize(NULL);
	if (!(hr == S_OK || hr == S_FALSE))
		return FALSE;

	IMetaDataDispenser* pIMetaDataDispenser;
	hr = CoCreateInstance(
					CLSID_CorMetaDataDispenser,	
					0,
					CLSCTX_INPROC_SERVER,
					IID_IMetaDataDispenser,
					(LPVOID *)&pIMetaDataDispenser);
	if (hr != S_OK)
		return FALSE;
	 
	// After obtaining the IMetaDataDispenser, the next step is to call its ::OpenScope method, 
	// specifying the IID of the interface you want. In this case, the scope is the name of the
	// assembly file. The IID you're interested in is IID_IMetaDataImport.
	IMetaDataAssemblyImport* pIMetaDataAssemblyImport;
	hr = pIMetaDataDispenser->OpenScope(
								pwszAssemblyFilename,
								0,
								IID_IMetaDataAssemblyImport,
								(LPUNKNOWN *)&pIMetaDataAssemblyImport);
	if (hr != S_OK)
		return FALSE;
	
	mdAssembly ptkAssembly;
	hr = pIMetaDataAssemblyImport->GetAssemblyFromScope(&ptkAssembly);
	if (hr != S_OK)
		return FALSE;

	const void* pbOriginator;
	ULONG cbOriginator;
	ULONG ulHashAlgId;
	WCHAR szName[2048];
	WCHAR szTitle[2048];
	WCHAR szDescription[2048];
	WCHAR szDefaultAlias[2048];
	ULONG chName;
	ULONG chTitle;
	ULONG chDescription;
	ULONG chDefaultAlias;

	ASSEMBLYMETADATA stMetaData;
	WCHAR szLocale[2048];
	WCHAR szConfiguration[2048];
	DWORD aProcessor[2];
	OSINFO aOS[2];
	stMetaData.szLocale = szLocale;
	stMetaData.cbLocale = 2048;
	stMetaData.rProcessor = aProcessor;
    stMetaData.ulProcessor = 2;
	stMetaData.rOS = aOS;
    stMetaData.ulOS = 2;
	stMetaData.szConfiguration = szConfiguration;
    stMetaData.cbConfiguration = 2048;

	DWORD dwAssemblyFlags;
	hr = pIMetaDataAssemblyImport->GetAssemblyProps(		// S_OK	or error.
										ptkAssembly,		// [IN]	The	Assembly for which to get the properties.
										&pbOriginator,		// [OUT] Pointer to	the	Originator blob.
										&cbOriginator,		// [OUT] Count of bytes	in the Originator Blob.
										&ulHashAlgId,		// [OUT] Hash Algorithm.
										szName,				// [OUT] Buffer	to fill	with name.
										2048,				// [IN]	Size of	buffer in wide chars.
										&chName,			// [OUT] Actual	# of wide chars	in name.
										&stMetaData,		// [OUT] Assembly MetaData.
										szTitle,			// [OUT] Title of the Assembly.
										2048,				// [IN]	Size of	buffer in wide chars.
										&chTitle,			// [OUT] Actual	# of wide chars.
										szDescription,		// [OUT] Description for the Assembly.
										2048,				// [IN]	Size of	buffer in wide chars.
										&chDescription,		// [OUT] Acutal	# of wide chars	in buffer.
										szDefaultAlias,		// [OUT] Default alias for the Assembly.
										2048,				// [IN]	Size of	buffer in wide chars.
										&chDefaultAlias,	// [OUT] Acutal	# of wide chars	in buffer.
										&dwAssemblyFlags);	// [OUT] Flags.
	if (hr != S_OK)
		return FALSE;

	*pusMajor = stMetaData.usMajorVersion;
	*pusMinor = stMetaData.usMinorVersion;
	*pusRevision = stMetaData.usRevisionNumber;
	*pusBuild = stMetaData.usBuildNumber;

	WideCharToMultiByte(
		CP_ACP,				// code page
		0,					// performance and mapping flags
		szName,				// wide-character string
		2048,				// number of chars in string
		pszAssemblyName,	// buffer for new string
		chAssemblyName,		// size of buffer
		NULL,				// default for unmappable chars
		NULL);				// set when default char used

	delete pwszAssemblyFilename;
	pIMetaDataDispenser->Release();
	pIMetaDataAssemblyImport->Release();
	return true;
	}
 
//-------------------------------------------------------------------------------------------------
// c_get_assembly_properties
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
// Retrieve the properties for the assembly whose filename is `pszFilename'
//-------------------------------------------------------------------------------------------------
void RetrieveAssemblyProperties(
		void* pCurrObject, 
		char* pszFileName, 
		void (*UpdateAssemblyProperties)(void*, char*, DWORD, DWORD, DWORD, DWORD)
		)
	{
//DebugBreak();
	ULONG chAssemblyName = 2048;
	unsigned short usMajor, usMinor, usBuild, usRevision;
	LPSTR pszAssemblyName = new CHAR[chAssemblyName];

	if (GetAssemblyProperties(pszFileName, pszAssemblyName, chAssemblyName, &usMajor, &usMinor, &usRevision, &usBuild))
		UpdateAssemblyProperties(pCurrObject, pszAssemblyName, usMajor, usMinor, usRevision, usBuild);
	else
		UpdateAssemblyProperties(pCurrObject, NULL, 0, 0, 0, 0);

	delete pszAssemblyName;
	}

//-------------------------------------------------------------------------------------------------
// Testing purpose
//-------------------------------------------------------------------------------------------------
/*int main(int argc, char* argv[])
{
	ULONG chAssemblyName = 2048;
	unsigned short usMajor, usMinor, usBuild, usRevision;
	LPSTR pszAssemblyName = new CHAR[chAssemblyName];

	GetAssemblyProperties("C:\\WINNT\\Microsoft.NET\\Framework\\v1.0.2204\\mscorlib.dll", pszAssemblyName, chAssemblyName, &usMajor, &usMinor, &usRevision, &usBuild);
//	GetAssemblyProperties(".", pszAssemblyName, chAssemblyName, &usMajor, &usMinor, &usRevision, &usBuild);

	delete pszAssemblyName;
	return 0;
}*/

