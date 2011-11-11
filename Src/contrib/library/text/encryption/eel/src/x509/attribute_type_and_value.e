note
	description: "x509v3 AttributeTypeAndValue sequence"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Truth and news are not the same thing. - Katharine Graham, owner of The Washington Post"

class
	ATTRIBUTE_TYPE_AND_VALUE

create
	make

feature
	make (type_a: OBJECT_IDENTIFIER value_a: SPECIAL [NATURAL_8])
		do
			type := type_a
			value := value_a
		end
		
feature
	type: OBJECT_IDENTIFIER
	value: SPECIAL [NATURAL_8]
end
