indexing
	description: "EifelBench kernel, or supposed to be so"

class
	EB_KERNEL3

inherit
	 EV_APPLICATION

creation

	make

feature -- Access

        main_window: EB_ABOUT_WINDOW is
			--
		do
			create Result.make_default
			Result.show
		end

end -- class EB_KERNEL3
