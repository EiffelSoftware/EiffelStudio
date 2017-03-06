class APPLICATION

create
	make

feature -- Initialization

	make
		do
			test_login_fail
		end


	test_login_fail
			-- New test routine
		local
			cfg: ESA_CLIENT_CONFIGURATION
			login: ESA_SUPPORT_LOGIN
			l_retry: BOOLEAN
			l_stop_watch: DT_STOPWATCH
		do
			create l_stop_watch.make
			l_stop_watch.start
			io.put_string ("Testing HTTP client timeout!%N")
			if not l_retry then
					-- !Note
					-- Launch the esa_api
				create cfg.make_with_config
				create login.make (cfg)
				login.attempt_logon ("bad_user", "bad_user", false)
				if login.is_bad_request then
					print ("%NClient timeout")
				end
			end
			l_stop_watch.stop
			io.print ("Elapsed time:" + l_stop_watch.elapsed_time.out)
			io.put_new_line
			io.read_line
		rescue
			l_retry := true
		end

end
