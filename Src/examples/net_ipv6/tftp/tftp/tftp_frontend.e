deferred class TFTP_FRONTEND

feature


	allow_overwrite (address: INET_ADDRESS): BOOLEAN is
		deferred
		end

	allow_write (address: INET_ADDRESS): BOOLEAN is
		deferred
		end

	allow_read (address: INET_ADDRESS): BOOLEAN is
		deferred
		end

	retransmit_count (address: INET_ADDRESS): NATURAL is
		deferred
		end

	timeout (address: INET_ADDRESS): NATURAL is
		deferred
		end


	log_message_by_source (a_source: STRING; a_level: INTEGER; a_message: STRING) is
		require
			source_non_void: a_source /= Void
			source_valid: not a_source.is_empty
			message_non_void: a_message /= Void
			message_valid: not a_message.is_empty
		deferred
		end

	log_message_by_address (an_address: INET_ADDRESS; a_level: INTEGER; a_message: STRING) is
		require
			address_non_void: an_address /= Void
			message_non_void: a_message /= Void
			message_valid: not a_message.is_empty
		do
			log_message_by_source (an_address.host_address, a_level, a_message)
		end

	base_path (an_address: INET_ADDRESS): STRING is
		deferred
		end
end
