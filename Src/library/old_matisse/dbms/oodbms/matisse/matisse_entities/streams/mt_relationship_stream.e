class MT_RELATIONSHIP_STREAM 

inherit 

	MT_STREAM

	MT_RELATIONSHIP_STREAM_EXTERNAL

Creation 
    make

feature {RELATIONSHIP} -- Implementation

    make(one_object : MT_OBJECT;one_relationship : MT_RELATIONSHIP) is
        -- Open Stream
    do
        sid := c_open_relationship_stream(one_object.oid,one_relationship.rid)
    end -- make

feature -- Access

    next_object : MT_OBJECT is
    local
        noid : INTEGER
    do
        noid := c_next_object(sid) 
        !!Result.make(noid)
    end -- next object

end -- class MT_RELATIONSHIP_STREAM
