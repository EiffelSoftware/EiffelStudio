indexing
	description: "Manager of the Color Tool."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	COLORING_COMMAND

inherit

	EV_COMMAND

	ONCES

creation
	make, make_from_menu

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Initialization
		require
			parent_exists: par /= Void
		do
			parent := par
		ensure
			parent_set: par = parent
		end

	make_from_menu (par: EV_CONTAINER; colorab: COLORABLE) is
		require
			parent_exists: par /= Void
			colorable_exists: colorab /= Void
		do
			colorable := colorab
			make(par)
		ensure
			colorable_set: colorable = colorab
		end


feature -- Implementation

	colorable: COLORABLE
		-- Element that we are going to color ( and eventually, the other 
		-- selected elements ).

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Popup the Color Tool.
		local
			com: EV_ROUTINE_COMMAND
		do
			!! color_tool.make(parent)
			!! com.make(~color_selected_entities)
			color_tool.add_ok_command(com, Void)
			color_tool.show
		end

	color_selected_entities (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Color the entity(ies).
		require
			color_tool_exists: color_tool /= Void
			color_selected : color_tool.color /= Void
		local
			color : EV_COLOR
			colorabl: COLORABLE
			list: LINKED_LIST [GRAPH_FORM]
			all_selected_with_entity: BOOLEAN
			li: LINKED_LIST [DATA]
		do
			list := workareas.selected_figures
			color := color_tool.color
			!! li.make
			if colorable /= Void then
				from
					list.start
				until
					list.after or all_selected_with_entity
				loop
					if list.item.data = colorable then
						all_selected_with_entity := TRUE
					else
						list.forth
					end
				end
			end
			if colorable/=Void and then not all_selected_with_entity then
				colorable.set_color(color)
				li.extend(colorable)
				observer_management.update_observer(colorable)
			else
				from
					list.start
				until
					list.after
				loop
					colorabl ?= list.item.data
					if colorabl /= Void then
						colorabl.set_color(color)
					end
					observer_management.update_observer(colorabl)
					li.extend(colorabl)
					list.forth
				end
			end	
			--workareas.unselect_all
			--workareas.group_to_refresh(li)
		end

feature -- Implementation

	color_tool: EV_COLOR_DIALOG
			-- Color Palette from which we can select a color.

	parent: EV_CONTAINER
			-- Parent window of 'color_tool'.

end -- class COLORING_COMMAND
