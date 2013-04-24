/*
indexing
	description: "[
		Implementation for the WEL_USER_VALIDATION class. It was inspired from
		the following Microsoft knowledge base:
			http://support.microsoft.com/kb/180548
		]"
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Avenue, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/


#define SECURITY_WIN32
#include <windows.h>
#include <sspi.h>
#include <lm.h>
#include <lmcons.h>
#include "eif_portable.h"
#include "eif_eiffel.h"

typedef struct _AUTH_SEQ {
	BOOL fInitialized;
	BOOL fHaveCredHandle;
	BOOL fHaveCtxtHandle;
	CredHandle hcred;
	struct _SecHandle hctxt;
} AUTH_SEQ;

/* Function pointer for dynamic loading of secur32.dll */
ACCEPT_SECURITY_CONTEXT_FN _AcceptSecurityContext = NULL;
ACQUIRE_CREDENTIALS_HANDLE_FN _AcquireCredentialsHandle = NULL;
COMPLETE_AUTH_TOKEN_FN _CompleteAuthToken = NULL;
DELETE_SECURITY_CONTEXT_FN _DeleteSecurityContext = NULL;
FREE_CONTEXT_BUFFER_FN _FreeContextBuffer = NULL;
FREE_CREDENTIALS_HANDLE_FN _FreeCredentialsHandle = NULL;
INITIALIZE_SECURITY_CONTEXT_FN _InitializeSecurityContext = NULL;
QUERY_SECURITY_PACKAGE_INFO_FN _QuerySecurityPackageInfo = NULL;
QUERY_SECURITY_CONTEXT_TOKEN_FN _QuerySecurityContextToken = NULL;

/* Function pointer for dynamic loading of netapi32.dll */
NET_API_STATUS (__stdcall * _NetUserModalsGet) (LPCWSTR, DWORD, LPBYTE *) = NULL;
NET_API_STATUS (__stdcall * _NetApiBufferFree) (LPVOID) = NULL;

rt_private void unload_netapi32_dll (HMODULE hModule)
{
	if (hModule) {
		FreeLibrary(hModule);
	}

	_NetUserModalsGet = NULL;
	_NetApiBufferFree = NULL;
}

rt_private HMODULE load_netapi32_dll () 
{
	HMODULE Result = NULL;

	Result = LoadLibrary(L"netapi32.dll");
	if (Result) {
		_NetUserModalsGet = (NET_API_STATUS (__stdcall *) (LPCWSTR, DWORD, LPBYTE *)) GetProcAddress(Result, "NetUserModalsGet");
		_NetApiBufferFree = (NET_API_STATUS (__stdcall *) (LPVOID)) GetProcAddress(Result, "NetApiBufferFree");

		if (!_NetUserModalsGet || !_NetApiBufferFree) {
			unload_netapi32_dll (Result);
			Result = NULL;
		}
	}
	return Result;
}


rt_private void unload_secur32_dll (HMODULE hModule)
{
	if (hModule) {
		FreeLibrary(hModule);
	}

	_AcceptSecurityContext = NULL;
	_AcquireCredentialsHandle = NULL;
	_CompleteAuthToken = NULL;
	_DeleteSecurityContext = NULL;
	_FreeContextBuffer = NULL;
	_FreeCredentialsHandle = NULL;
	_InitializeSecurityContext = NULL;
	_QuerySecurityPackageInfo = NULL;
	_QuerySecurityContextToken = NULL;
}

rt_private HMODULE load_secur32_dll () 
{
	HMODULE Result = NULL;

	Result = LoadLibrary(L"secur32.dll");
	if (Result) {
		_AcceptSecurityContext = (ACCEPT_SECURITY_CONTEXT_FN) GetProcAddress(Result, "AcceptSecurityContext");
		_AcquireCredentialsHandle = (ACQUIRE_CREDENTIALS_HANDLE_FN) GetProcAddress(Result, "AcquireCredentialsHandleW");
		_CompleteAuthToken = (COMPLETE_AUTH_TOKEN_FN) GetProcAddress(Result, "CompleteAuthToken");
		_DeleteSecurityContext = (DELETE_SECURITY_CONTEXT_FN) GetProcAddress(Result, "DeleteSecurityContext");
		_FreeContextBuffer = (FREE_CONTEXT_BUFFER_FN) GetProcAddress(Result, "FreeContextBuffer");
		_FreeCredentialsHandle = (FREE_CREDENTIALS_HANDLE_FN) GetProcAddress(Result, "FreeCredentialsHandle");
		_InitializeSecurityContext = (INITIALIZE_SECURITY_CONTEXT_FN) GetProcAddress(Result, "InitializeSecurityContextW");
		_QuerySecurityPackageInfo = (QUERY_SECURITY_PACKAGE_INFO_FN) GetProcAddress(Result, "QuerySecurityPackageInfoW");
		_QuerySecurityContextToken = (QUERY_SECURITY_CONTEXT_TOKEN_FN) GetProcAddress(Result, "QuerySecurityContextToken");

		if
			(!_AcceptSecurityContext || !_AcquireCredentialsHandle || !_CompleteAuthToken ||
			 !_DeleteSecurityContext || !_FreeContextBuffer || !_FreeCredentialsHandle ||
			 !_InitializeSecurityContext || !_QuerySecurityPackageInfo || !_QuerySecurityContextToken)
		{
			unload_secur32_dll(Result);
			Result = NULL;
		}
	}
	return Result;
}


