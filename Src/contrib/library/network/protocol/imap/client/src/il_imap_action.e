note
	description: "The available actions and their IMAP command"
	author: "Basile Maret"
	EIS: "name=Client Commands", "src=https://tools.ietf.org/html/rfc3501#section-6", "protocol=uri"

class
	IL_IMAP_ACTION

feature -- Access

	-- Any state actions
	Capability_action: NATURAL = 1
	Noop_action: NATURAL = 2
	Logout_action: NATURAL = 3

	-- Not authenticated state actions
	Login_action: NATURAL = 4
	Starttls_action: NATURAL = 5

	-- Authenticated state actions
	Select_action: NATURAL = 6
	Examine_action: NATURAL = 7
	Create_action: NATURAL = 8
	Delete_action: NATURAL = 9
	Rename_action: NATURAL = 10
	Subscribe_action: NATURAL = 11
	Unsubscribe_action: NATURAL = 12
	List_action: NATURAL = 13
	Lsub_action: NATURAL = 14
	Status_action: NATURAL = 15
	Append_action: NATURAL = 16

	-- Selected state actions
	Check_action: NATURAL = 17
	Close_action: NATURAL = 18
	Expunge_action: NATURAL = 19
	Search_action: NATURAL = 20
	Fetch_action: NATURAL = 21
	Store_action: NATURAL = 22
	Copy_action: NATURAL = 23
	Uid_copy_action: NATURAL = 24
	Uid_fetch_action: NATURAL = 25
	Uid_store_action: NATURAL = 26





	min_action: NATURAL = 1
	max_action: NATURAL = 26

feature -- Basic Operations

	get_command( a_action: NATURAL): STRING
			-- Returns the imap command corresponding to the action `a_action'
		require
			valid_action: a_action >= min_action and a_action <= max_action
		do
			inspect a_action
			when Login_action then
				Result := "LOGIN"
			when Starttls_action then
				Result := "STARTTLS"
			when Capability_action then
				Result := "CAPABILITY"
			when Noop_action then
				Result := "NOOP"
			when Logout_action then
				Result := "LOGOUT"
			when Select_action then
				Result := "SELECT"
			when Examine_action then
				Result := "EXAMINE"
			when Create_action then
				Result := "CREATE"
			when Delete_action then
				Result := "DELETE"
			when Rename_action then
				Result := "RENAME"
			when Subscribe_action then
				Result := "SUBSCRIBE"
			when Unsubscribe_action then
				Result := "UNSUBSCRIBE"
			when List_action then
				Result := "LIST"
			when Lsub_action then
				Result := "LSUB"
			when Status_action then
				Result := "STATUS"
			when Append_action then
				Result := "APPEND"
			when Check_action then
				Result := "CHECK"
			when Close_action then
				Result := "CLOSE"
			when Expunge_action then
				Result := "EXPUNGE"
			when Search_action then
				Result := "SEARCH"
			when Fetch_action then
				Result := "FETCH"
			when Store_action then
				Result := "STORE"
			when Copy_action then
				Result := "COPY"
			when Uid_copy_action then
				Result := "UID COPY"
			when Uid_fetch_action then
				Result := "UID FETCH"
			when Uid_store_action then
				Result := "UID STORE"
			else
				Result := ""
			end
		ensure
			result_set: not Result.is_empty
		end

note
	copyright: "2015-2016, Maret Basile, Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
