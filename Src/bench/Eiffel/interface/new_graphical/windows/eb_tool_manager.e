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
		require
			t_valid: t /= void and not t.destroyed
		deferred
		ensure
			shown: t.shown
		end

	raise_tool (t: EB_TOOL) is
			-- destroys the tool.
		require
			t_valid: t /= void and not t.destroyed
		deferred
		ensure
			shown: t.shown
		end

	hide_tool (t: EB_TOOL) is
			-- destroys the tool.
		require
			t_valid: t /= void and not t.destroyed
		deferred
		ensure
			hidden: not t.shown
		end

	destroy_tool (t: EB_TOOL) is
			-- destroys the tool.
		require
			t_valid: t /= void and not t.destroyed
		deferred
		ensure
			destroyed: t.destroyed
		end

feature -- Resize

	set_tool_size (t: EB_TOOL; new_width, new_height: INTEGER) is
			-- sets the size of the tool, if possible.
			-- this procedure does not require that `t' is not
			-- destroyed, because only the manager is affected.
		require
			t_non_void: t /= void
		deferred
		end

	set_tool_width (t: EB_TOOL; new_width: INTEGER) is
		require
			t_non_void: t /= void
		deferred
		end

	set_tool_height (t: EB_TOOL; new_height: INTEGER) is
		require
			t_non_void: t /= void
		deferred
		end

feature -- Tool status report

	tool_title (t: EB_TOOL) : STRING is
		require
			t_non_void: t /= void
		deferred
		end

	tool_icon_name (t: EB_TOOL) : STRING is
		require
			t_non_void: t /= void
		deferred
		end

feature -- Tool status setting

	set_tool_title (t: EB_TOOL; s: STRING) is
		require
			t_non_void: t /= void
		deferred
		end

	set_tool_icon_name (t: EB_TOOL; s: STRING) is
		require
			t_non_void: t /= void
		deferred
		end

end -- class EB_TOOL_MANAGER
