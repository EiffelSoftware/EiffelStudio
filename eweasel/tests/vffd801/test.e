class TEST

create
	make

feature {NONE} -- Creation

        make
        	local
        		t: TEST
		do
			t := f1
			t := f2
			t := f3
			t := f4
			t := f5
		end

feature -- Access

	f1: TEST
		once
			Result := Current
		end

	f2: TEST
		once ("OBJECT")
			Result := Current
		end

	f3: TEST
		once ("THREAD")
			Result := Current
		end

	f4: TEST
		once ("PROCESS")
			Result := Current
		end

	f5: TEST
		note
			once_status: "global"
		once
			Result := Current
		end

end
