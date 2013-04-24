note
	description: "[
					Specifies values that identify the aspect of a Command to invalidate.
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_UI_INVALIDATIONS_ENUM

feature -- Query

	ui_invalidations_state: INTEGER
			-- A state property, such as UI_PKEY_Enabled.
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
			-- The value property of a Command.
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
			-- Any property.
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
			-- All properties.
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
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
