note
	description: "PCRE escape character constants"
	copyright: "Copyright (c) 2001-2002, Harald Erdbruegger and others"
	license: "MIT License"

class ESCAPE_CONSTANTS

feature -- Access

	escape_character (a_code: INTEGER): INTEGER
			-- Code of escape character for character with code `a_code';
			-- Return 0 if not escaped.
		require
			a_code_positive: a_code >= 0
		do
			inspect a_code
			when {ASCII}.Colon then
				Result := {ASCII}.Colon
			when {ASCII}.Semicolon then
				Result := {ASCII}.Semicolon
			when {ASCII}.Lessthan then
				Result := {ASCII}.Lessthan
			when {ASCII}.Equal_sign then
				Result := {ASCII}.Equal_sign
			when {ASCII}.Greaterthan then
				Result := {ASCII}.Greaterthan
			when {ASCII}.Questmark then
				Result := {ASCII}.Questmark
			when {ASCII}.commercial_at then
				Result := {ASCII}.commercial_at
			when {ASCII}.Upper_a then
				Result := -esc_uca
			when {ASCII}.Upper_b then
				Result := -esc_ucb
			when {ASCII}.Upper_d then
				Result := -esc_ucd
			when {ASCII}.Upper_s then
				Result := -esc_ucs
			when {ASCII}.Upper_w then
				Result := -esc_ucw
			when {ASCII}.Upper_z then
				Result := -esc_ucz
			when {ASCII}.Lbracket then
				Result := {ASCII}.Lbracket
			when {ASCII}.Backslash then
				Result := {ASCII}.Backslash
			when {ASCII}.Rbracket then
				Result := {ASCII}.Rbracket
			when {ASCII}.bar then
				Result := {ASCII}.bar
			when {ASCII}.Underlined then
				Result := {ASCII}.Underlined
			when {ASCII}.grave_accent then
				Result := {ASCII}.grave_accent
			when {ASCII}.Lower_a then
				Result := 7
			when {ASCII}.Lower_b then
				Result := -esc_lcb
			when {ASCII}.Lower_d then
				Result := -esc_lcd
			when {ASCII}.Lower_e then
				Result := 27
			when {ASCII}.Lower_f then
				Result := {ASCII}.Line_feed
			when {ASCII}.Lower_n then
				Result := {ASCII}.line_feed
			when {ASCII}.Lower_r then
				Result := {ASCII}.Carriage_return
			when {ASCII}.Lower_s then
				Result := -esc_lcs
			when {ASCII}.Lower_t then
				Result := {ASCII}.Tabulation
			when {ASCII}.Lower_w then
				Result := -esc_lcw
			when {ASCII}.Lower_z then
				Result := -esc_lcz
			else
				Result := 0
			end
		end

feature -- Constants

	esc_uca: INTEGER = 1
	esc_ucb: INTEGER = 2
	esc_lcb: INTEGER = 3
	esc_ucd: INTEGER = 4
	esc_lcd: INTEGER = 5
	esc_ucs: INTEGER = 6
	esc_lcs: INTEGER = 7
	esc_ucw: INTEGER = 8
	esc_lcw: INTEGER = 9
	esc_ucz: INTEGER = 10
	esc_lcz: INTEGER = 11
	esc_ref: INTEGER = 12

end
