indexing
	description: "Plain encapsulation of StrongName API"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

feature -- Constants

	sn_leave_key: INTEGER is 0x00000001
			-- Flags for StrongNameKeyGen.
			-- Leave key pair registered with CSP.

feature -- C externals

	get_error: INTEGER is
			-- Retrieve error code if any.
		external
			"C macro signature : EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameErrorInfo"
		end
		
	strong_name_free_buffer (a_key_blob: POINTER) is
			-- Free buffer allocated by routines below.
		external
			"C macro signature (BYTE *) use <StrongName.h>"
		alias
			"StrongNameFreeBuffer"
		end

	strong_name_key_gen (a_container_name: POINTER; flags: INTEGER;
			a_public_key, a_key_size: POINTER): INTEGER
		is
			-- Generate a new key pair for strong name use.
		external
			"C macro signature (LPCWSTR, DWORD, BYTE **, ULONG *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyGen"
		end

	strong_name_install (a_container_name: POINTER; a_public_key: POINTER;
			a_key_size: INTEGER): INTEGER
		is
			-- Import key pair into a key container.
		external
			"C macro signature (LPCWSTR, BYTE *, ULONG): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyInstall"
		end
		
	strong_name_delete (a_container_name: POINTER): INTEGER is
			-- Import key pair into a key container.
		external
			"C macro signature (LPCWSTR): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyDelete"
		end

	strong_name_get_public_key (a_container_name: POINTER; a_key_blob: POINTER;
			a_key_blob_size: INTEGER; a_public_key: POINTER; a_public_key_size: POINTER): INTEGER
		is
			-- Retrieve the public portion of a key pair.
		external
			"[
				C macro signature (LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameGetPublicKey"
		end

	strong_name_hash_size (a_hash_alg: INTEGER; a_hash_size: POINTER): INTEGER is
			-- Compute  size of buffer in `a_hash_size' needed to hold a hash
			-- for a given hash algorithm `a_hash_alg'.
		external
			"C macro signature (ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameHashSize"
		end

	strong_name_signature_size (a_public_key: POINTER; a_key_size: INTEGER;
			a_hash_size: POINTER): INTEGER
		is
			-- Compute size that needs to be allocated for a signature in an assembly.
		external
			"C macro signature (BYTE *, ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameSignatureSize"
		end

	strong_name_signature_generation (a_file_path, a_container, a_public_key: POINTER;
			a_public_key_size: INTEGER; a_hash_buffer, a_hash_buffer_size: POINTER): INTEGER
		is
			-- Hash and sign a manifest.
		external
			"[
				C macro signature (LPCWSTR, LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameSignatureGeneration"
		end
			
	get_hash_from_assembly_file (a_file_path: POINTER; a_hash_alg_id: POINTER;
			a_hash_buffer: POINTER; a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER
		is
				-- Compute hash of `a_blob' using `a_hash_alg_id'.
		external
			"[
				C macro signature (LPCWSTR, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
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
				C macro
				signature (BYTE *, DWORD, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"GetHashFromBlob"
		end
			
end -- class MD_STRONG_NAME
