
class SAVE_AS_SYSTEM 

inherit

	SHARED_EIFFEL_PROJECT;
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
		local
			show_text: SHOW_TEXT
		do
			show_text ?= text_window.last_format;
			if show_text /= Void then
				Eiffel_project.set_lace_file_name (text_window.file_name)
			end;
		end

end
