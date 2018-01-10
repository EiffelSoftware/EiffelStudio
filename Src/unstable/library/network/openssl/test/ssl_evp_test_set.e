note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SSL_EVP_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

feature -- Test routines

	test_evp_cipher_ctx

		do
			assert ("not default_pointer", {SSL_EVP}.c_evp_cipher_ctx_new /= default_pointer)
		end

	test_evp_ctrl_gcm_set_ivlen
		do
			assert ("gsm_set_ivlen=0x9", {SSL_EVP}.c_evp_ctrl_gcm_set_ivlen = 0x9 )
		end
end


