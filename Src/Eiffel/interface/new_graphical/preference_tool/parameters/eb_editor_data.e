indexing
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
			init_fonts
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

	make (a_preferences: PREFERENCES) is
			-- Create
		do
			Precursor {EDITOR_DATA} (a_preferences)
		end

feature -- Value

	breakpoint_background_color: EV_COLOR is
			-- Background color used to display breakpoints		
		do
			Result := breakpoint_background_color_preference.value
		end

	assertion_tag_text_color: EV_COLOR is
		do
			Result := assertion_tag_text_color_preference.value
		end

	assertion_tag_background_color: EV_COLOR is
		do
			Result := assertion_tag_background_color_preference.value
		end

	indexing_tag_text_color: EV_COLOR is
		do
			Result := indexing_tag_text_color_preference.value
		end

	indexing_tag_background_color: EV_COLOR is
		do
			Result := indexing_tag_background_color_preference.value
		end

	reserved_text_color: EV_COLOR is
		do
			Result := reserved_text_color_preference.value
		end

	reserved_background_color: EV_COLOR is
		do
			Result := reserved_background_color_preference.value
		end

	generic_text_color: EV_COLOR is
		do
			Result := generic_text_color_preference.value
		end

	generic_background_color: EV_COLOR is
		do
			Result := generic_background_color_preference.value
		end

	local_text_color: EV_COLOR is
		do
			Result := local_text_color_preference.value
		end

	local_background_color: EV_COLOR is
		do
			Result := local_background_color_preference.value
		end

	class_text_color: EV_COLOR is
		do
			Result := class_text_color_preference.value
		end

	class_background_color: EV_COLOR is
		do
			Result := class_background_color_preference.value
		end

	feature_text_color: EV_COLOR is
		do
			Result := feature_text_color_preference.value
		end

	feature_background_color: EV_COLOR is
		do
			Result := feature_background_color_preference.value
		end

	target_text_color: EV_COLOR is
		do
			Result := target_text_color_preference.value
		end

	target_background_color: EV_COLOR is
		do
			Result := target_background_color_preference.value
		end

	cluster_text_color: EV_COLOR is
		do
			Result := cluster_text_color_preference.value
		end

	cluster_background_color: EV_COLOR is
		do
			Result := cluster_background_color_preference.value
		end

	error_text_color: EV_COLOR is
		do
			Result := error_text_color_preference.value
		end

	error_background_color: EV_COLOR is
		do
			Result := error_background_color_preference.value
		end

	object_text_color: EV_COLOR is
		do
			Result := object_text_color_preference.value
		end

	object_background_color: EV_COLOR is
		do
			Result := object_background_color_preference.value
		end

	once_and_constant_in_upper: BOOLEAN is
			-- Is first letter of once or constant in upper case?
		do
			Result := once_and_constant_in_upper_preference.value
		end

	underscore_is_separator: BOOLEAN is
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)
		do
			Result := underscore_is_separator_preference.value
		end

	autocomplete_brackets_and_parentheses: BOOLEAN is
			-- Should we close the brackets and parentheses automatically?
		do
			Result := autocomplete_brackets_and_parentheses_preference.value
		end

	autocomplete_quotes: BOOLEAN is
			-- Should we close the quotes automatically?
		do
			Result := autocomplete_quotes_preference.value
		end

	show_any_features: BOOLEAN is
			-- Should autocomplete show features inherited from any ?
		do
			Result := show_any_features_preference.value
		end

	auto_auto_complete: BOOLEAN is
			-- Should completion window show automatically after valid '.' calls?
		do
			Result := auto_auto_complete_preference.value
		end

	auto_complete_words: BOOLEAN is
			-- Should completion automatically complete words when a single best match is available?
		do
			Result := auto_complete_words_preference.value
		end

	auto_remove_trailing_blank_when_saving: BOOLEAN is
			-- Should trailing blanks be auto-removed when saving?
		do
			Result := auto_remove_trailing_blank_when_saving_preference.value
		end

	filter_completion_list: BOOLEAN is
			-- Indicates if completion list matches should be filtered down based on current matches.  If not then
			-- the list will always contain possible completion options and closest match will be selected during typing.
		do
			Result := filter_completion_list_preference.value
		end

	show_completion_signature: BOOLEAN is
			-- Should feature signature be shown in completion list?
		do
			Result := show_completion_signature_preference.value
		end

	show_completion_type: BOOLEAN is
			-- Should feature type be shown in completion list?
		do
			Result := show_completion_type_preference.value
		end

	show_completion_disambiguated_name: BOOLEAN is
			-- Should disambiguated name be shown in completion list?
		do
			Result := show_completion_disambiguated_name_preference.value
		end

	show_completion_obsolete_items: BOOLEAN is
			-- Should obsolete items be shown in completion list?
		do
			Result := show_completion_obsolete_items_preference.value
		end

	syntax_complete_enabled: BOOLEAN is
			-- should main keywords be completed ?
		do
			Result := syntax_complete_enabled_preference.value
		end

	customized_string_1: STRING is
			-- strings defined by the user.
		do
			Result := customized_string_1_preference.value
		end

	customized_string_2: STRING is
			-- strings defined by the user.
		do
			Result := customized_string_2_preference.value
		end

	customized_string_3: STRING is
			-- strings defined by the user.
		do
			Result := customized_string_3_preference.value
		end

	new_tab_at_left: BOOLEAN is
			-- When creating new tab, should added it at the begin of the target notebook?
		do
			Result := new_tab_at_left_preference.value
		end

	left_side: BOOLEAN

	maximized: BOOLEAN

	warning_text_color: EV_COLOR is
			-- Warning text color
		do
			Result := warning_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	warning_background_color: EV_COLOR is
			-- Warning background color
		do
			Result := warning_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	argument_text_color: EV_COLOR is
			-- Argument text color
		do
			Result := argument_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	argument_background_color: EV_COLOR is
			-- Argument background color
		do
			Result := argument_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	folder_text_color: EV_COLOR is
			-- Folder text color
		do
			Result := folder_text_color_preference.value
		ensure
			result_attached: Result /= Void
		end

	folder_background_color: EV_COLOR is
			-- Folder background color
		do
			Result := folder_background_color_preference.value
		ensure
			result_attached: Result /= Void
		end

