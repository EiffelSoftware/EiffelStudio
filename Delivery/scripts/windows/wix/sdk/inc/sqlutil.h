#pragma once
//-------------------------------------------------------------------------------------------------
// <copyright file="sqlutil.h" company="Microsoft">
//    Copyright (c) Microsoft Corporation.  All rights reserved.
//
//    The use and distribution terms for this software are covered by the
//    Common Public License 1.0 (http://opensource.org/licenses/cpl.php)
//    which can be found in the file CPL.TXT at the root of this distribution.
//    By using this software in any fashion, you are agreeing to be bound by
//    the terms of this license.
//
//    You must not remove this notice, or any other, from this software.
// </copyright>
// 
// <summary>
//    SQL helper functions.
// </summary>
//-------------------------------------------------------------------------------------------------

#include <cguid.h>
#include <oledberr.h>
#include <msdasc.h>
#include <sqloledb.h>


#ifdef __cplusplus
extern "C" {
#endif

// structs
struct SQL_FILESPEC
{
	WCHAR wzName[MAX_PATH];
	WCHAR wzFilename[MAX_PATH];
	WCHAR wzSize[MAX_PATH];
	WCHAR wzMaxSize[MAX_PATH];
	WCHAR wzGrow[MAX_PATH];
};


// functions
HRESULT DAPI SqlConnectDatabase(
	__in LPCWSTR wzServer, 
	__in LPCWSTR wzInstance,
	__in LPCWSTR wzDatabase, 
	__in BOOL fIntegratedAuth, 
	__in LPCWSTR wzUser, 
	__in LPCWSTR wzPassword, 
	__out IDBCreateSession** ppidbSession
	);
HRESULT DAPI SqlStartTransaction(
	__in IDBCreateSession* pidbSession,
	__out IDBCreateCommand** ppidbCommand,
	__out ITransaction** ppit
	);
HRESULT DAPI SqlEndTransaction(
	__in ITransaction* pit,
	__in BOOL fCommit
	);
HRESULT DAPI SqlDatabaseExists(
	__in LPCWSTR wzServer,
	__in LPCWSTR wzInstance,
	__in LPCWSTR wzDatabase,
	__in BOOL fIntegratedAuth,
	__in LPCWSTR wzUser,
	__in LPCWSTR wzPassword,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlSessionDatabaseExists(
	__in IDBCreateSession* pidbSession,
	__in LPCWSTR wzDatabase,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlDatabaseEnsureExists(
	__in LPCWSTR wzServer,
	__in LPCWSTR wzInstance,
	__in LPCWSTR wzDatabase,
	__in BOOL fIntegratedAuth,
	__in LPCWSTR wzUser,
	__in LPCWSTR wzPassword,
	__in SQL_FILESPEC* psfDatabase,
	__in SQL_FILESPEC* psfLog,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlSessionDatabaseEnsureExists(
	__in IDBCreateSession* pidbSession,
	__in LPCWSTR wzDatabase,
	__in SQL_FILESPEC* psfDatabase,
	__in SQL_FILESPEC* psfLog,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlCreateDatabase(
	__in LPCWSTR wzServer,
	__in LPCWSTR wzInstance,
	__in LPCWSTR wzDatabase,
	__in BOOL fIntegratedAuth,
	__in LPCWSTR wzUser,
	__in LPCWSTR wzPassword,
	__in SQL_FILESPEC* psfDatabase,
	__in SQL_FILESPEC* psfLog,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlSessionCreateDatabase(
	__in IDBCreateSession* pidbSession,
	__in LPCWSTR wzDatabase,
	__in SQL_FILESPEC* psfDatabase,
	__in SQL_FILESPEC* psfLog,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlDropDatabase(
	__in LPCWSTR wzServer,
	__in LPCWSTR wzInstance,
	__in LPCWSTR wzDatabase,
	__in BOOL fIntegratedAuth,
	__in LPCWSTR wzUser,
	__in LPCWSTR wzPassword,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlSessionDropDatabase(
	__in IDBCreateSession* pidbSession,
	__in LPCWSTR wzDatabase,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlSessionExecuteQuery(
	__in IDBCreateSession* pidbSession, 
	__in LPCWSTR wzSql, 
	__out_opt IRowset** ppirs,
	__out_opt DBROWCOUNT* pcRows,
	__out BSTR* pbstrErrorDescription
	);
HRESULT DAPI SqlCommandExecuteQuery(
	__in IDBCreateCommand* pidbCommand, 
	__in LPCWSTR wzSql, 
	__out IRowset** ppirs,
	__out DBROWCOUNT* pcRows
	);
HRESULT DAPI SqlGetErrorInfo(
	__in IUnknown* pObjectWithError,
	__in REFIID IID_InterfaceWithError,
	__in DWORD dwLocaleId,
	__out_opt BSTR* pbstrErrorSource,
	__out BSTR* pbstrErrorDescription
	);

#ifdef __cplusplus
}
#endif
