note
	description: "Blackboard data for a feature."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_FEATURE_DATA

inherit

	EBB_CHILD_ELEMENT [EBB_CLASS_DATA, EBB_FEATURE_DATA]

	EBB_FEATURE_ASSOCIATION

	SHARED_WORKBENCH
		export {NONE} all end

	EBB_SHARED_HELPER
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_feature: attached FEATURE_I)
			-- Initialize empty feature data associated to `a_feature'.
		do
			make_with_feature (a_feature)

			create tool_results.make
			create tool_results_.make (5)
		ensure
			consistent: system.class_of_id (class_id) = a_feature.written_class
			consistent2: associated_feature.rout_id_set ~ a_feature.rout_id_set
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
			l_tool_result: EBB_VERIFICATION_RESULT
			l_is_stale: BOOLEAN
		do
			Result := 0
			l_is_stale := is_stale
			from
				tool_results_.start
			until
				tool_results_.after
			loop
				if l_is_stale or not tool_results_.item_for_iteration.is_stale then
					l_tool_result := tool_results_.item_for_iteration.verification_result
					l_weight := l_tool_result.weight
					l_total_weight := l_total_weight + l_weight
					Result := Result + (l_weight * l_tool_result.score)
				end
				tool_results_.forth
			end
			if l_total_weight > 0 then
				Result := Result / l_total_weight
			else
				Result := {REAL}.nan
			end
		end

	manual_score: REAL
			-- Correctness score set manually.
		do
			Result := correctness_override (associated_feature.body.indexes).value
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
		local
			l_visibility: REAL
			l_importance: REAL
		do
			if associated_feature.is_exported_for (system.any_class.compiled_class) then
				l_visibility := 2.0
			else
				l_visibility := 1.0
			end
			l_importance := importance_weight (associated_feature.body.indexes)
			Result := l_visibility * l_importance
		end

	manual_weight: REAL
			-- Weight of this class set manually.
		do
			Result := weight_override (associated_feature.body.indexes)
		end

	tool_results_: HASH_TABLE [TUPLE [verification_result: EBB_VERIFICATION_RESULT; is_stale: BOOLEAN], EBB_TOOL]
			-- Lastest result of each tool.

	message: STRING
			-- Latest message to be displayed.
		do
			if tool_results.is_empty then
				Result := ""
			else
				Result := tool_results.first.message
			end
		end

	tool_results: LINKED_LIST [EBB_VERIFICATION_RESULT]
			-- List of tool results.

	tool_results_list: LIST [TUPLE [verification_result: EBB_VERIFICATION_RESULT; is_stale: BOOLEAN]]
			-- List representation of tool results.
		do
			Result := tool_results_.linear_representation
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
			if is_compiled and then associated_feature.body /= Void then
				Result := correctness_override (associated_feature.body.indexes).is_set
			end
		end

	has_manual_weight: BOOLEAN
			-- Is a manual weight set?
		do
			Result := not manual_weight.is_nan
		end

	is_stale: BOOLEAN
			-- Is data stale?
		do
			Result := not tool_results_.is_empty
			from
				tool_results_.start
			until
				tool_results_.after or not Result
			loop
				Result := tool_results_.item_for_iteration.is_stale
				tool_results_.forth
			end

		end

feature -- Element change

	add_tool_result (a_result: EBB_VERIFICATION_RESULT)
			-- TODO
		do
			if tool_results_.has (a_result.tool) then
					-- TODO: store old results?
				tool_results_.force ([a_result, False], a_result.tool)
			else
				tool_results_.put ([a_result, False], a_result.tool)
			end

			tool_results.put_front (a_result)
		end

feature -- Basic operations

	append_message (a_text_formatter: TEXT_FORMATTER)
			-- Append message to `a_text_formatter'.
		do
			if not tool_results.is_empty then
				a_text_formatter.add (tool_results.first.tool.name + ": ")
				tool_results.first.single_line_message (a_text_formatter)
			end
		end

	set_stale
			-- <Precursor>
		do
			from
				tool_results_.start
			until
				tool_results_.after
			loop
				tool_results_.item_for_iteration.is_stale := True
				tool_results_.forth
			end
		end

end
