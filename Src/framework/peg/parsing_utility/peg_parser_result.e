note
	description: "Summary description for {PARSER_RESULT}."
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	PEG_PARSER_RESULT

inherit
	ANY
		redefine
			out
		end

create
	make

feature -- Initialize

	make (a_left_to_parse: PEG_PARSER_STRING; a_success: BOOLEAN)
		require
			a_left_to_parse_attached: attached a_left_to_parse
		do
			left_to_parse := a_left_to_parse
			success := a_success
			create {ARRAYED_LIST [ANY]} internal_result.make (1)
		ensure
			internal_result_attached: attached internal_result
			success_set: attached success and success = a_success
			left_to_parse_set: attached left_to_parse and left_to_parse = a_left_to_parse
		end

feature {NONE} -- Access

	internal_error_messages: detachable LIST [STRING]
			-- Internal detachable error messages holder

feature -- Access

	internal_result: LIST [ANY] assign set_result
			-- Result of parsing. Is at least an empty list

	error_messages: LIST [STRING]
			-- All the errors that resulted while parsing
		do
			if attached internal_error_messages as l_e_messages then
				Result := l_e_messages
			else
				create {ARRAYED_LIST [STRING]} Result.make (0)
				internal_error_messages := Result
			end
		ensure
			Result_attached: attached Result
		end

	append_result (a_result: ANY)
			-- Appends an object to the list of objects
		require
			a_result_attached: attached a_result
		do
			internal_result.extend (a_result)
		end

	append_results (a_result: PEG_PARSER_RESULT)
			-- Merges the two result lists as well as other global data (like errors)
		require
			a_result_attached: attached a_result
		do
			internal_result.append (a_result.internal_result)
			error_messages.append (a_result.error_messages)
		ensure
			internal_result_appended: internal_result.count = (old internal_result.count) + (old a_result.internal_result.count)
			error_messages_appended: error_messages.count = (old error_messages.count) + (old a_result.error_messages.count)
		end

	replace_result (a_result: ANY)
			-- Replaces the current results by `a_result'
		require
			a_result_attached: attached a_result
		do
			internal_result.wipe_out
			append_result (a_result)
		ensure
			only_new_result_in_list: internal_result.count = 1 and internal_result.first = a_result
		end

	set_result (a_result: like internal_result)
			-- Sets the result
		require
			a_result_attached: attached a_result
		do
			internal_result := a_result
		end

	success: BOOLEAN assign set_success
		-- Has the parsing been a success?

	set_success (is_success: BOOLEAN)
			-- Sets the success.
		do
			success := is_success
		ensure
			success_set: success = is_success
		end

	left_to_parse: PEG_PARSER_STRING assign set_left_to_parse
		-- The string that has still to be parsed

	set_left_to_parse (a_string: PEG_PARSER_STRING)
			-- Sets the string which has been left to parse.
		require
			a_string_attached: attached a_string
		do
			left_to_parse := a_string
		end

feature -- Element change

	put_error_message (a_message: STRING)
			-- Add an error message to the output
		require
			a_message_attached: attached a_message
		local
			l_errors: LIST [STRING]
		do
			error_messages.extend (a_message + " " + format_debug (left_to_parse.debug_information))
			if left_to_parse.current_internal_position >= left_to_parse.longest_match.count-1 then
				create {ARRAYED_LIST [STRING]} l_errors.make (1)
				l_errors.append (error_messages)
				left_to_parse.longest_match.set_error_message (l_errors)
			end
		end

	format_debug (a_line_row: TUPLE [line: INTEGER; row: INTEGER]): STRING
			-- Formats the debug information
		do
			Result := "line: " + a_line_row.line.out + " row: " + a_line_row.row.out
		end

	longest_match_debug: STRING
			-- Formats the line/row information of the longest match
		do
			Result := format_debug (left_to_parse.debug_information_with_index (left_to_parse.longest_match.count))
		ensure
			Result_attached_and_not_empty: attached Result and then not Result.is_empty
		end

	longest_match_line_row: TUPLE [line, row: INTEGER]
			-- Returns the line and row of the longest match
		do
			Result := left_to_parse.debug_information_with_index (left_to_parse.longest_match.count)
		ensure
			Result_attached: attached Result
		end

	out: STRING
			-- <Precursor>
		do
			Result := left_to_parse.out + "," + success.out + " results(" + internal_result.count.out + "): "
			from
				internal_result.start
			until
				internal_result.after
			loop
				Result.append ("%N%T" + internal_result.index.out + ": " + internal_result.item.out)
				internal_result.forth
			end
			Result.append ("*****************************************")
		end

end
