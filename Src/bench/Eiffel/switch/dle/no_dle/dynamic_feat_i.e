class
	DYNAMIC_FEAT_I

inherit
	DYNAMIC_I
		redefine
			is_partial
		end;

	TWO_WAY_SORTED_SET [STRING]
		rename
			make as twss_make
		export
			{NONE} twss_make
		end

creation

	make

feature {NONE} -- Initialization

	make is
		do
			twss_make;
			compare_objects
		end;

feature -- Status report

	is_partial: BOOLEAN is True

	is_dynamic (feat_name: STRING): BOOLEAN is
		do
			Result := has (feat_name)
		end;

end -- class DYNAMIC_FEAT_I
