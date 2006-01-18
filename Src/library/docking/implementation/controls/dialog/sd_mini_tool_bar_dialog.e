indexing
	description: "Dialog that contain mini tool bar when not enough space shown in SD_TITLE_BAR."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MINI_TOOL_BAR_DIALOG

inherit
	EV_POPUP_WINDOW

create
	make

feature {NONE}  -- Initlization

	make (a_widget: EV_WIDGET) is
			-- Creation method.
		require
			not_void: a_widget /= Void
		local
			l_container: EV_CONTAINER
			l_vertical_box: EV_VERTICAL_BOX
			l_tool_bar: EV_TOOL_BAR
			l_widgets: LINEAR [EV_WIDGET]
		do
			default_create
			focus_out_actions.extend (agent on_focus_out)

			l_container ?= a_widget
			l_tool_bar ?= a_widget
			if l_container /= Void then
				from
					create l_vertical_box
					extend (l_vertical_box)
					l_widgets := l_container.linear_representation
					l_widgets.start
				until
					l_widgets.after
				loop
					l_container.prune (l_widgets.item)
					l_vertical_box.extend (l_widgets.item)
					l_widgets.forth
				end
			else
				if a_widget.parent /= Void then
					a_widget.parent.prune (a_widget)
				end
				extend (a_widget)
			end
		end

	on_focus_out is
			-- Handle focus out actions.
		do
			destroy
		end

end
