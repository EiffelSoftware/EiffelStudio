note
	description: "Responsible for query native system colors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SYSTEM_COLOR

feature -- Query

	default_background_color: EV_COLOR
			-- Default background color
			-- Different from EV_STOCK_COLORS default_background_color, this one will change with theme.
		deferred
		end

	non_focused_selection_color: EV_COLOR
			-- Non focused selection color for title bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	non_focused_selection_title_color: EV_COLOR
			-- Non focused selectetion color for title.
		deferred
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR
			-- Non focused selection color for title's text.
		deferred
		ensure
			not_void: Result /= Void
		end

	focused_selection_color: EV_COLOR
			-- Focused selection color for title bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR
			-- Focused selection color for title bar text.
		deferred
		ensure
			not_void: Result /= Void
		end

	active_border_color: EV_COLOR
			-- Background color of multiple document interface (MDI) applications.
		deferred
		ensure
			not_void: Result /= Void
		end

	button_text_color: EV_COLOR
			-- Text color of buttons.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Font

	tool_bar_font: EV_FONT
			-- <Precursor>
		deferred
		ensure
			not_void: Result /= Void
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
