note
	description: "Client side for processing echo via SSL connection."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit

	ARGUMENTS

	INET_ADDRESS_FACTORY

	INET_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make
		local
			host: STRING
			port: INTEGER
			prefer_ipv4_stack: BOOLEAN
			address: detachable INET_ADDRESS
			timeout: INTEGER
			l_socket: SSL_NETWORK_STREAM_SOCKET
			a_file_name: FILE_NAME
		do
			host := "requestb.in"
			port := 443
			if argument_count > 0 then
				host := argument (1)
				if argument_count > 1 then
					port := argument (2).to_integer
				end
				if argument_count > 2 then
					prefer_ipv4_stack := argument (3).to_boolean
				end
				if argument_count > 3 then
					timeout := argument (4).to_integer
				end
			end
			if prefer_ipv4_stack then
				set_ipv4_stack_preferred (True)
			end
			io.put_string ("start ssl_client")
			io.put_string (" host = ")
			io.put_string (host)
			io.put_string (", port = ")
			io.put_integer (port)
			io.put_new_line

				-- Obtain the host address
			address := create_from_name (host)
			if address = Void then
				io.put_string ("Unknown host " + host)
				io.put_new_line
			else
					-- Create the socket connection to the Echo Server.

				create l_socket.make_client_by_address_and_port (address, port)
					-- Set the connection timeout
					--				l_socket.set_connect_timeout (100)
					-- Connect to the Server
				l_socket.set_tls_server_name_indication ("www.requestb.in")

				l_socket.connect
				if not l_socket.is_connected then
					io.put_string ("Unable to connect to host " + host + ":" + port.out)
					io.put_new_line
				else
						-- Since this is the client, we will initiate the talking.
					client_get.append ("%R%N")
					client_get.append ("Host: requestb.in")
					client_get.append ("%R%N")
					client_get.append ("Cache-Control:max-age=0")
					client_get.append ("%R%N")
					client_get.append ("Accept:*/*;q=0.8")
					client_get.append ("%R%N")
					client_get.append ("upgrade-insecure-requests:1")
					client_get.append ("%R%N")
					client_get.append ("%R%N")
					send_message_and_receive_reply (l_socket, client_get)

						-- Close the connection
					l_socket.close
				end
			end
			io.put_string ("finish echo_client")
			io.put_new_line
		end

feature {NONE} --Implementation

	send_message_and_receive_reply (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			send_message (a_socket, message)
			receive_reply (a_socket)
		end

	send_message (a_socket: SSL_NETWORK_STREAM_SOCKET; message: STRING)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_write
			valid_message: message /= Void and then not message.is_empty
		do
			a_socket.put_string (message)
		end

	receive_reply (a_socket: SSL_NETWORK_STREAM_SOCKET)
		require
			valid_socket: a_socket /= Void and then a_socket.is_open_read
		local
			l_last_string: detachable STRING
		do
			l_last_string := receive_data (a_socket)
			check
				l_last_string_attached: l_last_string /= Void
			end
			io.put_string ("Server Says: ")
			io.put_string (l_last_string)
			io.put_new_line
		end

	receive_data (a_socket: SSL_NETWORK_STREAM_SOCKET): STRING
		local
			end_of_stream: BOOLEAN
		do
			from
				a_socket.read_line
				Result := ""
			until
				end_of_stream
			loop
				Result.append (a_socket.last_string)
				if a_socket.last_string /= void and not a_socket.last_string.is_empty and a_socket.socket_ok then
					a_socket.read_line
				else
					end_of_stream := True
				end
			end
		end

	client_get: STRING = "GET / HTTP/1.1"


	ca_crt: STRING = "..\ca-bundle.crt"
		-- seff signed certificate.



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
