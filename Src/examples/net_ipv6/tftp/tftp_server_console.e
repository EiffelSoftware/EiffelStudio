indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class

	TFTP_SERVER_CONSOLE

inherit

	ARGUMENTS

	INET_PROPERTIES

	TFTP_FRONTEND

	TFTP_EVENT_LISTENER

create

	make

feature {NONE} -- Initialization

	make is
		local
			prefer_ipv4_stack: BOOLEAN
			server_thread: SERVER_THREAD
		do
			if argument_count > 0  then
				prefer_ipv4_stack := argument (1).to_boolean
			end

			if prefer_ipv4_stack then
				set_ipv4_stack_preferred (True)
			end

			io.put_string ("starting console TFTP server")
			io.put_new_line

				-- Create the Server Thread
			create server_thread.make (Current)
			server_thread.add_tftp_event_listener (Current)
			server_thread.execute
		end

feature -- Implementation

	allow_overwrite (address: INET_ADDRESS): BOOLEAN is
		do
			Result := True
		end

	allow_write (address: INET_ADDRESS): BOOLEAN is
		do
			Result := True
		end

	allow_read (address: INET_ADDRESS): BOOLEAN is
		do
			Result := True
		end

	retransmit_count (address: INET_ADDRESS): NATURAL is
		do
			Result := 5
		end

	timeout (address: INET_ADDRESS): NATURAL is
		do
			Result := 5000
		end


	log_message_by_source (a_source: STRING; a_level: INTEGER; a_message: STRING) is
		do
			io.put_string (a_source + "[" + a_level.out + "] " + a_message)
			io.put_new_line
		end

	base_path (an_address: INET_ADDRESS): STRING is
		do
			Result := "."
		end

	tftp_message (e: TFTP_EVENT) is
		do
			inspect e.id
			when {TFTP_EVENT}.request_complete then
				io.put_string ("request complete%N")
			when {TFTP_EVENT}.request_incomplete then
				io.put_string ("request incomplete%N")
			when {TFTP_EVENT}.request_outoforder then
				io.put_string ("request outoforder%N")
			when {TFTP_EVENT}.request_processing then
				io.put_string ("request processing%N")
			when {TFTP_EVENT}.request_received then
				io.put_string ("request received%N")
			when {TFTP_EVENT}.request_retransmit then
				io.put_string ("request retransmit%N")
			else
			end
		end

	sent_data (data_length: INTEGER) is
		do
				io.put_string ("sent data, lenght = " + data_length.out +"%N")
		end

	received_data (data_length: INTEGER) is
		do
				io.put_string ("received data, lenght = " + data_length.out +"%N")
		end
end
