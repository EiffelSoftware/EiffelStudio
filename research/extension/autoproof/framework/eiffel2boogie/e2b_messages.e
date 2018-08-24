note
	description: "Messages used in AutoProof."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	E2B_MESSAGES

inherit

	SHARED_LOCALE

feature -- Validity error messages

	functional_feature_not_function: STRING_32
		do Result := "Functional feature has to be a pure function." end

	functional_feature_not_single_assignment: STRING_32
		do Result := "A functional feature has to consist of exactly one assignment to the Result (and optional check instructions before the assignment)." end

	functional_feature_redefined: STRING_32
		do Result := "Functional feature cannot be redefined." end

	pure_function_has_mods: STRING_32
		do Result := "Function with a non-empty modify clause has to be declared impure." end

	impure_function_in_contract (a_fname: STRING): STRING_32
		do Result := locale.formatted_string ("Impure function '$1' cannot be used in specifications.", a_fname) end

	invalid_call_in_invariant: STRING_32
		do Result := "Class invariant must not access built-in attributes closed or owner, or functions marked inv_unfriendly." end

	invalid_call_in_friendly_function: STRING_32
		do Result := "A pure function must not access built-in attributes closed or owner, or functions marked inv_unfriendly, unless it is itself inv_unfriendly." end

	creator_call_as_procedure (a_pname: STRING): STRING_32
		do Result := locale.formatted_string ("Feature '$1' is a creator but is called as a regular procedure.", a_pname) end

	nonsetter_call_from_setter (a_pname: STRING): STRING_32
		do Result := locale.formatted_string ("A non-setter procedure '$1' is called from a setter procedure.", a_pname) end

	first_argument_string: STRING_32
		do Result := "First argument has to be a manifest string." end

	first_argument_string_or_tuple: STRING_32
		do Result := "First argument has to be a manifest string or a tuple of manifest strings." end

	unknown_feature (a_fname, a_cname: STRING): STRING_32
		do Result := locale.formatted_string ("Feature '$1' is not found in class '$2'.", a_fname, a_cname) end

	unknown_attribute (a_fname, a_cname: STRING): STRING_32
		do Result := locale.formatted_string ("Feature '$1' is not an attribute of class '$2'.", a_fname, a_cname) end

	unknown_model (a_fname, a_cname: STRING): STRING_32
		do Result := locale.formatted_string ("Feature '$1' is not a model attribute of class '$2'.", a_fname, a_cname) end

	invalid_model_replacement (a_fname, a_cname: STRING): STRING_32
		do Result := locale.formatted_string ("Feature '$1' is a model of the parent class '$2' and thus cannot be a replacemnt model.", a_fname, a_cname) end

	invalid_tag (a_tag, a_class_name: STRING): STRING_32
		do Result := locale.formatted_string ("Filtered invariant of class '$2' lists invalid tag: $1", a_tag, a_class_name) end

	invalid_context_for_special_predicate (a_kind: STRING): STRING_32
		do Result := locale.formatted_string ("$1 clauses are only allowed in preconditions and loop invariants (will be ignored)", a_kind) end

	invalid_context_for_read_predicate: STRING_32
		do Result := "Read sets are only allowed for functions (will be ignored)" end

	variant_bad_type (a_index: INTEGER): STRING_32
		do Result := locale.formatted_string ("Type of variant number $1 has no well-founded order.", a_index.out) end

	logical_invalid_type_properties: STRING_32
		do Result := "The number of typed properties in the logical class does not correspond to the number of generic parameters." end

	logical_no_across_conversion: STRING_32
		do Result := "The logical class is used in quantification but does not map its new_cursor feature to a set." end

	guard_feature_not_predicate: STRING_32
		do Result := "Update guard has to be of type BOOLEAN." end

	guard_feature_arg_count: STRING_32
		do Result := "Update guard has to have exctly two argument." end

	guard_feature_arg1: STRING_32
		do Result := "The first argument of an update guard has to be of the same type as the guarded attribute." end

	guard_feature_arg2: STRING_32
		do Result := "The second argument of an update guard has to be of type ANY." end

	invalid_ghost_status (a_old_fname, a_old_cname: STRING): STRING_32
		do Result := locale.formatted_string ("Ghost status does not match previous version '$1' from class '$2'.", a_old_fname, a_old_cname) end

