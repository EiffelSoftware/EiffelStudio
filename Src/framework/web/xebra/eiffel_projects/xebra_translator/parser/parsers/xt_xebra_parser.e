note
	description: "[
		{XT_XEBRA_PARSER}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XT_XEBRA_PARSER

inherit
	ERROR_SHARED_MULTI_ERROR_MANAGER

	PEG_FACTORY

create
	make

feature -- Initialization

	make
			-- Initialize parsers
		do
				-- A common identifier. Will put the identifier {STRING} on the stack
			identifier_prefix := (lower_case | upper_case | hyphen | underscore)
			identifier_prefix.fixate
			identifier := identifier_prefix + (-(lower_case | upper_case | hyphen | underscore | digit))
			identifier := identifier.consumer
			identifier.fixate
			identifier.set_name ("identifier")

				-- XML comments
			comment := rstringp ("<!--") + (-(stringp("-->").negate + rany)) + rstringp ("-->")
			comment.set_behaviour (agent concatenate_results)
			comment.set_name ("comment")

			open := char ('<')
			close := char ('>')

			source_path := "No source path specified"
		end

feature {XT_XEBRA_PARSER} -- Access

	source_path: STRING
			-- The path to the original file

feature -- Access

	set_source_path (a_source_path: like source_path)
			-- Sets the source path.
		require
			a_source_path_attached: attached a_source_path
		do
			source_path := a_source_path
		ensure
			source_path_set: source_path = a_source_path
		end

feature {NONE} -- Convenience

	add_parse_error (a_message: STRING)
			-- Adds a parse error to the error maanager
		do
			error_manager.add_error (create {XERROR_PARSE}.make
				([a_message]), False)
		end

feature {XT_XEBRA_PARSER}

	identifier, comment, open, close, identifier_prefix: PEG_ABSTRACT_PEG
			-- A xml identifier

feature {XT_XEBRA_PARSER} -- Behaviours

	concatenate_results (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Concatenates all result's 'out'-output to a single {String}
		require
			a_result_attached: attached a_result
		local
			l_product: STRING
			l_internal_result: LIST [ANY]
		do
			l_product := ""
			l_internal_result := a_result.parse_result
			from
				l_internal_result.start
			until
				l_internal_result.after
			loop
				l_product := l_product + l_internal_result.item.out
				l_internal_result.forth
			end
			Result := a_result
			Result.parse_result.wipe_out
			Result.append_result (l_product)
		ensure
			Result_attached: attached Result
		end

end
