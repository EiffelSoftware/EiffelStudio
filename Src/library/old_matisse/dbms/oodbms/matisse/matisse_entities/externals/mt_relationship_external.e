class MT_RELATIONSHIP_EXTERNAL 

feature {NONE} -- Implementation MT_RELATIONSHIP

    c_get_relationship_from_name(name:POINTER) : INTEGER is
        -- Use GetRelationship
    external
        "C"
    end -- c_get_relationship_from_name

    c_check_relationship(rid,oid : INTEGER)  is
        -- Use Mt_CheckRelationship
    external
        "C"
    end -- c_check_relationship

end -- class MT_RELATIONSHIP_EXTERNAL
