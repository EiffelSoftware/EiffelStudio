note
	description: "Summary description for {PE_RVA_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_RVA_ITEM

inherit
	PE_NATURAL_32_ITEM

create
	make

convert
	value: {NATURAL_32}

feature -- Status report

	to_string: STRING_32
		do
			Result := {STRING_32} "RVA=" + Precursor
		end


end
