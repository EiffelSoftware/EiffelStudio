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

feature -- Factory

	new_class_figure (a_class: CLASS_I): BON_CLASS_FIGURE is
			-- Create a concrete class figure.
		do
			create Result.make_with_class (a_class)
			Result.set_drawable (drawable)
			projector.register_figure (Result, draw_bon_class_figure_agent)
		end

	new_cluster_figure (a_cluster: CLUSTER_I): BON_CLUSTER_FIGURE is
			-- Create a concrete cluster figure.
		do
			create Result.make_with_cluster (a_cluster)
			Result.set_drawable (drawable)
			projector.register_figure (Result, draw_bon_cluster_figure_agent)
		end

end -- class BON_CLUSTER_DIAGRAM
