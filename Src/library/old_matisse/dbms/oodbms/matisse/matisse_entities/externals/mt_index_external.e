class MT_INDEX_EXTERNAL 


feature {NONE} -- Implementation MT_INDEX

    c_get_index(index_name : POINTER) : INTEGER is
        -- Use MtGetIndex
    external
        "C"
    end -- c_get_index


end -- class MT_INDEX_EXTERNAL
