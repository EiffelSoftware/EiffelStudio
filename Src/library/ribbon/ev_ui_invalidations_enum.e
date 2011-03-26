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

feature -- Contract support

	is_valid (a_int: INTEGER): BOOLEAN
			-- If `a_int' an value of Current enumeration
		do
			Result := a_int = ui_invalidations_state or else
					a_int = ui_invalidations_value or else
					a_int = ui_invalidations_property or else
					a_int = ui_invalidations_allproperties
		end
end
