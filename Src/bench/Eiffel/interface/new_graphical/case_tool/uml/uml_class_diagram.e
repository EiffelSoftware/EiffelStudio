indexing
	description: "Objects that is a UML view for a eiffel class graph."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UML_CLASS_DIAGRAM
	
inherit
	EIFFEL_CLASS_DIAGRAM
		redefine
			default_create,
			default_view_name
		end

create
	make

feature {NONE} -- Initialization

	default_create is
			-- Create an UML_CLASS_DIAGRAM.
		do
			Precursor {EIFFEL_CLASS_DIAGRAM}
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
			is_uml := True
			make_with_model_and_factory (a_graph, create {UML_FACTORY})
			context_editor := a_tool
			is_client_supplier_links_shown := False
		end
		
feature -- Access

	default_view_name: STRING is
			-- Name for the default view.
		do
			Result := "DEFAULT:UML"
		end

end -- class UML_CLASS_DIAGRAM
