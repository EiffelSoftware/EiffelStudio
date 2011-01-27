note
	description: "Summary description for {EV_UI_INVALIDATIONS_ENUM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UI_INVALIDATIONS_ENUM

feature -- Query

	ui_invalidations_state: INTEGER
			--
		external
			"C inline use %"Uiribbon.h%""
		alias
			"[
			{
				return UI_INVALIDATIONS_STATE;
			}
			]"
		end

	ui_invalidations_value: INTEGER
			--
		external
			"C inline use %"Uiribbon.h%""
		alias
			"[
			{
				return UI_INVALIDATIONS_VALUE;
			}
			]"
		end

	 ui_invalidations_property: INTEGER
			--
		external
			"C inline use %"Uiribbon.h%""
		alias
			"[
			{
				return  UI_INVALIDATIONS_PROPERTY;
			}
			]"
		end

	ui_invalidations_allproperties: INTEGER
			--
		external
			"C inline use %"Uiribbon.h%""
		alias
			"[
			{
				return UI_INVALIDATIONS_ALLPROPERTIES;
			}
			]"
		end
end
