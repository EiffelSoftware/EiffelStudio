
class TRANSL_SET_TEXT 

inherit

	TRANSL_COMMAND

creation
	make
	
feature 

	c_name: STRING is "Set translation text";

	set_text (s: STRING) is
		do
			text := clone (s);
		end
	
feature {NONE} --Initialization
	
	make (txt: STRING; transl: TRANSLATION) is
		do
			set_text(txt)
			execute(transl)
		end
	
	
feature {NONE}

	old_text, text: STRING;

	trans_work is
		do
			old_text := clone (translation.text);
			translation.set_text (text);
			context_catalog.update_translation_page;
			if translation.edited then
				translation.editor.update_translation
			end
		end;

	undo is
		do
			translation.set_text (old_text);
			context_catalog.update_translation_page
		end;

end
