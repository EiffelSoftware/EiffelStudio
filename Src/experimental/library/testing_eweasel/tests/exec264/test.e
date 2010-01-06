class 
	  TEST

create
	make

feature -- Initialization

	make is
		do
			print ((agent {A}.a).item ([create {A}.make]))
			io.new_line
		end

end -- class TEST
