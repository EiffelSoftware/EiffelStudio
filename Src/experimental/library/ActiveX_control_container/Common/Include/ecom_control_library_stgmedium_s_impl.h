/*-----------------------------------------------------------
    typedef struct tagSTGMEDIUM {
    DWORD tymed;
    [switch_type(DWORD), switch_is((DWORD) tymed)]
        union
        {
        [case(TYMED_GDI)]
            HBITMAP hBitmap;
        [case(TYMED_MFPICT)]
            HMETAFILEPICT hMetaFilePict;
        [case(TYMED_ENHMF)]
            HENHMETAFILE hEnhMetaFile;
        [case(TYMED_HGLOBAL)]
            HGLOBAL hGlobal;
        [case(TYMED_FILE)]
            LPOLESTR lpszFileName;
        [case(TYMED_ISTREAM)]
            IStream *pstm;
        [case(TYMED_ISTORAGE)]
            IStorage *pstg;
        [default]
                ;
        };
        [unique] IUnknown *pUnkForRelease;
    }STGMEDIUM;

  
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_STGMEDIUM_S_IMPL_H__
#define __ECOM_CONTROL_LIBRARY_STGMEDIUM_S_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_grt_globals_control_interfaces2.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus

#define ccom_stgmedium_tymed(_ptr_) (EIF_INTEGER)(((STGMEDIUM *)_ptr_)->tymed)

#define ccom_stgmedium_set_tymed(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->tymed) = (DWORD)_field_)

#ifdef NONAMELESSUNION

#define ccom_stgmedium_h_bitmap(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->u.hBitmap)

#define ccom_stgmedium_set_h_bitmap(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.hBitmap) = (HBITMAP)_field_)

#define ccom_stgmedium_h_meta_file_pict(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->u.hMetaFilePict)

#define ccom_stgmedium_set_h_meta_file_pict(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.hMetaFilePict) = (HMETAFILEPICT)_field_)

#define ccom_stgmedium_h_enh_meta_file(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->u.hEnhMetaFile)

#define ccom_stgmedium_set_h_enh_meta_file(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.hEnhMetaFile) = (HENHMETAFILE)_field_)

#define ccom_stgmedium_h_global(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->u.hGlobal)

#define ccom_stgmedium_set_h_global(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.hGlobal) = (HGLOBAL)_field_)

#define ccom_stgmedium_lpsz_file_name(_ptr_) (EIF_REFERENCE)rt_ce.ccom_ce_lpwstr((LPWSTR)(((STGMEDIUM *)_ptr_)->u.lpszFileName), NULL)

#define ccom_stgmedium_set_lpsz_file_name(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.lpszFileName) = (LPOLESTR)rt_ec.ccom_ec_lpwstr ((EIF_REFERENCE)_field_, NULL))

#define ccom_stgmedium_pstm(_ptr_) (EIF_REFERENCE)grt_ce_control_interfaces2.ccom_ce_pointed_interface_71(((STGMEDIUM *)_ptr_)->u.pstm)

#define ccom_stgmedium_set_pstm(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.pstm) = (IStream *)_field_)

#define ccom_stgmedium_pstg(_ptr_) (EIF_REFERENCE)grt_ce_control_interfaces2.ccom_ce_pointed_interface_280(((STGMEDIUM *)_ptr_)->u.pstg)

#define ccom_stgmedium_set_pstg(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->u.pstg) = (IStorage *)_field_)

#else /* !NONAMELESSUNION */

#define ccom_stgmedium_h_bitmap(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->hBitmap)

#define ccom_stgmedium_set_h_bitmap(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->hBitmap) = (HBITMAP)_field_)

#define ccom_stgmedium_h_meta_file_pict(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->hMetaFilePict)

#define ccom_stgmedium_set_h_meta_file_pict(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->hMetaFilePict) = (HMETAFILEPICT)_field_)

#define ccom_stgmedium_h_enh_meta_file(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->hEnhMetaFile)

#define ccom_stgmedium_set_h_enh_meta_file(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->hEnhMetaFile) = (HENHMETAFILE)_field_)

#define ccom_stgmedium_h_global(_ptr_) (EIF_POINTER)(((STGMEDIUM *)_ptr_)->hGlobal)

#define ccom_stgmedium_set_h_global(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->hGlobal) = (HGLOBAL)_field_)

#define ccom_stgmedium_lpsz_file_name(_ptr_) (EIF_REFERENCE)rt_ce.ccom_ce_lpwstr((LPWSTR)(((STGMEDIUM *)_ptr_)->lpszFileName), NULL)

#define ccom_stgmedium_set_lpsz_file_name(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->lpszFileName) = (LPOLESTR)rt_ec.ccom_ec_lpwstr ((EIF_REFERENCE)_field_, NULL))

#define ccom_stgmedium_pstm(_ptr_) (EIF_REFERENCE)grt_ce_control_interfaces2.ccom_ce_pointed_interface_71(((STGMEDIUM *)_ptr_)->pstm)

#define ccom_stgmedium_set_pstm(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->pstm) = (IStream *)_field_)

#define ccom_stgmedium_pstg(_ptr_) (EIF_REFERENCE)grt_ce_control_interfaces2.ccom_ce_pointed_interface_280(((STGMEDIUM *)_ptr_)->pstg)

#define ccom_stgmedium_set_pstg(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->pstg) = (IStorage *)_field_)

#endif /* !NONAMELESSUNION */

#define ccom_stgmedium_p_unk_for_release(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_pointed_unknown (((STGMEDIUM *)_ptr_)->pUnkForRelease))

#define ccom_stgmedium_set_p_unk_for_release(_ptr_, _field_) ((((STGMEDIUM *)_ptr_)->pUnkForRelease) = (IUnknown *)_field_)

#endif
#ifdef __cplusplus
}
#endif

#endif