rt_private LPVOID retrieve_token_information_class (HANDLE hToken, TOKEN_INFORMATION_CLASS InfoClass, LPDWORD lpdwSize)
{
	LPVOID pInfo = NULL;
	*lpdwSize = 0;

		/* Determine the size of the buffer needed */
	if (GetTokenInformation (hToken, InfoClass, NULL, *lpdwSize, lpdwSize)) {
			/* Allocate a buffer for getting token information */
		pInfo = LocalAlloc(LPTR, *lpdwSize);
		if (pInfo != NULL) {
			if (!GetTokenInformation(hToken, InfoClass, pInfo, *lpdwSize, lpdwSize)) {
					/* Error, we need to free `pInfo'. */
				LocalFree(pInfo);
			}
		}
	}
	return pInfo;
}

rt_private PSID get_user_sid_from_rid (DWORD Rid)
{
	PUSER_MODALS_INFO_2 umi2;
	NET_API_STATUS nas;

	UCHAR SubAuthorityCount;
	PSID pSid = NULL;
	HMODULE hModule;

	hModule = load_netapi32_dll();
	if (hModule) {
		nas = _NetUserModalsGet(NULL, 2, (LPBYTE *)&umi2);

		if (nas != NERR_Success) {
			SetLastError(nas);
		} else {
			SubAuthorityCount = *GetSidSubAuthorityCount (umi2->usrmod2_domain_id);

				/* Allocate storage for new Sid. account domain Sid + account Rid */
			pSid = (PSID) LocalAlloc(LPTR, GetSidLengthRequired((UCHAR)(SubAuthorityCount + 1)));
			if (pSid != NULL) {
				if (InitializeSid( pSid, GetSidIdentifierAuthority(umi2->usrmod2_domain_id), (BYTE)(SubAuthorityCount+1))) {
					DWORD SubAuthIndex = 0;
						/* Copy existing subauthorities from account domain Sid into new Sid. */

					for (; SubAuthIndex < SubAuthorityCount ; SubAuthIndex++) {
						*GetSidSubAuthority(pSid, SubAuthIndex) =
						*GetSidSubAuthority(umi2->usrmod2_domain_id, SubAuthIndex);
					} 
						/* Append Rid to new Sid. */
					*GetSidSubAuthority(pSid, SubAuthorityCount) = Rid;
				}
			}
			_NetApiBufferFree(umi2);
		}
		unload_netapi32_dll (hModule);
	}
	return pSid;
}

rt_private int is_guest (HANDLE hToken)
{
	int Result = 0;
	PSID pGuestSid = NULL;
	TOKEN_USER *pUserInfo = NULL;
	DWORD dwSize = 0;

	pGuestSid = get_user_sid_from_rid (DOMAIN_USER_RID_GUEST);
	if (pGuestSid) {
			/* Get user information */
		pUserInfo = (TOKEN_USER *)retrieve_token_information_class(hToken, TokenUser, &dwSize);
		if (pUserInfo != NULL) {
			Result = EqualSid(pGuestSid, pUserInfo->User.Sid);
			LocalFree(pUserInfo);
		}
		LocalFree(pGuestSid);
	}
	return Result;
}

