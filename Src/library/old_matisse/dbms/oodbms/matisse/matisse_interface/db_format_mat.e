indexing

    Product: EiffelStore
    Database: Matisse

class DB_FORMAT_MAT

inherit

	DB_FORMAT_I

	BASIC_ROUTINES

feature -- Conversion

    boolean_format (object: BOOLEAN): STRING is
            -- String representation in SQL string of `object'
        do
            if object.item then
                Result := True_representation
            else
                Result := False_representation
            end        
        end

    date_format (object: DATE_TIME): STRING is
            -- String representation in SQL of `object'
        do
        ensure then
            Result = date_buffer
        end

    string_format (s: STRING): STRING is
            -- String representation in SQL of `object'
        do
        end

feature {NONE} -- Status report

    True_representation: STRING is "'T'"

    False_representation: STRING is "'F'"

    Concat_string: STRING is "'||'"

    Max_len: INTEGER is 255

    break (s: STRING): STRING is
            -- Broken long string using
        require
            s_not_void: s /= Void
        do
        end

    date_buffer: STRING is
            -- String buffer
        once
            !! Result.make (20)
        end

end -- class DB_FORMAT_MAT
