indexing

    Product: EiffelStore
    Database: Matisse

class DB_DATA_MAT

inherit

    DB_STATUS_USE

    DB_DATA_SQL

    EXT_INTERNAL

    DB_CONSTANT
        export
            {NONE} all
        end

feature -- Status report

    count: INTEGER
        -- Number of columns in result

    max_count: INTEGER
        -- Maximum number of columns in result (unused)

    map_table: ARRAY [INTEGER]
            -- Correspondance table between column rank and
            -- attribute rank in mapped object

    item (index: INTEGER): ANY is
            -- Data at `index'-th column
        require else
            index_in_range: index > 0 and index <= count
        do
        end

    column_name (index: INTEGER): STRING is
            -- Name of the `index'-th column
        require else
            index_in_range: index > 0 and index <= count
        do
        ensure then
            Result = select_name.item (index)
        end

feature -- Element change

    update_map_table (object: ANY) is
            -- Update map table according to field names of `object'.
        require else
            object_exists: object /= Void
        do
        end

    fill_in (no_descriptor: INTEGER) is
            -- Fill in results obtained from Matisse
        do
        end

feature {NONE} -- Status report

    f_any: ANY
            -- Local entity
    f_date: DATE_TIME
            -- Local entity
    f_string, tmp_string: STRING
            -- Local entities
    f_double: DOUBLE
            -- Local entities

    mat_string: STRING_MAT is
            -- Object used to get string from the C interface to oracle `oracle.pc'
        once
            !! Result.make (selection_string_size)
        ensure
            result_not_void: Result /= Void
        end

    buffer: STRING is
            -- String buffer
        once
            !! Result.make (50)
        ensure
            result_not_void: Result /= Void
        end

    is_real_type (s: STRING): BOOLEAN is
            -- Is `s' a real type representation?
        require
            s_not_void: s /= Void
        do
            Result := s.index_of ('.', 1) /= 0
        end

    value_is_null (ind: INTEGER no_descriptor: INTEGER): BOOLEAN is
            -- Is value at `ind' for `no_descriptor' null?
        do
        end

    value: ARRAY [ANY]
            -- Array of values corresponding to a tuple

    value_size: ARRAY [INTEGER]
            -- Array of result value size for each column

    value_type: ARRAY [INTEGER]
            -- Array of column result type coded according to Eiffel conventions

    value_indicator: ARRAY [INTEGER]
            -- Unused

    select_name: ARRAY [STRING]
            -- Array of selected column names listed in select clause

    max_select_size: ARRAY [INTEGER]
            -- Unused

    select_size: ARRAY [INTEGER]
            -- Unused

    indicator_name: ARRAY [INTEGER]
            -- Unused

    max_indicator_size: ARRAY [INTEGER]
            -- Unused

    indicator_size: ARRAY [INTEGER]
            -- Unused

end -- class DB_DATA_MAT
