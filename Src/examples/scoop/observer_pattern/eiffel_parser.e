note
	description: "Summary description for {EIFFEL_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_PARSER

inherit
	EXECUTION_ENVIRONMENT

feature

	parse (a_file: separate STRING)
		do
				-- Need some time to parse.
			sleep (1000)
			if attached post_action as l_p then
				apply_post_action (l_p)
			end
		end

	set_post_parsing_action (a_action: like post_action)
		do
			post_action := a_action
		end

	post_action: detachable separate PROCEDURE

	apply_post_action (a_action: separate PROCEDURE)
		do
			a_action.apply
		end

end
