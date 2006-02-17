indexing
	description: "System color used by docking library."
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

end
