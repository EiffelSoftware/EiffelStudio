note
	description: "MESSAGES API, database API."
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGES_API

create
	make

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST[MESSAGES]} db.make(0)
		end

feature -- Access

	items: LIST[MESSAGES]
			-- All database items.
		do
			Result := db
		end

feature -- Access

	search (a_key: INTEGER_64): detachable MESSAGES
			-- Search by key `a_key'.
		local
			l_status: BOOLEAN
		do
			from
				db.start
			until
				db.after or l_status
			loop
				if db.item.id = a_key then
					Result := db.item
					l_status := True
				end
				db.forth
			end
		end

feature -- Insert

	put (a_user, a_item: separate READABLE_STRING_32)
			-- Add `a_item' to the storage.
		local
			l_message: MESSAGES
			l_string: STRING_32
			l_user: STRING_32
		do
			create l_string.make_from_separate (a_item)
			create l_user.make_from_separate (a_user)
			create l_message.make (l_user, l_string, db.count + 1)
			db.force (l_message)
		end


feature {NONE} -- Implementation

	db: LIST[MESSAGES]
			-- current messages.

end
