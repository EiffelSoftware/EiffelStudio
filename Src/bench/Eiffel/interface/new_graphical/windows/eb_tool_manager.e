indexing
	description:
		"Abstract notion of a tool manager"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_MANAGER

feature -- Initialization

feature -- Access

--	tool: EB_TOOL is
--			-- tool under management
--		deferred
--		end
--	the tool attribute is not used cause
--	the manager can have several tools.

	tool_parent: EV_CONTAINER is
			-- parent of `tool'
		deferred
		end

	associated_window: EV_WINDOW is
			-- window used as parent of `tool''s subwindows
		deferred
		end

feature -- Tool management

	show_tool (t: EB_TOOL) is
			-- shows the tool.
		deferred
		ensure
			shown: t.shown
		end

	raise_tool (t: EB_TOOL) is
			-- destroys the tool.
		deferred
		ensure
			shown: t.shown
		end

	hide_tool (t: EB_TOOL) is
			-- destroys the tool.
		deferred
		ensure
			hidden: not t.shown
		end

	destroy_tool (t: EB_TOOL) is
			-- destroys the tool.
		deferred
		ensure
			destroyed: t.destroyed
		end

feature -- Resize

	set_size (min_x, min_y: INTEGER) is
		deferred
		end

	set_width (new_width: INTEGER) is
		deferred
		end

	set_height (new_height: INTEGER) is
		deferred
		end

feature -- Tool status report

	tool_title : STRING is
		deferred
		end

	tool_icon_name : STRING is
		deferred
		end

feature -- Tool status setting

	set_tool_title (t: EB_TOOL; s: STRING) is
		deferred
		end

	set_tool_icon_name (t: EB_TOOL; s: STRING) is
		deferred
		end

end -- class EB_TOOL_MANAGER
