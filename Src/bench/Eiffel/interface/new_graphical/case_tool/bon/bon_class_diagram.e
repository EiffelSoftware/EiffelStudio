indexing
	description: "Objects that is a bon view for an eiffel class diagram."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLASS_DIAGRAM
	
inherit
	EIFFEL_CLASS_DIAGRAM

create
	make

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

end -- class BON_CLASS_DIAGRAM