feature -- Verification error messages

	check_violated: STRING_32
		do Result := "Check may be violated (untagged)." end

	check_with_tag_violated: STRING_32
		do Result := "Check $tag may be violated." end

	function_precondition_violated: STRING_32
		do Result := "Precondition may be violated on invocation of $called_feature." end

	invariant_violated: STRING_32
		do Result := "Invariant might not hold on call to $called_feature." end

	invariant_with_tag_violated: STRING_32
		do Result := "Invariant $tag might not hold on call to $called_feature." end

	precondition_violated: STRING_32
		do Result := "Precondition may be violated on call to $called_feature (untagged)." end

	precondition_with_tag_violated: STRING_32
		do Result := "Precondition $tag may be violated on call to $called_feature." end

	postcondition_violated: STRING_32
		do Result := "Postcondition may be violated (untagged)." end

	postcondition_with_tag_violated: STRING_32
		do Result := "Postcondition $tag may be violated." end

	loop_inv_violated_on_entry: STRING_32
		do Result := "Loop invariant may be violated on entry (untagged)." end

	loop_inv_with_tag_violated_on_entry: STRING_32
		do Result := "Loop invariant $tag may be violated on entry." end

	loop_inv_not_maintained: STRING_32
		do Result := "Loop invariant may not be maintained (untagged)." end

	loop_inv_with_tag_not_maintained: STRING_32
		do Result := "Loop invariant $tag may not be maintained." end

	void_call: STRING_32
		do Result := "Possible Void call." end

	void_call_in_precondition: STRING_32
		do Result := "Possible Void call in precondition on call to $called_feature (untagged)." end

	void_call_in_precondition_with_tag: STRING_32
		do Result := "Possible Void call in precondition $tag on call to $called_feature." end

	void_call_in_postcondition: STRING_32
		do Result := "Possible Void call in postcondition (untagged)." end

	void_call_in_postcondition_with_tag: STRING_32
		do Result := "Possible Void call in postcondition $tag." end

	decreases_not_decreasing: STRING_32
		do Result := "Variant may not decrease at this recursive call / the end of this loop body." end

	decreases_bounded: STRING_32
		do Result := "Integer variant component at position $variant may be negative." end

	overflow: STRING_32
		do Result := "Possible arithmetic overflow." end

	overflow_in_precondition: STRING_32
		do Result := "Possible arithmetic overflow in precondition on call to $called_feature (untagged)." end

	overflow_in_precondition_with_tag: STRING_32
		do Result := "Possible arithmetic overflow in precondition $tag on call to $called_feature." end

	overflow_in_postcondition: STRING_32
		do Result := "Possible arithmetic overflow in postcondition (untagged)." end

	overflow_in_postcondition_with_tag: STRING_32
		do Result := "Possible arithmetic overflow in postcondition $tag." end

	assignment_attached_and_allocated: STRING_32
		do Result := "Target of assignment may not be attached or allocated" end

	assignment_closed_or_owner_not_allowed: STRING_32
		do Result := "The fields `closed' and `owner' cannot be directly assigned." end

	assignment_target_open: STRING_32
		do Result := "Target of assignment may not be open." end

	assignment_observers_open_or_guard_holds: STRING_32
		do Result := "Observers of the assignment target may be invalidated." end

	assignment_attribute_writable: STRING_32
		do Result := "Target attribute may not be writable." end

	access_attribute_readable: STRING_32
		do Result := "Attribute $called_feature might not be readable." end

	access_frame_readable: STRING_32
		do Result := "Some members of the read frame of $called_feature might not be readable." end

	ownership_explicit_note: STRING_32
		do Result := "Disable this default by making $explicit_value explicit." end

feature -- Other

	boogie_launch_failed (a_executable: STRING_32): STRING_32
		do Result := locale.formatted_string ("Launching Boogie failed (command was '$1').", a_executable) end

	internal_translation_error (a_unit_id: STRING_32): STRING_32
		do Result := locale.formatted_string ("Translation of '$1' failed due to an internal error.", a_unit_id) end

feature -- GUI

	tool_header_class: STRING_32
		do Result := "Class" end

	tool_header_feature: STRING_32
		do Result := "Feature" end

	tool_header_information: STRING_32
		do Result := "Information" end

	tool_header_position: STRING_32
		do Result := "Position" end

	tool_header_time: STRING_32
		do Result := "Time [s]" end

	tool_successful_button (a_value: INTEGER): STRING_32
		do Result := locale.formatted_string ("$1 Successful", a_value) end

	tool_failed_button (a_value: INTEGER): STRING_32
		do Result := locale.formatted_string ("$1 Failed", a_value) end

	tool_error_button (a_value: INTEGER): STRING_32
		do Result := locale.formatted_string (locale.plural_translation ("$1 Error", "$1 Errors", a_value), a_value) end

	tool_text_filter: STRING_32
		do Result := "Filter" end

	status_translating (a_current, a_total: INTEGER): STRING_32
		do Result := locale.formatted_string ("Translating Eiffel to Boogie ($1/$2 elements remaining)", a_current, a_total) end

	status_boogie_running (a_milliseconds: INTEGER): STRING_32
		do Result := locale.formatted_string ("Boogie running: $1 s", a_milliseconds // 1000) end

	status_boogie_finished (a_milliseconds: INTEGER): STRING_32
		do Result := locale.formatted_string ("Boogie finished: $1 s", a_milliseconds // 1000) end


end
