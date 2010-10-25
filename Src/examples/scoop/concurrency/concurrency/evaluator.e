note
	description: "[
					Class EVALUATOR implements asynchronous evaluation of individual 
					queries and their reporting to ANSWER COLLECTOR. It is used by 
					the parallel wait mechanism.
																					]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

class
	EVALUATOR

inherit
	EXECUTOR

create
	evaluate

feature {NONE} -- Initialization

	evaluate (a_query: detachable separate FUNCTION [ANY, TUPLE, ANY]; an_answer_collector : detachable separate ANSWER_COLLECTOR)
			-- Creation procedure.
		require
			a_query /= Void
			an_answer_collector /= Void
		do
			if {a: separate ANSWER_COLLECTOR} an_answer_collector then
				answer_collector := a
			end
			if {q: separate FUNCTION [ANY, TUPLE, detachable separate ANY]}a_query then
				evaluate_and_report (q)
			end
		end

feature {NONE} -- Implementation

	evaluate_and_report (a_query: separate FUNCTION [ANY, TUPLE, detachable separate ANY])
			-- Evaluate a query and report result to answer collector .
		do
			a_query.call ([])
			notify_answer_collector (answer_collector, a_query.last_result)
		end

	notify_answer_collector (an_answer_collector: separate ANSWER_COLLECTOR; a_result : detachable separate ANY)
			-- Report a result to an answer collector .
		do
			an_answer_collector.update_answer (a_result)
		end

	answer_collector: separate ANSWER_COLLECTOR
			-- Answer collector

end
