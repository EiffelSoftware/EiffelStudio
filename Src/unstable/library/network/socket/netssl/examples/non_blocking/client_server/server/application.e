note
	description: "Single threaded echo server."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name:OpenSSL certificates how to", "src=http://pages.cs.wisc.edu/~zmiller/ca-howto/", "protocol=uri"

class
	APPLICATION

inherit

	ARGUMENTS_32
	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
		local
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			listen_socket: SSL_NETWORK_STREAM_SOCKET
			accept_timeout: INTEGER
			l_address: detachable NETWORK_SOCKET_ADDRESS
		do
			port := 12111

			if argument_count > 0  then
				port := argument (1).to_integer
				if argument_count > 1 then
					prefer_ipv4_stack := argument (2).to_boolean
				end
				if argument_count > 2 then
					accept_timeout := argument (3).to_integer
				end
			end

			if prefer_ipv4_stack then
				set_ipv4_stack_preferred (True)
			end

			io.put_string ("starting echo_server")
			io.put_string (" port = ")
			io.put_integer (port)
			io.put_new_line

				-- Create the Server socket
			create listen_socket.make_server_by_port (port)

				-- Using certificates and key from manifests
			ca_crt_manifest.adjust
			ca_key_manifesst.adjust
			listen_socket.set_certificate_x509_string (ca_crt_manifest)
			listen_socket.set_private_rsa_key_string (ca_key_manifesst)

				-- Using certificates and key from file
--			create a_file_name.make_from_string (ca_crt)
--			listen_socket.set_certificate_file_name (a_file_name)
---			create a_file_name.make_from_string (ca_key)
--			listen_socket.set_key_file_name (a_file_name)

			if not listen_socket.is_bound then
				io.put_string ("Unable bind to port "+ port.out)
				io.put_new_line
			else
				l_address := listen_socket.address
				check l_address_attached: l_address /= Void end
				io.put_string ("Listening on address = " + l_address.host_address.host_address + " port = " + l_address.port.out)
				io.put_new_line
					-- Listen on Server Socket with queue length = 2
				listen_socket.listen (2)
					-- Set the accept timeout
				listen_socket.set_accept_timeout (accept_timeout)
				perform_accept_serve_loop (listen_socket)
			end
			listen_socket.close
			io.put_string ("finish echo_server%N")
		end

