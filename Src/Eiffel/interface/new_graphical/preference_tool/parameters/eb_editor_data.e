note
	description: "Editor preferences"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Christophe Bonnard / Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_DATA

inherit
	EDITOR_DATA
		export
			{ANY} fonts
		undefine
			max_color_id
		redefine
			make,
			initialize_preferences,
			update,
			init_colors,
			init_fonts,
			update_font
		end

	EB_SHORTCUTS_DATA
		redefine
			update
		end

	EB_SHARED_MANAGERS

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	EB_EDITOR_TOKEN_IDS

	SHARED_BENCH_NAMES
		export
			{NONE} all
		end

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES)
			-- Create
		do
			Precursor {EDITOR_DATA} (a_preferences)
			create post_update_actions
		end

feature -- Value

	breakpoint_background_color: EV_COLOR
			-- Background color used to display breakpoints		
		do
			Result := breakpoint_background_color_preference.value
		end

	assertion_tag_text_color: EV_COLOR
		do
			Result := assertion_tag_text_color_preference.value
		end

	assertion_tag_background_color: EV_COLOR
		do
			Result := assertion_tag_background_color_preference.value
		end

	note_tag_text_color: EV_COLOR
		do
			Result := note_tag_text_color_preference.value
		end

	note_tag_background_color: EV_COLOR
		do
			Result := note_tag_background_color_preference.value
		end

	reserved_text_color: EV_COLOR
		do
			Result := reserved_text_color_preference.value
		end

	reserved_background_color: EV_COLOR
		do
			Result := reserved_background_color_preference.value
		end

	generic_text_color: EV_COLOR
		do
			Result := generic_text_color_preference.value
		end

	generic_background_color: EV_COLOR
		do
			Result := generic_background_color_preference.value
		end

	local_text_color: EV_COLOR
		do
			Result := local_text_color_preference.value
		end

	local_background_color: EV_COLOR
		do
			Result := local_background_color_preference.value
		end

	class_text_color: EV_COLOR
		do
			Result := class_text_color_preference.value
		end

	class_background_color: EV_COLOR
		do
			Result := class_background_color_preference.value
		end

	feature_text_color: EV_COLOR
		do
			Result := feature_text_color_preference.value
		end

	feature_background_color: EV_COLOR
		do
			Result := feature_background_color_preference.value
		end

	target_text_color: EV_COLOR
		do
			Result := target_text_color_preference.value
		end

	target_background_color: EV_COLOR
		do
			Result := target_background_color_preference.value
		end

	cluster_text_color: EV_COLOR
		do
			Result := cluster_text_color_preference.value
		end

	cluster_background_color: EV_COLOR
		do
			Result := cluster_background_color_preference.value
		end

	error_text_color: EV_COLOR
		do
			Result := error_text_color_preference.value
		end

	error_background_color: EV_COLOR
		do
			Result := error_background_color_preference.value
		end

	object_text_color: EV_COLOR
		do
			Result := object_text_color_preference.value
		end

	object_background_color: EV_COLOR
		do
			Result := object_background_color_preference.value
		end

	once_and_constant_in_upper: BOOLEAN
			-- Is first letter of once or constant in upper case?
		do
			Result := once_and_constant_in_upper_preference.value
		end

	underscore_is_separator: BOOLEAN
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)
		do
			Result := underscore_is_separator_preference.value
		end

	autocomplete_brackets_and_parentheses: BOOLEAN
			-- Should we close the brackets and parentheses automatically?
		do
			Result := autocomplete_brackets_and_parentheses_preference.value
		end

	autocomplete_quotes: BOOLEAN
			-- Should we close the quotes automatically?
		do
			Result := autocomplete_quotes_preference.value
		end

	show_any_features: BOOLEAN
			-- Should autocomplete show features inherited from any ?
		do
			Result := show_any_features_preference.value
		end

	auto_auto_complete: BOOLEAN
			-- Should completion window show automatically after valid '.' calls?
		do
			Result := auto_auto_complete_preference.value
		end

	auto_complete_words: BOOLEAN
			-- Should completion automatically complete words when a single best match is available?
		do
			Result := auto_complete_words_preference.value
		end

	auto_remove_trailing_blank_when_saving: BOOLEAN
			-- Should trailing blanks be auto-removed when saving?
		do
			Result := auto_remove_trailing_blank_when_saving_preference.value
		end

	filter_completion_list: BOOLEAN
			-- Indicates if completion list matches should be filtered down based on current matches.  If not then
			-- the list will always contain possible completion options and closest match will be selected during typing.
		do
			Result := filter_completion_list_preference.value
		end

	highlight_matching_braces: BOOLEAN
			-- Should matching braces be highlighted at the carets position?
		do
			Result := highlight_matching_braces_preference.value
		end

	is_linked_editing_enabled: BOOLEAN
			-- Linked tokens editing enabled?
			-- (for instance to rename local variables inside the editor).
		do
			Result := is_linked_editing_enabled_preference.value
		end

	show_completion_signature: BOOLEAN
			-- Should feature signature be shown in completion list?
		do
			Result := show_completion_signature_preference.value
		end

	show_completion_target_class: BOOLEAN
			-- Should target class be shown in completion dialog?
		do
			Result := show_completion_target_class_preference.value
		end

	show_completion_type: BOOLEAN
			-- Should feature type be shown in completion list?
		do
			Result := show_completion_type_preference.value
		end

	show_completion_disambiguated_name: BOOLEAN
			-- Should disambiguated name be shown in completion list?
		do
			Result := show_completion_disambiguated_name_preference.value
		end

	show_completion_unicode_symbols: BOOLEAN
			-- Should unicode symbols be shown in feature completion list?
		do
			Result := show_completion_unicode_symbols_preference.value
		end

	show_completion_obsolete_items: BOOLEAN
			-- Should obsolete items be shown in completion list?
		do
			Result := show_completion_obsolete_items_preference.value
		end

	show_completion_tooltip: BOOLEAN
			-- Should tooltips be shown in the completion list
		do
			Result := show_completion_tooltip_preference.value
		end

	syntax_complete_enabled: BOOLEAN
			-- should main keywords be completed ?
		do
			Result := syntax_complete_enabled_preference.value
		end

	customized_string_1: STRING
			-- strings defined by the user.
		do
			Result := customized_string_1_preference.value
		end

	customized_string_2: STRING
			-- strings defined by the user.
		do
			Result := customized_string_2_preference.value
		end

	customized_string_3: STRING
			-- strings defined by the user.
		do
			Result := customized_string_3_preference.value
		end

	new_tab_at_left: BOOLEAN
			-- When creating new tab, should added it at the begin of the target notebook?
		do
			Result := new_tab_at_left_preference.value
		end

	left_side: BOOLEAN

	maximized: BOOLEAN

	warning_text_color: EV_COLOR
			-- Warning text color
		do
			Result := warning_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	warning_background_color: EV_COLOR
			-- Warning background color
		do
			Result := warning_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	argument_text_color: EV_COLOR
			-- Argument text color
		do
			Result := argument_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	argument_background_color: EV_COLOR
			-- Argument background color
		do
			Result := argument_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	folder_text_color: EV_COLOR
			-- Folder text color
		do
			Result := folder_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	folder_background_color: EV_COLOR
			-- Folder background color
		do
			Result := folder_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	auto_show_feature_contract_tooltips: BOOLEAN
			-- Should feature contract tool tips be automatically shown
		do
			Result := auto_show_feature_contract_tooltips_preference.value
		end

