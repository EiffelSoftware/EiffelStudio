note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	ESA_API_CLIENT_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_login_fail
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			login: ESA_SUPPORT_LOGIN
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create login.make (cfg)
			login.attempt_logon ("bad_user", "bad_user", false)
			assert ("Not logged in", not login.is_logged_in)
		end

	test_login_success
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			login: ESA_SUPPORT_LOGIN
		do
				-- !Note
				-- Launch the esa_api
			create cfg.make_with_config
			create login.make (cfg)
			login.attempt_logon ("javierv", "test", false)
			assert ("is logged in", login.is_logged_in)

			login.force_logout
			assert ("not logged", not login.is_logged_in)
		end

	test_report_problem
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			reporter: ESA_SUPPORT_BUG_REPORTER
			report: ESA_SUPPORT_BUG_REPORT
		do
			create report.make ("testing client", "testing client", "testing client")
			report.set_environment ("Win")
			report.set_to_reproduce ("to_reproduce")
			create cfg.make_with_config
			create reporter.make (cfg)
			reporter.attempt_logon ("javierv", "test", false)
			reporter.report_bug (report)
		end


	test_user_account
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			account: ESA_SUPPORT_ACCOUNT
		do
			create cfg.make_with_config
			create account.make (cfg)
			account.attempt_logon ("test", "test", false) --! Change to a valid user name and password
			assert ("is logged in", account.is_logged_in)
			if attached account.account_details as l_account_details then
				assert ("display name",l_account_details.displayed_name.is_equal ("test test")) --! change to a valid first and last name or update the comparison.
			end
		end

	test_register_user_missing_data
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			register: ESA_SUPPORT_USER_REGISTER
			user:  ESA_USER_REGISTER
			retried: BOOLEAN
			exception: EXCEPTION
		do
				-- missing password and check password
			if not retried then
				create user.make
				user.set_first_name ("u1")
				user.set_last_name ("u2")
				user.set_email ("u@email.com")
				user.set_user_name ("uu")
				create cfg.make_with_config
				create register.make (cfg)
				register.user_register (user)
			else
				assert ("Check exception",exception /= Void)
			end
		rescue
			retried := True
			if attached (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception as l_exception then
				exception := l_exception
			end
			retry
		end


	test_register_user
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			register: ESA_SUPPORT_USER_REGISTER
			user:  ESA_USER_REGISTER
		do
			create user.make
			user.set_first_name ("u")
			user.set_last_name ("u")
			user.set_email ("u6@email.com")
			user.set_user_name ("uu6")
			user.set_password ("test")
			user.set_check_password ("test")
			create cfg.make_with_config
			create register.make (cfg)
			register.user_register (user)
		end


end


