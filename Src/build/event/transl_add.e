
class TRANSL_ADD 

inherit

	TRANSL_COMMAND;
	TRANSL_SHARED
	
feature 

	c_name: STRING is "Add Translation";

feature {NONE}

	trans_work is
		do
			translation_list.add (translation);
			context_catalog.update_translation_page
		end;

feature 

	undo is
		do
			translation_list.start;
			translation_list.search (translation);
			if not translation_list.after then
				translation_list.remove;
				context_catalog.update_translation_page;
				if translation.edited then
					translation.editor.reset
				end
			end
		end;
	
end
