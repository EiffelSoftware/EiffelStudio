
class TRANSL_ADD 

inherit

	TRANSL_COMMAND;
	SHARED_TRANSLATIONS
	
creation
	execute
	
feature 

	c_name: STRING is "Add Translation";

feature {NONE}

	trans_work is
		do
			Shared_translation_list.extend (translation);
			context_catalog.update_translation_page
		end;

feature 

	undo is
		do
			Shared_translation_list.start;
			Shared_translation_list.search (translation);
			if not Shared_translation_list.after then
				Shared_translation_list.remove;
				context_catalog.update_translation_page;
				if translation.edited then
					translation.editor.clear
				end
			end
		end;
	
end
