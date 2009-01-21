
class TEST
create
	make

inherit

	A

	D
		undefine
			my_routine
		end


feature
	
	make
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				my_routine
			end
		rescue
			io.put_string ("Ok")
			l_retried := True
			retry
		end

end
