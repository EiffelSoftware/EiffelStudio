indexing
	description: "Object database feature descriptor: describes attribute or relationship %
                    %as known on the database, as well as the corresponding Eiffel object %
                    %mappings."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

deferred class ODB_FEATURE_DESCRIPTOR

feature -- Access
	db_name:STRING
			-- name of this feature on database

	db_type:INTEGER
			-- type of this feature on database

	eif_name:STRING
			-- eiffel attribute name of this feature

	eif_type:INTEGER
			-- eiffel field type of this feature, as returned by INTERNAL.field_type

	eif_position:INTEGER
			-- field position of this feature in relevant eiffel object
	
feature {ODB_CLASS_DESCRIPTOR} -- Modification
	set_eif_details(an_eif_type, an_eif_position:INTEGER) is
		do
			eif_type := an_eif_type
			eif_position := an_eif_position
		end

feature -- Status
	is_attribute:BOOLEAN is
			-- True if this feature is classified as an attribute on the database
		deferred
		end

	is_relationship:BOOLEAN is
			-- True if this feature is classified as an relationship on the database
		deferred
		end

feature -- Conversion
	as_string:STRING is
		do
			!!Result.make(0)
			Result.append(db_name) 
			Result.append(", (") Result.append(eif_name)
			Result.append(") %TDB type: ") Result.append_integer(db_type) 
		end

invariant
	Db_name_exists: db_name /= Void and then not db_name.empty

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

