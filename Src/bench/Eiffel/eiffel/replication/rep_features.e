class REP_FEATURES

inherit

	EXTEND_TABLE [FEATURE_AS, INTEGER]
		rename
			make as et_make
		end;

	IDABLE
		rename
			id as class_id
		undefine
			twin
		end;

creation

	make

feature

	class_id: INTEGER;
		-- Class id where features are replicated

	make (i: INTEGER; ci: INTEGER) is
			-- Make Current with `i' items and with
			-- class_id `ci'.
		do
			et_make (i);
			class_id := ci;
		end;

end
