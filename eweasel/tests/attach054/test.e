
class TEST

create
	make, default_create

feature

	make is
		local
			x: TEST2
		do
			create x
			print (x.to_string.as_lower); io.new_line
		end

end
