indexing
	description: "Multiple tool manager item"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MULTIPLE_MANAGER_TOOL_ITEM

inherit
	EB_MULTIPLE_MANAGER_ITEM

feature -- Access

	container: EV_CONTAINER is
		do
			Result := tool.container
		end

	tool: EB_TOOL

	parent: EV_CONTAINER
		-- Parent of the tool container
		-- It is a split area, unless there is only one tool.

	brother: EV_CONTAINER
		-- Widget the tool container shares its parent with
		-- Always exists, unless there is only one tool.

	title: STRING

	icon_name: STRING

feature -- Element change

	
	set_tool (t: EB_TOOL) is
		do
			tool := t
		ensure
			set: tool = t
		end

	set_parent (c: EV_CONTAINER) is
		do
			parent := c
		ensure
			set: parent = c
		end

	set_brother (c: EV_CONTAINER) is
		do
			brother := c
		ensure
			set: brother = c
		end

	set_title (s: STRING) is
		do
			title := s
		ensure
			set: title = s
		end

	set_tool_icon_name (s: STRING) is
		do
			icon_name := s
		ensure
			set: icon_name = s
		end

end -- class EB_MULTIPLE_MANAGER_TOOL_ITEM
