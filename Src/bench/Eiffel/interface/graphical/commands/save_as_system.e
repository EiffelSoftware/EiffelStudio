
class SAVE_AS_SYSTEM 

inherit

	SHARED_WORKBENCH;
	SAVE_AS_FILE
		redefine
			make, update_more
		end

creation

	make

	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;

	update_more is
		do
			Lace.set_file_name (text_window.file_name)
		end

end
