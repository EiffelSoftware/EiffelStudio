class SHARED_CURSOR

feature

	one_cursor  : DB_RESULT is
	once
		create Result.make
	end -- one_cursor

end -- class SHARED_CURSOR
