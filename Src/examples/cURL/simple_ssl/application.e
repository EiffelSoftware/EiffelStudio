note
	description: "[
		cURL simple ssl example Eiffel version. 
		For original C version, please see:
		https://curl.haxx.se/libcurl/c/simplessl.html
		
		This demo will get html source from http://www.google.com, then print the html codes to command line.
		This is the simplest way to download a URL source.
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=simplessl", "src=https://curl.haxx.se/libcurl/c/simplessl.html", "protocol=uri"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
			-- Shows HTTPS usage with client certs
			-- using badssl.com site for testing
		local
			l_result: INTEGER
			l_cert: STRING
			l_path: PATH
		do
			io.put_string ("Eiffel cURL simple ssl example.")
			io.put_new_line
			create file.make_create_read_write ("dumpit.log")
			file.put_string ("Dump log")
			file.put_new_line
			file.flush
			if curl_easy.is_api_available then
				curl_handle := curl_easy.init

					-- First we specify which URL we would like to download.
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "https://client.badssl.com/")

					-- ask libcurl to use TLS version 1.2 or later */
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSLVERSION, {CURL_OPT_CONSTANTS}.CURL_SSLVERSION_TLSv1_2)
				curl_easy.setopt_file (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_HEADERDATA, file)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_HEADER, 1)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_USERAGENT, "Eiffel libCurl")

					-- cert is stored PEM coded in file...
					-- since PEM is default, we needn't set it for PEM
					-- curl_easy_setopt(curl, CURLOPT_SSLCERTTYPE, "PEM");
					--curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSLCERTTYPE, "PEM")
					--curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_KEYPASSWD, "badssl.com")
					--curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSLCERT, "./client.pem")

					-- Format P12
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSLCERTTYPE, "P12")
					-- set the passphrase (if the key has one...)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_KEYPASSWD, "badssl.com")
					--set the cert for client authentication
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSLCERT, "./client.p12")

				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_cainfo, "./cacert.pem")

					-- Verify the peer's SSL certificate,set to 1 is enabled, and the verification fails to prove that the certificate is authentic, the connection fails.
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSL_VERIFYPEER, 1)
					-- Verify the certificate's name against host. checking the server's certificate's claimed identity.
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSL_VERIFYHOST, 2)

					-- When the option is zero, the peer certificate verification succeeds regardless.
					-- curl_easy.setopt_integer(curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSL_VERIFYPEER, 0)
					-- When the verify value is 0, the connection succeeds regardless of the names in the certificate.
					--curl_easy.setopt_integer(curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_SSL_VERIFYHOST, 0)

					-- enable TCP keep-alive probing.
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.CURLOPT_TCP_KEEPALIVE, 1)

					-- After `perform' has been called, the remote HTML source is printed in the console.
				l_result := curl_easy.perform (curl_handle)

					-- Always cleanup
				curl_easy.cleanup (curl_handle)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	curl_handle: POINTER;
		-- cURL handle

	file: RAW_FILE

end -- class APPLICATION
