class MATISSE_TABLES 

inherit

	IDF_ID 

feature -- Access

	idf_table_name : STRING is once Result:="IDF_TABLE" end -- idf_table_name

	idf_table : CELL[MATISSE_IDF_TABLE] is once !!Result.put(Void) end -- idf_table

end -- class MATISSE_TABLES
