note
	description: "Summary description for {WSF_SESSION_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_SESSION_DATA

inherit
	HASH_TABLE [detachable ANY, READABLE_STRING_32]

create
	make

feature -- Access

	expiration: detachable DATE_TIME

feature -- Element change

	set_expiration (dt: like expiration)
		do
			expiration := dt
		end

end
