deferred class 

	TFTP_EVENT_LISTENER

feature

	tftp_message (e: TFTP_EVENT)
		deferred
		end

	sent_data (data_length: INTEGER)
		deferred
		end

	received_data (data_length: INTEGER)
		deferred
		end
end
