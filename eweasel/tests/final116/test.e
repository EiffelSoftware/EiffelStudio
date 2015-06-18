class TEST

inherit
	EXCEPTIONS

creation
	make

feature

	make
		local
			l_array: ARRAY [INTEGER]
		do
			global_counter := 0
			create l_array.make_filled(0, 1, 10)
			user_initialization
		end

	user_initialization is
		do
			if global_counter < 100 then
				global_counter := global_counter + 1
				if update_windows_in_progress
				then
					request_update_windows := True
				else
					update_windows_in_progress := True
					xyzzy
				end
			end
		rescue
			update_windows_in_progress := False
			request_update_windows := False
			retry
		end

	xyzzy is
		do
			user_initialization
			if request_update_windows
			then
				raise("test")
			end
		rescue
			foo
		end

	foo is
		local
			l_retry: BOOLEAN
		do
			if not l_retry
			then
				raise("sldk")
			end
		rescue
			l_retry := True
			retry
		end

	request_update_windows: BOOLEAN

	update_windows_in_progress: BOOLEAN

	global_counter: INTEGER

end
