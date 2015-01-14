note
	description : "test application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			test_invalid_input
			test_missing_input
			test_missing_key_input
		end


	test_invalid_input
			-- invalid-input-response
		local
			l_captcha: RECAPTCHA_API
		do
			create l_captcha.make ("","234")
			check
				not_true:not l_captcha.verify
			end
		end

	test_missing_input
			-- missing-input-response
		local
			l_captcha: RECAPTCHA_API
		do
			create l_captcha.make ("key","")
			check
				not_true:not l_captcha.verify
			end
		end

	test_missing_key_input
			-- missing-input-response
			-- invalid-input-response
		local
			l_captcha: RECAPTCHA_API
		do
			create l_captcha.make ("","")
			l_captcha.set_remoteip("localhost")
			check
				not_true:not l_captcha.verify
			end
		end

end
