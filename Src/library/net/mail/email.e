indexing
	description: "Email Object"
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	EMAIL

inherit
	MEMORY_RESOURCE

create
	make, make_with_entry

feature -- Initialization

	make is
			-- Initialize the headers table.
		do
			create headers.make (3)
		end

	make_with_entry (header_from, header_to: STRING) is
			-- Create an email with the 'header_from' and the 'header_to'.
		require
			needed_info: header_from /= Void
						 and then header_to /= Void 
		do
			create headers.make (3)
			add_header_entry (H_from, header_from)
			add_header_entry (H_to, header_to)
		end

feature {NONE} -- Basic operations.

	transfer (resource: PROTOCOL_RESOURCE) is
			-- Used when the mailer will receive an email from 'resource'.
		do
			
		end

feature -- Basic operations

	add_header_entry (header_key, header_entry: STRING) is
			-- Add 'header_entry' to header 'header_key',
			-- If no such header exists, create it.
		require
			not_void: header_entry /= Void and then header_key /= Void
		local
			a_header: HEADER
		do
			if headers.has (header_key) then
				a_header:= headers.item (header_key)
				a_header.add_entry (header_entry)
			else
				create a_header.make (header_entry)
				headers.put (a_header, header_key)
				if Default_headers.has (header_key) then
					a_header.enable_contains_addresses
				end
			end
		end

	add_header_entries (header_key: STRING; header_entries: ARRAY [STRING]) is
			-- Add multiple 'header_entries' at once  to 'header_key',
			-- If not such header exists. create it.
		local
			a_header: HEADER
		do
			if headers.has (header_key) then
				a_header:= headers.item (header_key)
				a_header.add_entries (header_entries)
			else
				create a_header.make_with_entries (header_entries)
				headers.put (a_header, header_key)
				if Default_headers.has (header_key) then
					a_header.enable_contains_addresses
				end
			end		
		end

	remove_header_entry (header_key, header_entry: STRING) is
			-- Remove 'header_entry' from header 'header_key'.
		require
			header_exists: headers.has (header_key)
			header_entry_exists: 
					(headers.item (header_key)). entries.has (header_entry)
		local
			a_header: HEADER			
		do
			a_header:= headers.item (header_key)
			a_header.entries.prune (header_entry)
		ensure
			header_entry_no_longer_exists: 
					not (headers.item (header_key)). entries.has (header_entry)
		end

	send is
			-- Send email.
		do

		end

	receive is
			-- Receive email.
		do

		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_received: BOOLEAN is True
		-- Can an email received?

	can_be_sent: BOOLEAN is True
		-- Can an email be send?

end -- class EMAIL
