note
	description: "A mailbox"
	author: "Basile Maret"
	EIS: "name=Mailbox size response", "protocol=URI", "src=https://tools.ietf.org/html/rfc3501#section-7.3"

class
	IL_MAILBOX

create
	make

feature {NONE} -- Initialization

	make
			-- Create the mailbox.
		do
			unselect
		end

feature -- Access

	is_selected: BOOLEAN

	name: STRING

	flags: LIST [STRING]

	permanent_flags: LIST [STRING]

	exists: INTEGER

	recent: INTEGER

	unseen: INTEGER

	uid_next: INTEGER

	uid_validity: INTEGER

	is_read_only: BOOLEAN

feature -- Basic Operations

	unselect
			-- Reset all the fields of the mailbox
		do
			is_selected := false
			create name.make_empty
			create {LINKED_LIST [STRING]}flags.make
			create {LINKED_LIST [STRING]}permanent_flags.make
			create {LINKED_LIST [INTEGER]}recent_expunge.make
			create recent_flag_fetches.make (0)
			exists := -1
			recent := -1
			unseen := -1
			uid_next := -1
			uid_validity := -1
			is_read_only := true
			is_updated := false
		ensure
			not was_updated
		end

	set_updated
			-- Set the mailbox as updated
		do
			is_updated := true
		end

	unset_updated
			-- Erase the recent changes and set the mailbox as not updated
		do
			create {LINKED_LIST [INTEGER]}recent_expunge.make
			create recent_flag_fetches.make (0)
			is_updated := false
		ensure
			not was_updated
		end

	was_updated: BOOLEAN
			-- Returns true iff there are changes in the mailbox since the last call to this function or access to `recent_flag_fetches' or `recent_expunge'
		do
			Result := is_updated or not recent_expunge.is_empty or not recent_flag_fetches.is_empty
			is_updated := false
		end

	set_selected (a_name: STRING)
			-- Set the mailbox as selected and set `name' to `a_name'
		require
			a_name_not_empty: a_name /= Void and then not a_name.is_empty
		do
			is_selected := true
			name := a_name
		end

	set_exists (n: INTEGER)
		do
			exists := n
			set_updated
		ensure
			is_updated
		end

	set_recent (n: INTEGER)
		do
			recent := n
			set_updated
		ensure
			is_updated
		end

	set_unseen (n: INTEGER)
		do
			unseen := n
		end

	set_uid_next (n: INTEGER)
		do
			uid_next := n
		end

	set_uid_validity (n: INTEGER)
		do
			uid_validity := n
		end

	set_flags (a_flags: LIST [STRING])
		do
			flags := a_flags
		end

	set_permanent_flags (a_permanent_flags: LIST [STRING])
		do
			permanent_flags := a_permanent_flags
		end

	set_read_only (b: BOOLEAN)
		do
			is_read_only := b
		end

	add_recent_expunge (a_seq_number: INTEGER)
			-- Add `a_seq_number' to the list `recent_expunge'
		do
			recent_expunge.extend (a_seq_number)
			exists := exists - 1
		ensure
			recent_expunge.has (a_seq_number)
		end

	get_recent_expunge: LIST [INTEGER]
			-- Return the list `recent_expunge' and clear it
		do
			Result := recent_expunge
			create {LINKED_LIST [INTEGER]}recent_expunge.make
		ensure
			recent_expunge_cleared: recent_expunge.is_empty
			result_old_recent_expunge: Result = old recent_expunge
		end

	add_recent_flag_fetch (a_seq_number: INTEGER; a_flag_list: LIST [STRING])
			-- Add an entry mapping `a_seq_number' to `a_flag_list' into `recent_flag_fetches'
		require
			a_flag_list_not_void: a_flag_list /= Void
		do
			recent_flag_fetches.put (a_flag_list, a_seq_number)
		ensure
			recent_flag_fetches.has (a_seq_number)
		end

	get_recent_flag_fetches: HASH_TABLE [LIST [STRING], INTEGER]
			-- Return the list `recent_flag_fetches' and clear it
		do
			Result := recent_flag_fetches
			create recent_flag_fetches.make (0)
		ensure
			recent_flag_fetches_cleared: recent_flag_fetches.is_empty
			result_old_recent_flag_fetches: Result = old recent_flag_fetches
		end

feature {NONE} -- Implementation

	is_updated: BOOLEAN

	recent_expunge: LIST [INTEGER]

	recent_flag_fetches: HASH_TABLE [LIST [STRING], INTEGER]
			-- matches the message sequence number to a list of flags

invariant
	unselected_has_empty_name: is_selected = not name.is_empty

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
