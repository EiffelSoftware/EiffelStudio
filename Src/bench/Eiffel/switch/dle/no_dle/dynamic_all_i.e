class
	DYNAMIC_ALL_I

inherit
	DYNAMIC_I
		redefine
			is_all
		end

feature -- Status report

	is_all: BOOLEAN is True

	is_dynamic (feat_name: STRING): BOOLEAN is
		do
			Result := true
		end;

end -- class DYNAMIC_ALL_I
