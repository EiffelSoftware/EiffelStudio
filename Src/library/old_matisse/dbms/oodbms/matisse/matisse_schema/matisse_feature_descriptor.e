indexing
	description: "Matisse object database feature descriptor."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

class MATISSE_FEATURE_DESCRIPTOR

inherit 
	ODB_FEATURE_DESCRIPTOR

	MATISSE_CONST
		export
			{NONE} all
		end

creation
	make

feature -- Initialisation
	make(a_db_name:STRING; a_db_type:INTEGER) is
		require
			Db_name_exists: a_db_name /= Void and then not a_db_name.empty
		do
			db_name := a_db_name
			db_type := a_db_type
			eif_name := unqualified_db_name
		end

feature -- Access
	unqualified_db_name:STRING is
			-- name of this feature on database with any "class::" qualification
			-- due to being in relative schema form
		local
			spos:INTEGER
		do
			spos := db_name.substring_index(Relative_schema_name_seperator, 1)
			if spos = 0 then 
				Result := clone(db_name)
			else
				Result := db_name.substring(spos + Relative_schema_name_seperator.count, db_name.count)
			end
		end

feature -- Status
	is_attribute:BOOLEAN is
		do
			Result := db_type /= Mtrelationship_type
		end

	is_relationship:BOOLEAN is
		do
			Result := db_type = Mtrelationship_type
		end

invariant
	Eif_name_exists: eif_name /= Void and then not eif_name.empty

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

