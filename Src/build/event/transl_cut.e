
class TRANSL_CUT

inherit

	TRANSL_COMMAND;
	TRANSL_SHARED
	
feature 

	c_name: STRING is "Cut Translation";

feature {NONE}

	index: INTEGER;

	trans_work is
		do
			translation_list.start;
			translation_list.search (translation);
			if translation_list.after then
				failed := True
			else
				index := translation_list.index;
				translation_list.remove;
				context_catalog.update_translation_page;
				if translation.edited then
					translation.editor.reset
				end
			end
		end;

feature 

	undo is
		do
			if not translation_list.empty then
				translation_list.go_i_th (index - 1);
				translation_list.add_right (translation);
			else
				translation_list.add (translation)
			end;
			context_catalog.update_translation_page;
		end;
	
end
