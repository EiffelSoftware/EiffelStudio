deferred class DYNAMIC_I

feature

	is_all: BOOLEAN is
		do
		end;

	is_no: BOOLEAN is
		do
		end;

	is_partial: BOOLEAN is
		do
		end;

	is_dynamic (feat_name: STRING): BOOLEAN is
		deferred
		end;

end -- class DYNAMIC_I
