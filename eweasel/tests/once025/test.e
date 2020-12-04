class TEST

create
	make

feature

	make
		do
			⟳ d: {WEEK_DAYS}.instances ¦ io.put_string (d.greeting); io.put_new_line ⟲
		end

end
