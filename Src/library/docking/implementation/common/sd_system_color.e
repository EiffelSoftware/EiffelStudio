indexing
	description: "System color used by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_SYSTEM_COLOR

feature -- Query

	non_focused_selection_color: EV_COLOR is
			-- Non focused selection color for title bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	non_focused_selection_title_color: EV_COLOR is
			-- Non focused selectetion color for title.
		deferred
		ensure
			not_void: Result /= Void
		end

	non_focused_title_text_color: EV_COLOR is
			-- Non focused selection color for title's text.
		deferred
		ensure
			not_void: Result /= Void
		end

	focused_selection_color: EV_COLOR is
			-- Focused selection color for title bar.
		deferred
		ensure
			not_void: Result /= Void
		end

	focused_title_text_color: EV_COLOR is
			-- Focused selection color for title bar text.
		deferred
		ensure
			not_void: Result /= Void
		end

	active_border_color: EV_COLOR is
			-- Background color of multiple document interface (MDI) applications.
		deferred
		ensure
			not_void: Result /= Void
		end

	button_text_color: EV_COLOR is
			-- Text color of buttons.
		deferred
		ensure
			not_void: Result /= Void
		end

indexing
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
