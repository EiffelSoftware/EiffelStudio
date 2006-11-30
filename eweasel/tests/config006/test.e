class TEST

create
	make

feature 

	make is
		do
			debug
				print ("unnamed")
				io.new_line
			end

			debug ("foo")
				print ("foo")
				io.new_line
			end

			debug ("bar")
				print ("bar")
				io.new_line
			end

			debug ("foo", "bar")
				print ("foobar")
				io.new_line
			end
		end
end
