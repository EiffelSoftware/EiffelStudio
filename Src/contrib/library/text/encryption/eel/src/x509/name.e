note
	description: "x509v3 Name choice"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "When goods don't cross borders, soldiers will. - Fredric Bastiat, early French economists"

class
	NAME

create
	make

feature
	make (rdn_sequence_a: LIST [ATTRIBUTE_TYPE_AND_VALUE])
		do
			rdn_sequence := rdn_sequence_a
		end
		
feature
	rdn_sequence: LIST [ATTRIBUTE_TYPE_AND_VALUE]
end
