indexing
	description: 
		"Eiffel Vision tooltipable. Mswindows implementation."
	status: "See notice at end of class"
	keywords: "tooltip, popup"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_TOOLTIPABLE_IMP
	
inherit
	
	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	WEL_TTF_CONSTANTS

feature -- Initialization

	tooltip: STRING is
			-- Text of tooltip assigned to `Current'.
		do
			Result := internal_tooltip_string
			if Result = Void then
				Result := ""
			end
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		local
			tool_info: WEL_TOOL_INFO
			envir: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			create envir
			app_imp ?= envir.application.implementation

			if not a_tooltip.is_empty then
					--| The tooltip does not seem to work correctly unless we
					--| destroy the old tooltip before creating the new one.
				if internal_tooltip /= Void and then internal_tooltip.exists then
					internal_tooltip.destroy
				end
				create internal_tooltip.make (tooltip_window, 1)
				create tool_info.make
				tool_info.set_text (a_tooltip)
				tool_info.set_flags (Ttf_subclass + Ttf_idishwnd)
				tool_info.set_id_with_window (tooltip_window)
				internal_tooltip.add_tool (tool_info)
				internal_tooltip.activate

					-- Set the inital time delay for the tooltip.
				internal_tooltip.set_initial_delay_time (app_imp.tooltip_delay)
				
				app_imp.all_tooltips.extend (internal_tooltip)
			else
				if internal_tooltip_string /= Void and then not internal_tooltip_string.is_empty then
						-- If `tooltip' is not `Void' then there should always
						-- be an internal tooltip.
					check
						internal_tooltip_not_void: internal_tooltip /= Void
					end
				
						-- Remove `internal_tooltip' from `all_tooltips' in
						-- EV_APPLICATION_IMP.
					create envir
					app_imp ?= envir.application.implementation
					app_imp.all_tooltips.prune (internal_tooltip)
			
						-- Destroy `internal_tooltip'.
					internal_tooltip.destroy
				end
			end

				-- Assign `a_tooltip' to `tooltip'.
			internal_tooltip_string := clone (a_tooltip)
		end

feature {NONE} -- Implementation

	internal_tooltip_string: STRING
		-- Internal text of tooltip assigned to `Current'.

	internal_tooltip: WEL_TOOLTIP
		-- WEL_TOOLTIP used internally by current.

	tooltip_window: WEL_WINDOW is
			-- Window of `Current' for use with tooltips.
			--| This is redefined in descendents as necessary.
			--| When redefinition has taken place in all descendents then
			--| This can be removed.
		do
			Result := Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOLTIPABLE

end -- EV_TOOLTIPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

