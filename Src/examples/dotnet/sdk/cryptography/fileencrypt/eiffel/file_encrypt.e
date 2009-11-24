note
	status: "See notice at end of class."
	legal: "See notice at end of class."
class
	FILE_ENCRYPT

inherit
	SYSTEM_OBJECT

create {NONE}
	main

feature {NONE} -- Initialization

	main
			-- Program entry point
		local
			l_fs: FILE_STREAM
			l_input: SYSTEM_STRING
			l_arr_input: NATIVE_ARRAY [NATURAL_8]
			l_des: DES_CRYPTO_SERVICE_PROVIDER
			l_des_encrypt: ICRYPTO_TRANSFORM
			l_crypto_stream: CRYPTO_STREAM
			l_des_dencrypt: ICRYPTO_TRANSFORM
			l_crypto_stream_decr: CRYPTO_STREAM
			l_fs_read: FILE_STREAM
		do
				-- Creating a file stread
			create l_fs.make ("encypted_file.txt", {FILE_MODE}.create_, {FILE_ACCESS}.write)

			{SYSTEM_CONSOLE}.write_line ("Enter some test to be stored in encrypted file:")
			l_input := {SYSTEM_CONSOLE}.read_line

			l_arr_input := convert_string_to_byte_array (l_input)

				-- DES instance with random key
			create l_des.make
				-- Create DES encryptor for this instance
			l_des_encrypt := l_des.create_encryptor

				-- Create crypto stream that transofmr file stream using DES encryption
			create l_crypto_stream.make (l_fs, l_des_encrypt, {CRYPTO_STREAM_MODE}.write)

				-- Write out DES encrypted file
			l_crypto_stream.write (l_arr_input, 0, l_arr_input.count)
			l_crypto_stream.close

				-- Create file stream to read encrypted file back
			create l_fs_read.make (l_fs.name, {FILE_MODE}.open, {FILE_ACCESS}.read)

				-- Create DES decryptor from out DES instance
			l_des_dencrypt := l_des.create_decryptor

				-- Create crypto stream set to read and do a DES decryption transform on incming bytes
			create l_crypto_stream_decr.make (l_fs_read, l_des_dencrypt, {CRYPTO_STREAM_MODE}.read)
				-- Print out the contents of the decrypted file
			{SYSTEM_CONSOLE}.write_line ((create {STREAM_READER}.make (l_crypto_stream_decr, create {UNICODE_ENCODING}.make)).read_to_end)

			{SYSTEM_CONSOLE}.write_line
			{SYSTEM_CONSOLE}.write_line ("Press Enter to continue...")
			{SYSTEM_CONSOLE}.read_line.do_nothing
		end

feature {NONE} -- Implementation

	convert_string_to_byte_array (a_str: SYSTEM_STRING): NATIVE_ARRAY [NATURAL_8]
			-- Converts a supplied string into an array of {NATURAL_8}
		require
			a_str_attached: a_str /= Void
		do
			Result := (create {UNICODE_ENCODING}.make).get_bytes (a_str)
		ensure
			result_attached: Result /= Void
			result_count_matches_input_length: a_str.length * 2 = Result.count
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software/Microsoft Corporation. All rights reserved."
	license: "[
			This file is part of the Microsoft .NET Framework SDK Code Samples.

			This source code is intended only as a supplement to Microsoft
			Development Tools and/or on-line documentation.  See these other
			materials for detailed information regarding Microsoft code samples.

			THIS CODE AND INFORMATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY
			KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
			IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
			PARTICULAR PURPOSE.
		]"


end