rt_private BOOL get_client_context (AUTH_SEQ *pAS, PSEC_WINNT_AUTH_IDENTITY pAuthIdentity,
		PVOID pIn, DWORD cbIn, PVOID pOut, PDWORD pcbOut, PBOOL pfDone)
{
/*
 Routine Description:
	Optionally takes an input buffer coming from the server and returns
	a buffer of information to send back to the server. Also returns
	an indication of whether or not the context is complete.

 Return Value:
	Returns TRUE if successful; otherwise FALSE.
*/

	SECURITY_STATUS ss;
	TimeStamp tsExpiry;
	SecBufferDesc sbdOut;
	SecBuffer sbOut;
	SecBufferDesc sbdIn;
	SecBuffer sbIn;
	ULONG fContextAttr;

	if (!pAS->fInitialized) {

		ss = _AcquireCredentialsHandle(NULL, L"NTLM",
				SECPKG_CRED_OUTBOUND, NULL, pAuthIdentity, NULL, NULL,
				&pAS->hcred, &tsExpiry);
		if (ss < 0) {
			return FALSE;
		}

		pAS->fHaveCredHandle = TRUE;
	}

		/* Prepare output buffer */
	sbdOut.ulVersion = 0;
	sbdOut.cBuffers = 1;
	sbdOut.pBuffers = &sbOut;

	sbOut.cbBuffer = *pcbOut;
	sbOut.BufferType = SECBUFFER_TOKEN;
	sbOut.pvBuffer = pOut;

		/* Prepare input buffer */
	if (pAS->fInitialized) {
		sbdIn.ulVersion = 0;
		sbdIn.cBuffers = 1;
		sbdIn.pBuffers = &sbIn;

		sbIn.cbBuffer = cbIn;
		sbIn.BufferType = SECBUFFER_TOKEN;
		sbIn.pvBuffer = pIn;
	}

	ss = _InitializeSecurityContext(&pAS->hcred,
			pAS->fInitialized ? &pAS->hctxt : NULL, NULL, 0, 0,
			SECURITY_NATIVE_DREP, pAS->fInitialized ? &sbdIn : NULL,
			0, &pAS->hctxt, &sbdOut, &fContextAttr, &tsExpiry);
	if (ss < 0) {
		return FALSE;
	}

	pAS->fHaveCtxtHandle = TRUE;

		/* If necessary, complete token */
	if (ss == SEC_I_COMPLETE_NEEDED || ss == SEC_I_COMPLETE_AND_CONTINUE) {

		ss = _CompleteAuthToken(&pAS->hctxt, &sbdOut);
		if (ss < 0) {
			return FALSE;
		}
	}

	*pcbOut = sbOut.cbBuffer;

	if (!pAS->fInitialized)
		pAS->fInitialized = TRUE;

	*pfDone = !(ss == SEC_I_CONTINUE_NEEDED || ss == SEC_I_COMPLETE_AND_CONTINUE );

	return TRUE;
}


rt_private BOOL get_server_context(AUTH_SEQ *pAS, PVOID pIn, DWORD cbIn, PVOID pOut, PDWORD pcbOut, PBOOL pfDone)
{
/*
 Routine Description:
	Takes an input buffer coming from the client and returns a buffer
	to be sent to the client. Also returns an indication of whether or
	not the context is complete.

 Return Value:
	Returns TRUE if successful; otherwise FALSE.
*/

	SECURITY_STATUS ss;
	TimeStamp tsExpiry;
	SecBufferDesc sbdOut;
	SecBuffer sbOut;
	SecBufferDesc sbdIn;
	SecBuffer sbIn;
	ULONG fContextAttr;

	if (!pAS->fInitialized) {

		ss = _AcquireCredentialsHandle(NULL, L"NTLM",
				SECPKG_CRED_INBOUND, NULL, NULL, NULL, NULL, &pAS->hcred,
				&tsExpiry);
		if (ss < 0) {
			return FALSE;
		}

		pAS->fHaveCredHandle = TRUE;
	}

		/* Prepare output buffer */
	sbdOut.ulVersion = 0;
	sbdOut.cBuffers = 1;
	sbdOut.pBuffers = &sbOut;

	sbOut.cbBuffer = *pcbOut;
	sbOut.BufferType = SECBUFFER_TOKEN;
	sbOut.pvBuffer = pOut;

		/* Prepare input buffer */
	sbdIn.ulVersion = 0;
	sbdIn.cBuffers = 1;
	sbdIn.pBuffers = &sbIn;

	sbIn.cbBuffer = cbIn;
	sbIn.BufferType = SECBUFFER_TOKEN;
	sbIn.pvBuffer = pIn;

	ss = _AcceptSecurityContext(&pAS->hcred,
			pAS->fInitialized ? &pAS->hctxt : NULL, &sbdIn, 0,
			SECURITY_NATIVE_DREP, &pAS->hctxt, &sbdOut, &fContextAttr,
			&tsExpiry);
	if (ss < 0) {
		return FALSE;
	} else {
		pAS->fHaveCtxtHandle = TRUE;

			/* If necessary, complete token */
		if (ss == SEC_I_COMPLETE_NEEDED || ss == SEC_I_COMPLETE_AND_CONTINUE) {

			ss = _CompleteAuthToken(&pAS->hctxt, &sbdOut);
			if (ss < 0) {
				return FALSE;
			}
		}

		*pcbOut = sbOut.cbBuffer;

		if (!pAS->fInitialized) {
			pAS->fInitialized = TRUE;
		}

		*pfDone = !(ss == SEC_I_CONTINUE_NEEDED || ss == SEC_I_COMPLETE_AND_CONTINUE);

		return TRUE;
	}
}

