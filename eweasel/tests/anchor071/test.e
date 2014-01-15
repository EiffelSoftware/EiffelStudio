class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create graph_widget
		end

feature
	graph_widget: KD_GRAPH_WIDGET

	add_edge (a_edge: KD_EDGE [KD_MODEL_DISPLAY])
		do
			graph_widget.add_edge (a_edge.edge)
		end

end
