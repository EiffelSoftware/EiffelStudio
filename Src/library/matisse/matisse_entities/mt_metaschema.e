indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_METASCHEMA

inherit
	MT_STORABLE

feature -- Access

	name: STRING is
			-- "Mt Name" of meta-schema object in Matisse
		do
			!! Result.make (0) 
			Result.from_c (c_object_mt_name (oid))
		end -- name

feature {MATISSE, MT_RS_CONTAINABLE}

	database: MATISSE
	
	set_database (a_db: MATISSE) is
		do
			database := a_db
		end
	
end -- class MT_METASCHEMA
