indexing
	description: "Concrete BON diagram factory with clusters."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_DIAGRAM

inherit
	BON_DIAGRAM_FACTORY
		undefine
			default_create
		redefine
			new_class_figure,
			new_cluster_figure
		end

	CLUSTER_DIAGRAM

create
	make
	
create {BON_CLUSTER_DIAGRAM}
	make_filled

feature -- Factory

	new_class_figure (a_class: CLASS_I): BON_CLASS_FIGURE is
			-- Create a concrete class figure.
		do
			create Result.make_with_class (a_class)
			Result.set_drawable_cell (drawable_cell)
			Result.set_drawable_position (drawable_position)
			projector.register_figure (Result, draw_bon_class_figure_agent)
		end

	new_cluster_figure (a_cluster: CLUSTER_I): BON_CLUSTER_FIGURE is
			-- Create a concrete cluster figure.
		do
			create Result.make_with_cluster (a_cluster)
			Result.set_drawable_cell (drawable_cell)
			Result.set_drawable_position (drawable_position)
			projector.register_figure (Result, draw_bon_cluster_figure_agent)
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

end -- class BON_CLUSTER_DIAGRAM
