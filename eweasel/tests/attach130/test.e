class TEST

create
	make

feature

	make
		local
			a: A
			has_retried: BOOLEAN
		do
			io.put_string
				(if has_retried then
					inspect a when {A}.make then "Failed (1)" else "OK" end
				else
					inspect a when {A}.make then "Failed (2)" end
				end)
			io.put_new_line
		rescue
			has_retried := True
			retry
		end

end
