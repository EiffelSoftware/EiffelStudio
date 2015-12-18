note
	description: "A warning. Warnings may lead to dangerous, bad, or unwanted program behavior"
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_WARNING

inherit
	CA_RULE_SEVERITY

feature -- Properties

	is_critical: BOOLEAN = False
			-- <Precursor>

	name: STRING_32 = "Warning"
			-- <Precursor>

	short_form: STRING_32 = "W"
			-- <Precursor>

end
