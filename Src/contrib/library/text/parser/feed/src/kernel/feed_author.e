note
	description: "[
			Author of feed or feed entry.
			- name and email information.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_AUTHOR

create
	make

feature {NONE} -- Initialization	

	make (a_name: READABLE_STRING_GENERAL)
		do
			create name.make_from_string_general (a_name)
		end

feature -- Access

	name: IMMUTABLE_STRING_32

	email: detachable READABLE_STRING_8

feature -- Element change

	set_email (a_email: detachable READABLE_STRING_GENERAL)
		do
			if a_email = Void then
				email := Void
			elseif a_email.is_valid_as_string_8 then
				email := a_email.as_string_8
			else
				email := Void
			end
		end

feature -- Visitor

	accept (vis: FEED_VISITOR)
		do
			vis.visit_author (Current)
		end

end
