indexing
	description: "Scope constants."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SCOPE_INFO

feature -- Access

	Feature_scope, Class_scope, Cluster_scope, System_scope, Archive_scope: INTEGER is unique
		-- Order relation between indexes of available scopes.

end -- class EB_METRIC_SCOPE_INFO
