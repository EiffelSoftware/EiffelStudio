note
	description: "[
					The deferred class CONCURRENCY provides an interface for the above 
					library facilities. To use these facilities, application classes must
					inherit from CONCURRENCY.
																							]"
	author: "Piotr Nienaltowski"
	date: "$Date$"
	revision: "$Revision$"

deferred class

	CONCURRENCY

feature -- Basic operations

	call (a_feature: attached separate ROUTINE [ANY, TUPLE])
			-- A universal enclosing routine which can be used for wrapping single
			-- separate calls. It takes an agent as argument
		do
			a_feature.call ([])
		end

	asynch (a_feature : detachable separate ROUTINE [ANY, TUPLE])
			-- Execute a feature fully asynchronously.
		require
			a_feature_exists : a_feature /= Void
		local
			executor : separate EXECUTOR
		do
			create executor.execute (a_feature)
		end

	sleep (a_time : INTEGER)
			-- Suspend activity for a time milliseconds .
		require
			a_time_non_negative : a_time >= 0
		do
			-- Implementation provided by scoop2scoopli
		end

feature -- Waiting faster

	evaluated_in_parallel (a_queries : LIST [detachable separate FUNCTION [ANY, TUPLE, detachable separate ANY]]; an_initial_answer , a_ready_answer: detachable separate ANY; an_operator : FUNCTION [ANY, TUPLE, detachable separate ANY]): detachable separate ANY
			-- Parallel evaluation of queries combined by an operator
		require
			a_queries.count > 0
		local
			answer_collector : separate ANSWER_COLLECTOR
		do
			create answer_collector.make (a_queries, an_initial_answer , a_ready_answer, an_operator)
			Result := answer (answer_collector)
		end

	answer (an_answer_collector : attached separate ANSWER_COLLECTOR): detachable separate ANY
			-- Answer from an answer collector
		require
			answer_ready (an_answer_collector)
		do
			Result := an_answer_collector.answer
		end

feature -- Predefined parallel operators

	parallel_or (l: LIST [detachable separate PREDICATE [ANY, TUPLE]]): BOOLEAN
		do
			if {res : BOOLEAN} evaluated_in_parallel (l , False , True,
--				agent or_else (b1: BOOLEAN; b2: BOOLEAN): BOOLEAN
				agent (b1, b2: BOOLEAN): BOOLEAN
					do
						Result := b1 or else b2
					end (?, ?))
			then
				Result := res
			end
	end

	parallel_and (l : LIST [detachable separate PREDICATE [ANY, TUPLE]]): BOOLEAN
		do
			if {res : BOOLEAN} evaluated_in_parallel (l , True, False ,
--				agent and_then (b1, b2: BOOLEAN): BOOLEAN
				agent (b1, b2: BOOLEAN): BOOLEAN
					do
						Result := b1 and then b2
					end (?, ?))
			then
				Result := res
			end
		end

	parallel_sum (l : LIST [detachable separate FUNCTION [ANY, TUPLE, INTEGER]]): INTEGER
		do
			if {res : INTEGER} evaluated_in_parallel (l , 0,{INTEGER}.min_value,
--				agent sum (i , j : INTEGER): INTEGER
				agent (i , j : INTEGER): INTEGER
					do
						Result := i + j
					end (?, ?))
			then
				Result := res
			end
		end

feature -- Resource pooling

	call_m_out_of_n (a_feature : ROUTINE [ANY, TUPLE]; a_pool : LIST [detachable separate ANY]; m: INTEGER)
			-- Apply a feature to m elements of a pool .
		require
			m > 0 and then a_pool . count >= m
		local
			pool_manager: separate POOL_MANAGER
			locker : separate LOCKER
		do
			create pool_manager.make (a_feature , m)
			from
				a_pool.start
			until
				a_pool.after
			loop
--				create locker.try_to_lock (a_pool.item, pool_manager)
				create locker.lock_target (a_pool.item, pool_manager)
				a_pool.forth
			end
		end

feature -- Contract support

	answer_ready (an_answer_collector : attached separate ANSWER_COLLECTOR): BOOLEAN
			-- If `an_answer_collector' ready?
		do
			Result := an_answer_collector.is_ready
		end

end
