indexing
	description: "EifelBench kernel, or supposed to be so";

class
	EB_KERNEL

inherit
	 EV_APPLICATION

creation

	make


feature -- Access

        main_window: EB_PREFERENCE_WINDOW is
			--
		do
			!!Result.make_top_level
			Result.show
		end;

end -- class EB_KERNEL
