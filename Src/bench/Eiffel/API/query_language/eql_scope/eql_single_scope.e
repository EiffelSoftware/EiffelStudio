indexing
	description: "Object that represents a single scope in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_SINGLE_SCOPE

inherit
	EQL_SCOPE
		undefine
			is_equal
		end

	EQL_ITERABLE_ITEM

feature -- Iterator

	itr: EQL_SINGLE_SCOPE_ITERATOR [like Current] is
			-- Iterator for Current
		do
			create Result.make (Current)
		end

	distinct_itr: like itr is
			-- Distinct iterator
		do
			Result := itr
		end

feature -- Status reporting

	is_feature_scope: BOOLEAN is
			-- Does current single scope represent a feature scope?
		do
		end

	is_class_scope: BOOLEAN is
			-- Does current single scope represent a class scope?
		do
		end

	is_cluster_scope: BOOLEAN is
			-- Does current single scope represent a cluster scope?
		do
		end

	is_system_scope: BOOLEAN is
			-- Does current single scope represent a system scope?
		do
		end

	is_invariant_scope: BOOLEAN is
			-- Does current single scope represent an invariant?
		do
		end

	is_metric_scope: BOOLEAN is
			-- Does current single scope represent a metric scope?
		do
		end

end
