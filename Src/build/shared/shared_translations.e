
class SHARED_TRANSLATIONS
	
feature {NONE}

	Shared_translation_list: LINKED_LIST [TRANSLATION] is
		once
			!!Result.make
		end;

end
