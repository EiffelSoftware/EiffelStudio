indexing
	description:
		"Data resources"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class DATA_RESOURCE inherit

	DATA_RESOURCE_ERROR_CONSTANTS
		redefine
			is_equal
		end

	HASHABLE
		redefine
			is_equal, is_hashable
		end
	
feature {NONE} -- Initialization

	make (addr: like address) is
			-- Create protocol.
		require
			address_exists: addr /= Void
		do
			address := addr
			initialize
		ensure
			address_set: address = addr
		end
		
	initialize is
			-- Initialize protocol.
		deferred
		end
		
feature -- Access
	
	last_packet: STRING
			-- Last packet read

	address: URL
			-- Associated address
			
	service: STRING is
			-- Name of service
		do
			Result := address.service
		end

	mode: INTEGER
			-- Current mode

	port: INTEGER is
			-- Port used by service
		do
			Result := address.port
		ensure
			result_non_negative: Result >= 0
		end

	proxy_host: STRING is
			-- Name or address of proxy host
		require
			proxy_supported: is_proxy_supported
			proxy_used: is_proxy_used
		do
			Result := address.proxy_host
		ensure
			result_not_empty: Result /= Void and then not Result.is_empty
		end

	proxy_port: INTEGER is
			-- Port of proxy
		require
			proxy_supported: is_proxy_supported
			proxy_used: is_proxy_used
		do
			Result := address.proxy_port
		ensure
			result_non_negative: Result >= 0
		end

	hash_code: INTEGER is
			-- Hash function
		do
			Result := address.hash_code
		end

	location: STRING is
			-- Location of resource
		require
			address_exists: address /= Void
		do
			Result := address.location
		end

feature -- Measurement

	count: INTEGER is
			-- Size of data resource
		deferred
		end
		 
	last_packet_size: INTEGER is
			-- Size of last packet
		deferred
		end
	 
	 read_buffer_size: INTEGER is
	 		-- Size of read buffer
	 	deferred
	 	end
	 
	 bytes_transferred: INTEGER is
	 		-- Number of transferred bytes
		deferred
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is resource equal to `other'?
		do
			Result := equal (address, other.address) and mode = other.mode
		end
	 
feature -- Status report

	is_open: BOOLEAN is
			-- Is resource open?
		deferred
		end
	 
	is_readable: BOOLEAN is
			-- Is it possible to open in read mode currently?
		deferred
		ensure
			mode_unchanged: mode = old mode
		end
	
	is_writable: BOOLEAN is
			-- Is it possible to open in write mode currently?
		deferred
		ensure
			mode_unchanged: mode = old mode
		end
	
	address_exists: BOOLEAN is
			-- Does address exists?
		deferred
		end
	 
	valid_mode (n: INTEGER): BOOLEAN is
			-- Is mode `n' valid?
		deferred
		end
	 
	is_packet_pending: BOOLEAN is
			-- Can another packet currently be read out?
		deferred
		end
	
	has_packet: BOOLEAN is
			-- Is there a packet available in `last_packet'?
		do
			Result := last_packet /= Void
		end
	
	transfer_initiated: BOOLEAN
			-- Has transfer being initiated.
			
	is_mode_set: BOOLEAN is
			-- Has resource mode been set?
		do
			Result := mode /= 0 and then valid_mode (mode)
		end
	
	is_proxy_supported: BOOLEAN is
			-- Is proxy supported by resource?
		do
			Result := address.is_proxy_supported
		end
		
	is_proxy_used: BOOLEAN is
			-- Does resource use a proxy?
		deferred
		end

	is_count_valid: BOOLEAN is
			-- Is value in `count' valid?
		deferred
		end
	 
	is_hashable: BOOLEAN is
			-- Are objects of current type hashable?
		do
			Result := address.is_hashable
		end

	error: BOOLEAN is
			-- Has an error occurred?
		do
			Result := error_code /= 0
		end

	error_code: INTEGER
			-- Code of error
	
	supports_multiple_transactions: BOOLEAN is
			-- Does resource support multiple tranactions per connection?
		deferred
		end
	 
	read_mode: BOOLEAN is
	 		-- Is read mode set?
		deferred
		end
	
	write_mode: BOOLEAN is
			-- Is write mode set?
		deferred
		end
	 
	 timeout: INTEGER
	 		-- Connection timeout
			
