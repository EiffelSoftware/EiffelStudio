indexing
	description: "All icons used in the docking library. Client programmer should inherit this."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ICONS_SINGLETON

feature -- Initlization

	init is
			-- Initlization
		do
		end

feature -- Icons

	unstick: EV_PIXMAP is
			-- Unstick icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	stick: 	EV_PIXMAP is
			-- Stick icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	maximize: EV_PIXMAP is
			-- Maximize icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	normal: EV_PIXMAP is
			-- Minimize icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	close: EV_PIXMAP is
			-- Close icon pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	default_icon: EV_PIXMAP is
			-- Default window icon.
		deferred
		ensure
			not_void: Result /= Void
		end

	pebble: EV_PIXMAP is
			-- Pebble.
		deferred
		ensure
			not_void: Result /= Void
		end

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- Hide tab indicator.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_indicator: EV_PIXMAP is
			-- Indicator for SD_TITLE_BAR, when there is nor enough space to show custom widget.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Side indicators

	arrow_indicator_up: STRING is
		deferred
		end

	arrow_indicator_down: STRING is
			--
		deferred
		end

	arrow_indicator_left: STRING is
			--
		deferred
		end

	arrow_indicator_right: STRING is
			--
		deferred
		end

	arrow_indicator_up_lightening: STRING is
			--
		deferred
		end

	arrow_indicator_down_lightening: STRING is
			--
		deferred
		end

	arrow_indicator_left_lightening: STRING is
			--
		deferred
		end

	arrow_indicator_right_lightening: STRING is
			--
		deferred
		end

feature -- Center indicators

	arrow_indicator_center: STRING is
			--
		deferred
		end

	arrow_indicator_center_lightening_up: STRING is
			--
		deferred
		end

	arrow_indicator_center_lightening_down: STRING is
			--
		deferred
		end

	arrow_indicator_center_lightening_left: STRING is
			--
		deferred
		end

	arrow_indicator_center_lightening_right: STRING is
			--
		deferred
		end

	arrow_indicator_center_lightening_center: STRING is
			--
		deferred
		end

feature -- Old half-tone style icons.

	drag_pointer_up: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_down: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_left: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_right: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_center: EV_CURSOR is
			-- When user drag a zone, pointer showed at top area.
		deferred
		ensure
			not_void: Result /= Void
		end

	drag_pointer_float: EV_CURSOR is
			-- When user drag a zone, pointer showed when should float.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Tool bars icons.

	tool_bar_customize_indicator: EV_PIXMAP is
			-- Indicator at right side of a Tool bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Indictor at right side of a tool bar when there is hidden tool bars.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- `tool_bar_customize_indicator' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			-- `tool_bar_customize_indicator_with_hidden_items' horizontal version.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_floating_customize: EV_PIXMAP is
			-- When tool bar is floating, customize button's pixmap.
		deferred
		ensure
			not_vod: Result /= Void
		end

	tool_bar_floating_close: EV_PIXMAP is
			-- When tool bar if floating, close buttons's pixmap.
		deferred
		ensure
			not_void: Result /= Void
		end

	tool_bar_customize_dialog: EV_PIXMAP is
			-- Pixmap used by EB_TOOL_BAR_EDITOR_BOX.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Zone management icons.

	close_context_tool_bar: EV_PIXMAP  is
			-- "Close" pixmap when user right click one SD_NOTEBOOK_TAB.
		deferred
		ensure
			not_void: Result /= Void
		end

	close_others: EV_PIXMAP is
			-- "Close all but this" pixmap when user right click one SD_NOTEBOOK_TAB.
		deferred
		ensure
			not_void: Result /= Void
		end

	close_all: EV_PIXMAP is
			-- When user click on a SD_NOTEBOOK_TAB, "close all" pixmap shown on context Tool bar.
		deferred
		ensure
			not_void: Result /= Void
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
