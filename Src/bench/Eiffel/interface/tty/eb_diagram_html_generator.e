indexing
	description: "Objects that generate an html file representing a diagram,%N%
			%to be included in html documentation (Dummy version for old%N%
			%graphical interface."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DIAGRAM_HTML_GENERATOR

create
	make_for_documentation
	
feature {NONE} -- Initialization

	make_for_documentation (a_cluster: CLUSTER_I; view_name: STRING; doc: DOCUMENTATION) is
		require
			a_cluster_not_void: a_cluster /= Void
			doc_not_void: doc /= Void
		do
		end

feature {DOCUMENTATION} -- Basic operations

	execute is
		do
		end
	
end -- class EB_DIAGRAM_HTML_GENERATOR
