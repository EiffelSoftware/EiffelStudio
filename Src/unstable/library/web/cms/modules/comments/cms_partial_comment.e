note
	description: "Summary description for {CMS_PARTIAL_COMMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PARTIAL_COMMENT

inherit
	CMS_COMMENT

create
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_cid: like id)
		do
			make
			id := a_cid
		end


end
