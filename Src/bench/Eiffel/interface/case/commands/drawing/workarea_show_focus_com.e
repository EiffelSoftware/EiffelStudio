indexing

	description: 
		"Command to update the focus area of the%
		%analysis window of the workarea";
	date: "$Date$";
	revision: "$Revision $"


class WORKAREA_SHOW_FOCUS_COM

inherit

	WORKAREA_COM
		rename
			make as make_workarea
		end

	ONCES
creation

	make

feature -- Creation

	make (w: like workarea) is
		do
			make_workarea (w)
		end

feature -- Properties

	drawing_area: EC_DRAWING_AREA is
		-- associated drawing area.
		do
			Result := workarea.drawing_area
		end

feature -- Execution

	context_data_useful: BOOLEAN is true;
			-- This command need a context_data structure

	execute (args: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
			-- Update the focus for current selected
			-- graphical object.
		local
			motion_data: EV_MOTION_EVENT_DATA
			button_data: EV_BUTTON_EVENT_DATA
			new_text: STRING;
			graph_relation: GRAPH_RELATION;
			handle_at: INTEGER;
			handle: HANDLE_DATA;
			rel_x, rel_y: INTEGER;
			handle_stone: HANDLE_STONE;
			f_label: CASE_FOCUS_LABEL;
			abs_x, abs_y: INTEGER;
			first_button_down: BOOLEAN
		do
			motion_data ?= data;
			button_data ?= data;
				if motion_data = Void then
					button_data ?= data;
					if button_data /= Void then
						abs_x := button_data.x;
						abs_y := button_data.y;
						first_button_down := False
					end
				else
					abs_x := motion_data.x;
					abs_y := motion_data.y;
					first_button_down := motion_data.first_button_pressed
				end
				if not first_button_down then
					rel_x := abs_x - drawing_area.x;
					rel_y := abs_y - drawing_area.y;
					graph_figure := workarea.figure_at (rel_x, rel_y)
					if graph_figure = void then
						new_text := " "
						-- Added, may have to be changed.
						-- Pascalf
						if graph_figure=Void then
							workarea.set_selected_entity(Void,Void)
						end
					else
						graph_relation ?= graph_figure;
						if graph_relation /= void then
							handle_at := graph_relation.handle_at
								(rel_x, rel_y);
							if handle_at = 0 then
							new_text := graph_relation.data.focus
								stone := graph_figure.stone;
							else
								handle := graph_relation.handle_data (handle_at)
								!! new_text.make (6);
								new_text.append ("Handle");	
								!! handle_stone.make (handle, graph_relation.workarea);
								stone := handle_stone;
							end
						else
							new_text := graph_figure.data.focus;
							stone := graph_figure.stone;
						end;
	
						workarea.set_selected_entity (graph_figure, stone)
						system.set_workarea_picked (workarea)
					end
				end
		end

	work (arg: ANY) is
			--| Current command should not popdown the error window,
			--| hence the redefinition
		do
			--execute (arg, Void)
		end

	feature -- Properties

		graph_figure: GRAPH_FORM;
		stone: STONE;


end -- class WORKAREA_SHOW_FOCUS_COM
