class MT_NAME_EXTERNAL 

feature {NONE} -- Implementation

    c_object_name(oid : INTEGER) : POINTER is
    external 
        "C"
    end -- c_object_name

end -- class MT_NAME_EXTERNAL
