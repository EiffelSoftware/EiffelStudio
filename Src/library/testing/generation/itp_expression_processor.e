note
	description: "[
		Processor for expressions (Visitor Pattern)
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

deferred class ITP_EXPRESSION_PROCESSOR

feature {ITP_EXPRESSION} -- Processing

	process_constant (a_value: ITP_CONSTANT)
			-- Process `a_value'.
		require
			a_value_not_void: a_value /= Void
		deferred
		end

	process_variable (a_value: ITP_VARIABLE)
			-- Process `a_value'.
		require
			a_value_not_void: a_value /= Void
		deferred
		end

end
