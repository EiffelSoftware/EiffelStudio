class DEMO 

inherit

	WINDOWS

creation

	make

feature

	make is
		do
			init_windowing;
			main_window.realize;
			iterate
				-- Event loop
		end;

end
