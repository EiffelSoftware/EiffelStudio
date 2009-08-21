class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			r32: REAL_32
			r64: REAL_64
		do
$C			{SYSTEM_THREAD}.current_thread.current_culture := create {CULTURE_INFO}.make ("ru-RU", false)
			r32 := {REAL_32} 1.5
			r64 := 1.5
			print (r32)
			io.put_new_line
			print (r64)
			io.put_new_line
			print (r32.out)
			io.put_new_line
			print (r64.out)
			io.put_new_line
		end

end
