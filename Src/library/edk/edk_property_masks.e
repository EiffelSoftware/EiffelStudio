note
	description: "Summary description for {EDK_PROPERTY_MASKS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDK_PROPERTY_MASKS

feature -- Access

	property_1_mask: NATURAL_8 = 0x1
	property_2_mask: NATURAL_8 = 0x2
	property_3_mask: NATURAL_8 = 0x4
	property_4_mask: NATURAL_8 = 0x8
	property_5_mask: NATURAL_8 = 0x10
	property_6_mask: NATURAL_8 = 0x20
	property_7_mask: NATURAL_8 = 0x40
	property_8_mask: NATURAL_8 = 0x80
		-- Masks used for boolean property retrieval

end
