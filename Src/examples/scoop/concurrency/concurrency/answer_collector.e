note
	description: "[
					Class ANSWER COLLECTOR is used by the parallel wait mechanism; 
					it gathers individual results and combines them into a final answer 
					given to a client.
																						]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
	ANSWER_COLLECTOR

inherit
	CONCURRENCY
		rename
			answer as answer_concurrency
		end

create
	make

feature {NONE} -- Initialization

	make (a_queries : attached separate LIST [?separate FUNCTION [ANY, TUPLE, ?separate ANY]]; an_initial_answer , a_ready_answer: ?separate ANY; a_combinator: attached separate FUNCTION [ANY, TUPLE, ?separate ANY])
			-- Creation procedure.
		require
			a_queries.count > 0
		local
			evaluator : separate EVALUATOR
		do
			answer := an_initial_answer;
			ready_answer := a_ready_answer
			count := a_queries.count
--			combinator := a_combinator.deep_import -- Non?separate copy
			combinator := a_combinator.deep_twin -- Non?separate copy --Larry 2010/10/13 this compiles in EVE64 ?
			from
				a_queries.start
			until
				a_queries.after
			loop
				create evaluator.evaluate (a_queries.item , Current)
				launch_executor (evaluator)
				a_queries.forth
			end
		ensure
			answer = an_initial_answer
			ready_answer = a_ready_answer
			count = a_queries.count
		end

feature {CONCURRENCY} -- Answer retrieval

	answer: ?separate ANY
		-- Answer

	is_ready : BOOLEAN
		-- Is answer ready?

feature {EVALUATOR} -- Answer update

	update_answer (a_result : ?separate ANY)
			-- Update answer with a result.
		do
			count := count - 1
			if not is_ready then
				combinator.call ([answer, a_result])
				answer := combinator.last_result
			end
			if count = 0 or else equal(answer, ready_answer) then -- Larry 2010-10-13: This can be compiled in EVE ?
				is_ready := True
			end
		ensure
			count = 0 implies is_ready
		end

feature {NONE} -- Implementation

	launch_executor (a_evaluator: separate EVALUATOR)
			--
		do
			--FIXME: not implemented
--			a_evaluator.
		end

	combinator: FUNCTION [ANY, TUPLE, ?separate ANY]
		-- Combinator for results

	ready_answer: ?separate ANY
		-- Answer that allows ignoring further results

	count: INTEGER
		-- Number of partial results to come

end