feature -- Preference

	breakpoint_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display breakpoints		

	assertion_tag_text_color_preference: COLOR_PREFERENCE
	assertion_tag_background_color_preference: COLOR_PREFERENCE
	note_tag_text_color_preference: COLOR_PREFERENCE
	note_tag_background_color_preference: COLOR_PREFERENCE
	reserved_text_color_preference: COLOR_PREFERENCE
	reserved_background_color_preference: COLOR_PREFERENCE
	generic_text_color_preference: COLOR_PREFERENCE
	generic_background_color_preference: COLOR_PREFERENCE
	local_text_color_preference: COLOR_PREFERENCE
	local_background_color_preference: COLOR_PREFERENCE
	class_text_color_preference: COLOR_PREFERENCE
	class_background_color_preference: COLOR_PREFERENCE
	feature_text_color_preference: COLOR_PREFERENCE
	feature_background_color_preference: COLOR_PREFERENCE
	cluster_text_color_preference: COLOR_PREFERENCE
	cluster_background_color_preference: COLOR_PREFERENCE
	error_text_color_preference: COLOR_PREFERENCE
	error_background_color_preference: COLOR_PREFERENCE
	object_text_color_preference: COLOR_PREFERENCE
	object_background_color_preference: COLOR_PREFERENCE
	target_text_color_preference: COLOR_PREFERENCE
	target_background_color_preference: COLOR_PREFERENCE

	once_and_constant_in_upper_preference: BOOLEAN_PREFERENCE
			-- Is first letter of once or constant in upper case?

	underscore_is_separator_preference: BOOLEAN_PREFERENCE
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)

	autocomplete_brackets_and_parentheses_preference: BOOLEAN_PREFERENCE
			-- Should we close the brackets and parentheses automatically?

	autocomplete_quotes_preference: BOOLEAN_PREFERENCE
			-- Should we close the quotes automatically?

	show_any_features_preference: BOOLEAN_PREFERENCE
			-- Should autocomplete show features inherited from any ?

	auto_auto_complete_preference: BOOLEAN_PREFERENCE
			-- Should completion window show automatically after valid '.' calls?

	auto_complete_words_preference: BOOLEAN_PREFERENCE
			-- Should completion automatically complete words when a single best match is available?

	auto_remove_trailing_blank_when_saving_preference: BOOLEAN_PREFERENCE
			-- Should trailing blanks be auto-removed when saving?

	filter_completion_list_preference: BOOLEAN_PREFERENCE
			-- Indicates if completion list matches should be filtered down based on current matches.  If not then
			-- the list will always contain possible completion options and closest match will be selected during typing.

	highlight_matching_braces_preference: BOOLEAN_PREFERENCE
			-- Should matching braces be highlighted at the carets position?

	is_linked_editing_enabled_preference: BOOLEAN_PREFERENCE
			-- Is linked editing enabled?

	show_completion_signature_preference: BOOLEAN_PREFERENCE
			-- Should feature signature be shown in completion list?

	show_completion_target_class_preference: BOOLEAN_PREFERENCE
			-- Should target class be shown in completion dialog?

	show_completion_type_preference: BOOLEAN_PREFERENCE
			-- Should feature type be shown in completion list?

	show_completion_disambiguated_name_preference: BOOLEAN_PREFERENCE
			-- Should disambiguated name be shown in completion list?

	show_completion_unicode_symbols_preference: BOOLEAN_PREFERENCE
			-- Should unicode symbols be shown in feature completion list?

	show_completion_obsolete_items_preference: BOOLEAN_PREFERENCE
			-- Should obsolete items be shown in completion list?

	show_completion_tooltip_preference: BOOLEAN_PREFERENCE
			-- Should obsolete items be shown in completion list?

	syntax_complete_enabled_preference: BOOLEAN_PREFERENCE
			-- should main keywords be completed ?

	minimum_count_for_unicode_symbols_completion_preference: INTEGER_PREFERENCE
			-- Minimum number of character before showing unicode symbols in completion list.

	customized_string_1_preference: STRING_PREFERENCE
	customized_string_2_preference: STRING_PREFERENCE
	customized_string_3_preference: STRING_PREFERENCE
			-- strings defined by the user.			

	new_tab_at_left_preference: BOOLEAN_PREFERENCE
			-- When create new tab, should it created at the begin of the target notebook?

	warning_text_color_preference: COLOR_PREFERENCE
	warning_background_color_preference: COLOR_PREFERENCE

	argument_text_color_preference: COLOR_PREFERENCE
	argument_background_color_preference: COLOR_PREFERENCE
			-- Color of name of arguments displayed in metric tool

	folder_text_color_preference: COLOR_PREFERENCE
	folder_background_color_preference: COLOR_PREFERENCE
			-- Color of name of folders displayed in metric tool

	auto_show_feature_contract_tooltips_preference: BOOLEAN_PREFERENCE
			-- Should feature contract tool tips be automatically shown

