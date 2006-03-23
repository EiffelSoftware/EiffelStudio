indexing
	description: "IME constants"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IME_CONSTANTS

feature -- Dialog Box Options

	Ime_config_general: INTEGER is 1

	Ime_config_register_word: INTEGER is 2

	Ime_config_selectdictionary: INTEGER is 3

feature -- IME hotkey constants

	Ime_chotkey_ime_nonime_toggle: INTEGER is 10

	Ime_chotkey_shape_toggle: INTEGER is 11

	Ime_chotkey_symbol_toggle: INTEGER is 12

	Ime_jhotkey_close_open: INTEGER is 48

	Ime_khotkey_shape_toggle: INTEGER is 80

	Ime_khotkey_hanjaconvert: INTEGER is 81

	Ime_khotkey_english: INTEGER is 82

	Ime_thotkey_ime_nonime_toggle: INTEGER is 112

	Ime_thotkey_shape_toggle: INTEGER is 113

	Ime_thotkey_symbol_toggle: INTEGER is 114

	Ime_hotkey_dswitch_first: INTEGER is  256

	Ime_hotkey_dswitch_last: INTEGER is 287

	Ime_hotkey_private_first: INTEGER is 512

	Ime_ithotkey_resend_resultstr: INTEGER is 512

	Ime_ithotkey_previous_composition: INTEGER is 513

	Ime_ithotkey_uistyle_toggle: INTEGER is 514

	Ime_ithotkey_reconvertstring: INTEGER is 515

	Ime_hotkey_private_last: INTEGER is 543

feature -- IME Conversion Mode Constants

	Ime_cmode_alphanumeric: INTEGER is 0

	Ime_cmode_native: INTEGER is 1

	Ime_cmode_chinese: INTEGER is 1

	Ime_cmode_hangeul: INTEGER is 1

	Ime_cmode_hangul: INTEGER is 1

	Ime_cmode_japanese: INTEGER is 1

	Ime_cmode_katakana: INTEGER is 2

	Ime_cmode_language: INTEGER is 3

	Ime_cmode_fullshape: INTEGER is 8

	Ime_cmode_roman: INTEGER is 16

	Ime_cmode_charcode: INTEGER is 32

	Ime_cmode_hanjaconvert: INTEGER is 64

	Ime_cmode_softkbd: INTEGER is 128

	Ime_cmode_noconversion: INTEGER is 256

	Ime_cmode_eudc: INTEGER is 512

	Ime_cmode_symbol: INTEGER is 1024

	Ime_cmode_fixed: INTEGER is 2048

feature -- IME Sentence Mode Constants

	Ime_smode_none: INTEGER is 0

	Ime_smode_pluralclause: INTEGER is 1

	Ime_smode_singleconvert: INTEGER is 2

	Ime_smode_automatic: INTEGER is 4

	Ime_smode_phrasepredict: INTEGER is 8

	Ime_smode_conversation: INTEGER is 10

feature -- Sorting Constants

	Sort_default: INTEGER is 0

	Sort_japanese_xjis: INTEGER is 0

	Sort_japanese_unicode: INTEGER is 1

	Sort_chinese_big5: INTEGER is 0

	Sort_chinese_prcp: INTEGER is 0

	Sort_chinese_unicode: INTEGER is 1

	Sort_chinese_prc: INTEGER is 2

	Sort_chinese_bopomofo: INTEGER is 3

	Sort_korean_ksc: INTEGER is 0

	Sort_korean_unicode: INTEGER is 1

	Sort_german_phone_book: INTEGER is 1

	Sort_hungarian_default: INTEGER is 0

	Sort_hungarian_technical: INTEGER is 1

	Sort_georgian_traditional: INTEGER is 0

	Sort_georgian_modern: INTEGER is 1

feature -- IME property information flags

	Igp_getimeversion: INTEGER is -4

	Igp_property: INTEGER is 4

	Igp_conversion: INTEGER is 8

	Igp_sentence: INTEGER is 12

	Igp_ui: INTEGER is 16

	Igp_setcompstr: INTEGER is 20

	Igp_select: INTEGER is 24

feature -- Ime property information constants.

	Ime_prop_at_caret: INTEGER is 65536

	Ime_prop_special_ui: INTEGER is 131072

	Ime_prop_candlist_start_from_1: INTEGER is 264144

	Ime_prop_unicode: INTEGER is 524288

	Ime_prop_complete_on_unselect: INTEGER is 1048576

feature -- User interface capabilities.

	Ui_cap_2700: INTEGER is 1

	Ui_cap_rot90: INTEGER is 2

	Ui_cap_rotany: INTEGER is 4

feature -- Composition string capabilities.

	Scs_cap_compstr: INTEGER is 1

	Scs_cap_makeread: INTEGER is 2

	Scs_cap_setreconvertstring: INTEGER is 4

feature -- Selection inheritance capabilities.

	Select_cap_conversion: INTEGER is 1

	Select_cap_sentence: INTEGER is 2

feature -- System version number for which the IME was created.

	Imever_0310: INTEGER is 200000

	Imever_0400: INTEGER is 262144

feature -- Composition window properties.

	Cfs_default: INTEGER is 0

	Cfs_rect: INTEGER is 1

	Cfs_point: INTEGER is 2

	Cfs_force_position: INTEGER is 32

	Cfs_candidatepos: INTEGER is 64

	Cfs_exclude: INTEGER is 128;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
