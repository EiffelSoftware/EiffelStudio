class TEST

create
	make

feature

	make
		do
			{B}.make.do_nothing
			{B}.make_default.do_nothing
			{B}.make_object.do_nothing
			{B}.make_thread.do_nothing
			{B}.make_process.do_nothing
			{B}.make_do.do_nothing
		end

end