feature {NONE} -- Preference Strings

	assertion_tag_text_color_string: STRING = "editor.eiffel.colors.assertion_tag_text_color"
	assertion_tag_background_color_string: STRING = "editor.eiffel.colors.assertion_tag_background_color"
	note_tag_text_color_string: STRING = "editor.eiffel.colors.note_tag_text_color"
	note_tag_background_color_string: STRING = "editor.eiffel.colors.note_tag_background_color"
	reserved_text_color_string: STRING = "editor.eiffel.colors.reserved_text_color"
	reserved_background_color_string: STRING = "editor.eiffel.colors.reserved_background_color"
	generic_text_color_string: STRING = "editor.eiffel.colors.generic_text_color"
	generic_background_color_string: STRING = "editor.eiffel.colors.generic_background_color"
	local_text_color_string: STRING = "editor.eiffel.colors.local_text_color"
	local_background_color_string: STRING = "editor.eiffel.colors.local_background_color"
	class_text_color_string: STRING = "editor.eiffel.colors.class_text_color"
	class_background_color_string: STRING = "editor.eiffel.colors.class_background_color"
	feature_text_color_string: STRING = "editor.eiffel.colors.feature_text_color"
	feature_background_color_string: STRING = "editor.eiffel.colors.feature_background_color"
	cluster_text_color_string :STRING = "editor.eiffel.colors.cluster_text_color"
	cluster_background_color_string: STRING = "editor.eiffel.colors.cluster_background_color"
	error_text_color_string : STRING = "editor.eiffel.colors.error_text_color"
	error_background_color_string: STRING = "editor.eiffel.colors.error_background_color"
	object_text_color_string: STRING = "editor.eiffel.colors.object_text_color"
	object_background_color_string: STRING = "editor.eiffel.colors.object_background_color"
	breakpoint_background_color_string: STRING = "editor.eiffel.colors.breakpoint_background_color"
	target_text_color_string: STRING = "editor.eiffel.colors.target_text_color"
	target_background_color_string: STRING = "editor.eiffel.colors.target_text_background_color"
	warning_text_color_string: STRING = "editor.eiffel.colors.warning_text_color"
	warning_background_color_string: STRING = "editor.eiffel.colors.warning_background_color"
	line_text_color_string: STRING = "editor.eiffel.colors.line_text_color"
	line_background_color_string: STRING = "editor.eiffel.colors.line_background_color"
	argument_text_color_string: STRING = "editor.eiffel.colors.argument_text_color"
	argument_background_color_string: STRING = "editor.eiffel.colors.argument_background_color"
	folder_text_color_string: STRING = "editor.eiffel.colors.folder_text_color"
	folder_background_color_string: STRING = "editor.eiffel.colors.folder_background_color"

	once_and_constant_in_upper_string: STRING = "editor.eiffel.once_and_constant_in_upper"
			-- Is first letter of once or constant in upper case?

	underscore_is_separator_string: STRING = "editor.eiffel.underscore_is_separator"
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)

	autocomplete_brackets_and_parentheses_string: STRING = "editor.eiffel.auto-complete_brackets_and_parentheses"
			-- Should we close the brackets and parentheses automatically?

	autocomplete_quotes_string: STRING = "editor.eiffel.auto-complete_quotes"
			-- Should we close the quotes automatically?

	show_any_features_string: STRING = "editor.eiffel.show_ANY_features"
			-- Should autocomplete show features inherited from any ?

	auto_auto_complete_string: STRING = "editor.eiffel.auto_auto-complete"
			-- Should completion window show automatically after valid '.' calls?

	auto_complete_words_string: STRING = "editor.eiffel.auto_complete_words"
			-- Should completion automatically complete words when a single best match is available?

	auto_remove_trailing_blank_when_saving_string: STRING = "editor.eiffel.auto_remove_trailing_blank_when_saving"
			-- Should trailing blanks be auto-removed when saving?

	filter_completion_list_string: STRING = "editor.eiffel.filter_completion_list"
			-- Indicates if completion list matches should be filtered down based on current matches.  If not then
			-- the list will always contain possible completion options and closest match will be selected during typing.

	show_completion_signature_string: STRING = "editor.eiffel.show_completion_signature"
			-- Should feature signature be shown in completion list?

	show_completion_target_class_string: STRING = "editor.eiffel.show_completion_target_class"
			-- Should target class be shown in completion dialog?

	show_completion_type_string: STRING = "editor.eiffel.show_completion_type"
			-- Should feature type be shown in completion list?

	show_completion_disambiguated_name_string: STRING = "editor.eiffel.show_completion_disambiguated_name"
			-- Should disambiguated name be shown in completion list?

	show_completion_unicode_symbols_string: STRING = "editor.eiffel.show_completion_unicode_symbols"
			-- Should unicode symbols be shown in feature completion list?

	show_completion_obsolete_items_string: STRING = "editor.eiffel.show_obsolete_items"
			-- Should obsolete items be shown in completion list?

	show_completion_tooltip_string: STRING = "editor.eiffel.show_completion_tooltip"
			-- Should completion tooltips be shown in the completion list?

	syntax_complete_enabled_string: STRING = "editor.eiffel.syntax_complete_enabled"
			-- should main keywords be completed ?

	minimum_count_for_unicode_symbols_completion_preference_string: STRING = "editor.eiffel.minimum_count_for_unicode_symbols_completion"

	customized_string_1_string: STRING = "editor.eiffel.customized_string_1"
	customized_string_2_string: STRING = "editor.eiffel.customized_string_2"
	customized_string_3_string: STRING = "editor.eiffel.customized_string_3"
			-- strings defined by the user.

	new_tab_at_left_string: STRING = "editor.general.new_tab_at_left"
			-- Create new tab at left side of the target notebook?

	highlight_matching_braces_string: STRING = "editor.eiffel.highlight_matching_braces"
			-- Should matching braces be highlighted at the carets position?

	is_linked_editing_enabled_string: STRING = "editor.eiffel.linked_token_editing_enabled"
			-- Is linked editing enabled?

	auto_show_feature_contract_tooltips_string: STRING = "editor.eiffel.auto_show_feature_contract_tooltip"
			-- Should feature contract tool tips be automatically shown

feature {NONE} -- Init colors and fonts.

	init_colors
			-- Initialize colors.
		do
			Precursor
			colors.put (breakpoint_background_color_preference.value, breakpoint_background_color_id)
			colors.put (assertion_tag_text_color_preference.value, assertion_tag_text_color_id)
			colors.put (assertion_tag_background_color_preference.value, assertion_tag_background_color_id)
			colors.put (note_tag_text_color_preference.value, indexing_tag_text_color_id)
			colors.put (note_tag_background_color_preference.value, indexing_tag_background_color_id)
			colors.put (reserved_text_color_preference.value, reserved_text_color_id)
			colors.put (reserved_background_color_preference.value, reserved_background_color_id)
			colors.put (generic_text_color_preference.value, generic_text_color_id)
			colors.put (generic_background_color_preference.value, generic_background_color_id)
			colors.put (local_text_color_preference.value, local_text_color_id)
			colors.put (local_background_color_preference.value, local_background_color_id)
			colors.put (class_text_color_preference.value, class_text_color_id)
			colors.put (class_background_color_preference.value, class_background_color_id)
			colors.put (feature_text_color_preference.value, feature_text_color_id)
			colors.put (feature_background_color_preference.value, feature_background_color_id)
			colors.put (cluster_text_color_preference.value, cluster_text_color_id)
			colors.put (cluster_background_color_preference.value, cluster_background_color_id)
			colors.put (error_text_color_preference.value, error_text_color_id)
			colors.put (error_background_color_preference.value, error_background_color_id)
			colors.put (object_text_color_preference.value, object_text_color_id)
			colors.put (object_background_color_preference.value, object_background_color_id)
			colors.put (target_text_color_preference.value, target_text_color_id)
			colors.put (target_background_color_preference.value, target_background_color_id)
			colors.put (warning_text_color_preference.value, warning_text_color_id)
			colors.put (warning_background_color_preference.value, warning_background_color_id)
			colors.put (argument_text_color_preference.value, argument_text_color_id)
			colors.put (argument_background_color_preference.value, argument_background_color_id)
			colors.put (folder_text_color_preference.value, folder_text_color_id)
			colors.put (folder_background_color_preference.value, folder_background_color_id)
		end

	init_fonts
			-- <Precursor>
		do
			Precursor
		end

	update_font
			-- Font was changed, must redraw tokens due to possible width change.
		do
				-- FIXME: change to event handling ... "service"?
			if
				attached {IDE_S} (create {SERVICE_CONSUMER [IDE_S]}).service as l_ide_service
			then
				l_ide_service.on_zoom (font_zoom_factor_preference.value)
			end

			Precursor
		end

feature -- Update

	update
			-- The preferences have changed.
		do
			init_colors
			window_manager.quick_refresh_all_editors
			Precursor {EB_SHORTCUTS_DATA}
			post_update_actions.call (Void)
		end

	post_update_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions called after preferences has been called.
			-- NOTE: Actions registered should be removed when they become useless, otherwise memory leaks.

