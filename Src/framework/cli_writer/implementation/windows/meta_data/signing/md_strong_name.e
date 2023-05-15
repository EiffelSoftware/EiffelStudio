note
	description: "Plain encapsulation of StrongName API."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_STRONG_NAME

inherit
	MD_STRONG_NAME_I

create
	make_with_version

feature {NONE} -- Initialize

	make_with_version (a_runtime_version: like runtime_version)
			-- Initialize Current. Initialize `exists' accordingly.
		require
			a_runtime_version_not_void: a_runtime_version /= Void
			has_version: (create {IL_ENVIRONMENT}).is_version_installed (a_runtime_version)
		local
			l_dll: WEL_DLL
		do
			runtime_version := a_runtime_version
				-- Initialize `path' so that we can load `mscorsn.dll'.
			setup
				-- Check that `mscorsn.dll' can be found.
			create l_dll.make ("mscorsn.dll")
			exists := l_dll.exists
		ensure
			runtime_version_set: runtime_version = a_runtime_version
		end

feature -- Status report

	exists: BOOLEAN
			-- Is `mscorsn.dll' available?

	runtime_version: STRING_32
			-- Version for which we are signing.

feature {NONE} -- Status report

	setup
			-- Initialize environment for loading `mscorsn.dll', i.e.
			-- append path to `mscorsn.dll' to PATH environment variable.
		local
			s: STRING_32
			l_il_env: IL_ENVIRONMENT_I
			e: EXECUTION_ENVIRONMENT
		once
				-- Look for specific version of the runtime since `mscorsn.dll' is
				-- version specific.
			create {IL_ENVIRONMENT} l_il_env.make (runtime_version)
			if l_il_env.is_dotnet_installed then
					-- We try to call `get_error'. If the DLL exists, it
					-- will work, if it does not exist it will not reach
					-- `Result := True', thus `Result' will be False.
				create e
				s := e.item ("PATH")
				if not attached s then
					create s.make_empty
				end
				if attached l_il_env.dotnet_framework_path as l_dotnet_framework_path then
					s.prepend_string_general (";")
					s.prepend_string (l_dotnet_framework_path.name)
				end
				e.put (s, "PATH")
			end
		end

feature -- Constants

	sn_leave_key: INTEGER = 0x00000001
			-- Flags for StrongNameKeyGen.
			-- Leave key pair registered with CSP.

feature -- Access

	public_key (a_key_blob: MANAGED_POINTER): detachable MANAGED_POINTER
			-- Retrieve public portion of key pair `a_key_blob`.
		local
			l_ptr: POINTER
			l_key_size: INTEGER
		do
				-- TODO: This is an obsolete interface call:
				-- https://docs.microsoft.com/en-us/dotnet/framework/unmanaged-api/strong-naming/strongnamegetpublickey-function
				-- Use this instead:
				-- https://docs.microsoft.com/en-us/dotnet/framework/unmanaged-api/hosting/iclrstrongname-strongnamegetpublickey-method
			if strong_name_get_public_key (default_pointer, a_key_blob.item, a_key_blob.count, $l_ptr, $l_key_size) /= 0 then
				create Result.make_from_pointer (l_ptr, l_key_size)
				strong_name_free_buffer (l_ptr)
			end
		end

	public_key_token (a_public_key_blob: MANAGED_POINTER): MANAGED_POINTER
			-- Retrieve public key token associated with `a_public_key_blob'.
		local
			l_ptr: POINTER
			l_key_size: INTEGER
			l_result: INTEGER
		do
			l_result := strong_name_token_from_public_key (a_public_key_blob.item, a_public_key_blob.count, $l_ptr, $l_key_size)
			create Result.make_from_pointer (l_ptr, l_key_size)
			strong_name_free_buffer (l_ptr)
		end

	assembly_signature (a_file: CLI_STRING; a_public_private_key: MANAGED_POINTER): MANAGED_POINTER
			-- Signature of assembly `a_file' using `a_public_private_key'.
		require
			a_file_not_void: a_file /= Void
			a_public_private_key_not_void: a_public_private_key /= Void
		local
			l_ptr: POINTER
			l_size, l_result: INTEGER
		do
			l_result := strong_name_signature_generation (a_file.item, default_pointer,
				a_public_private_key.item, a_public_private_key.count, $l_ptr, $l_size)
			create Result.make_from_pointer (l_ptr, l_size)
			strong_name_free_buffer (l_ptr)
		end

	assembly_signature_size (a_public_private_key: MANAGED_POINTER): INTEGER
			-- Size of signature using `a_public_private_key'.
		require
			a_public_private_key_not_void: a_public_private_key /= Void
		local
			l_result: INTEGER
		do
			l_result := strong_name_signature_size (
				a_public_private_key.item, a_public_private_key.count, $Result)
		end

	hash_of_file (a_file_path: CLI_STRING): MANAGED_POINTER
			-- Compute hash of `a_file_path' using default algorithm.
		local
			l_hash: MANAGED_POINTER
			l_alg_id, l_result, l_size: INTEGER
		do
			create l_hash.make (1024)
			l_result := get_hash_from_file (a_file_path.item, $l_alg_id, l_hash.item, l_hash.count, $l_size)
			create Result.make_from_pointer (l_hash.item, l_size)
		end

