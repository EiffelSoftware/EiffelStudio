note
	description: "Summary description for {SHOP_CUSTOMER}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHOP_CUSTOMER

create
	make_with_user,
	make_with_email

feature {NONE} -- Initialization

	make_with_user (a_user: CMS_USER)
		do
			user := a_user
			email := a_user.email
			initialize
		end

	make_with_email (a_email: READABLE_STRING_8)
		do
			email := a_email
			initialize
		end

	initialize
		do
			create items.make (0)
		end

feature -- Access

	email: detachable READABLE_STRING_8

	user: detachable CMS_USER

	items: STRING_TABLE [READABLE_STRING_32]

end
