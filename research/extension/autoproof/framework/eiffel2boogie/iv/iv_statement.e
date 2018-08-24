note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_STATEMENT

inherit

	IV_INFO_NODE

feature -- Access

	origin_information: detachable IV_STATEMENT_ORIGIN
			-- Origin of this statement (if any).

feature -- Element change

	set_origin_information (a_origin_information: detachable IV_STATEMENT_ORIGIN)
			-- Set `origin_information' to `a_origin_information'.
		do
			if attached a_origin_information as l_origin then
				origin_information := l_origin.twin
			else
				origin_information := Void
			end
		ensure
			origin_information_set: origin_information = a_origin_information or origin_information ~ a_origin_information
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- Process `a_visitor'.
		deferred
		end

end
