once class B

inherit
	A

create
	make,
	make_default,
	make_object,
	make_thread,
	make_process,
	make_do

feature {NONE} -- Creation

    make_default once end
    make_object once ("OBJECT") end
    make_thread once ("THREAD") end
    make_process once ("PROCESS") end
    make_do do end

end