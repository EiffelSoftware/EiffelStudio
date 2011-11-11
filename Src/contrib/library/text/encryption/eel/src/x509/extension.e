note
	description: "x509v3 extension sequence"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The Constitution is not an instrument for the government to restrain the people, it is an instrument for the people to restrain the government - lest it come to dominate our lives and interests. - Patrick Henry"

class
	EXTENSION

create
	make

feature
	make (extn_id_a: OBJECT_IDENTIFIER critical_a: BOOLEAN extn_value_a: SPECIAL [NATURAL_8])
		do
			extn_id := extn_id_a
			critical := critical_a
			extn_value := extn_value_a
		end

feature
	extn_id: OBJECT_IDENTIFIER
	critical: BOOLEAN
	extn_value: SPECIAL [NATURAL_8]
end
