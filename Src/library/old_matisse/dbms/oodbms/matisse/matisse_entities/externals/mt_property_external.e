class MT_PROPERTY_EXTERNAL 

feature {NONE} -- Implementation MT_PROPERTY

    c_check_property(pid,oid : INTEGER) : BOOLEAN is
        -- Use MtCheckProperty
    external
        "C"
    end -- c_check_property

end -- class MT_PROPERTY_EXTERNAL
