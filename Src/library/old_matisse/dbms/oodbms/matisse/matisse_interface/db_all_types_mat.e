indexing

    product: EiffelStore
	database : Matisse

class DB_ALL_TYPES_MAT inherit

    DB_ALL_TYPES_I

creation -- Creation procedure

    make

feature -- Element change

	register_all is
		-- Register all available types.
		-- Do nothing
		once
		end -- register_all

end -- class DB_ALL_TYPES_MAT

