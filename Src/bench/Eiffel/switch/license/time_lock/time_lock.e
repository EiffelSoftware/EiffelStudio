class TIME_LOCK

inherit
	EXECUTION_ENVIRONMENT

creation
	make

feature {NONE} -- Initialization

	make (init_dir: DIRECTORY_NAME) is
			-- Initialize time lock.
		require
			valid_password: passwd /= Void
			valid_license_file: license_file /= Void
		local
			ans: INTEGER
			cwd: STRING
			msg_box: WEL_MSG_BOX
			msg: STRING
			wel_buffer: WEL_STRING
			wel_password: WEL_STRING
			wel_fname: WEL_STRING
		do
			cwd := current_working_directory
			change_working_directory (init_dir)

			!! wel_buffer.make ("000000000000000000000000000")
			!! wel_password.make (passwd)
			!! wel_fname.make (license_file)
			ans := verifyTimeLock (wel_fname.item, wel_password.item, wel_buffer.item)

			if ans = Tlock_error_success then
				if wel_buffer.string.is_equal (time_lock_id) then
					ans := showMainDialog(wel_password.item)
					if ans >= 0 then
						if ans = Purchased_user then
							licensed := True
						end
						if ans = New_user or else ans = Trial_user then
							licensed := True
							if open_trial_session then
								if not close_trial_session then
									msg := "Could not open the trial session."
									msg.append ("%NPLease Contact ISE.")
								end
							else
								msg := "Could not open the trial session."
								msg.append ("%NPLease Contact ISE.")
							end
						end	
					elseif ans = Tlock_error_wrongversion then
						msg := "Wrong version of TimeLOCK."
					else
						msg := "Time lock error code (dialog): "
						msg.append (ans.out)
					end
				else
					msg := "Invalid license file for this version of EiffelBench."
				end
			elseif ans = Tlock_error_fileread then
				msg := "Could not read the license file "
				msg.append (license_file)
			elseif ans = Tlock_error_filenotfound then
				msg := "Could not find the license file "
				msg.append (license_file)
			else
				msg := "Time Lock error."
			end

			if msg /= Void then
				!! msg_box.make
				msg_box.error_message_box (Void, msg, "Time Lock Error")
			end
			change_working_directory (cwd)
		end

feature -- Access

	licensed: BOOLEAN
				-- Is the produce licensed?

feature {NONE} -- Implementation

	time_lock_id: STRING is "156410714003864683762838"
	New_user: INTEGER is 28176
	Trial_user: INTEGER is 14360
	Purchased_user: INTEGER is 57831
	Expired_user: INTEGER is 51842

	passwd: STRING is "1255852334077000855633320661846"
	license_file: STRING is "bench42F.lic"

feature {NONE} -- Externals

	verifyTimeLock (file_name, password, strResult: POINTER): INTEGER is
			-- Get TimeLock information and verify that nothing has
			-- been modified or corrupted.
		external
			"C (LPCTSTR, LPCTSTR, LPTSTR): EIF_INTEGER | %"tlkapi.h%""
		alias
			"verifyTimeLock32"
		end

	showMainDialog (psswd: POINTER): INTEGER is
			-- Show registration dialog.
		external
			"C (LPCTSTR): EIF_INTEGER | %"tlkapi.h%""
		alias
			"showMainDialog"
		end

	open_trial_session: BOOLEAN is
			-- Open trial session, ie set correctly the registry keys for TimeLock.
			-- Return True if it was successful.
		external
			"C | %"tlkapi.h%""
		alias
			"trialEnvironmentOpen"
		end

	close_trial_session: BOOLEAN is
			-- Close trial session, ie set correctly the registry keys for TimeLock.
			-- Return True if it was successful.
		external
			"C | %"tlkapi.h%""
		alias
			"trialEnvironmentClose"
		end

feature {NONE} -- Macros

	Tlock_error_wrongversion: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_WRONGVERSION"
		end

	Tlock_error_noaccessyet: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_NOACCESSYET"
		end

	Tlock_error_fileread: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_FILEREAD"
		end

	Tlock_error_badpassword: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_BADPASSWORD"
		end

	Tlock_error_filenotfound: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_FILENOTFOUND"
		end

	Tlock_error_success: INTEGER is
		external
			"C [macro %"tlkapi.h%"]"
		alias
			"TLOCK_ERROR_SUCCESS"
		end

end -- class TIME_LOCK
