class REP_CLASS_DEPEND

inherit
	EXTEND_TABLE [REP_FEATURE_DEPEND, STRING]

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			copy, is_equal
		end;

creation
	make

end
