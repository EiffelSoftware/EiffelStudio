indexing
	description: "Grid item for metric text criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TEXT_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_TEXT_CRITERION]
		undefine
			default_create,
			is_equal,
			copy
		end

	DIALOG_PROPERTY [TUPLE [a_text: STRING_GENERAL; a_case_sensitive: BOOLEAN; a_matcher: INTEGER]]
		rename
			make as property_make
		redefine
			convert_to_data
		end

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		local
			l_value: like value
		do
			l_value := safe_value

			create property_dialog
			property_dialog.set_value (l_value)
			property_dialog.data_change_actions.extend (agent set_value)

			make_with_dialog ("", property_dialog)
			set_display_agent (agent display_value_agent)
			set_value (l_value)
			enable_text_editing
			set_tooltip (metric_names.f_insert_text_here)
		end

feature -- Access

	grid_item: EV_GRID_ITEM is
			-- Grid item for Current property
		do
			Result := Current
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Load `a_criterion' into Current.
		do
			change_value_actions.block
			set_value ([a_criterion.text, a_criterion.is_case_sensitive, a_criterion.matching_strategy])
			set_text (displayed_value)
			change_value_actions.resume
		end

	store_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Store Current in `a_criterion'.
		local
			l_value: like value
		do
			l_value := safe_value
			a_criterion.set_text (l_value.a_text.as_string_8)
			a_criterion.set_matching_strategy (l_value.a_matcher)
			if l_value.a_case_sensitive then
				a_criterion.enable_case_sensitive
			else
				a_criterion.disable_case_sensitive
			end

		end

	safe_value: like value is
			-- Returns `value'.
			-- If `value' is Void, return a default value.
		do
			Result := value
			if Result = Void then
				Result := ["", False, {QL_NAME_CRITERION}.identity_matching_strategy]
			end
			Result.compare_objects
		ensure
			result_attached: Result /= Void
		end


feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value is
			-- Convert displayed data into data.
		local
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				Result := [a_string.as_string_8.twin, False, {QL_NAME_CRITERION}.identity_matching_strategy]
			else
				Result := [a_string.as_string_8.twin, l_value.a_case_sensitive, l_value.a_matcher]
			end
			Result.compare_objects
		end

	property_dialog: EB_METRIC_TEXT_PROPERTY_DIALOG
			-- Dialog to display advanced options for text criterion

	display_value_agent (a_value: like value): STRING_32 is
			-- Action to return displayable string
		local
			l_str: STRING_GENERAL
		do
			if a_value /= Void then
				l_str := a_value.a_text
			end
			if l_str /= Void then
				Result := l_str.to_string_32
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	property_dialog_attached: property_dialog /= Void

end
