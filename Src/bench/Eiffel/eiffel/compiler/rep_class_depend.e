class REP_CLASS_DEPEND

inherit

	EXTEND_TABLE [REP_FEATURE_DEPEND, STRING];
	IDABLE
		undefine
			copy, is_equal
		end;

creation

	make

feature 

	id: CLASS_ID;
			-- Id of the associated class

	set_id (i: CLASS_ID) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

end
