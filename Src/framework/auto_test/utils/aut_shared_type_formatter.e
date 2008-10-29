indexing
	description: "Type formatter"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SHARED_TYPE_FORMATTER

feature -- Access

	type_name (a_type: TYPE_A; a_feature: FEATURE_I): STRING is
			-- Name of `a_type'.
			-- `a_feature' is used to resolve anchored type.
		require
			a_type_attached: a_type /= Void
		local
			l_type_formatter: AUT_TYPE_A_TEXT_FORMATTER
		do
			l_type_formatter := type_formatter
			l_type_formatter.wipe_type_name
			type_output_strategy.process (a_type, l_type_formatter, a_type.associated_class, a_feature)
			Result := l_type_formatter.type_name.twin
		ensure
			result_attached: Result /= Void
		end

	type_name_with_context (a_type: TYPE_A; a_context_class: CLASS_C; a_context_feature: FEATURE_I): STRING is
			-- Name of `a_type' in context `a_context_class' and `a_context_feature'
		require
			a_type_attached: a_type /= Void
			a_context_class_attached: a_context_class /= Void
		local
			l_type_formatter: AUT_TYPE_A_TEXT_FORMATTER
		do
			l_type_formatter := type_formatter
			l_type_formatter.wipe_type_name
			type_output_strategy.process (a_type, l_type_formatter, a_context_class, a_context_feature)
			Result := l_type_formatter.type_name.twin
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	type_output_strategy: AST_TYPE_OUTPUT_STRATEGY is
			-- Output strategy for type
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	type_formatter: AUT_TYPE_A_TEXT_FORMATTER is
			-- Type formatter
		once
			create Result.make
		ensure
			result_attached: Result /= Void
		end

end
