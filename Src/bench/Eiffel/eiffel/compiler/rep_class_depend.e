class REP_CLASS_DEPEND

inherit

	EXTEND_TABLE [REP_FEATURE_DEPEND, STRING];
	IDABLE
		undefine
			twin
		end;

creation

	make

feature 

	id: INTEGER;
			-- Id of the associated class

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

end
