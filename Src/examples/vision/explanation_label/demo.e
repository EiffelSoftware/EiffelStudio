indexing
	description: "Root class of the example";
	date: "$Date$";
	revision: "$Revision$"

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

end -- class DEMO