feature -- Status setting

	open is
			-- Open resource.
		require
			no_error_occurred: not error
			mode_set: is_mode_set
		deferred
		ensure
			no_packet_available: not (has_packet and is_packet_pending)
			initiated_flag_reset: not transfer_initiated
			failure_means_error: not is_open implies error
		end

	close is
			-- Close.
		require
			open: is_open
		deferred
		ensure
			closed: not is_open
			mode_unchanged: mode = old mode
			no_packet_available: not (has_packet and is_packet_pending)
		end
	
	initiate_transfer is
			-- Initiate transfer.
		require
			no_error_occurred: not error
			mode_set: is_mode_set
			open: is_open
			not_initiated: not transfer_initiated
		deferred
		ensure
			failure_means_error: not transfer_initiated implies error
		end
	
	set_read_buffer_size (n: INTEGER) is
			-- Set size of read buffer.
		require
			size_positive: n > 0
		deferred
		ensure
			buffer_size_set: read_buffer_size = n
		end
		
	set_read_mode is
			-- Set read mode.
		deferred
		ensure
			read_mode_set: read_mode
		end
	 
	set_write_mode is
	 		-- Set write mode.
		deferred
		ensure
			write_mode_set: write_mode
		end
	
	set_port (port_no: INTEGER) is
			-- Set port number to `port_no'.
		require
			closed: not is_open
			non_negative_port_number: port_no >= 0
		do
			address.set_port (port_no)
		ensure
			port_set: port = port_no
		end

	set_proxy (host: STRING; port_no: INTEGER) is
			-- Set proxy host to `host' and port to `port_no'.
		require
			proxy_supported: is_proxy_supported
			closed: not is_open
			non_empty_host: host /= Void and then not host.is_empty
			host_ok: address.proxy_host_ok (host)
			non_negative_port: port_no >= 0
		do
			address.set_proxy (host, port_no)
		ensure
			proxy_set: address.is_proxy_used
		end

	set_proxy_information (pi: PROXY_INFORMATION) is
			-- Set proxy information to `pi'.
		require
			proxy_supported: is_proxy_supported
		do
			address.set_proxy_information (pi)
		ensure
			proxy_set: address.is_proxy_used
		end

	set_username (un: STRING) is
			-- Set username to `un'.
		require
			username_accepted: address.has_username
			non_empty_username: un /= Void and then not un.is_empty
		do
			address.set_username (un)
		end

	set_password (pw: STRING) is
			-- Set password to `pw'.
		require
			password_accepted: address.is_password_accepted
			non_empty_password: pw /= Void and then not pw.is_empty
		do
			address.set_password (pw)
		end
		
		
	set_timeout (n: INTEGER) is
			-- Set connection timeout to `n'.
		require
			non_negative: n >= 0
		do
			timeout := n
		ensure
			timeout_set: timeout = n
		end

	reset_proxy is
			-- Reset proxy information.
		do
			address.reset_proxy
		ensure
			proxy_reset: not address.is_proxy_used
		end
		
	reset_error is
			-- Reset error.
		do
			error_code := 0
		ensure
			error_reset: not error
		end

	reuse_connection (other: DATA_RESOURCE) is
			-- Reuse connection of `other'.
		require
			other_exists: other /= Void
			same_type: same_type (other)
			supports_multiple_transactions: supports_multiple_transactions and
				other.supports_multiple_transactions
			other_opened: other.is_open
		deferred
		end
	 
feature -- Removal

	dispose is
			-- Clean up resource.
		do
			if is_open then close end
		end
		
feature -- Output

	put (other: DATA_RESOURCE) is
			-- Write out resource `other'.
		require
			no_error_occurred: not (error and other.error)
			other_resource_exists: other /= Void
			resources_open: is_open and other.is_open
			writable: is_writable
			transfer_initated: transfer_initiated
		deferred
		ensure
		end

feature -- Input

	read is
			-- Read packet.
		require
			no_error_occurred: not error
			open: is_open
			transfer_initated: transfer_initiated
			readable: is_readable
			positive_read_buffer_size: read_buffer_size > 0	
			packet_pending: is_packet_pending
		deferred
		ensure
			packet_received: is_packet_pending implies last_packet_size > 0
			counter_correct: not error implies
				bytes_transferred = old bytes_transferred + last_packet_size
		end

feature {NONE} -- Constants

	default_timeout: INTEGER is 20
			-- Default timeout duration in seconds

invariant

	address_assigned: address /= Void
	timeout_non_negative: timeout >= 0
	packet_constraint: not (has_packet xor last_packet /= Void)
	pending_constraint: is_packet_pending implies 
						(is_open and is_readable and transfer_initiated)
	error_definition: error = (error_code /= 0)
	valid_count_constraint: count > 0 implies is_count_valid
	mode_constraint: is_mode_set = read_mode xor write_mode
	
end -- class DATA_RESOURCE


--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

