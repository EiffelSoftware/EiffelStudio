indexing
	description: "Tools for BON diagram factory ."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BON_DIAGRAM_FACTORY

feature -- Implementation

	projector: EV_WIDGET_PROJECTOR is
			-- Projector of `Current' client.
		deferred
		end

	drawable: EV_DRAWABLE is
			-- Output for `Current'client.
		deferred
		end	

feature -- Factory

	new_cluster_figure (a_cluster: CLUSTER_I): BON_CLUSTER_FIGURE is
			-- Create a concrete cluster figure.
		do
		end

	new_class_figure (a_class: CLASS_I): BON_CLASS_FIGURE is
			-- Create a concrete class figure.
		do
		end

	new_inheritance_figure (a_descendant, a_ancestor: CLASS_FIGURE): BON_INHERITANCE_FIGURE is
			-- Create a concrete inheritance figure.
		do
			create Result.make_with_classes (a_descendant, a_ancestor)
			Result.set_drawable (drawable)
			projector.register_figure (Result, draw_bon_inheritance_figure_agent)
		end

	new_client_supplier_figure (a_client, a_supplier: CLASS_FIGURE; data: CASE_SUPPLIER): BON_CLIENT_SUPPLIER_FIGURE is
			-- Create a concrete client-supplier figure.
		do
			create Result.make_with_classes (a_client, a_supplier, data)
			Result.set_drawable (drawable)
			projector.register_figure (Result, draw_bon_cs_figure_agent)
		end

feature {EB_CONTEXT_EDITOR} -- Drawing

	draw_bon_cs_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_cs_figure
		end

	draw_bon_cs_figure (bcs: BON_CLIENT_SUPPLIER_FIGURE) is
		do
			bcs.draw
		end

	draw_bon_inheritance_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_inheritance_figure
		end

	draw_bon_inheritance_figure (ihf: BON_INHERITANCE_FIGURE) is
		do
			ihf.draw
		end

	draw_bon_class_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_class_figure
		end

	draw_bon_class_figure (cf: BON_CLASS_FIGURE) is
		do
			cf.draw
		end

	draw_bon_cluster_figure_agent: PROCEDURE [ANY, TUPLE [EV_FIGURE]] is
			-- Routine to add to projector.
		once
			Result := ~draw_bon_cluster_figure
		end

	draw_bon_cluster_figure (cf: BON_CLUSTER_FIGURE) is
		do
			cf.draw
		end

end -- class BON_DIAGRAM_FACTORY
