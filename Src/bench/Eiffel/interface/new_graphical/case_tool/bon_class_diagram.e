indexing
	description: "Concrete BON diagram factory without clusters."
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLASS_DIAGRAM

inherit
	BON_DIAGRAM_FACTORY
		undefine
			default_create
		redefine
			new_class_figure
		end

	CONTEXT_DIAGRAM

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

end -- class BON_CLASS_DIAGRAM
