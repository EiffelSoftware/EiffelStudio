indexing

    Product: EiffelStore
    Database: Matisse

class LOGIN_MATISSE

feature -- Status setting

	set (h_name,d_name: STRING) is
		-- Set host name and database name before connection becomes possible.
		 require
			arguments_not_void : h_name /= Void and d_name /= Void
			arguments_not_empty : not ( h_name.empty or d_name.empty)
		do
			host_name := clone (h_name)
			database_name := clone (d_name)
		ensure
			host_name.is_equal (h_name)
			database_name.is_equal (d_name)
		end -- set

feature -- Access

	host_name: STRING  -- Client Host name

	database_name: STRING -- Name of database beeing used

end -- class LOGIN_MATISSE
