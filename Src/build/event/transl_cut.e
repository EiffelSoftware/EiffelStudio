
class TRANSL_CUT

inherit

	TRANSL_COMMAND;
	SHARED_TRANSLATIONS
	
feature 

	c_name: STRING is "Cut Translation";

feature {NONE}

	index: INTEGER;

	trans_work is
		do
			Shared_translation_list.start;
			Shared_translation_list.search (translation);
			if Shared_translation_list.after then
				failed := True
			else
				index := Shared_translation_list.index;
				Shared_translation_list.remove;
				context_catalog.update_translation_page;
				if translation.edited then
					translation.editor.clear
				end
			end
		end;

feature 

	undo is
		do
			if not Shared_translation_list.empty then
				Shared_translation_list.go_i_th (index - 1);
				Shared_translation_list.put_right (translation);
			else
				Shared_translation_list.extend (translation)
			end;
			context_catalog.update_translation_page;
		end;
	
end
