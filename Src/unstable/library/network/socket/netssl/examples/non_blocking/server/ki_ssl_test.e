class
	KI_SSL_TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			l_inet : INET_PROPERTIES
			l_accepted, l_listener: SSL_NETWORK_STREAM_SOCKET
		do
			create l_inet
			l_inet.set_ipv4_stack_preferred (False)
			create l_listener.make_server_by_port (9997)
			x509_certificate.adjust
			private_key.adjust
			l_listener.set_certificate_x509_string (x509_certificate)
			l_listener.set_private_rsa_key_string (private_key)
			l_listener.set_connect_timeout (1000)
			l_listener.listen (1000)
			l_listener.accept
			l_accepted := l_listener.accepted
			if attached l_accepted and then l_accepted.is_open_read then
				l_accepted.set_non_blocking
				l_accepted.read_line
				print ("%N" + l_accepted.last_string)
				l_accepted.put_string (l_accepted.last_string)
			end

		end

feature {NONE} -- SSL

	x509_certificate: STRING = "[
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

	private_key: STRING =  "[
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
