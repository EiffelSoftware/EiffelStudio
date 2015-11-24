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

end


