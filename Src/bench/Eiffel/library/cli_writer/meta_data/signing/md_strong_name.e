indexing
	description: "Plain encapsulation of StrongName API"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

inherit
	IL_ENVIRONMENT

feature -- Status report

	present: BOOLEAN is
			-- True if `mscorsn.dll' is available, False otherwise.
			-- Append path to `mscorsn.dll' to PATH environment variable.
		local
			l_val: INTEGER
			retried, success: BOOLEAN
			path, path_name: WEL_STRING
			s: STRING
		once
			if not retried and is_dotnet_installed then
					-- We try to call `get_error'. If the DLL exists, it 
					-- will work, if it does not exist it will not reach
					-- `Result := True', thus `Result' will be False.
				create path.make_empty (32767) -- Max size of env. var is 32767 characters
				create path_name.make ("PATH")
				l_val := get_environment_variable (path_name.item, path.item, 32767)
				if l_val > 0 then
					s := path.string
					s.append (";" + dotnet_framework_path)
					create path.make (s)
					success := set_environment_variable (path_name.item, path.item)
				end
				l_val := get_error
				Result := True
			end
		rescue
			retried := True
			retry
		end
		
feature -- Constants

	sn_leave_key: INTEGER is 0x00000001
			-- Flags for StrongNameKeyGen.
			-- Leave key pair registered with CSP.

feature -- C externals

	get_error: INTEGER is
			-- Retrieve error code if any.
		external
			"dllwin mscorsn.dll signature : EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameErrorInfo"
		end
		
	strong_name_free_buffer (a_key_blob: POINTER) is
			-- Free buffer allocated by routines below.
		external
			"dllwin mscorsn.dll signature (BYTE *) use <StrongName.h>"
		alias
			"StrongNameFreeBuffer"
		end

	strong_name_key_gen (a_container_name: POINTER; flags: INTEGER;
			a_public_key, a_key_size: POINTER): INTEGER
		is
			-- Generate a new key pair for strong name use.
		external
			"dllwin mscorsn.dll signature (LPCWSTR, DWORD, BYTE **, ULONG *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyGen"
		end

	strong_name_install (a_container_name: POINTER; a_public_key: POINTER;
			a_key_size: INTEGER): INTEGER
		is
			-- Import key pair into a key container.
		external
			"dllwin mscorsn.dll signature (LPCWSTR, BYTE *, ULONG): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyInstall"
		end
		
	strong_name_delete (a_container_name: POINTER): INTEGER is
			-- Import key pair into a key container.
		external
			"dllwin mscorsn.dll signature (LPCWSTR): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyDelete"
		end

	strong_name_get_public_key (a_container_name: POINTER; a_key_blob: POINTER;
			a_key_blob_size: INTEGER; a_public_key: POINTER; a_public_key_size: POINTER): INTEGER
		is
			-- Retrieve the public portion of a key pair.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameGetPublicKey"
		end

	strong_name_hash_size (a_hash_alg: INTEGER; a_hash_size: POINTER): INTEGER is
			-- Compute size of buffer in `a_hash_size' needed to hold a hash
			-- for a given hash algorithm `a_hash_alg'.
		external
			"dllwin mscorsn.dll signature (ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameHashSize"
		end

	strong_name_signature_size (a_public_key: POINTER; a_key_size: INTEGER;
			a_hash_size: POINTER): INTEGER
		is
			-- Compute size that needs to be allocated for a signature in an assembly.
		external
			"dllwin mscorsn.dll signature (BYTE *, ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameSignatureSize"
		end

	strong_name_signature_generation (a_file_path, a_container, a_public_key: POINTER;
			a_public_key_size: INTEGER; a_hash_buffer, a_hash_buffer_size: POINTER): INTEGER
		is
			-- Hash and sign a manifest.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameSignatureGeneration"
		end
	
	strong_name_token_from_public_key (public_key: POINTER; key_length: INTEGER;
			token, token_lenght: POINTER): INTEGER
		is
			-- Create a strong name token from a public key blob.
		external
			"[
				dllwin mscorsn.dll signature (BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameTokenFromPublicKey"
		end
		
	get_hash_from_assembly_file (a_file_path: POINTER; a_hash_alg_id: POINTER;
			a_hash_buffer: POINTER; a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER
		is
			-- Compute hash of `a_blob' using `a_hash_alg_id'.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"GetHashFromAssemblyFileW"
		end
			
	get_hash_from_blob (a_blob: POINTER; a_blob_size: INTEGER; a_hash_alg_id: POINTER;
			a_hash_buffer: POINTER; a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER
		is
				-- Compute hash of `a_blob' using `a_hash_alg_id'.
		external
			"[
				dllwin mscorsn.dll
				signature (BYTE *, DWORD, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"GetHashFromBlob"
		end
	
	get_environment_variable (name, buffer: POINTER; size: INTEGER): INTEGER is
			-- Get environment variable `name' and put result in `buffer' with size `size'.
			-- Return size of variable or 0 if not found.
		external
			"C macro signature (LPCTSTR, LPTSTR, DWORD): EIF_INTEGER use <windows.h>"
		alias
			"GetEnvironmentVariable"
		end

	set_environment_variable (name, value: POINTER): BOOLEAN is
			-- Set environment variable `name' with value `value'.
			-- Return True if successful.
		external
			"C macro signature (LPCTSTR, LPCTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"SetEnvironmentVariable"
		end

end -- class MD_STRONG_NAME
