class
	DYNAMIC_NO_I

inherit
	DYNAMIC_I
		redefine
			is_no
		end

feature -- Status report

	is_no: BOOLEAN is True

	is_dynamic (feat_name: STRING): BOOLEAN is
		do
		end;

end -- class DYNAMIC_NO_I
