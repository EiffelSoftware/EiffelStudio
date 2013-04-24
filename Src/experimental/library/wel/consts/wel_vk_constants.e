note
	description	: "Virtual Key code (VK) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_VK_CONSTANTS

feature -- Access

	Vk_lbutton: INTEGER = 1
			-- Declared in Windows as VK_LBUTTON

	Vk_rbutton: INTEGER = 2
			-- Declared in Windows as VK_RBUTTON

	Vk_cancel: INTEGER = 3
			-- Declared in Windows as VK_CANCEL

	Vk_mbutton: INTEGER = 4
			-- Declared in Windows as VK_MBUTTON

	Vk_back: INTEGER = 8
			-- Declared in Windows as VK_BACK

	Vk_tab: INTEGER = 9
			-- Declared in Windows as VK_TAB

	Vk_clear: INTEGER = 12
			-- Declared in Windows as VK_CLEAR

	Vk_return: INTEGER = 13
			-- Declared in Windows as VK_RETURN

	Vk_shift: INTEGER = 16
			-- Declared in Windows as VK_SHIFT

	Vk_control: INTEGER = 17
			-- Declared in Windows as VK_CONTROL

	Vk_menu, vk_alt: INTEGER = 18
			-- Declared in Windows as VK_MENU

	Vk_pause: INTEGER = 19
			-- Declared in Windows as VK_PAUSE

	Vk_capital: INTEGER = 20
			-- Declared in Windows as VK_CAPITAL

	Vk_escape: INTEGER = 27
			-- Declared in Windows as VK_ESCAPE

	Vk_space: INTEGER = 32
			-- Declared in Windows as VK_SPACE

	Vk_prior: INTEGER = 33
			-- Declared in Windows as VK_PRIOR

	Vk_next: INTEGER = 34
			-- Declared in Windows as VK_NEXT

	Vk_end: INTEGER = 35
			-- Declared in Windows as VK_END

	Vk_home: INTEGER = 36
			-- Declared in Windows as VK_HOME

	Vk_left: INTEGER = 37
			-- Declared in Windows as VK_LEFT

	Vk_up: INTEGER = 38
			-- Declared in Windows as VK_UP

	Vk_right: INTEGER = 39
			-- Declared in Windows as VK_RIGHT

	Vk_down: INTEGER = 40
			-- Declared in Windows as VK_DOWN

	Vk_select: INTEGER = 41
			-- Declared in Windows as VK_SELECT

	Vk_print: INTEGER = 42
			-- Declared in Windows as VK_PRINT

	Vk_execute: INTEGER = 43
			-- Declared in Windows as VK_EXECUTE

	Vk_snapshot: INTEGER = 44
			-- Declared in Windows as VK_SNAPSHOT

	Vk_insert: INTEGER = 45
			-- Declared in Windows as VK_INSERT

	Vk_delete: INTEGER = 46
			-- Declared in Windows as VK_DELETE

	Vk_help: INTEGER = 47
			-- Declared in Windows as VK_HELP

	Vk_numpad0: INTEGER = 96
			-- Declared in Windows as VK_NUMPAD0

	Vk_numpad1: INTEGER = 97
			-- Declared in Windows as VK_NUMPAD1

	Vk_numpad2: INTEGER = 98
			-- Declared in Windows as VK_NUMPAD2

	Vk_numpad3: INTEGER = 99
			-- Declared in Windows as VK_NUMPAD3

	Vk_numpad4: INTEGER = 100
			-- Declared in Windows as VK_NUMPAD4

	Vk_numpad5: INTEGER = 101
			-- Declared in Windows as VK_NUMPAD5

	Vk_numpad6: INTEGER = 102
			-- Declared in Windows as VK_NUMPAD6

	Vk_numpad7: INTEGER = 103
			-- Declared in Windows as VK_NUMPAD7

	Vk_numpad8: INTEGER = 104
			-- Declared in Windows as VK_NUMPAD8

	Vk_numpad9: INTEGER = 105
			-- Declared in Windows as VK_NUMPAD9

	Vk_multiply: INTEGER = 106
			-- Declared in Windows as VK_MULTIPLY

	Vk_add: INTEGER = 107
			-- Declared in Windows as VK_ADD

	Vk_separator: INTEGER = 108
			-- Declared in Windows as VK_SEPARATOR

	Vk_subtract: INTEGER = 109
			-- Declared in Windows as VK_SUBTRACT

	Vk_decimal: INTEGER = 110
			-- Declared in Windows as VK_DECIMAL

	Vk_divide: INTEGER = 111
			-- Declared in Windows as VK_DIVIDE

	Vk_f1: INTEGER = 112
			-- Declared in Windows as VK_F1

	Vk_f2: INTEGER = 113
			-- Declared in Windows as VK_F2

	Vk_f3: INTEGER = 114
			-- Declared in Windows as VK_F3

	Vk_f4: INTEGER = 115
			-- Declared in Windows as VK_F4

	Vk_f5: INTEGER = 116
			-- Declared in Windows as VK_F5

	Vk_f6: INTEGER = 117
			-- Declared in Windows as VK_F6

	Vk_f7: INTEGER = 118
			-- Declared in Windows as VK_F7

	Vk_f8: INTEGER = 119
			-- Declared in Windows as VK_F8

	Vk_f9: INTEGER = 120
			-- Declared in Windows as VK_F9

	Vk_f10: INTEGER = 121
			-- Declared in Windows as VK_F10

	Vk_f11: INTEGER = 122
			-- Declared in Windows as VK_F11

	Vk_f12: INTEGER = 123
			-- Declared in Windows as VK_F12

	Vk_f13: INTEGER = 124
			-- Declared in Windows as VK_F13

	Vk_f14: INTEGER = 125
			-- Declared in Windows as VK_F14

	Vk_f15: INTEGER = 126
			-- Declared in Windows as VK_F15

	Vk_f16: INTEGER = 127
			-- Declared in Windows as VK_F16

	Vk_f17: INTEGER = 128
			-- Declared in Windows as VK_F17

	Vk_f18: INTEGER = 129
			-- Declared in Windows as VK_F18

	Vk_f19: INTEGER = 130
			-- Declared in Windows as VK_F19

	Vk_f20: INTEGER = 131
			-- Declared in Windows as VK_F20

	Vk_f21: INTEGER = 132
			-- Declared in Windows as VK_F21

	Vk_f22: INTEGER = 133
			-- Declared in Windows as VK_F22

	Vk_f23: INTEGER = 134
			-- Declared in Windows as VK_F23

	Vk_f24: INTEGER = 135
			-- Declared in Windows as VK_F24

	Vk_numlock: INTEGER = 144
			-- Declared in Windows as VK_NUMLOCK

	Vk_scroll: INTEGER = 145
			-- Declared in Windows as VK_SCROLL

	Vk_lshift: INTEGER = 160
			-- Declared in Windows as VK_LSHIFT

	Vk_rshift: INTEGER = 161
			-- Declared in Windows as VK_RSHIFT

	Vk_lcontrol: INTEGER = 162
			-- Declared in Windows as VK_LCONTROL

	Vk_rcontrol: INTEGER = 163
			-- Declared in Windows as VK_RCONTROL

	Vk_lmenu: INTEGER = 164
			-- Declared in Windows as VK_LMENU

	Vk_rmenu: INTEGER = 165
			-- Declared in Windows as VK_RMENU

	Vk_apps: INTEGER = 0x5D
			-- Declared in Windows as VK_APPS

	-- Vk_0 thru Vk_9 are the same as their ASCII equivalents: '0' thru '9'.
	Vk_0: INTEGER = 48
	Vk_1: INTEGER = 49
	Vk_2: INTEGER = 50
	Vk_3: INTEGER = 51
	Vk_4: INTEGER = 52
	Vk_5: INTEGER = 53
	Vk_6: INTEGER = 54
	Vk_7: INTEGER = 55
	Vk_8: INTEGER = 56
	Vk_9: INTEGER = 57

	-- Vk_a thru Vk_z are the same as their ASCII equivalents: 'A' thru 'Z'.
	Vk_a: INTEGER = 65
	Vk_b: INTEGER = 66
	Vk_c: INTEGER = 67
	Vk_d: INTEGER = 68
	Vk_e: INTEGER = 69
	Vk_f: INTEGER = 70
	Vk_g: INTEGER = 71
	Vk_h: INTEGER = 72
	Vk_i: INTEGER = 73
	Vk_j: INTEGER = 74
	Vk_k: INTEGER = 75
	Vk_l: INTEGER = 76
	Vk_m: INTEGER = 77
	Vk_n: INTEGER = 78
	Vk_o: INTEGER = 79
	Vk_p: INTEGER = 80
	Vk_q: INTEGER = 81
	Vk_r: INTEGER = 82
	Vk_s: INTEGER = 83
	Vk_t: INTEGER = 84
	Vk_u: INTEGER = 85
	Vk_v: INTEGER = 86
	Vk_w: INTEGER = 87
	Vk_x: INTEGER = 88
	Vk_y: INTEGER = 89
	Vk_z: INTEGER = 90;

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




end -- class WEL_VK_CONSTANTS

