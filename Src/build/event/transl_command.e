
deferred class TRANSL_COMMAND 

inherit

	EB_UNDOABLE;
	
feature 

	name: STRING is
		do		
			!!Result.make (0);
			Result.append (c_name);
			Result.append ("(");
			Result.append (translation.text);
			Result.append (")");
		end;

feature {NONE}

	c_name: STRING is 
		deferred
		end;

	translation: TRANSLATION;

	work (argument: TRANSLATION) is
		do
			translation := argument;
			trans_work;
		end;

	trans_work is
		deferred
		end;

	redo is
		do
			trans_work
		end;

	failed: BOOLEAN;
	
invariant
	translation_not_void: translation /= Void
end
