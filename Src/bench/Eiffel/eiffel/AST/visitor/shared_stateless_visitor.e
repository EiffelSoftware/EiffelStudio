indexing
	description: "Collection of stateless visitors."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_STATELESS_VISITOR

feature -- Access

	clickable_info: AST_CLICKABLE_INFO_VISITOR is
			-- Visitor to get CLASS_I and feature names for CLICKABLE_AST nodes
		once
			create Result
		ensure
			clickable_info_not_void: Result /= Void
		end

	clickable_generator: AST_CLICKABLE_VISITOR is
			-- Visitor to generate a CLICK_LIST
		once
			create Result
		ensure
			clickable_generator_not_void: Result /= Void
		end

	export_status_generator: AST_EXPORT_STATUS_GENERATOR is
			-- Visitor to generate EXPORT_I instance from CLIENT_AS
		once
			create Result
		ensure
			export_status_generator_not_void: Result /= Void
		end

	feature_i_generator: AST_FEATURE_I_GENERATOR is
			-- Visitor to create FEATURE_I instance from FEATURE_AS
		once
			create Result
		ensure
			feature_i_generator_not_void: Result /= Void
		end

	feature_checker: AST_FEATURE_CHECKER_GENERATOR is
			-- Visitor to check code of a routine
		once
			create Result
		ensure
			feature_checker_not_void: Result /= Void
		end

	locals_builder: AST_LOCALS_INFO is
			-- Visitor to build table of locals
		once
			create Result
		ensure
			locals_builder_not_void: Result /= Void
		end

	type_checker: AST_TYPE_CHECKER is
			-- Visitor to check types.
		once
			create Result
		ensure
			type_checker_not_void: Result /= Void
		end

	value_i_generator: AST_VALUE_I_GENERATOR is
			-- Visitor to check types.
		once
			create Result
		ensure
			value_i_generator_not_void: Result /= Void
		end

end
