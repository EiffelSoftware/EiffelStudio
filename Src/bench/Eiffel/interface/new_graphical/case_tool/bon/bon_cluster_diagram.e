indexing
	description: "Objects that is a bon view for a eiffel cluster graph"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_DIAGRAM
	
inherit
	EIFFEL_CLUSTER_DIAGRAM
	
create
	make,
	make_without_interactions
		
feature {NONE} -- Initialization
		
	make (a_graph: like model; a_tool: like context_editor) is
			-- Initialize as context in `a_tool' showing `a_graph'.
		require
			a_graph_not_void: a_graph /= Void
			a_tool_not_void: a_tool /= Void
		do
			is_uml := False
			make_with_model_and_factory (a_graph, create {BON_FACTORY})
			context_editor := a_tool
		end
		
feature {EB_DIAGRAM_HTML_GENERATOR} -- Initialization

	make_without_interactions (a_graph: like model) is
			-- Create a BON_CLUSTER_DIAGRAM showing `a_graph'.
		require
			a_graph_not_void: a_graph /= Void
		do
			make_with_model_and_factory (a_graph, create {BON_FACTORY})
		end

end -- class BON_CLUSTER_DIAGRAM
