indexing
	description	: "Objects that holds all used WEL Constants"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_WEL_CONSTANTS

create
	default_create

feature -- Access

	wel_wm_constants: WEL_WM_CONSTANTS is
		once
			create Result
		end

	wel_ws_constants: WEL_WS_CONSTANTS is
		once
			create Result
		end

	wel_mk_constants: WEL_MK_CONSTANTS is
		once
			create Result
		end

	wel_vk_constants: WEL_VK_CONSTANTS is
		once
			create Result
		end

	wel_sw_constants: WEL_SW_CONSTANTS is
		once
			create Result
		end

end -- class EV_WEL_CONSTANTS
