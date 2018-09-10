note
	description: "Blackboard data for a class."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_CLASS_DATA

inherit

	EBB_CHILD_ELEMENT [EBB_CLUSTER_DATA, EBB_CLASS_DATA]

	EBB_PARENT_ELEMENT [EBB_CLASS_DATA, EBB_FEATURE_DATA]

	EBB_CLASS_ASSOCIATION

	SHARED_WORKBENCH
		export {NONE} all end

	EBB_SHARED_ALL

create
	make

feature {NONE} -- Initialization

	make (a_class: attached like associated_class)
			-- Initialize empty verification state associated to `a_class'.
		do
			make_parent
			make_with_class (a_class)

			work_state := {EBB_STATE}.compilation
			result_state := {EBB_STATE}.unknown
		ensure
-- might not be same object
--			consistent: associated_class = a_class
			a_class.name.is_equal (associated_class.name)
		end

feature -- Access

	score: REAL
			-- Correctness score for this class in interval [-1, 1].
		do
			if has_manual_score then
				Result := manual_score
			else
				Result := automatic_score
			end
		ensure
			score_in_range: not score.is_nan implies -1.0 <= score and score <= 1.0
		end

	automatic_score: REAL
			-- Correctness score calculated from score of individual routines.
		local
			l_weight: REAL
			l_total_weight: REAL
			l_feature_data: EBB_FEATURE_DATA
		do
			if is_compiled then
				from
					Result := 0
					children.start
				until
					children.after
				loop
					l_feature_data := children.item
					if l_feature_data.has_score then
						l_weight := l_feature_data.weight
						l_total_weight := l_total_weight + l_weight
						Result := Result + (l_weight * l_feature_data.score)
					end
					children.forth
				end
				if l_total_weight > 0 then
					Result := Result / l_total_weight
				else
					Result := {REAL}.nan
				end
			else
				Result := {REAL}.nan
			end
		end

	manual_score: REAL
			-- Correctness score set manually.
		do
			if is_compiled and then compiled_class.ast.top_indexes /= Void then
				Result := correctness_override (associated_class.compiled_class.ast.top_indexes).value
			else
				Result := {REAL}.nan
			end
		end

	weight: REAL
			-- Weight of this class for correctness of whole system.
		do
			if has_manual_weight then
				Result := manual_weight
			else
				Result := automatic_weight
			end
		ensure
			weight_not_negative: Result >= 0.0
		end

	automatic_weight: REAL
			-- Weight of this class determined automatically.
		do
			Result := 1.0
			if is_compiled then
				Result := importance_weight (associated_class.compiled_class.ast.top_indexes)
			end
		end

	manual_weight: REAL
			-- Weight of this class set manually.
		do
			if is_compiled then
				Result := weight_override (associated_class.compiled_class.ast.top_indexes)
			else
				Result := {REAL}.nan
			end
		end

	lowest_feature_score: REAL
			-- Lowest score of a child feature.
		local
			l_feature_data: EBB_FEATURE_DATA
		do
			Result := {REAL}.nan
			from
				children.start
			until
				children.after
			loop
				l_feature_data := children.item
				if l_feature_data.has_score and then
					(l_feature_data.score < Result or else Result.is_nan)
				then
					Result := l_feature_data.score
				end
				children.forth
			end
		end

	non_verified_feature_count: INTEGER
			-- Number of features with a score below or equal to 0.
		local
			l_feature_data: EBB_FEATURE_DATA
		do
			from
				children.start
			until
				children.after
			loop
				l_feature_data := children.item
				if l_feature_data.has_score and then
					(l_feature_data.score <= 0)
				then
					Result := Result + 1
				end
				children.forth
			end
		end

	features_below_threshold (a_threshold: REAL): INTEGER
			-- Number of features with a score below or equal to `a_threshold'.
		local
			l_feature_data: EBB_FEATURE_DATA
		do
			from
				children.start
			until
				children.after
			loop
				l_feature_data := children.item
				if l_feature_data.has_score and then
					(l_feature_data.score < a_threshold)
				then
					Result := Result + 1
				end
				children.forth
			end
		end

	features_above_threshold (a_threshold: REAL): INTEGER
			-- Number of features with a score below or equal to `a_threshold'.
		local
			l_feature_data: EBB_FEATURE_DATA
		do
			from
				children.start
			until
				children.after
			loop
				l_feature_data := children.item
				if l_feature_data.has_score and then
					(l_feature_data.score > a_threshold)
				then
					Result := Result + 1
				end
				children.forth
			end
		end

feature -- Status report

	has_score: BOOLEAN
			-- Is a score set?
		do
			Result := not score.is_nan
		end

	has_manual_score: BOOLEAN
			-- Is a manual score set?
		do
			Result := not manual_score.is_nan
		end

	has_manual_weight: BOOLEAN
			-- Is a manual weight set?
		do
			Result := not manual_weight.is_nan
		end

	is_stale: BOOLEAN
			-- Is data stale?
		do
			from
				children.start
			until
				children.after or Result
			loop
				Result := children.item.is_stale
				children.forth
			end
		end

feature -- Element change

	set_work_state (a_state: like work_state)
			-- Set `work_state' to `a_state'.
		require
			(create {EBB_STATE}).is_valid_work_state (a_state)
		do
			work_state := a_state
		ensure
			work_state_set: work_state = a_state
		end

	set_result_state (a_state: like result_state)
			-- Set `result_state' to `a_state'.
		require
			(create {EBB_STATE}).is_valid_result_state (a_state)
		do
			result_state := a_state
		ensure
			result_state_set: result_state = a_state
		end

feature

	work_state: INTEGER
			-- Work state of class.

	result_state: INTEGER
			-- Result state of class.

invariant
	work_state_valid: (create {EBB_STATE}).is_valid_work_state (work_state)
	result_state_valid: (create {EBB_STATE}).is_valid_result_state (result_state)

end
