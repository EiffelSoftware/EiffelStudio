class MT_KEYS_EXTERNAL 


feature {NONE} -- Implementation Keys management

    c_keys_count : INTEGER is
    external
        "C"
    end -- c_keys_count

    c_ith_key(i:INTEGER) : INTEGER is
    external
        "C"
    end -- c_ith_key

    c_free_keys is
    external
        "C"
    end -- c_free_keys

end -- class MT_KEYS_EXTERNAL
