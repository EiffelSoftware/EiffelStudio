note
	description: "[
		Can be used to parse the args of a request to get a table of argument names and values.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"


class
	XH_REQUEST_ARG_TABLE_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end

feature -- Basic Operations

	argument_table (a_args: STRING): detachable HASH_TABLE [STRING, STRING]
			-- Returns a table of arguments if the string could be parsed successfully
		require
			not_a_args_is_detached: a_args /= Void
		local
			l_result: PEG_PARSER_RESULT
		do
			l_result := parser.parse (create {PEG_PARSER_STRING}.make_from_string (a_args))

			if l_result.error_messages.count > 0 or l_result.left_to_parse.count > 0 then
				from
					l_result.error_messages.start
				until
					l_result.error_messages.after
				loop
					print (l_result.error_messages.item)
					l_result.error_messages.forth
				end

			else
				if attached {like argument_table} l_result.internal_result.first as l_rec then
					Result := l_rec
				end
			end
		end


feature {NONE} -- Parser

	parser: PEG_ABSTRACT_PEG
			-- Creates the parser
		local
			any,
			key_name,
			key_value,
			item_name,
			item_value,
			table_item,
			table: PEG_ABSTRACT_PEG
			l_parser_result: PEG_PARSER_RESULT
		once
				-- Special
			create {PEG_ANY} any.make
			any.ommit_result

				-- Constants
			key_name := stringp ("&")
			key_value := stringp ("=")

				-- User fields
			item_name := (-(key_value.negate + any)).consumer
			item_name.fixate
			item_value := (-((key_name.negate) + any)).consumer
			item_value.fixate


				-- Structure
			table_item := key_name + item_name + key_value + item_value
			table_item.set_behaviour (agent build_table_item)
			table := -(table_item)
			table.set_behaviour (agent build_table)

			Result := table
		ensure
			result_attached: Result /= Void
		end


	build_table_item (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a name value tuple
			-- TABLE_ENTRY =  item_name  item_value;
		require
			a_result_attached: attached a_result
		local
			l_item: TUPLE [name: STRING; value: STRING]
		do
			Result := a_result
			if attached {STRING} a_result.internal_result [1] as l_name and
				attached {STRING} a_result.internal_result [2] as l_value then
					Result.replace_result ([l_name, l_value])
			end
		ensure
			Result_attached: attached Result
		end

	build_table (a_result: PEG_PARSER_RESULT): PEG_PARSER_RESULT
			-- Builds a hash table
			-- TABLE = {TABLE_ENTRIES}
		require
			a_result_attached: attached a_result
		local
			l_table_args: HASH_TABLE [STRING, STRING]
		do
			Result := a_result
			create l_table_args.make (a_result.internal_result.count)
			from
				a_result.internal_result.start
			until
				a_result.internal_result.after
			loop
				if attached {TUPLE [name: STRING; value: STRING]} a_result.internal_result.item as l_arg then
					l_table_args.put (l_arg.value, l_arg.name)
				end
				a_result.internal_result.forth
			end
			Result.replace_result (l_table_args)
		ensure
			Result_attached: attached Result
		end

	stringp (a_string: STRING): PEG_SEQUENCE
			-- Generates a parser which parses `a_string'
		require
			a_string_valid: attached a_string and then not a_string.is_empty
		local
			l_i: INTEGER
		do
			create Result.make
			from
				l_i := 1
			until
				l_i > a_string.count
			loop
				Result := Result + char (a_string [l_i])
				l_i := l_i + 1
			end
			Result.fixate
		ensure
			Result_attached: attached Result
		end

	char (a_char: CHARACTER): PEG_CHARACTER
			-- Generates  Character Parser
		require
			a_char_attached: attached a_char
		do
			create Result.make_with_character (a_char)
			Result.ommit_result
		ensure
			Result_attached: attached Result
		end

end
