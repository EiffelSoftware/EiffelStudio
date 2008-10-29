indexing
	description:
		"Transactions consisting out of a single transfer"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SINGLE_TRANSACTION inherit

	TRANSACTION

create

	make

feature {NONE} -- Initialization

	make (s, t: DATA_RESOURCE) is
			-- Create transaction.
		require
			source_exists: s /= Void
			target_exists: t /= Void
		do
			source := s
			target := t
			source.set_read_mode
			target.set_write_mode
		ensure
			source_set: source = s
			target_set: target = t
			read_mode_set: source.read_mode
			write_mode_set: target.write_mode
		end

feature -- Access

	source: DATA_RESOURCE
			-- Current source
	
	target: DATA_RESOURCE
			-- Current target
	
feature -- Measurement

	count: INTEGER is 1
			-- Number of transactions (Always 1)

feature -- Status report

	is_correct: BOOLEAN is
			-- Is transaction set up correctly?
		do
			Result := source.is_readable and target.is_writable
		end

	succeeded: BOOLEAN is
			-- Has the transaction succeeded?
		do
			Result := not error and then not source.is_packet_pending and 
				(source.bytes_transferred = target.bytes_transferred) and
				(source.is_count_valid implies 
				source.count = target.bytes_transferred)
		end

feature -- Status setting

	reset_error is
			-- Reset error flags.
		do
			source.reset_error
			target.reset_error
		end

feature -- Basic operations

	execute is
			-- Execute transaction.
		do
			debug Io.error.put_string ("- OPEN -%N") end
			source.open
			target.open
			if not error then
				debug Io.error.put_string ("- INITIATE -%N") end
				source.initiate_transfer
				target.initiate_transfer
				if not error then
					debug Io.error.put_string ("- TRANSFER -%N") end
					target.put (source)
				end
			end
			debug Io.error.put_string ("- CLOSE -%N") end
			if source.is_open then source.close end
			if target.is_open then target.close end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SINGLE_TRANSACTION

