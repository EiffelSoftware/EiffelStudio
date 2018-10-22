note
	description: "Summary description for {TEST_RSA_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RSA_API

inherit

	EQA_TEST_SET

feature -- Tests


	test_decrypt
		local
			l_keypair: SSL_KEY_PAIR
			l_result:  STRING
			l_rsa: SSL_RSA
		do
			create l_keypair.make
			create l_rsa

			l_result := l_rsa.encrypt ("Eiffel", l_keypair)
			assert ("Eiffel", l_rsa.decrypt (l_result, l_keypair).same_string ("Eiffel"))
		end

end
