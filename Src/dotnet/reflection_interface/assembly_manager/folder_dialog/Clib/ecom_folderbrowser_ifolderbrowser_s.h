/*-----------------------------------------------------------
browse folder library. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_FOLDERBROWSER_IFOLDERBROWSER_S_H__
#define __ECOM_FOLDERBROWSER_IFOLDERBROWSER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_FolderBrowser_IFolderBrowser_FWD_DEFINED__
#define __ecom_FolderBrowser_IFolderBrowser_FWD_DEFINED__
namespace ecom_FolderBrowser
{
class IFolderBrowser;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_FolderBrowser_IFolderBrowser_INTERFACE_DEFINED__
#define __ecom_FolderBrowser_IFolderBrowser_INTERFACE_DEFINED__
namespace ecom_FolderBrowser
{
class IFolderBrowser : public IUnknown
{
public:
	IFolderBrowser () {};
	~IFolderBrowser () {};

	/*-----------------------------------------------------------
	Folder chosen by the user.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FolderName(  /* [out] */ LPWSTR * result1 ) = 0;


	/*-----------------------------------------------------------
	Set initial folder name.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetStartingFolder(  /* [in] */ LPWSTR * result1 ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif