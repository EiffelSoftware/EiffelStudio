indexing

	description: 
		"Command to update the focus area of the%
		%analysis window of the workarea";
	date: "$Date$";
	revision: "$Revision $"


class WORKAREA_INIT_PND

inherit

	WORKAREA_COM
		rename
			make as make_workarea
		end

	ONCES
creation

	make

feature -- Creation

	make (w: like workarea; d: like drawing_area) is
		do
			make_workarea (w)
			drawing_area := d
		end

feature -- Properties

	drawing_area: EC_DRAWING_AREA

feature -- Execution

	context_data_useful: BOOLEAN is true;
			-- This command need a context_data structure

	execute (args: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
			-- Update the focus for current selected
			-- graphical object.
		local
			workarea_show_focus: WORKAREA_SHOW_FOCUS_COM

			graph_form: GRAPH_FORM
			stone: EC_STONE
		do
			!! workarea_show_focus.make (workarea)

			workarea_show_focus.execute (args, data)
			
			graph_form := workarea_show_focus.graph_figure
			stone := workarea_show_focus.stone

			drawing_area.set_transported_data (stone)
			if stone /= Void then
				drawing_area.set_data_type (stone.stone_type_pnd)
			end

			--	f_label := workarea.analysis_window.focus_label;
			--	if not f_label.text.is_equal (new_text) then
				--	f_label.set_text (new_text)
			--	end
		end;

end -- class WORKAREA_SHOW_FOCUS_COM
