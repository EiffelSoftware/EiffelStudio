indexing
	description: "Abstract notion of a tool container"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_TOOL_CONTAINER

inherit
	EV_CONTAINER


feature -- Initialization

feature -- Access

	tool: EB_TOOL is
			-- tool under management
		deferred
		end

feature -- Tool management

	show_tool is
			-- destroys the tool.
		deferred
		ensure
			shown: tool.shown
		end

	raise_tool is
			-- destroys the tool.
		deferred
		ensure
			shown: tool.shown
		end

	hide_tool is
			-- destroys the tool.
		deferred
		ensure
			hidden: not tool.shown
		end

	destroy_tool is
			-- destroys the tool.
		deferred
		ensure
			destroyed: tool.destroyed
		end

feature -- Commands from tool

	set_title (s: STRING) is
		deferred
		end

end -- class EB_TOOL_CONTAINER
