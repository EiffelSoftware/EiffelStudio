note
	description: "Email Object"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
			-- Initialize the headers table.
		do
			create headers.make (3)
			mail_message := ""
			mail_signature := ""
		end

	make_with_entry (header_from, header_to: STRING)
			-- Create an email with the 'header_from' and the 'header_to'.
		require
			needed_info: header_from /= Void
						 and then header_to /= Void
		do
			make
			add_header_entry (H_from, header_from)
			add_header_entry (H_to, header_to)
		end

feature {NONE} -- Basic operations.

	transfer (resource: PROTOCOL_RESOURCE)
			-- Used when the mailer will receive an email from 'resource'.
		do

		end

feature -- Basic operations

	add_header_entry (header_key, header_entry: STRING)
			-- Add 'header_entry' to header 'header_key',
			-- If no such header exists, create it.
		require
			not_void: header_entry /= Void and then header_key /= Void
		local
			a_header: detachable HEADER
		do
			if headers.has (header_key) then
				a_header:= headers.item (header_key)
				check a_header_attached: a_header /= Void end
				a_header.add_entry (header_entry)
			else
				create a_header.make (header_entry)
				headers.put (a_header, header_key)
				if Default_headers.has (header_key) then
					a_header.enable_contains_addresses
				end
			end
		end

	add_header_entries (header_key: STRING; header_entries: ARRAY [STRING])
			-- Add multiple 'header_entries' at once  to 'header_key',
			-- If not such header exists. create it.
		local
			a_header: detachable HEADER
		do
			if headers.has (header_key) then
				a_header:= headers.item (header_key)
				check a_header_attached: a_header /= Void end
				a_header.add_entries (header_entries)
			else
				create a_header.make_with_entries (header_entries)
				headers.put (a_header, header_key)
				if Default_headers.has (header_key) then
					a_header.enable_contains_addresses
				end
			end
		end

	remove_header_entry (header_key, header_entry: STRING)
			-- Remove 'header_entry' from header 'header_key'.
		require
			header_exists: headers.has (header_key)
			header_entry_exists:
					attached {HEADER} headers.item (header_key) as l_header and then l_header.entries.has (header_entry)
		local
			a_header: detachable HEADER
		do
			a_header:= headers.item (header_key)
				-- Per precondition
			check a_header_attached: a_header /= Void end
			a_header.entries.prune (header_entry)
		ensure
			header_entry_no_longer_exists:
				attached {HEADER} headers.item (header_key) as l_header_after and then not l_header_after.entries.has (header_entry)
		end

	remove_header_entries (header_key: STRING)
		require
			header_exists: headers.has (header_key)
		local
			a_header: detachable HEADER
		do
			a_header:= headers.item (header_key)
				-- Per precondition
			check a_header_attached: a_header /= Void end
			a_header.entries.wipe_out
		end

	has_header_entry (header_key: STRING): BOOLEAN
		do
			Result:= headers.has (header_key)
		end

	send
			-- Send email.
		do

		end

	receive
			-- Receive email.
		do

		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_received: BOOLEAN = True
		-- Can an email received?

	can_be_sent: BOOLEAN = True;
		-- Can an email be send?

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EMAIL