feature -- Factory

	new_public_private_key_pair: MANAGED_POINTER
			-- Generate a new public-private key pair.
		local
			l_ptr: POINTER
			l_result, l_size: INTEGER
		do
			l_result := strong_name_key_gen (default_pointer, 0, $l_ptr, $l_size)
			create Result.make_from_pointer (l_ptr, l_size)
			strong_name_free_buffer (l_ptr)
		ensure
			new_public_private_key_pair_not_void: Result /= Void
		end

feature {NONE} -- C externals

	frozen get_error: INTEGER
			-- Retrieve error code if any.
		external
			"dllwin mscorsn.dll signature : EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameErrorInfo"
		end

	frozen strong_name_free_buffer (a_key_blob: POINTER)
			-- Free buffer allocated by routines below.
		external
			"dllwin mscorsn.dll signature (BYTE *) use <StrongName.h>"
		alias
			"StrongNameFreeBuffer"
		end

	frozen strong_name_key_gen (a_container_name: POINTER; flags: INTEGER;
			a_public_key, a_key_size: POINTER): INTEGER

			-- Generate a new key pair for strong name use.
		external
			"dllwin mscorsn.dll signature (LPCWSTR, DWORD, BYTE **, ULONG *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyGen"
		end

	frozen strong_name_install (a_container_name: POINTER; a_public_key: POINTER;
			a_key_size: INTEGER): INTEGER

			-- Import key pair into a key container.
		external
			"dllwin mscorsn.dll signature (LPCWSTR, BYTE *, ULONG): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyInstall"
		end

	frozen strong_name_delete (a_container_name: POINTER): INTEGER
			-- Import key pair into a key container.
		external
			"dllwin mscorsn.dll signature (LPCWSTR): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameKeyDelete"
		end

	frozen strong_name_get_public_key (a_container_name: POINTER; a_key_blob: POINTER;
			a_key_blob_size: INTEGER; a_public_key: POINTER; a_public_key_size: POINTER): INTEGER

			-- Retrieve the public portion of a key pair.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameGetPublicKey"
		end

	frozen strong_name_hash_size (a_hash_alg: INTEGER; a_hash_size: POINTER): INTEGER
			-- Compute size of buffer in `a_hash_size' needed to hold a hash
			-- for a given hash algorithm `a_hash_alg'.
		external
			"dllwin mscorsn.dll signature (ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameHashSize"
		end

	frozen strong_name_signature_size (a_public_key: POINTER; a_key_size: INTEGER;
			a_hash_size: POINTER): INTEGER

			-- Compute size that needs to be allocated for a signature in an assembly.
		external
			"dllwin mscorsn.dll signature (BYTE *, ULONG, DWORD *): EIF_INTEGER use <StrongName.h>"
		alias
			"StrongNameSignatureSize"
		end

	frozen strong_name_signature_generation (a_file_path, a_container, a_public_key: POINTER;
			a_public_key_size: INTEGER; a_hash_buffer, a_hash_buffer_size: POINTER): INTEGER

			-- Hash and sign a manifest.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, LPCWSTR, BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameSignatureGeneration"
		end

	frozen strong_name_token_from_public_key (a_public_key: POINTER; key_length: INTEGER;
			token, token_lenght: POINTER): INTEGER

			-- Create a strong name token from a public key blob.
		external
			"[
				dllwin mscorsn.dll signature (BYTE *, ULONG, BYTE **, ULONG *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"StrongNameTokenFromPublicKey"
		end

	frozen get_hash_from_assembly_file (a_file_path: POINTER; a_hash_alg_id: POINTER;
			a_hash_buffer: POINTER; a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER

			-- Compute hash of `a_blob' using `a_hash_alg_id'.
		external
			"[
				dllwin mscorsn.dll signature (LPCWSTR, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"GetHashFromAssemblyFileW"
		end

	frozen get_hash_from_blob (a_blob: POINTER; a_blob_size: INTEGER; a_hash_alg_id: POINTER;
			a_hash_buffer: POINTER; a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER

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

	frozen get_hash_from_file (a_path: POINTER; a_hash_alg_id: POINTER; a_hash_buffer: POINTER;
			a_hash_buffer_size: INTEGER; computed_size: POINTER): INTEGER

		external
			"[
				dllwin mscorsn.dll
				signature (LPCWSTR, unsigned int *, BYTE *, DWORD, DWORD *): EIF_INTEGER
				use <StrongName.h>
			]"
		alias
			"GetHashFromFileW"
		end

invariant
	runtime_version_not_void: runtime_version /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
