indexing
	description: "EifelBench kernel, or supposed to be so"

class
	EB_KERNEL1

inherit
	 EV_APPLICATION

creation

	make

feature -- Access

        first_window: EB_PREFERENCE_WINDOW is
			--
		do
			create Result.make_top_level
			Result.show
		end

end -- class EB_KERNEL1
