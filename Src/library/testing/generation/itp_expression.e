indexing
	description: "[
		Common ancestor for all Expressions supported by the interpreter.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

deferred class ITP_EXPRESSION

feature -- Processing

	process (a_processor: ITP_EXPRESSION_PROCESSOR) is
			-- Process current expression.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

end
