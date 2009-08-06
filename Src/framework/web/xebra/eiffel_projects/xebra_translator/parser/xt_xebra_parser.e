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

	set_source_path (a_source_path: STRING)
			-- Sets the source path.
		require
			a_source_path_attached: attached a_source_path
		do
			source_path := a_source_path
		ensure
			source_path_set: source_path = a_source_path
		end

feature {NONE} -- Convenience

	chars_without_ommit (a_string: STRING): PEG_SEQUENCE
			-- Creates a parser which parses the `a_string'
		require
			a_string_attached: attached a_string
			a_string_not_empty: not a_string.is_empty
		local
			l_i: INTEGER
		do
			create Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + create {PEG_CHARACTER}.make_with_character (a_string [l_i])
				l_i := l_i + 1
			end
		ensure
			Result_attached: attached Result
		end

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
		do
			l_product := ""
			from
				a_result.internal_result.start
			until
				a_result.internal_result.after
			loop
				l_product := l_product + a_result.internal_result.item.out
				a_result.internal_result.forth
			end
			Result := a_result
			Result.internal_result.wipe_out
			Result.append_result (l_product)
		ensure
			Result_attached: attached Result
		end

end
