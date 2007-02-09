indexing
	description: "WEL tooltipable. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_TOOLTIPABLE

inherit
	EV_ANY_HANDLER

	WEL_TOOLTIP_CONSTANTS

feature -- Initialization

	tooltip: STRING_32 is
			-- Text of tooltip assigned to `Current'.
		do
			if internal_tooltip_string = Void then
				Result := ""
			else
				Result := internal_tooltip_string.twin
			end
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		local
			l_app: EV_APPLICATION_IMP
		do
			l_app ?= (create {EV_ENVIRONMENT}).application.implementation
			check l_app_not_void: l_app /= Void end
			if not a_tooltip.is_empty then
				if tool_info /= Void then
					tool_info.set_text (a_tooltip)
					if internal_tooltip_string = Void or else internal_tooltip_string.is_empty then
							-- There was no tooltip before, meaning that it has been removed.
							-- We need to add it again.
						l_app.internal_tooltip.add_tool (tool_info)
					else
						l_app.internal_tooltip.update_text (tool_info)
					end
				else
					create tool_info.make
					tool_info.set_text (a_tooltip)
					tool_info.set_flags (Ttf_subclass + Ttf_idishwnd)
					tool_info.set_id_with_window (tooltip_window)
					l_app.internal_tooltip.add_tool (tool_info)
				end
			else
				if internal_tooltip_string /= Void and then not internal_tooltip_string.is_empty then
						-- If `tooltip' is not `Void' then there should always
						-- be an internal tooltip.
					check
						tool_info_not_void: tool_info /= Void
					end
					l_app.internal_tooltip.remove_tool (tool_info)
				end
			end
				-- Assign `a_tooltip' to `tooltip'.
			internal_tooltip_string := a_tooltip.twin
		end

feature {NONE} -- Implementation

	tool_info: WEL_TOOL_INFO
			-- Structure that holds the tooltip data for current widget.

	internal_tooltip_string: STRING_32
		-- Internal text of tooltip assigned to `Current'.

	tooltip_window: WEL_WINDOW is
			-- Window of `Current' for use with tooltips.
			--| This is redefined in descendents as necessary.
			--| When redefinition has taken place in all descendents then
			--| This can be removed.
		do
			Result := Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
