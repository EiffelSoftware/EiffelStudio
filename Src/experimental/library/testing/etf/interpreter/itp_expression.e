note
	description: "[
		Common ancestor for all Expressions supported by the interpreter.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

deferred class ITP_EXPRESSION

feature -- Processing

	process (a_processor: ITP_EXPRESSION_PROCESSOR)
			-- Process current expression.
		require
			a_processor_not_void: a_processor /= Void
		deferred
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
