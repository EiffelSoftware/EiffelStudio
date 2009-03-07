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
            print("XEbra Application started.")
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
            if attached {NETWORK_STREAM_SOCKET} soc1.accepted as soc2 then
	            if attached {STRING} soc2.retrieved as message then
	            	message.append (read_page("/home/fabioz/local/xebra/websites/red_bull.htm"))
	            	soc2.independent_store (message)
	            end
            	soc2.close
            end
        end


   read_page(a_file: STRING): STRING
   			-- Reads a text file and returns it as a string
 		 require
 		 	a_file_not_empty: not a_file.is_empty
 		 local
   			l_file: PLAIN_TEXT_FILE
 		 do
			Result := ""
			create l_file.make_open_read (a_file)
	        l_file.read_stream (l_file.count)
	        if attached {STRING} l_file.last_string as str then
	        	Result := str.twin
	        end
	        l_file.close
		 end

end
