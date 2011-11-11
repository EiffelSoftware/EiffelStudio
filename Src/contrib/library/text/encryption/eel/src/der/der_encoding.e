note
	description: "Summary description for {DER_ENCODING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DER_ENCODING

inherit
	DEVELOPER_EXCEPTION

create
	make

feature
	make (reason_a: STRING)
		do
			reason := reason_a
		end

feature
	reason: STRING
end