EIF_BOOLEAN cwel_is_credential_valid (LPTSTR szDomain, LPTSTR szUser, LPTSTR szPassword)
{
	AUTH_SEQ asServer = {0};
	AUTH_SEQ asClient = {0};
	BOOL fDone = FALSE;
	EIF_BOOLEAN Result = EIF_FALSE;
	DWORD cbOut = 0;
	DWORD cbIn = 0;
	DWORD cbMaxToken = 0;
	PVOID pClientBuf = NULL;
	PVOID pServerBuf = NULL;
	PSecPkgInfo pSPI = NULL;
	HMODULE hModule = NULL;

	SEC_WINNT_AUTH_IDENTITY ai;

	hModule = load_secur32_dll ();
	if (hModule) {
			/* Get max token size */
		_QuerySecurityPackageInfo(L"NTLM", &pSPI);
		cbMaxToken = pSPI->cbMaxToken;
		_FreeContextBuffer(pSPI);

			/* Allocate buffers for client and server messages */
		pClientBuf = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, cbMaxToken);
		pServerBuf = HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, cbMaxToken);

			/* Initialize auth identity structure */
		ZeroMemory(&ai, sizeof(ai));
		ai.Domain = szDomain;
		ai.DomainLength = lstrlen(szDomain);
		ai.User = szUser;
		ai.UserLength = lstrlen(szUser);
		ai.Password = szPassword;
		ai.PasswordLength = lstrlen(szPassword);
		ai.Flags = SEC_WINNT_AUTH_IDENTITY_UNICODE;

			/* Prepare client message (negotiate). */
		cbOut = cbMaxToken;
		if (get_client_context (&asClient, &ai, NULL, 0, pClientBuf, &cbOut, &fDone)) {
				/* Prepare server message (challenge). */
			cbIn = cbOut;
			cbOut = cbMaxToken;
			if (!get_server_context(&asServer, pClientBuf, cbIn, pServerBuf, &cbOut, &fDone)) {
				/* Most likely failure: AcceptServerContext fails with SEC_E_LOGON_DENIED
				 * in the case of bad szUser or szPassword.
				 * Unexpected Result: Logon will succeed if you pass in a bad szUser and
				 * the guest account is enabled in the specified domain. */
			} else {
					/* Prepare client message (authenticate). */
				cbIn = cbOut;
				cbOut = cbMaxToken;
				if (get_client_context (&asClient, &ai, pServerBuf, cbIn, pClientBuf, &cbOut, &fDone)) {
						/* Prepare server message (authentication). */
					cbIn = cbOut;
					cbOut = cbMaxToken;
					if (get_server_context(&asServer, pClientBuf, cbIn, pServerBuf, &cbOut, &fDone)) {
						Result = EIF_TRUE;
						{
							HANDLE hToken = NULL;
							if (_QuerySecurityContextToken(&asServer.hctxt, &hToken) == 0) {
								if (is_guest (hToken)) {
									Result = EIF_FALSE;
								}
								CloseHandle(hToken);
							}
						}
					}
				}
			}
		}

			/* Clean up resources. */
		if (asClient.fHaveCtxtHandle) {
			_DeleteSecurityContext(&asClient.hctxt);
		}

		if (asClient.fHaveCredHandle) {
			_FreeCredentialsHandle(&asClient.hcred);
		}

		if (asServer.fHaveCtxtHandle) {
			_DeleteSecurityContext(&asServer.hctxt);
		}

		if (asServer.fHaveCredHandle) {
			_FreeCredentialsHandle(&asServer.hcred);
		}

		unload_secur32_dll (hModule);

		HeapFree(GetProcessHeap(), 0, pClientBuf);
		HeapFree(GetProcessHeap(), 0, pServerBuf);
	}

	return Result;
}
