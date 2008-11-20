indexing
	description:

		"Sequence of requests with their responses that are witness to an observation of that execution"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_WITNESS

inherit

	AUT_REQUEST_LIST
		export {ANY} all
		redefine
			make

		end

	EXCEP_CONST
		export {NONE} all end

	REFACTORING_HELPER

create

	make,
	make_default

feature {NONE} -- Initialization

	make (a_list: like list; a_first_index: like first_index; a_last_index: like last_index) is
			-- Create new witness.
		do
			Precursor (a_list, a_first_index, a_last_index)
			judge
		end

feature -- Access

	is_pass: BOOLEAN
			-- Did test case pass?

	is_fail: BOOLEAN
			-- Did test case fail? This means a bug was found.

	is_invalid: BOOLEAN
			-- Was test case not executable because a prerequisite was not
			-- established? Most often this means a precondition was violated.

	is_bad_response: BOOLEAN
			-- Did an unknown error occure that made the interpreter respond
			-- in an unexpected way?

	classifications: DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]
			-- Classifcations resulting from this witness

	is_same_bug (other: AUT_WITNESS): BOOLEAN is
			-- Is `other' witnessing the same bug as this witness?
			-- Note that this is a heuristics that considers class, feature and exception only.
		require
			other_not_void: other /= Void
			witnesses_fail: is_fail and other.is_fail
		local
			cs: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
			cs_other: DS_LINEAR_CURSOR [AUT_TEST_CASE_RESULT]
			response: AUT_NORMAL_RESPONSE
			other_response: AUT_NORMAL_RESPONSE
		do
			Result := classifications.count = other.classifications.count
			if Result then
				from
					cs := classifications.new_cursor
					cs.start
					cs_other := other.classifications.new_cursor
					cs_other.start
				until
					cs.off or not Result
				loop
					Result := (cs.item.class_ = cs_other.item.class_) and (cs.item.feature_ = cs_other.item.feature_)
					cs.forth
					cs_other.forth
				end
				cs.go_after
				cs_other.go_after
			end
			if Result then
				response ?= item (count).response
				other_response ?= other.item (other.count).response
				check
					response_not_void: response /= Void
					other_response_not_void: other_response /= Void
				end
				Result := response.exception.code = other_response.exception.code and
							equal (response.exception.class_name, other_response.exception.class_name) and
							equal (response.exception.recipient_name, other_response.exception.recipient_name) and
							equal (response.exception.tag_name, other_response.exception.tag_name) and
							equal (response.exception.break_point_slot, other_response.exception.break_point_slot)
			end
		end

	set_used_vars (a_used_vars: like used_vars)
		do
			used_vars := a_used_vars
		ensure
			used_vars_set: used_vars = a_used_vars
		end

	used_vars: DS_HASH_TABLE [TUPLE [type: ?TYPE_A; name: ?STRING; check_dyn_type: BOOLEAN], ITP_VARIABLE]
			-- Set of used variables: keys are variables, items are tuples of static type of variable
			-- and a boolean flag showing if the static type should be checked against dynamic type
			-- (is only the case for variables returned as results of function calls and those whose type
			-- is left Void)

feature -- Deltas

	deltas (n: INTEGER): DS_LINEAR [DS_LIST [AUT_REQUEST]] is
			-- Request list divided into `n' parts.
			-- Requests will be fresh.
		require
			n_big_enough: n >= 2
			n_small_enough: n <= count
		local
		do
		ensure
			delta_not_void: Result /= Void
			delta_doesn_have_void: not Result.has (Void)
			delta_size_correct: Result.count = n
		end

	deltas_complement (i: INTEGER; n: INTEGER): DS_LIST [AUT_REQUEST] is
			-- All but the `i'-th complement of the `n' delta list of the current requests.
			-- Requests will be fresh.
		require
			i_big_enough: i >= 1
			i_small_enough: i <= n
			n_big_enough: n >= 2
			n_small_enough: n <= count
		do
		ensure
			delta_not_void: Result /= Void
			delta_doesn_have_void: not Result.has (Void)
		end

feature {NONE} -- Implementation

	judge is
			-- Judge current witness.
		local
			last_request: AUT_REQUEST
			normal_response: AUT_NORMAL_RESPONSE
			classification: AUT_TEST_CASE_RESULT
			invoke_request: AUT_INVOKE_FEATURE_REQUEST
			create_request: AUT_CREATE_OBJECT_REQUEST
			feature_: FEATURE_I
			class_: CLASS_C
		do
			create {DS_ARRAYED_LIST [AUT_TEST_CASE_RESULT]} classifications.make (1)
			last_request := item (count)
			create_request ?= last_request
			invoke_request ?= last_request

			if create_request /= Void then
				class_ := create_request.class_of_target_type
				if create_request.creation_procedure /= Void then
					feature_ := create_request.creation_procedure
				else
					feature_ := class_.default_create_feature
				end
			elseif invoke_request /= Void then
				if invoke_request.target_type /= Void then
					class_ := invoke_request.class_of_target_type
					feature_ := invoke_request.feature_to_call
				end
			end
			check
				consistent: (feature_ /= Void) = (class_ /= Void)
			end
			if last_request.response /= Void then
				if last_request.response.is_bad or last_request.response.is_error then
					is_bad_response := True
					if feature_ /= Void then
						create classification.make (Current, class_, feature_)
						classifications.force_last (classification)
					end
				else
					normal_response ?= last_request.response
					check
						normal_response_not_void: normal_response /= Void
					end
					if normal_response.exception = Void then
						is_pass := True
						if feature_ /= Void then
							create classification.make (Current, class_, feature_)
							classifications.force_last (classification)
						end
					else
						if normal_response.exception.code = Precondition and normal_response.exception.trace_depth = 1 then
							is_invalid := True
							if feature_ /= Void then
								create classification.make (Current, class_, feature_)
								classifications.force_last (classification)
							end
						else
							is_fail := True
							-- TODO: if the exception trace is bigger than one, we should create a classification
							-- for each routine that failed, not only for the bottom most
							if feature_ /= Void then
								create classification.make (Current, class_, feature_)
								classifications.force_last (classification)
							end
						end
					end
				end
			else
				-- No response recorded (maybe the request was not executed because of an inconsistency) -> invalid
				is_invalid := True
			end
		end

invariant

	mutal_is_pass: is_pass = (not is_fail and not is_invalid and not is_bad_response)
	mutal_is_fail: is_fail = (not is_pass and not is_invalid and not is_bad_response)
	mutal_is_invalid: is_invalid = (not is_pass and not is_fail and not is_bad_response)
	mutal_is_bad_response: is_bad_response = (not is_pass and not is_fail and not is_invalid)
	classifications_not_void: classifications /= Void
	no_classification_void: not classifications.has (Void)
	at_most_one_classification: classifications.count <= 1

end
