note
	description: "Helper class to perform several calls."
	author: "Florian Besser"
	date: "$Date$"
	revision: "$Revision$"

class
	WORKER

feature

	send_async_call (o: separate WORKER): BOOLEAN
		do
			o.receive_async_call
			Result := True
		end

	send_async_call_fail (o: separate WORKER): BOOLEAN
		do
			o.receive_async_call_fail
			Result := True
		end

	send_sync_call (o: separate WORKER): BOOLEAN
		do
			Result := o.receive_sync_call
		end

	send_sync_call_fail (o: separate WORKER): BOOLEAN
		do
			Result := o.receive_sync_call_fail
		end

	send_self_call: BOOLEAN
		do
			Result := Current.receive_sync_call
		end

	send_self_call_fail: BOOLEAN
		do
			Result := Current.receive_sync_call_fail
		end

	receive_async_call
		do
			--Do Nothing
		end

	receive_async_call_fail
		do
			my_exception.raise
		end

	receive_sync_call: BOOLEAN
		do
			Result := True
		end

	receive_sync_call_fail: BOOLEAN
		do
			my_exception.raise
			Result := True
		end

	my_exception: DEVELOPER_EXCEPTION
            once
                create Result
            end

end
