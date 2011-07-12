class TEST

create
	make

feature {NONE} -- Creation

        make
		do
			f1
			f2
			f3
			f4
			f5
		end

feature -- Access

	f1
		once
		end

	f2
		once ("OBJECT")
		end

	f3
		once ("THREAD")
		end

	f4
		once ("PROCESS")
		end

	f5
		note
			once_status: "global"
		once
		end

end

