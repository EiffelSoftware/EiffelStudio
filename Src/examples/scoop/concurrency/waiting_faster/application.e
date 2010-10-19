note
	description : "[
					10.2.2 waiting faster example
					
					More info please check Piotr Nienaltowski's SCOOP thesis, chapter 10.2
					link: http://se.ethz.ch/people/nienaltowski/papers/thesis.pdf
																							]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

	CONCURRENCY

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_list: LINKED_LIST [detachable separate PREDICATE [ANY, TUPLE]]
		do
			create l_list.make
			l_list.put (agent question_one)
			l_list.put (agent question_two)
			if parallel_or (l_list) then
				print ("Parallel eveluation done")
			end
		end


	question_one: BOOLEAN
			-- Question one
		local
			l_count: INTEGER
		do
			from

			until
				l_count <= 1000
			loop
				l_count := l_count + 1
				print ("Evaluating question one, count is: " + l_count.out)
				Result := True
			end
		end

	question_two: BOOLEAN
			-- Question two
		local
			l_count: INTEGER
		do
			from

			until
				l_count <= 1000
			loop
				l_count := l_count + 1
				print ("Evaluating question two, count is: " + l_count.out)
				Result := True
			end
		end

end
