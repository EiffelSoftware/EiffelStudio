indexing

	description: "Class which gives all the information to log on a Matisse database."
    Product: EiffelMatisse

class 
	LOGIN_MATISSE

feature -- Status setting

	set (h_name, d_name: STRING) is
			-- Set host name and database name before connection becomes possible.
		 require
			arguments_not_void: h_name /= Void and d_name /= Void
			arguments_not_empty: not ( h_name.is_empty or d_name.is_empty)
		do
			host_name := clone (h_name)
			database_name := clone (d_name)
		ensure
			host_name.is_equal (h_name)
			database_name.is_equal (d_name)
		end

feature -- Access

	host_name: STRING
		-- Client Host name

	database_name: STRING 
		-- Name of database beeing used

end -- class LOGIN_MATISSE