feature -- Preference

	breakpoint_background_color_preference: COLOR_PREFERENCE
			-- Background color used to display breakpoints		

	assertion_tag_text_color_preference: COLOR_PREFERENCE
	assertion_tag_background_color_preference: COLOR_PREFERENCE
	indexing_tag_text_color_preference: COLOR_PREFERENCE
	indexing_tag_background_color_preference: COLOR_PREFERENCE
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

	show_completion_signature_preference: BOOLEAN_PREFERENCE
			-- Should feature signature be shown in completion list?

	show_completion_type_preference: BOOLEAN_PREFERENCE
			-- Should feature type be shown in completion list?

	show_completion_disambiguated_name_preference: BOOLEAN_PREFERENCE
			-- Should disambiguated name be shown in completion list?

	show_completion_obsolete_items_preference: BOOLEAN_PREFERENCE
			-- Should obsolete items be shown in completion list?

	syntax_complete_enabled_preference: BOOLEAN_PREFERENCE
			-- should main keywords be completed ?

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

feature {NONE} -- Preference Strings

	assertion_tag_text_color_string: STRING is "editor.eiffel.colors.assertion_tag_text_color"
	assertion_tag_background_color_string: STRING is "editor.eiffel.colors.assertion_tag_background_color"
	indexing_tag_text_color_string: STRING is "editor.eiffel.colors.indexing_tag_text_color"
	indexing_tag_background_color_string: STRING is "editor.eiffel.colors.indexing_tag_background_color"
	reserved_text_color_string: STRING is "editor.eiffel.colors.reserved_text_color"
	reserved_background_color_string: STRING is "editor.eiffel.colors.reserved_background_color"
	generic_text_color_string: STRING is "editor.eiffel.colors.generic_text_color"
	generic_background_color_string: STRING is "editor.eiffel.colors.generic_background_color"
	local_text_color_string: STRING is "editor.eiffel.colors.local_text_color"
	local_background_color_string: STRING is "editor.eiffel.colors.local_background_color"
	class_text_color_string: STRING is "editor.eiffel.colors.class_text_color"
	class_background_color_string: STRING is "editor.eiffel.colors.class_background_color"
	feature_text_color_string: STRING is "editor.eiffel.colors.feature_text_color"
	feature_background_color_string: STRING is "editor.eiffel.colors.feature_background_color"
	cluster_text_color_string :STRING is "editor.eiffel.colors.cluster_text_color"
	cluster_background_color_string: STRING is "editor.eiffel.colors.cluster_background_color"
	error_text_color_string : STRING is "editor.eiffel.colors.error_text_color"
	error_background_color_string: STRING is "editor.eiffel.colors.error_background_color"
	object_text_color_string: STRING is "editor.eiffel.colors.object_text_color"
	object_background_color_string: STRING is "editor.eiffel.colors.object_background_color"
	breakpoint_background_color_string: STRING is "editor.eiffel.colors.breakpoint_background_color"
	target_text_color_string: STRING is "editor.eiffel.colors.target_text_color"
	target_background_color_string: STRING is "editor.eiffel.colors.target_text_background_color"
	warning_text_color_string: STRING is "editor.eiffel.colors.warning_text_color"
	warning_background_color_string: STRING is "editor.eiffel.colors.warning_background_color"
	line_text_color_string: STRING is "editor.eiffel.colors.line_text_color"
	line_background_color_string: STRING is "editor.eiffel.colors.line_background_color"
	argument_text_color_string: STRING is "editor.eiffel.colors.argument_text_color"
	argument_background_color_string: STRING is "editor.eiffel.colors.argument_background_color"
	folder_text_color_string: STRING is "editor.eiffel.colors.folder_text_color"
	folder_background_color_string: STRING is "editor.eiffel.colors.folder_background_color"

	once_and_constant_in_upper_string: STRING is "editor.eiffel.once_and_constant_in_upper"
			-- Is first letter of once or constant in upper case?

	underscore_is_separator_string: STRING is "editor.eiffel.underscore_is_separator"
			-- Should '_' be considered a word separator (used for word by word
			-- moves and selection)

	autocomplete_brackets_and_parentheses_string: STRING is "editor.eiffel.auto-complete_brackets_and_parentheses"
			-- Should we close the brackets and parentheses automatically?

	autocomplete_quotes_string: STRING is "editor.eiffel.auto-complete_quotes"
			-- Should we close the quotes automatically?

	show_any_features_string: STRING is "editor.eiffel.show_ANY_features"
			-- Should autocomplete show features inherited from any ?

	auto_auto_complete_string: STRING is "editor.eiffel.auto_auto-complete"
			-- Should completion window show automatically after valid '.' calls?

	auto_complete_words_string: STRING is "editor.eiffel.auto_complete_words"
			-- Should completion automatically complete words when a single best match is available?

	auto_remove_trailing_blank_when_saving_string: STRING is "editor.eiffel.auto_remove_trailing_blank_when_saving"
			-- Should trailing blanks be auto-removed when saving?

	filter_completion_list_string: STRING is "editor.eiffel.filter_completion_list"
			-- Indicates if completion list matches should be filtered down based on current matches.  If not then
			-- the list will always contain possible completion options and closest match will be selected during typing.

	show_completion_signature_string: STRING is "editor.eiffel.show_completion_signature"
			-- Should feature signature be shown in completion list?

	show_completion_type_string: STRING is "editor.eiffel.show_completion_type"
			-- Should feature type be shown in completion list?

	show_completion_disambiguated_name_string: STRING is "editor.eiffel.show_completion_disambiguated_name"
			-- Should disambiguated name be shown in completion list?

	show_completion_obsolete_items_string: STRING = "editor.eiffel.show_obsolete_items"
			-- Should obsolete items be shown in completion list?

	syntax_complete_enabled_string: STRING is "editor.eiffel.syntax_complete_enabled"
			-- should main keywords be completed ?

	customized_string_1_string: STRING is "editor.eiffel.customized_string_1"
	customized_string_2_string: STRING is "editor.eiffel.customized_string_2"
	customized_string_3_string: STRING is "editor.eiffel.customized_string_3"
			-- strings defined by the user.

	new_tab_at_left_string: STRING is "editor.general.new_tab_at_left"
			-- Create new tab at left side of the target notebook?

