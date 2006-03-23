indexing
	description:
		"Eiffel Vision tooltipable. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
				internal_tooltip.set_max_tip_width (32000)

				create tool_info.make
				tool_info.set_text (a_tooltip)
				tool_info.set_flags (Ttf_subclass + Ttf_idishwnd)
				tool_info.set_id_with_window (tooltip_window)

				internal_tooltip.add_tool (tool_info)
				internal_tooltip.activate

					-- Set the inital time delay for the tooltip.
				internal_tooltip.set_initial_delay_time (app_imp.tooltip_delay)

				app_imp.all_tooltips.extend (internal_tooltip.item)
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
					app_imp.all_tooltips.prune (internal_tooltip.item)

						-- Destroy `internal_tooltip'.
					internal_tooltip.destroy
				end
			end

				-- Assign `a_tooltip' to `tooltip'.
			internal_tooltip_string := a_tooltip.twin
		end

feature {NONE} -- Implementation

	destroy is
			-- Destroy `Current'.
		local
			envir: EV_ENVIRONMENT
			app_imp: EV_APPLICATION_IMP
		do
			if internal_tooltip /= Void then
					-- Remove `internal_tooltip' from `all_tooltips' in
					-- EV_APPLICATION_IMP.
				create envir
				app_imp ?= envir.application.implementation
				app_imp.all_tooltips.prune (internal_tooltip.item)
			end
			set_is_destroyed (True)
		end


	internal_tooltip_string: STRING_32
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

	interface: EV_TOOLTIPABLE;

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




end -- EV_TOOLTIPABLE_IMP

