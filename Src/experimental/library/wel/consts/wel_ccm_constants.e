note
	description: "Common Control Message constants to find out if a control is unicode based or not."
	date: "April 2nd 2002"
	revision: "1.0"

class
	WEL_CCM_CONSTANTS

feature -- Access

	Ccm_getunicodeformat: INTEGER = 8198

	Ccm_setunicodeformat: INTEGER = 8197

end
