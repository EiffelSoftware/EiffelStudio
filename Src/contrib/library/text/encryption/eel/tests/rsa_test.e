note
	description: "Summary description for {RSA_TEST}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "When buying and selling are controlled by legislation, the first things to be bought and sold are legislators. - P.J. O'Rourke"

class
	RSA_TEST

inherit
	EQA_TEST_SET

feature
	test_small
		local
			private: RSA_PRIVATE_KEY
			public: RSA_PUBLIC_KEY
			message: INTEGER_X
			ciphertext: INTEGER_X
			plaintext: INTEGER_X
		do
			create private.make (61, 53, 3233, 17)
			create public.make (3233, 17)
			assert ("test small 1", private.d.to_integer = 2753)
			create message.make_from_integer (123)
			ciphertext := public.encrypt (message)
			assert ("test small 2", ciphertext.to_integer = 855)
			plaintext := private.decrypt (ciphertext)
			assert ("test small 3", plaintext.to_integer = 123)
		end

	test_1024_reflexive
		local
			key_pair: RSA_KEY_PAIR
			message: INTEGER_X
			cipher: INTEGER_X
			plain: INTEGER_X
			signature: INTEGER_X
			correct: BOOLEAN
		do
			create key_pair.make (1024)
			create message.make_random (128)
			cipher := key_pair.public.encrypt (message)
			plain := key_pair.private.decrypt (cipher)
			assert ("test 1024 reflexive 1", plain ~ message)
			signature := key_pair.private.sign (message)
			correct := key_pair.public.verify (message, signature)
			assert ("test 1024 reflexive 2", correct)
		end

	test_2048_reflexive
		local
			key_pair: RSA_KEY_PAIR
			message: INTEGER_X
			cipher: INTEGER_X
			plain: INTEGER_X
			signature: INTEGER_X
			correct: BOOLEAN
		do
			create key_pair.make (2048)
			create message.make_random (128)
			cipher := key_pair.public.encrypt (message)
			plain := key_pair.private.decrypt (cipher)
			assert ("test 2048 reflexive 1", plain ~ message)
			signature := key_pair.private.sign (message)
			correct := key_pair.public.verify (message, signature)
			assert ("test 2048 reflexive 2", correct)
		end

	test_4096_reflexive
		local
			key_pair: RSA_KEY_PAIR
			message: INTEGER_X
			cipher: INTEGER_X
			plain: INTEGER_X
			signature: INTEGER_X
			correct: BOOLEAN
		do
			create key_pair.make (4096)
			create message.make_random (128)
			cipher := key_pair.public.encrypt (message)
			plain := key_pair.private.decrypt (cipher)
			assert ("test 4096 reflexive 1", plain ~ message)
			signature := key_pair.private.sign (message)
			correct := key_pair.public.verify (message, signature)
			assert ("test 4096 reflexive 2", correct)
		end
end