feature {NONE} -- Initialization

	initialize_preferences
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			Precursor {EDITOR_DATA}
			initialize_fixed_shortcuts

			create l_manager.make (preferences, "editor.eiffel")

				-- Colors
			breakpoint_background_color_preference := l_manager.new_color_preference_value (l_manager, breakpoint_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			assertion_tag_text_color_preference := l_manager.new_color_preference_value (l_manager, assertion_tag_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			assertion_tag_background_color_preference := l_manager.new_color_preference_value (l_manager, assertion_tag_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			note_tag_text_color_preference := l_manager.new_color_preference_value (l_manager, note_tag_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			note_tag_background_color_preference := l_manager.new_color_preference_value (l_manager, note_tag_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			reserved_text_color_preference := l_manager.new_color_preference_value (l_manager, reserved_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			reserved_background_color_preference := l_manager.new_color_preference_value (l_manager, reserved_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			generic_text_color_preference := l_manager.new_color_preference_value (l_manager, generic_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			generic_background_color_preference := l_manager.new_color_preference_value (l_manager, generic_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			local_text_color_preference := l_manager.new_color_preference_value (l_manager, local_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			local_background_color_preference := l_manager.new_color_preference_value (l_manager, local_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			class_text_color_preference := l_manager.new_color_preference_value (l_manager, class_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			class_background_color_preference := l_manager.new_color_preference_value (l_manager, class_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			feature_text_color_preference := l_manager.new_color_preference_value (l_manager, feature_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			feature_background_color_preference := l_manager.new_color_preference_value (l_manager, feature_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			cluster_text_color_preference := l_manager.new_color_preference_value (l_manager, cluster_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			cluster_background_color_preference := l_manager.new_color_preference_value (l_manager, cluster_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			error_text_color_preference := l_manager.new_color_preference_value (l_manager, error_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			error_background_color_preference := l_manager.new_color_preference_value (l_manager, error_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			object_text_color_preference := l_manager.new_color_preference_value (l_manager, object_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			object_background_color_preference := l_manager.new_color_preference_value (l_manager, object_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			target_text_color_preference := l_manager.new_color_preference_value (l_manager, target_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			target_background_color_preference := l_manager.new_color_preference_value (l_manager, target_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			warning_text_color_preference := l_manager.new_color_preference_value (l_manager, warning_text_color_string, create{EV_COLOR}.make_with_8_bit_rgb (200, 64, 0))
			warning_background_color_preference := l_manager.new_color_preference_value (l_manager, warning_background_color_string, create{EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			argument_text_color_preference := l_manager.new_color_preference_value (l_manager, argument_text_color_string, create{EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			argument_background_color_preference := l_manager.new_color_preference_value (l_manager, argument_background_color_string, create{EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
			folder_text_color_preference := l_manager.new_color_preference_value (l_manager, folder_text_color_string, create{EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			folder_background_color_preference := l_manager.new_color_preference_value (l_manager, folder_background_color_string, create{EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))

				-- Booleans			
			underscore_is_separator_preference := l_manager.new_boolean_preference_value (l_manager, underscore_is_separator_string, False)
			once_and_constant_in_upper_preference := l_manager.new_boolean_preference_value (l_manager, once_and_constant_in_upper_string, False)
			autocomplete_brackets_and_parentheses_preference := l_manager.new_boolean_preference_value (l_manager, autocomplete_brackets_and_parentheses_string, False)
			autocomplete_quotes_preference := l_manager.new_boolean_preference_value (l_manager, autocomplete_quotes_string, False)
			show_any_features_preference := l_manager.new_boolean_preference_value (l_manager, show_any_features_string, False)
			syntax_complete_enabled_preference := l_manager.new_boolean_preference_value (l_manager, syntax_complete_enabled_string, True)
			auto_auto_complete_preference := l_manager.new_boolean_preference_value (l_manager, auto_auto_complete_string, True)
			auto_complete_words_preference := l_manager.new_boolean_preference_value (l_manager, auto_complete_words_string, True)
			auto_remove_trailing_blank_when_saving_preference := l_manager.new_boolean_preference_value (l_manager, auto_remove_trailing_blank_when_saving_string, True)
			filter_completion_list_preference := l_manager.new_boolean_preference_value (l_manager, filter_completion_list_string, True)
			highlight_matching_braces_preference := l_manager.new_boolean_preference_value (l_manager, highlight_matching_braces_string, True)
			show_completion_signature_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_signature_string, True)
			show_completion_target_class_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_target_class_string, True)
			show_completion_type_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_type_string, True)
			show_completion_disambiguated_name_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_disambiguated_name_string, False)
			show_completion_unicode_symbols_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_unicode_symbols_string, True)
			show_completion_obsolete_items_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_obsolete_items_string, False)
			show_completion_tooltip_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_tooltip_string, True)
			minimum_count_for_unicode_symbols_completion_preference := l_manager.new_integer_preference_value (l_manager, minimum_count_for_unicode_symbols_completion_preference_string, 3)
			customized_string_1_preference := l_manager.new_string_preference_value (l_manager, customized_string_1_string, "")
			customized_strings.extend (customized_string_1_preference)
			customized_string_2_preference := l_manager.new_string_preference_value (l_manager, customized_string_2_string, "")
			customized_strings.extend (customized_string_2_preference)
			customized_string_3_preference := l_manager.new_string_preference_value (l_manager, customized_string_3_string, "")
			customized_strings.extend (customized_string_3_preference)
			new_tab_at_left_preference := l_manager.new_boolean_preference_value (l_manager, new_tab_at_left_string, False)
			auto_show_feature_contract_tooltips_preference := l_manager.new_boolean_preference_value (l_manager, auto_show_feature_contract_tooltips_string, True)

				-- Auto colors
			generic_background_color_preference.set_auto_preference (normal_background_color_preference)
			class_background_color_preference.set_auto_preference (normal_background_color_preference)
			feature_background_color_preference.set_auto_preference (normal_background_color_preference)
			cluster_background_color_preference.set_auto_preference (normal_background_color_preference)
			error_background_color_preference.set_auto_preference (normal_background_color_preference)
			object_background_color_preference.set_auto_preference (normal_background_color_preference)
			target_background_color_preference.set_auto_preference (normal_background_color_preference)
			folder_background_color_preference.set_auto_preference (normal_background_color_preference)
			argument_background_color_preference.set_auto_preference (normal_background_color_preference)
			warning_background_color_preference.set_auto_preference (normal_background_color_preference)
			note_tag_background_color_preference.set_auto_preference (normal_background_color_preference)
			assertion_tag_background_color_preference.set_auto_preference (normal_background_color_preference)
			reserved_background_color_preference.set_auto_preference (normal_background_color_preference)
			local_background_color_preference.set_auto_preference (normal_background_color_preference)

			keyword_font_preference.change_actions.extend (agent update)
			normal_text_color_preference.change_actions.extend (agent update)
			normal_background_color_preference.change_actions.extend (agent update)
			selection_text_color_preference.change_actions.extend (agent update)
			selection_background_color_preference.change_actions.extend (agent update)
			focus_out_selection_background_color_preference.change_actions.extend (agent update)
			string_text_color_preference.change_actions.extend (agent update)
			string_background_color_preference.change_actions.extend (agent update)
			keyword_text_color_preference.change_actions.extend (agent update)
			keyword_background_color_preference.change_actions.extend (agent update)
			spaces_text_color_preference.change_actions.extend (agent update)
			spaces_background_color_preference.change_actions.extend (agent update)
			comments_text_color_preference.change_actions.extend (agent update)
			comments_background_color_preference.change_actions.extend (agent update)
			number_text_color_preference.change_actions.extend (agent update)
			number_background_color_preference.change_actions.extend (agent update)
			operator_text_color_preference.change_actions.extend (agent update)
			operator_background_color_preference.change_actions.extend (agent update)
			breakpoint_background_color_preference.change_actions.extend (agent update)
			assertion_tag_text_color_preference.change_actions.extend (agent update)
			assertion_tag_background_color_preference.change_actions.extend (agent update)
			note_tag_text_color_preference.change_actions.extend (agent update)
			note_tag_background_color_preference.change_actions.extend (agent update)
			reserved_text_color_preference.change_actions.extend (agent update)
			reserved_background_color_preference.change_actions.extend (agent update)
			generic_text_color_preference.change_actions.extend (agent update)
			generic_background_color_preference.change_actions.extend (agent update)
			local_text_color_preference.change_actions.extend (agent update)
			local_background_color_preference.change_actions.extend (agent update)
			class_text_color_preference.change_actions.extend (agent update)
			class_background_color_preference.change_actions.extend (agent update)
			feature_text_color_preference.change_actions.extend (agent update)
			feature_background_color_preference.change_actions.extend (agent update)
			cluster_text_color_preference.change_actions.extend (agent update)
			cluster_background_color_preference.change_actions.extend (agent update)
			error_text_color_preference.change_actions.extend (agent update)
			error_background_color_preference.change_actions.extend (agent update)
			object_text_color_preference.change_actions.extend (agent update)
			object_background_color_preference.change_actions.extend (agent update)
			smart_indentation_preference.change_actions.extend (agent update)
			underscore_is_separator_preference.change_actions.extend (agent update)
			once_and_constant_in_upper_preference.change_actions.extend (agent update)
			autocomplete_brackets_and_parentheses_preference.change_actions.extend (agent update)
			autocomplete_quotes_preference.change_actions.extend (agent update)
			show_any_features_preference.change_actions.extend (agent update)
			syntax_complete_enabled_preference.change_actions.extend (agent update)
			quadruple_click_enabled_preference.change_actions.extend (agent update)
			auto_auto_complete_preference.change_actions.extend (agent update)
			auto_complete_words_preference.change_actions.extend (agent update)
			auto_remove_trailing_blank_when_saving_preference.change_actions.extend (agent update)
			filter_completion_list_preference.change_actions.extend (agent update)
			show_completion_signature_preference.change_actions.extend (agent update)
			show_completion_target_class_preference.change_actions.extend (agent update)
			show_completion_type_preference.change_actions.extend (agent update)
			show_completion_disambiguated_name_preference.change_actions.extend (agent update)
			show_completion_unicode_symbols_preference.change_actions.extend (agent update)
			show_completion_obsolete_items_preference.change_actions.extend (agent update)
			show_completion_tooltip_preference.change_actions.extend (agent update)
			customized_string_1_preference.change_actions.extend (agent update)
			customized_string_2_preference.change_actions.extend (agent update)
			customized_string_3_preference.change_actions.extend (agent update)
			new_tab_at_left_preference.change_actions.extend (agent update)
			normal_text_color_preference.change_actions.extend (agent update)
			warning_text_color_preference.change_actions.extend (agent update)
			warning_background_color_preference.change_actions.extend (agent update)
			argument_text_color_preference.change_actions.extend (agent update)
			argument_background_color_preference.change_actions.extend (agent update)
			folder_text_color_preference.change_actions.extend (agent update)
			folder_background_color_preference.change_actions.extend (agent update)

			initialize_autocomplete_prefs

			default_shortcut_actions := editor_shortcut_actions
			create l_manager.make (preferences, "shortcuts.editor")
			initialize_shortcuts_prefs (l_manager)

			default_shortcut_actions := completion_shortcut_actions
			create l_manager.make (preferences, "shortcuts.code_completion")
			initialize_shortcuts_prefs (l_manager)

				-- Experimental: linked editing
			is_linked_editing_enabled_preference := l_manager.new_boolean_preference_value (l_manager, is_linked_editing_enabled_string, False)
			is_linked_editing_enabled_preference.set_hidden (True)
		end

	initialize_autocomplete_prefs
		local
			i: INTEGER
			id: STRING
			keyword_name: STRING
			l_manager: EB_PREFERENCE_MANAGER
			l_b_pref1, l_b_pref2: BOOLEAN_PREFERENCE
			l_s_pref1, l_s_pref2, l_s_pref3, l_s_pref4: STRING_PREFERENCE
			l_par_name,
			l_child_name: STRING
			a_list: ARRAYED_LIST [STRING]
		do
			from
				create autocomplete_prefs.make (40)
				complete_keywords_names_keys.start
			until
				complete_keywords_names_keys.after
			loop
				l_par_name := "editor.eiffel.autocomplete." + complete_keywords_names_keys.item
				create l_manager.make (preferences, l_par_name)
				a_list := complete_keywords_names.item (complete_keywords_names_keys.item)
				from
					a_list.start
				until
					a_list.after
				loop
					i := i + 1
					keyword_name := a_list.item
					if keyword_name.has (' ') then
						keyword_name := keyword_name.twin
						keyword_name.replace_substring_all (" ", "_")
					end
					id := l_par_name + "." + keyword_name
					l_child_name := id.twin

					id := l_child_name + ".autocomplete_" + keyword_name
					l_b_pref1 := l_manager.new_boolean_preference_value (l_manager, id, True)

					id := l_child_name + ".use_default_" + keyword_name
					l_b_pref2 := l_manager.new_boolean_preference_value (l_manager, id, True)

					id := l_child_name + ".custom_" + keyword_name + "_space"
					l_s_pref1 := l_manager.new_string_preference_value (l_manager, id, "")
					l_s_pref1.change_actions.extend (agent update)

					id := l_child_name + ".custom_" + keyword_name + "_return"
					l_s_pref2 := l_manager.new_string_preference_value (l_manager, id, "")
					l_s_pref2.change_actions.extend (agent update)

					id := l_child_name + ".custom_" + keyword_name + "_space_later"
					l_s_pref3 := l_manager.new_string_preference_value (l_manager, id, "")
					l_s_pref3.change_actions.extend (agent update)

					id := l_child_name + ".custom_" + keyword_name + "_return_later"
					l_s_pref4 := l_manager.new_string_preference_value (l_manager, id, "")
					l_s_pref4.change_actions.extend (agent update)

					autocomplete_prefs.force ([l_b_pref1, l_b_pref2, l_s_pref1, l_s_pref2, l_s_pref3, l_s_pref4], keyword_name)

					a_list.forth
				end
				complete_keywords_names_keys.forth
			end
		end

	initialize_fixed_shortcuts
			-- Initialize fixed shortcuts in relative shortcuts.
			-- Fixed shortcuts can not be overridden by normal shortcuts.
		do
			indention_shortcut.set_group (main_window_group)
			unindention_shortcut.set_group (main_window_group)
			editor_cut_shortcut.set_group (main_window_group)
			editor_copy_shortcut.set_group (main_window_group)
			editor_paste_shortcut.set_group (main_window_group)
			editor_select_all_shortcut.set_group (main_window_group)
		end

feature -- Auto-complete Access

	is_keyword_auto_complete (a_keyword: STRING): BOOLEAN
			-- Is auto-complete for `a_keyword' enabled?
		require
			a_keyword_not_void: a_keyword /= Void
		do
			if attached autocomplete_prefs.item (a_keyword.as_lower) as l_prefs then
				Result := l_prefs.autocomplete.value
			end
		end

	keyword_inserts (a_keyword: STRING): TUPLE [custom_space, custom_return, custom_space_later, custom_return_later: STRING]
			-- Default keyword inserts.
		require
			a_keyword_not_void: a_keyword /= Void
		local
			l_keyword: STRING
			l_prefs: TUPLE [autocomplete: BOOLEAN_PREFERENCE;
							use_default: BOOLEAN_PREFERENCE;
							custom_space: STRING_PREFERENCE;
							custom_return: STRING_PREFERENCE;
							custom_space_later: STRING_PREFERENCE;
							custom_return_later: STRING_PREFERENCE]

		do
			l_keyword := a_keyword.as_lower

			l_prefs := autocomplete_prefs.item (l_keyword)
			if not l_prefs.use_default.value then
				Result := [l_prefs.custom_space.value, l_prefs.custom_return.value, l_prefs.custom_return_later.value, l_prefs.custom_return_later.value]
			else
				if attached default_insert.item (a_keyword) as l_def then
					Result := l_def
				end
			end
		end

feature {NONE} -- Auto-complete

	autocomplete_prefs: HASH_TABLE [TUPLE [autocomplete: BOOLEAN_PREFERENCE;
											use_default: BOOLEAN_PREFERENCE;
											custom_space: STRING_PREFERENCE;
											custom_return: STRING_PREFERENCE;
											custom_space_later: STRING_PREFERENCE;
											custom_return_later: STRING_PREFERENCE],
									STRING]
			-- Preferences for all keyword auto-completion.

	default_insert: HASH_TABLE [TUPLE [custom_space, custom_return, custom_space_later, custom_return_later: STRING], STRING]
			-- default strings to be inserted after keywords
		once
			create Result.make (40)
						-- note
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$"], "note")
						-- class
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "class")
						-- inherit
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "inherit")
						-- creation
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "creation")
						-- feature
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$"], "feature")

						-- is
			Result.force ([" $cursor$", "%N$indent$%%T%%T-- $cursor$%N$indent$%T", " $cursor$", "%N$indent$$cursor$"], "is")
						-- require
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "require")
						-- require else
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "require else")
						-- local
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "local")
						-- attribute
			Result.force ([" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "attribute")
						-- do
			Result.force ([" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "do")
						-- once
			Result.force ([" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "once")
						-- deferred
			Result.force ([" end$cursor$", "%N$indent$end$cursor$", " $cursor$", "%N$indent$$cursor$"], "deferred")
						-- external
			Result.force ([" %"$cursor$%" end", "%N$indent$%%T%"$cursor$%"%N$indent$end", " $cursor$", "%N$indent$$cursor$"], "external")
						-- rescue
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "rescue")
						-- ensure
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "ensure")
						-- ensure then
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "ensure then")
						-- alias
			Result.force ([" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$"], "alias")

						-- if
			Result.force ([" $cursor$ then%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "if")
						-- then
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "then")
						-- elseif
			Result.force ([" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$"], "elseif")
						-- else
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "else")
						-- inspect
			Result.force ([" $cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "inspect")
						-- when
			Result.force ([" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$"], "when")
						-- from
			Result.force ([" $cursor$%N$indent$until%N$indent$loop%N$indent$end", "%N$indent$%%T$cursor$%N$indent$until%N$indent$%%T%N$indent$loop%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "from")
						-- variant
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "variant")
						-- until
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "until")
						-- loop
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "loop")
						-- debug
			Result.force ([" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "debug")
						-- check
			Result.force ([" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "check")

						-- rename
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "rename")
						-- redefine
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "redefine")
						-- undefine
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "undefine")
						-- select
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "select")
						-- export
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "export")

						-- Precursor
			Result.force ([" {$cursor$}", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$"], "Precursor")
						-- create
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$"], "create")
						-- obsolete
			Result.force ([" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$"], "obsolete")
						-- invariant
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$"], "invariant")
						-- end
			Result.force ([" $cursor$", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$"], "end")

						-- across
			Result.force ([" $cursor$ as  all  end", "%N$indent$%%T$cursor$ as %N$indent$loop%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$"], "across")
						-- some
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "some")
						-- all
			Result.force ([" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$"], "all")

						-- separate
			Result.force ([" $cursor$", "%N$indent$%T$cursor$ as %N$indent$do%N$indent$%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$ as ,"], "separate")
		end

feature {NONE} -- Keys

	key_with_name (name: STRING): INTEGER
			-- key code corresponding to `name'
		require
			name /= Void
		local
			s1, s2: STRING
			i: INTEGER
			found: BOOLEAN
		do
			if name.is_empty then
				Result := Key_strings.lower - 1
			else
				s1 := name.as_lower
				from
					i := Key_strings.lower
				until
					found or i > Key_strings.upper
				loop
					s2 := Key_strings.item (i).as_lower
					found := s1.is_equal (s2)
					i := i + 1
				end
				if found then
					Result := i - 1
				else
					Result := Key_strings.lower - 1
				end
			end
		end

feature -- Syntax Completion Customization

	completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make (35)
			Result.append (class_completed_keywords)
			Result.append (feature_completed_keywords)
			Result.append (inherit_completed_keywords)
			Result.append (control_completed_keywords)
			Result.append (other_completed_keywords)
			Result.compare_objects
		end

	class_completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make_from_array (<<"note", "class", "inherit", "creation", "feature">>)
			Result.compare_objects
		end

	feature_completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make_from_array (<<"is", "require", "require else", "local", "attribute", "do", "once", "deferred", "external", "rescue", "ensure", "ensure then", "alias">>)
			Result.compare_objects
		end

	inherit_completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make_from_array (<<"rename", "redefine", "undefine", "select", "export">>)
			Result.compare_objects
		end

	control_completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make_from_array (<<"if", "then", "elseif", "else", "inspect", "when", "from", "variant", "until", "loop", "debug", "check", "across", "some", "all", "separate">>)
			Result.compare_objects
		end

	other_completed_keywords: ARRAYED_LIST [STRING]
			-- list of completed keywords
		once
			create Result.make_from_array (<<"precursor", "create", "obsolete", "invariant", "end">>)
			Result.compare_objects
		end

	complete_keywords_names: HASH_TABLE [ARRAYED_LIST[STRING], STRING]
			-- should the corresponding keyword in `completed_keywords' be completed ?
		once
			create Result.make (35)
			Result.put (class_completed_keywords, complete_keywords_names_keys @ 1)
			Result.put (feature_completed_keywords, complete_keywords_names_keys @ 2)
			Result.put (inherit_completed_keywords, complete_keywords_names_keys @ 3)
			Result.put (control_completed_keywords, complete_keywords_names_keys @ 4)
			Result.put (other_completed_keywords, complete_keywords_names_keys @ 5)
		end

	complete_keywords_names_keys: ARRAYED_LIST [STRING]
			-- should the corresponding keyword in `completed_keywords' be completed ?
		once
			create Result.make_from_array (<<"class_structure_keywords", "feature_structure_keywords", "inherit_clauses_keywords", "control_structure_keywords", "other_keywords">>)
		end

feature -- Fixed shortcuts

	indention_shortcut: EB_FIXED_SHORTCUT
			-- Indention shortcut
		once
			create Result.make (names.fs_indent,  create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab), False, False, False)
		end

	unindention_shortcut: EB_FIXED_SHORTCUT
			-- Unindention shortcut
		once
			create Result.make (names.fs_unindent,  create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab), False, False, True)
		end

	editor_cut_shortcut: EB_FIXED_SHORTCUT
			-- Fixed shortcut for Cut.
		once
			create Result.make (names.fs_cut, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_x), False, True, False)
		end

	editor_copy_shortcut: EB_FIXED_SHORTCUT
			-- Fixed shortcut for Copy.
		once
			create Result.make (names.fs_copy, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), False, True, False)
		end

	editor_paste_shortcut: EB_FIXED_SHORTCUT
			-- Fixed shortcut for Paste.
		once
			create Result.make (names.fs_paste, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_v), False, True, False)
		end

	editor_select_all_shortcut: EB_FIXED_SHORTCUT
			-- Fixed shortcut for Select All.
		once
			create Result.make (names.fs_select_all, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), False, True, False)
		end

feature -- Keybord shortcuts Customization

	customized_strings: ARRAYED_LIST [STRING_PREFERENCE]
			--
		once
			create Result.make (3)
		end

	shortcuts: STRING_TABLE [SHORTCUT_PREFERENCE]
			-- Shortcuts
		once
			create Result.make (default_shortcut_actions.count)
		end

	default_shortcut_actions: ARRAYED_LIST [TUPLE [actions: HASH_TABLE [TUPLE [alt: BOOLEAN; ctrl: BOOLEAN; shift: BOOLEAN; key: STRING_8], STRING_8]; group: MANAGED_SHORTCUT_GROUP]]
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString)

	editor_shortcut_actions: ARRAYED_LIST [TUPLE [HASH_TABLE [TUPLE [alt: BOOLEAN; ctrl: BOOLEAN; shift: BOOLEAN; key: STRING_8], STRING_8], MANAGED_SHORTCUT_GROUP]]
			-- Array for shortcut defaults
			-- in tuple, the four elements are: (Alt/Ctrl/Shift/KeyString)
		local
			l_hash: HASH_TABLE [TUPLE [alt: BOOLEAN; ctrl: BOOLEAN; shift: BOOLEAN; key: STRING_8], STRING_8]
		once
			create Result.make (1)

				-- Shortcuts for main window group
			create l_hash.make (16)
			l_hash.put ([False, False, False, key_strings.item (Key_F2).twin.as_string_8], "customized_insertion_1")
			l_hash.put ([False,  True, False, key_strings.item (Key_F2).twin.as_string_8], "customized_insertion_2")
			l_hash.put ([False, False,  True, key_strings.item (Key_F2).twin.as_string_8], "customized_insertion_3")
			l_hash.put ([False, False,  True, key_strings.item (key_F3).twin.as_string_8], "search_backward")
			l_hash.put ([False, False,  False, key_strings.item (key_F3).twin.as_string_8], "search_forward")
			l_hash.put ([False, True, False, key_strings.item (Key_F3).twin.as_string_8], "search_selection_forward")
			l_hash.put ([False, True, True, key_strings.item (Key_F3).twin.as_string_8], "search_selection_backward")

			l_hash.put ([False,  True, False, key_strings.item (Key_f).twin.as_string_8], "show_quick_search_bar")
			l_hash.put ([False,  True, False, key_strings.item (Key_h).twin.as_string_8], "show_search_and_replace_panel")
			l_hash.put ([False,  True, False, key_strings.item (Key_k).twin.as_string_8], "comment")
			l_hash.put ([False,  True, True, key_strings.item (Key_k).twin.as_string_8], "uncomment")
			l_hash.put ([False,  True, True, key_strings.item (Key_p).twin.as_string_8], "prettify")
			l_hash.put ([False,  True, False, key_strings.item (Key_u).twin.as_string_8], "set_to_uppercase")
			l_hash.put ([False,  True, True, key_strings.item (Key_u).twin.as_string_8], "set_to_lowercase")

			l_hash.put ([False,  True, False, key_strings.item (Key_l).twin.as_string_8], "toggle_line_number_visibility")

			l_hash.put ([False,  True, False, key_strings.item (Key_i).twin.as_string_8], "embed_if_clause")
			l_hash.put ([False,  True, False, key_strings.item (Key_d).twin.as_string_8], "embed_debug_clause")

			l_hash.put ([False,  True, False, key_strings.item (key_open_bracket).twin.as_string_8], "find_matching_brace")

			l_hash.put ([False, True, False, key_strings.item (Key_g).twin.as_string_8], "show_goto_dialog")

			l_hash.put ([False,  True, False, key_strings.item (Key_m).twin.as_string_8], "maximize_editor_area")
			l_hash.put ([False,  True, True, key_strings.item (Key_m).twin.as_string_8], "minimize_editor_area")

			l_hash.put ([False,  True, False, key_strings.item (Key_equal).twin.as_string_8], "zoom_in")
			l_hash.put ([False,  True, False, key_strings.item (Key_dash).twin.as_string_8], "zoom_out")

			l_hash.put ([False,  True, False, key_strings.item (key_numpad_add).twin.as_string_8], "zoom_in_numpad")
			l_hash.put ([False,  True, False, key_strings.item (key_numpad_subtract).twin.as_string_8], "zoom_out_numpad")

			l_hash.put ([False,  True, False, key_strings.item (key_0).twin.as_string_8], "zoom_reset")
			l_hash.put ([False,  True, False, key_strings.item (key_numpad_0).twin.as_string_8], "zoom_reset_numpad")

			l_hash.put ([True,  True, False, key_strings.item (key_space).twin.as_string_8], "insert_symbol")

			Result.extend ([l_hash, main_window_group])
		end

	completion_shortcut_actions: ARRAYED_LIST [TUPLE [HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8], MANAGED_SHORTCUT_GROUP]]
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8]
		once
			create Result.make (2)

			create l_hash.make (2)
			l_hash.put ([False,  True, False, key_strings.item (Key_space).twin.as_string_8], "autocomplete")
			l_hash.put ([False,  True,  True, key_strings.item (Key_space).twin.as_string_8], "class_autocomplete")
			Result.extend ([l_hash, main_window_group])

				-- Shortcuts for completion window group
			create l_hash.make (9)
			l_hash.put ([False, False, False, key_strings.item (Key_F1).twin.as_string_8], completion_shortcut_toggle_filter)
			l_hash.put ([False, False, False, key_strings.item (Key_F2).twin.as_string_8], completion_shortcut_toggle_show_type)
			l_hash.put ([False, False, False, key_strings.item (Key_F3).twin.as_string_8], completion_shortcut_toggle_show_signature)
			l_hash.put ([False, False, False, key_strings.item (Key_F4).twin.as_string_8], completion_shortcut_toggle_show_disambiguated_name)
			l_hash.put ([False, False, False, key_strings.item (Key_F8).twin.as_string_8], completion_shortcut_toggle_show_unicode_symbols)
			l_hash.put ([False, False, False, key_strings.item (Key_F5).twin.as_string_8], completion_shortcut_toggle_show_obsolete_items)
			l_hash.put ([False, False, False, key_strings.item (Key_F6).twin.as_string_8], completion_shortcut_toggle_show_tooltip)
			l_hash.put ([False, False, False, key_strings.item (Key_F7).twin.as_string_8], completion_shortcut_toggle_remember_size)
			l_hash.put ([False, True, False, key_strings.item (key_space).twin.as_string_8], completion_shortcut_next_completion_panel)
			Result.extend ([l_hash, completion_window_group])
		end

	completion_shortcut_toggle_filter: STRING = "toggle_filter"
	completion_shortcut_toggle_show_type: STRING = "toggle_show_type"
	completion_shortcut_toggle_show_signature: STRING = "toggle_show_signature"
	completion_shortcut_toggle_show_disambiguated_name: STRING = "toggle_show_disambiguated_name"
	completion_shortcut_toggle_show_unicode_symbols: STRING = "toggle_show_unicode_symbols"
	completion_shortcut_toggle_show_obsolete_items: STRING = "toggle_show_obsolete_items"
	completion_shortcut_toggle_show_tooltip: STRING = "toggle_show_tooltip"
	completion_shortcut_toggle_remember_size: STRING = "toggle_remember_size"
	completion_shortcut_next_completion_panel: STRING = "next_completion_panel"


invariant
	preferences_not_void: preferences /= Void
	post_update_actions_not_void: post_update_actions /= Void
	keyword_font_preference_not_void: keyword_font_preference /= Void
	editor_font_zoom_factor_preference: font_zoom_factor_preference /= Void
	smart_indentation_preference_not_void: smart_indentation_preference /= Void
	normal_text_color_preference_not_void: normal_text_color_preference /= Void
	normal_background_color_preference_not_void: normal_background_color_preference /= Void
	selection_text_color_preference_not_void: selection_text_color_preference /= Void
	selection_background_color_preference_not_void: selection_background_color_preference /= Void
	string_text_color_preference_not_void: string_text_color_preference /= Void
	string_background_color_preference_not_void: string_background_color_preference /= Void
	keyword_text_color_preference_not_void: keyword_text_color_preference /= Void
	keyword_background_color_preference_not_void: keyword_background_color_preference /= Void
	spaces_text_color_preference_not_void: spaces_text_color_preference /= Void
	spaces_background_color_preference_not_void: spaces_background_color_preference /= Void
	comments_text_color_preference_not_void: comments_text_color_preference /= Void
	comments_background_color_preference_not_void: comments_background_color_preference /= Void
	number_text_color_preference_not_void: number_text_color_preference /= Void
	number_background_color_preference_not_void: number_background_color_preference /= Void
	operator_text_color_preference_not_void: operator_text_color_preference /= Void
	operator_background_color_preference_not_void: operator_background_color_preference /= Void
	breakpoint_background_color_preference_not_void: breakpoint_background_color_preference /= Void
	assertion_tag_text_color_preference_not_void: assertion_tag_text_color_preference /= Void
	assertion_tag_background_color_preference_not_void: assertion_tag_background_color_preference /= Void
	note_tag_text_color_preference_not_void: note_tag_text_color_preference /= Void
	note_tag_background_color_preference_not_void: note_tag_background_color_preference /= Void
	reserved_text_color_preference_not_void: reserved_text_color_preference /= Void
	reserved_background_color_preference_not_void: reserved_background_color_preference /= Void
	generic_text_color_preference_not_void: generic_text_color_preference /= Void
	generic_background_color_preference_not_void: generic_background_color_preference /= Void
	local_text_color_preference_not_void: local_text_color_preference /= Void
	local_background_color_preference_not_void: local_background_color_preference /= Void
	class_text_color_preference_not_void: class_text_color_preference /= Void
	class_background_color_preference_not_void: class_background_color_preference /= Void
	feature_text_color_preference_not_void: feature_text_color_preference /= Void
	feature_background_color_preference_not_void: feature_background_color_preference /= Void
	cluster_text_color_preference_not_void: cluster_text_color_preference /= Void
	cluster_background_color_preference_not_void: cluster_background_color_preference /= Void
	error_text_color_preference_not_void: error_text_color_preference /= Void
	error_background_color_preference_not_void: error_background_color_preference /= Void
	object_text_color_preference_not_void: object_text_color_preference /= Void
	object_background_color_preference_not_void: object_background_color_preference /= Void
	once_and_constant_in_upper_preference_not_void: once_and_constant_in_upper_preference /= Void
	underscore_is_separator_preference_not_void: underscore_is_separator_preference /= Void
	autocomplete_brackets_and_parentheses_preference_not_void: autocomplete_brackets_and_parentheses_preference /= Void
	autocomplete_quotes_preference_not_void: autocomplete_quotes_preference /= Void
	show_any_features_preference_not_void: show_any_features_preference /= Void
	auto_auto_complete_preference_not_void: auto_auto_complete_preference /= Void
	auto_complete_words_preference_not_void: auto_complete_words_preference /= Void
	auto_remove_trailing_blank_when_saving_preference_not_void: auto_remove_trailing_blank_when_saving_preference /= Void
	filter_completion_list_preference_not_void: filter_completion_list_preference /= Void
	show_completion_signature_preference_not_void: show_completion_signature_preference /= Void
	show_completion_target_class_preference_not_void: show_completion_target_class_preference /= Void
	show_completion_type_preference_not_void: show_completion_type_preference /= Void
	show_completion_disambiguated_name_preference_not_void: show_completion_disambiguated_name_preference /= Void
	show_completion_unicode_symbols_preference_not_void: show_completion_unicode_symbols_preference /= Void
	show_completion_obsolete_items_preference_not_void: show_completion_obsolete_items_preference /= Void
	show_completion_tooltip_string_attached: show_completion_tooltip_string /= Void
	minimum_count_for_unicode_symbols_completion_preference_not_void: minimum_count_for_unicode_symbols_completion_preference /= Void
	syntax_complete_enabled_preference_not_void: syntax_complete_enabled_preference /= Void
	customized_string_1_preference_not_void: customized_string_1_preference /= Void
	customized_string_2_preference_not_void: customized_string_2_preference /= Void
	customized_string_3_preference_not_void: customized_string_3_preference /= Void
	warning_text_color_preference_attached: warning_text_color_preference /= Void
	warning_background_color_preference_attached: warning_background_color_preference /= Void
	argument_text_color_preference_attached: argument_text_color_preference /= Void
	argument_background_color_preference_attached: argument_background_color_preference /= Void
	highlight_matching_braces_preference_attached: highlight_matching_braces_preference /= Void
	auto_show_feature_contract_tooltips_preference_attached: auto_show_feature_contract_tooltips_preference /= Void
	is_linked_editing_enabled_preference_attached: is_linked_editing_enabled_preference /= Void


note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_EDITOR_DATA


