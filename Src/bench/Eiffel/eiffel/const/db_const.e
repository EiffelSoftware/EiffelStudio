indexing
	description: "[
		Byte code constant for debug level
		These values have to match with those in run-time file update.h.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_CONST
	
feature -- Access

	Db_no:		CHARACTER is 'n';
	Db_yes:		CHARACTER is 'y';
	Db_tag:		CHARACTER is 't';

end -- class DB_CONST
