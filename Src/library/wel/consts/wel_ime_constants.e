note
	description: "IME constants"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_IME_CONSTANTS

feature -- Dialog Box Options

	Ime_config_general: INTEGER = 1

	Ime_config_register_word: INTEGER = 2

	Ime_config_selectdictionary: INTEGER = 3

feature -- IME hotkey constants

	Ime_chotkey_ime_nonime_toggle: INTEGER = 10

	Ime_chotkey_shape_toggle: INTEGER = 11

	Ime_chotkey_symbol_toggle: INTEGER = 12

	Ime_jhotkey_close_open: INTEGER = 48

	Ime_khotkey_shape_toggle: INTEGER = 80

	Ime_khotkey_hanjaconvert: INTEGER = 81

	Ime_khotkey_english: INTEGER = 82

	Ime_thotkey_ime_nonime_toggle: INTEGER = 112

	Ime_thotkey_shape_toggle: INTEGER = 113

	Ime_thotkey_symbol_toggle: INTEGER = 114

	Ime_hotkey_dswitch_first: INTEGER =  256

	Ime_hotkey_dswitch_last: INTEGER = 287

	Ime_hotkey_private_first: INTEGER = 512

	Ime_ithotkey_resend_resultstr: INTEGER = 512

	Ime_ithotkey_previous_composition: INTEGER = 513

	Ime_ithotkey_uistyle_toggle: INTEGER = 514

	Ime_ithotkey_reconvertstring: INTEGER = 515

	Ime_hotkey_private_last: INTEGER = 543

feature -- IME Conversion Mode Constants

	Ime_cmode_alphanumeric: INTEGER = 0

	Ime_cmode_native: INTEGER = 1

	Ime_cmode_chinese: INTEGER = 1

	Ime_cmode_hangeul: INTEGER = 1

	Ime_cmode_hangul: INTEGER = 1

	Ime_cmode_japanese: INTEGER = 1

	Ime_cmode_katakana: INTEGER = 2

	Ime_cmode_language: INTEGER = 3

	Ime_cmode_fullshape: INTEGER = 8

	Ime_cmode_roman: INTEGER = 16

	Ime_cmode_charcode: INTEGER = 32

	Ime_cmode_hanjaconvert: INTEGER = 64

	Ime_cmode_softkbd: INTEGER = 128

	Ime_cmode_noconversion: INTEGER = 256

	Ime_cmode_eudc: INTEGER = 512

	Ime_cmode_symbol: INTEGER = 1024

	Ime_cmode_fixed: INTEGER = 2048

feature -- IME Sentence Mode Constants

	Ime_smode_none: INTEGER = 0

	Ime_smode_pluralclause: INTEGER = 1

	Ime_smode_singleconvert: INTEGER = 2

	Ime_smode_automatic: INTEGER = 4

	Ime_smode_phrasepredict: INTEGER = 8

	Ime_smode_conversation: INTEGER = 10

feature -- Sorting Constants

	Sort_default: INTEGER = 0

	Sort_japanese_xjis: INTEGER = 0

	Sort_japanese_unicode: INTEGER = 1

	Sort_chinese_big5: INTEGER = 0

	Sort_chinese_prcp: INTEGER = 0

	Sort_chinese_unicode: INTEGER = 1

	Sort_chinese_prc: INTEGER = 2

	Sort_chinese_bopomofo: INTEGER = 3

	Sort_korean_ksc: INTEGER = 0

	Sort_korean_unicode: INTEGER = 1

	Sort_german_phone_book: INTEGER = 1

	Sort_hungarian_default: INTEGER = 0

	Sort_hungarian_technical: INTEGER = 1

	Sort_georgian_traditional: INTEGER = 0

	Sort_georgian_modern: INTEGER = 1

feature -- IME property information flags

	Igp_getimeversion: INTEGER = -4

	Igp_property: INTEGER = 4

	Igp_conversion: INTEGER = 8

	Igp_sentence: INTEGER = 12

	Igp_ui: INTEGER = 16

	Igp_setcompstr: INTEGER = 20

	Igp_select: INTEGER = 24

feature -- Ime property information constants.

	Ime_prop_at_caret: INTEGER = 65536

	Ime_prop_special_ui: INTEGER = 131072

	Ime_prop_candlist_start_from_1: INTEGER = 264144

	Ime_prop_unicode: INTEGER = 524288

	Ime_prop_complete_on_unselect: INTEGER = 1048576

feature -- User interface capabilities.

	Ui_cap_2700: INTEGER = 1

	Ui_cap_rot90: INTEGER = 2

	Ui_cap_rotany: INTEGER = 4

feature -- Composition string capabilities.

	Scs_cap_compstr: INTEGER = 1

	Scs_cap_makeread: INTEGER = 2

	Scs_cap_setreconvertstring: INTEGER = 4

feature -- Selection inheritance capabilities.

	Select_cap_conversion: INTEGER = 1

	Select_cap_sentence: INTEGER = 2

feature -- System version number for which the IME was created.

	Imever_0310: INTEGER = 200000

	Imever_0400: INTEGER = 262144

feature -- Composition window properties.

	Cfs_default: INTEGER = 0

	Cfs_rect: INTEGER = 1

	Cfs_point: INTEGER = 2

	Cfs_force_position: INTEGER = 32

	Cfs_candidatepos: INTEGER = 64

	Cfs_exclude: INTEGER = 128;

note
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
