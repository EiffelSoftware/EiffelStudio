note
	description: "Summary description for {WEB_APPLICATION}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_APPLICATION

create
	make

feature

    make
            -- Accept communication with client and exchange messages
        local
            soc1: NETWORK_STREAM_SOCKET
        do
            create soc1.make_server_by_port (3491)
            from
                soc1.listen (5)
            until
                false
            loop
                process (soc1) -- See below
            end
            soc1.cleanup
        end

    process (soc1: NETWORK_STREAM_SOCKET)
            -- Receive a message, extend it, and send it back
        do
            soc1.accept
            if {soc2: NETWORK_STREAM_SOCKET} soc1.accepted then
	            if {message: STRING} soc2.retrieved then
	            	message.append (" signed by Webapp")
	            	soc2.independent_store (message)
	            end
            	soc2.close
            end
        end

end
