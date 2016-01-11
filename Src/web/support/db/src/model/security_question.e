note
	description: "Object that represent a security question"
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_QUESTION

create
	make

feature {NONE} -- Initialization

	make (a_id:INTEGER; a_question:READABLE_STRING_32)
			-- Create an object security question with `a_id'
			-- an `a_question'.
		do
			id := a_id
			question := a_question
		ensure
			id_set: id = a_id
			question_set: question = a_question
		end

feature -- Access

	id: INTEGER
		-- unique id.

	question: READABLE_STRING_32
		-- Security question.		

feature -- Output

	output: STRING_8
			-- String representation.
		do
			create Result.make_empty
			Result.append(" Id: ")
			Result.append(id.out)
			Result.append(" Question: ")
			Result.append (question)
			Result.append("%N")

		end

end