feature {NONE} -- Init colors and fonts.

	init_colors is
			-- Initialize colors.
		do
			Precursor
			colors.put (breakpoint_background_color_preference.value, breakpoint_background_color_id)
			colors.put (assertion_tag_text_color_preference.value, assertion_tag_text_color_id)
			colors.put (assertion_tag_background_color_preference.value, assertion_tag_background_color_id)
			colors.put (indexing_tag_text_color_preference.value, indexing_tag_text_color_id)
			colors.put (indexing_tag_background_color_preference.value, indexing_tag_background_color_id)
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

	init_fonts is
			-- <Precursor>
		do
			Precursor
		end

feature -- Update

	update is
			-- The preferences have changed.
		do
			init_colors
			window_manager.quick_refresh_all_editors
			Precursor {EB_SHORTCUTS_DATA}
		end

feature {NONE} -- Initialization

	initialize_preferences is
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
			indexing_tag_text_color_preference := l_manager.new_color_preference_value (l_manager, indexing_tag_text_color_string, create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			indexing_tag_background_color_preference := l_manager.new_color_preference_value (l_manager, indexing_tag_background_color_string, create {EV_COLOR}.make_with_8_bit_rgb (255, 255, 255))
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
			show_completion_signature_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_signature_string, True)
			show_completion_type_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_type_string, True)
			show_completion_disambiguated_name_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_disambiguated_name_string, False)
			show_completion_obsolete_items_preference := l_manager.new_boolean_preference_value (l_manager, show_completion_obsolete_items_string, False)
			customized_string_1_preference := l_manager.new_string_preference_value (l_manager, customized_string_1_string, "")
			customized_strings.extend (customized_string_1_preference)
			customized_string_2_preference := l_manager.new_string_preference_value (l_manager, customized_string_2_string, "")
			customized_strings.extend (customized_string_2_preference)
			customized_string_3_preference := l_manager.new_string_preference_value (l_manager, customized_string_3_string, "")
			customized_strings.extend (customized_string_3_preference)
			new_tab_at_left_preference := l_manager.new_boolean_preference_value (l_manager, new_tab_at_left_string, True)

				-- Auto colors
			indexing_tag_background_color_preference.set_auto_preference (normal_background_color_preference)
			assertion_tag_background_color_preference.set_auto_preference (normal_background_color_preference)
			reserved_background_color_preference.set_auto_preference (normal_background_color_preference)
			local_background_color_preference.set_auto_preference (normal_background_color_preference)

			keyword_font_preference.change_actions.extend (agent update)
			font_zoom_factor_preference.change_actions.extend (agent update_font)
			normal_text_color_preference.change_actions.extend (agent update)
			normal_background_color_preference.change_actions.extend (agent update)
			selection_text_color_preference.change_actions.extend (agent update)
			selection_background_color_preference.change_actions.extend (agent update)
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
			indexing_tag_text_color_preference.change_actions.extend (agent update)
			indexing_tag_background_color_preference.change_actions.extend (agent update)
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
			show_completion_type_preference.change_actions.extend (agent update)
			show_completion_disambiguated_name_preference.change_actions.extend (agent update)
			show_completion_obsolete_items_preference.change_actions.extend (agent update)
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
		end

	initialize_autocomplete_prefs is
		local
			i: INTEGER
			id: STRING
			cnt: INTEGER
			insert: ARRAY [STRING]
			keyword_name: STRING
			l_manager: EB_PREFERENCE_MANAGER
			l_b_pref: BOOLEAN_PREFERENCE
			l_s_pref: STRING_PREFERENCE
			l_par_name,
			l_child_name: STRING
			a_list: ARRAYED_LIST [STRING]
		do
			from
				create complete_keywords.make (1, 39)
				create insert_after_keyword.make (1, 39)
				cnt := complete_keywords.count
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
					l_b_pref := l_manager.new_boolean_preference_value (l_manager, id, True)
					id := l_child_name + ".use_default_" + keyword_name
					l_b_pref := l_manager.new_boolean_preference_value (l_manager, id, True)

					complete_keywords.put (l_b_pref.value, i)

					if l_b_pref.value then
						insert_after_keyword.put (default_insert @ i, i)

						create insert.make (1, 4)
						id := l_child_name + ".custom_" + keyword_name + "_space"
						l_s_pref := l_manager.new_string_preference_value (l_manager, id, "")
						l_s_pref.change_actions.extend (agent update)
						insert.put (l_s_pref.value, 1)
						id := l_child_name + ".custom_" + keyword_name + "_return"
						l_s_pref := l_manager.new_string_preference_value (l_manager, id, "")
						l_s_pref.change_actions.extend (agent update)
						insert.put (l_s_pref.value, 2)
						id := l_child_name + ".custom_" + keyword_name + "_space_later"
						l_s_pref := l_manager.new_string_preference_value (l_manager, id, "")
						l_s_pref.change_actions.extend (agent update)
						insert.put (l_s_pref.value, 3)
						id := l_child_name + ".custom_" + keyword_name + "_return_later"
						l_s_pref := l_manager.new_string_preference_value (l_manager, id, "")
						l_s_pref.change_actions.extend (agent update)
						insert.put (l_s_pref.value, 4)
						insert_after_keyword.put (insert, i)
					end
					a_list.forth
				end
				complete_keywords_names_keys.forth
			end
		end

	initialize_fixed_shortcuts is
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

