deferred class 

	TFTP_EVENT_LISTENER

feature

	tftp_message (e: TFTP_EVENT) is
		deferred
		end

	sent_data (data_length: INTEGER) is
		deferred
		end

	received_data (data_length: INTEGER) is
		deferred
		end
end
