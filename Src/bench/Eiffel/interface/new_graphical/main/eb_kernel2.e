indexing
	description: "EifelBench kernel, or supposed to be so"

class
	EB_KERNEL2

inherit
	 EV_APPLICATION

creation

	make

feature -- Access

        main_window: EB_PROFILE_WINDOW is
			--
		do
			create Result.make_top_level
			Result.show
		end

end -- class EB_KERNEL2
