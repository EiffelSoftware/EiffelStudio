note
	description:
		"Shared decimal math constants"
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class DCM_MA_SHARED_DECIMAL_CONSTANTS

feature -- Access

	decimal: DCM_MA_DECIMAL_CONSTANTS
			-- Decimal constants
		once
			create Result
		ensure
			decimal_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 2004, Paul G. Crismer and others."
	copyright: "Copyright (c) 2011, SEL, York University, Toronto and others."
	license: "MIT license"
	details: "[
			Originally developed by Paul G. Crismer as part of Gobo. 
			Revised by Jocelyn Fiat for void safety.
		]"

end
