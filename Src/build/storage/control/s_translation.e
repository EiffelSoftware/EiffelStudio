
class S_TRANSLATION 

inherit

	SHARED_STORAGE_INFO

creation

	make
	
feature 

	identifier: INTEGER;
	
feature {NONE}

	text: STRING;

	internal_name: STRING;

	
feature 

	make (a_translation: TRANSLATION) is
		do
			identifier := a_translation.identifier;
			text := a_translation.text;
			internal_name := a_translation.internal_name;
		end;

	translation: TRANSLATION is
		do
			!!Result.make;
			Result.set_text (text);
			Result.set_internal_name (internal_name);
		end;

end
