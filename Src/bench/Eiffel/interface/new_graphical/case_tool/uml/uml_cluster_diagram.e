indexing
	description: "Objects that is an UML view for an eiffel cluster graph."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLUSTER_DIAGRAM
	
inherit
	EIFFEL_CLUSTER_DIAGRAM
		redefine
			default_view_name,
			default_create
		end
	
create
	make
		
feature {NONE} -- Initialization

	default_create is
			-- Create an UML_CLUSTER_DIAGRAM.
		do
			Precursor {EIFFEL_CLUSTER_DIAGRAM}
			is_uml := True
			is_client_supplier_links_shown := False
			is_right_angles := True
		end
		
		
	make (a_graph: like model; a_tool: like context_editor) is
			-- Initialize as context in `a_tool' showing `a_graph'.
		require
			a_graph_not_void: a_graph /= Void
			a_tool_not_void: a_tool /= Void
		do
			make_with_model_and_factory (a_graph, create {UML_FACTORY})
			context_editor := a_tool
		end

feature -- Access

	default_view_name: STRING is
			-- Name for default view.
		do
			Result := "DEFAULT:UML"
		end

end -- class UML_CLUSTER_DIAGRAM
