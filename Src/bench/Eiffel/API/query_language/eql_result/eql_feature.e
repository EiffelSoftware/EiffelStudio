indexing
	description: "Object that represents a feature item from a resultset of a certain EQL query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE

inherit
	EQL_CALLER
		rename
			data as e_feature
		redefine
			is_feature_scope
		end

	EQL_FEATURE_CELL
		undefine
			is_equal
		end

create
	make_with_feature

feature -- Status reporting

	is_feature_scope: BOOLEAN is True
			-- Does current single scope represent a feature scope?

	associated_class: CLASS_C is
			-- Compiled class associated with current
		do
			Result := e_feature.associated_class
		ensure then
			good_result: Result = e_feature.associated_class
		end

	written_class: CLASS_C is
			-- Written in class of current
		do
			Result := e_feature.written_class
		ensure
			result_set: Result = e_feature.written_class
		end

	name: STRING is
			-- Name of current feature
		do
			Result := e_feature.name
		end

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_feature (e_feature)
		end

invariant
	e_feature_not_void: e_feature /= Void
	associated_class_not_void: associated_class /= Void

end
