note
	description: "Summary description for {PARSER_RESULT}."
	author: "sandro"
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

feature -- Access


	internal_result: LIST [ANY] assign set_result
			-- Result of parsing. Is at least an empty list

	error_messages: LIST [STRING]
			-- All the results that resulted while parsing
		once
			create {ARRAYED_LIST [STRING]} Result.make (0)
		end

	append_result (a_result: ANY)
			-- Appends an object to the list of objects
		require
			a_result_attached: attached a_result
		do
			internal_result.extend (a_result)
		end

	append_results (a_results: LIST [ANY])
			-- Merges the two lists.
		do
			internal_result.append (a_results)
		end

	replace_result (a_result: ANY)
			-- Replaces the current results by `a_result'
		require
			a_result_attached: attached a_result
		do
			internal_result.wipe_out
			append_result (a_result)
		ensure
			only_new_result_in_list: internal_result.count = 1 and internal_result [1] = a_result
		end

	success: BOOLEAN
		-- Has the parsing been a success?

	left_to_parse: PEG_PARSER_STRING assign set_left_to_parse
		-- The string that has still to be parsed

	set_left_to_parse (a_string: PEG_PARSER_STRING)
			-- Sets the string which has been left to parse.
		do
			left_to_parse := a_string
		end

feature -- Element change

	put_error_message (a_message: STRING)
			-- Add an error message to the output
		do
			error_messages.extend (a_message)
		end

	set_result (a_result: like internal_result)
			-- Sets the result
		require
			a_result_attached: attached a_result
		do
			internal_result := a_result
		ensure
			internal_result_set: attached internal_result and then a_result = internal_result
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