feature {NONE} -- Build preferences for autocomplete

	default_insert: ARRAY [ARRAY [STRING]] is
			-- default strings to be inserted after keywords
		once
			Result := <<
						-- indexing
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- class
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- inherit
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- creation
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- feature
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,

						-- is
					<<" $cursor$", "%N$indent$%%T%%T-- $cursor$%N$indent$%T", " $cursor$", "%N$indent$$cursor$">>,
						-- require
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- require else
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- local
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- do
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- once
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- deferred
					<<" end$cursor$", "%N$indent$end$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- external
					<<" %"$cursor$%" end", "%N$indent$%%T%"$cursor$%"%N$indent$end", " $cursor$", "%N$indent$$cursor$">>,
						-- rescue
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- ensure
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- ensure then
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- alias
					<<" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$">>,

						-- if
					<<" $cursor$ then%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- then
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- elseif
					<<" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$">>,
						-- else
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- inspect
					<<" $cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", "%N$indent$%%T$cursor$%N$indent$when  then%N$indent$%%T%N$indent$else%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- when
					<<" $cursor$ then%N$indent$%%T", "%N$indent$%%T$cursor$%N$indent$then%N$indent$%%T", " $cursor$", "%N$indent$%T$cursor$">>,
						-- from
					<<" $cursor$%N$indent$until%N$indent$loop%N$indent$end", "%N$indent$%%T$cursor$%N$indent$until%N$indent$%%T%N$indent$loop%N$indent$%%T%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- variant
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- until
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- loop
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- debug
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,
						-- check
					<<" $cursor$ end", "%N$indent$%%T$cursor$%N$indent$end", " $cursor$", "%N$indent$%T$cursor$">>,

						-- rename
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- redefine
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- undefine
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- select
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,
						-- export
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$%T$cursor$">>,

						-- Precursor
					<<" {$cursor$}", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- create
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- obsolete
					<<" %"$cursor$%"", "%N$indent$%%T%"$cursor$%"", " $cursor$", "%N$indent$$cursor$">>,
						-- invariant
					<<" $cursor$", "%N$indent$%%T$cursor$", " $cursor$", "%N$indent$$cursor$">>,
						-- end
					<<" $cursor$", "%N$indent$$cursor$", " $cursor$", "%N$indent$$cursor$">>

				>>
		end

	key_with_name (name: STRING): INTEGER is
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

	completed_keywords: ARRAYED_LIST [STRING] is
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

	class_completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		once
			create Result.make_from_array (<<"indexing", "class", "inherit", "creation", "feature">>)
			Result.compare_objects
		end

	feature_completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		once
			create Result.make_from_array (<<"is", "require", "require else", "local", "do", "once", "deferred", "external", "rescue", "ensure", "ensure then", "alias">>)
			Result.compare_objects
		end

	inherit_completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		once
			create Result.make_from_array (<<"rename", "redefine", "undefine", "select", "export">>)
			Result.compare_objects
		end

	control_completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		once
			create Result.make_from_array (<<"if", "then", "elseif", "else", "inspect", "when", "from", "variant", "until", "loop", "debug", "check">>)
			Result.compare_objects
		end

	other_completed_keywords: ARRAYED_LIST [STRING] is
			-- list of completed keywords
		once
			create Result.make_from_array (<<"precursor", "create", "obsolete", "invariant", "end">>)
			Result.compare_objects
		end

	complete_keywords: ARRAY [BOOLEAN]
			-- should the corresponding keyword in `completed_keywords' be completed ?

	insert_after_keyword: ARRAY [ARRAY[STRING]]
			-- strings to be inserted after keywords

	complete_keywords_names: HASH_TABLE [ARRAYED_LIST[STRING], STRING] is
			-- should the corresponding keyword in `completed_keywords' be completed ?
		once
			create Result.make (35)
			Result.put (class_completed_keywords, complete_keywords_names_keys @ 1)
			Result.put (feature_completed_keywords, complete_keywords_names_keys @ 2)
			Result.put (inherit_completed_keywords, complete_keywords_names_keys @ 3)
			Result.put (control_completed_keywords, complete_keywords_names_keys @ 4)
			Result.put (other_completed_keywords, complete_keywords_names_keys @ 5)
		end

	complete_keywords_names_keys: ARRAYED_LIST [STRING] is
			-- should the corresponding keyword in `completed_keywords' be completed ?
		once
			create Result.make_from_array (<<"class_structure_keywords", "feature_structure_keywords", "inherit_clauses_keywords", "control_structure_keywords", "other_keywords">>)
		end

feature -- Fixed shortcuts

	indention_shortcut: EB_FIXED_SHORTCUT is
			-- Indention shortcut
		once
			create Result.make (names.fs_indent,  create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab), False, False, False)
		end

	unindention_shortcut: EB_FIXED_SHORTCUT is
			-- Unindention shortcut
		once
			create Result.make (names.fs_unindent,  create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab), False, False, True)
		end

	editor_cut_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for Cut.
		once
			create Result.make (names.fs_cut, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_x), False, True, False)
		end

	editor_copy_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for Copy.
		once
			create Result.make (names.fs_copy, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), False, True, False)
		end

	editor_paste_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for Paste.
		once
			create Result.make (names.fs_paste, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_v), False, True, False)
		end

	editor_select_all_shortcut: EB_FIXED_SHORTCUT is
			-- Fixed shortcut for Select All.
		once
			create Result.make (names.fs_select_all, create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), False, True, False)
		end

feature -- Keybord shortcuts Customization

	customized_strings: ARRAYED_LIST [STRING_PREFERENCE] is
			--
		once
			create Result.make (3)
		end

	shortcuts: HASH_TABLE [SHORTCUT_PREFERENCE, STRING] is
			-- Shortcuts
		once
			create Result.make (default_shortcut_actions.count)
		end

	default_shortcut_actions: ARRAYED_LIST [TUPLE [HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8], MANAGED_SHORTCUT_GROUP]]
			-- Array of shortcut defaults (Alt/Ctrl/Shift/KeyString)

	editor_shortcut_actions: ARRAYED_LIST [TUPLE [HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8], MANAGED_SHORTCUT_GROUP]] is
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8]
		once
			create Result.make (1)

				-- Shortcuts for main window group
			create l_hash.make (14)
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
			l_hash.put ([False,  True, False, key_strings.item (Key_u).twin.as_string_8], "set_to_uppercase")
			l_hash.put ([False,  True, True, key_strings.item (Key_u).twin.as_string_8], "set_to_lowercase")

			l_hash.put ([False,  True, False, key_strings.item (Key_l).twin.as_string_8], "toggle_line_number_visibility")

			l_hash.put ([False,  True, False, key_strings.item (Key_i).twin.as_string_8], "embed_if_clause")
			l_hash.put ([False,  True, False, key_strings.item (Key_d).twin.as_string_8], "embed_debug_clause")

			l_hash.put ([False, True, False, key_strings.item (Key_g).twin.as_string_8], "show_goto_dialog")

			Result.extend ([l_hash, main_window_group])
		end

	completion_shortcut_actions: ARRAYED_LIST [TUPLE [HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8], MANAGED_SHORTCUT_GROUP]] is
		local
			l_hash: HASH_TABLE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING_8], STRING_8]
		once
			create Result.make (2)

			create l_hash.make (2)
			l_hash.put ([False,  True, False, key_strings.item (Key_space).twin.as_string_8], "autocomplete")
			l_hash.put ([False,  True,  True, key_strings.item (Key_space).twin.as_string_8], "class_autocomplete")
			Result.extend ([l_hash, main_window_group])

				-- Shortcuts for completion window group
			create l_hash.make (5)
			l_hash.put ([False, False, False, key_strings.item (Key_F1).twin.as_string_8], "toggle_filter")
			l_hash.put ([False, False, False, key_strings.item (Key_F2).twin.as_string_8], "toggle_show_type")
			l_hash.put ([False, False, False, key_strings.item (Key_F3).twin.as_string_8], "toggle_show_signature")
			l_hash.put ([False, False, False, key_strings.item (Key_F4).twin.as_string_8], "toggle_show_disambiguated_name")
			l_hash.put ([False, False, False, key_strings.item (Key_F5).twin.as_string_8], "toggle_show_obsolete_items")
			l_hash.put ([False, False, False, key_strings.item (Key_F6).twin.as_string_8], "toggle_remember_size")
			Result.extend ([l_hash, completion_window_group])
		end

invariant
	preferences_not_void: preferences /= Void
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
	indexing_tag_text_color_preference_not_void: indexing_tag_text_color_preference /= Void
	indexing_tag_background_color_preference_not_void: indexing_tag_background_color_preference /= Void
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
	show_completion_type_preference_not_void: show_completion_type_preference /= Void
	show_completion_disambiguated_name_preference_not_void: show_completion_disambiguated_name_preference /= Void
	show_completion_obsolete_items_preference_not_void: show_completion_obsolete_items_preference /= Void
	syntax_complete_enabled_preference_not_void: syntax_complete_enabled_preference /= Void
	customized_string_1_preference_not_void: customized_string_1_preference /= Void
	customized_string_2_preference_not_void: customized_string_2_preference /= Void
	customized_string_3_preference_not_void: customized_string_3_preference /= Void
	warning_text_color_preference_attached: warning_text_color_preference /= Void
	warning_background_color_preference_attached: warning_background_color_preference /= Void
	argument_text_color_preference_attached: argument_text_color_preference /= Void
	argument_background_color_preference_attached: argument_background_color_preference /= Void


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_EDITOR_DATA


