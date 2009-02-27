class --OBSOLETE
    XB_SERVER_UDP
inherit

    SOCKET_RESOURCES

    STORABLE

create
    make

feature

    soc1, soc2: NETWORK_DATAGRAM_SOCKET
    ok: BOOLEAN

    make
            -- Accept communication with client and exchange messages
        do
        	io.putstring ("start server" + "%N")
            create soc1.make_bound (4950)
            from
            	ok := FALSE
            until
				ok = TRUE
            loop
				process -- See below
            end
            io.putstring ("terminate" + "%N")
            soc1.cleanup
        rescue
        	soc1.cleanup
        end

    process
            -- Receive a message, extend it, and send it back
        local
            our_message: DATAGRAM_PACKET
            i: INTEGER
            res: STRING
            buf: STRING
        do
            res := ""
            our_message := soc1.received (100, 0)
            io.putstring (our_message.data.count.out + "%N")
            from
            	i := 0
            until
            	--buf.is_equal ("")
            	i >= our_message.data.count
            loop
            	--if our_message.data. then

            	--end
            	buf := our_message.data.read_character (i).out
            	res.append (buf)
            	i:= i+1
            end

            io.putstring (res + "%N")
          	ok := FALSE--res.has_substring("end")
        end

end
