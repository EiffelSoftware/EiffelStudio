class MT_CREATE_OBJECT_EXTERNAL 

feature {NONE} -- Implementation

    c_create_object(name :POINTER) : INTEGER is
    external
        "C"
    end -- c_create_object

end -- class MT_CREATE_OBJECT_EXTERNAL
