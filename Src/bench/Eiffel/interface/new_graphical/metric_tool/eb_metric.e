indexing
	description: "Representation of metric objects"
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC
	
inherit
	COMPARABLE
		undefine
			is_equal
		end

feature -- Access

	name: STRING
		-- `Current' name

	set_name (n: STRING) is
			-- Asign `n' to `name'.
		require
			name_correct: name /= Void and then not name.is_empty
		do
			name := n
		end

	unit: STRING
		-- `Current' unit.

	tool: EB_METRIC_TOOL
		-- Associated interface.

	min_scope: INTEGER
		-- Index of the minimum scope type `Current' applies to.

	percentage: BOOLEAN
		-- Display metric result as a percentage ?
		-- False for basic and linear metrics.

	set_percentage (bool: BOOLEAN) is
			-- Assign `bool' to `percentage'.
		do
			percentage := bool
		end

feature -- Comparison

	infix "<" (other: EB_METRIC): BOOLEAN is
			-- Is current metric less than `other' in the sense of alphabetic order?
		require else
			valid_object_comparison: other /= Void
		local
			current_name, other_name: STRING
		do
			current_name := clone (name)
			other_name := clone (other.name)
			current_name.to_lower
			other_name.to_lower
			Result := current_name < other_name
		end

feature -- Application to scope

	value (s: EB_METRIC_SCOPE): DOUBLE is
			-- Evaluate `Current' over `s'.
		require
			scope_not_void: s /= Void
		deferred
		end

end -- class EB_METRIC
