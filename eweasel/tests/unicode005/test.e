class
	test

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			print (("%U+-").has ('%U'))
			io.new_line
		end

end