feature {NONE} -- Implementation

	perform_accept_serve_loop (socket: SSL_NETWORK_STREAM_SOCKET)
		require
			valid_socket: socket /= Void and then socket.is_bound
		do
			socket.accept
			if not attached socket.accepted as client_socket then
					-- Some error occured, perhaps because of the timeout
					-- We probably should provide some diagnostics here
				io.put_string ("accept result = Void")
				io.put_new_line
			elseif attached client_socket and then client_socket.was_error then
					-- Some error occured, not ssl client, ssl version not valid.
				io.put_string (client_socket.error)
				io.put_new_line
				client_socket.close_socket
			else
				client_socket.set_non_blocking
				perform_client_communication (client_socket)
			end
		end

	perform_client_communication (socket: SSL_NETWORK_STREAM_SOCKET)
		require
			socket_attached: socket /= Void
			socket_valid: socket.is_open_read and then socket.is_open_write
		local
			done: BOOLEAN
			l_address, l_peer_address: detachable NETWORK_SOCKET_ADDRESS
		do
			l_address := socket.address
			l_peer_address := socket.peer_address
			check
				l_address_attached: l_address /= Void
				l_peer_address_attached: l_peer_address /= Void
			end
			io.put_string ("Accepted client on the listen socket address = "+ l_address.host_address.host_address + " port = " + l_address.port.out +".")
			io.put_new_line
			io.put_string ("%T Accepted client address = " + l_peer_address.host_address.host_address + " , port = " + l_peer_address.port.out)
			io.put_new_line
			from
				done := False
			until
				done
			loop
				done := receive_message_and_send_replay (socket)
			end
			io.put_string ("Finished processing the client, address = "+ l_peer_address.host_address.host_address + " port = " + l_peer_address.port.out + ".")
			io.put_new_line
		end

	receive_message_and_send_replay (client_socket: SSL_NETWORK_STREAM_SOCKET): BOOLEAN
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_read and then client_socket.is_open_write
		local
			message: detachable STRING
		do
				-- Limit client message size to 10
				-- It's here just to demonstrate the usage of the `read_line_until' routine
			client_socket.read_line_until (10)
			message := client_socket.last_string
			if message /= Void then
				if message.ends_with ("%R") then
					message.keep_head (message.count-1)
				end
				io.put_string ("%NClient Says :")
				io.put_string (message)
				io.put_new_line
				if message.is_case_insensitive_equal ("quit") then
					Result := True
					client_socket.close
				else
					send_reply (client_socket, message)
				end
			end
		end

	send_reply (client_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			socket_attached: client_socket /= Void
			socket_valid: client_socket.is_open_write
			message_attached: message /= Void
		do
			client_socket.put_string (message + "%N")
		end

feature -- SSL Certificates

			--| Chnage the following two path's to your own crt and key files.

	ca_crt: STRING = "..\example.crt"
		-- seff signed certificate.

	ca_key: STRING = "..\example.key"
		-- ca key.

	ca_crt_manifest: STRING = "[
			-----BEGIN CERTIFICATE-----
			MIICWDCCAcGgAwIBAgIJAJnXGtV+PtiYMA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
			BAYTAkFVMRMwEQYDVQQIDApTb21lLVN0YXRlMSEwHwYDVQQKDBhJbnRlcm5ldCBX
			aWRnaXRzIFB0eSBMdGQwHhcNMTUwNDAzMjIxNTA0WhcNMTYwNDAyMjIxNTA0WjBF
			MQswCQYDVQQGEwJBVTETMBEGA1UECAwKU29tZS1TdGF0ZTEhMB8GA1UECgwYSW50
			ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB
			gQDFMK6ojzg+KlklhTossR13c51izMgGc3B0z9ttfHIcx2kxra3HtHcKIl5wSUvn
			G8zmSyFAyQTs5LUv65q46FM9qU8tP+vTeFCfNXvjRcIEpouta3J53K0xuUlxz4d4
			4D6qvdDWAez/0AkI4y5etW5zXtg7IQorJhsI9TmfGuruzwIDAQABo1AwTjAdBgNV
			HQ4EFgQUbWpk2HoHa0YqpEwr7CGEatBFTMkwHwYDVR0jBBgwFoAUbWpk2HoHa0Yq
			pEwr7CGEatBFTMkwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAAOBgQAi+h4/
			IgEocWkdRZBKHEcTrRxz5WhEDJMoVo9LhnXvCfn1G/4p6Un6sYv7Xzpi9NuSY8uV
			cjfJJXhtF3AtyZ70iTAxWaRWjGaZ03PYOjlledJ5rqJEt6CCn8m+JsfznduZvbxQ
			zQ6jCLXfyD/tvemB+yYEI3NntvRKx5/zt6Q26Q==
			-----END CERTIFICATE-----
		]"

	ca_key_manifesst: STRING = "[
			-----BEGIN RSA PRIVATE KEY-----
			MIICXAIBAAKBgQDFMK6ojzg+KlklhTossR13c51izMgGc3B0z9ttfHIcx2kxra3H
			tHcKIl5wSUvnG8zmSyFAyQTs5LUv65q46FM9qU8tP+vTeFCfNXvjRcIEpouta3J5
			3K0xuUlxz4d44D6qvdDWAez/0AkI4y5etW5zXtg7IQorJhsI9TmfGuruzwIDAQAB
			AoGAR5efMg+dieRyLU8rieJcImxVbfOPg9gRsjdtIVkXTR+RL7ow59q7hXBo/Td/
			WU8cm1gXoJ/bK+71YYqWyB+BaLRIWvRWb7Gdw203tu4e136Ca5uuY+71qdbVTVcl
			NQ7J+T+eAQFP+a+DdT3ZQxu9eze87SMbu6i5YSpIk2kusOECQQDunv/DQ+nc+NgR
			DF+Td3sNYUVRT9a1CWi6abAG6reXwp8MS4NobWDf+Ps4JODhEEwlIdq5qL7qqYBZ
			Gc1TJJ53AkEA0404Fn6vAzzegBcS4RLlYTK7nMr0m4pMmDMCI6YzAYdMmKHp1e6f
			IwxSmQrmwyAgwcT01bc0+A8yipcC2BWQaQJBAJ01QZm635OGmos41KsKF5bsE8gL
			SpBBH69Yu/ECqGwie7iU84FUNnO4zIHjwghlPVVlZX3Vz9o4S+fn2N9DC+cCQGyZ
			QyCxGdC0r5fbwHJQS/ZQn+UGfvlVzqoXDVMVn3t6ZES6YZrT61eHnOM5qGqklIxE
			Old3vDZXPt/MU8Zvk3kCQBOgUx2VxvTrHN37hk9/QIDiM62+RenBm1M3ah8xTosf
			1mSeEb6d9Kwb3TgPBmA7YXzJuAQfRIvEPMPxT5SSr6Q=
			-----END RSA PRIVATE KEY-----
		]"

end
