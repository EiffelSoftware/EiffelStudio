indexing

    Product: EiffelStore
    Database: Matisse

class DB_TUPLE_MAT

inherit

    DB_TUPLE_I

creation -- Creation procedure

    make

feature -- Status report

    data: DB_DATA_MAT
            -- Associated data description

feature -- Initialization

    make is
            -- Create `implementation'.
        do
            !! data
        end

end -- class DB_TUPLE_MAT
