indexing
	description	: "Constants relative to Mouse & Keyboard"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_INPUT_CONSTANTS

feature -- Mouse Activate constants.

	Ma_activate: INTEGER is 1
			-- Declared in Windows as MA_ACTIVATE

	Ma_activateandeat: INTEGER is 2
			-- Declared in Windows as MA_ACTIVATEANDEAT

	Ma_noactivate: INTEGER is 3
			-- Declared in Windows as MA_NOACTIVATE

	Ma_noactivateandeat: INTEGER is 4
			-- Declared in Windows as MA_NOACTIVATEANDEAT

feature -- Mouse and Key (MK) constants

	Mk_control: INTEGER is 8
			-- Declared in Windows as MK_CONTROL

	Mk_lbutton: INTEGER is 1
			-- Declared in Windows as MK_LBUTTON

	Mk_mbutton: INTEGER is 16
			-- Declared in Windows as MK_MBUTTON

	Mk_rbutton: INTEGER is 2
			-- Declared in Windows as MK_RBUTTON

	Mk_shift: INTEGER is 4
			-- Declared in Windows as MK_SHIFT

feature -- Virtual Key (VK) constants

	Vk_lbutton: INTEGER is 1
			-- Declared in Windows as VK_LBUTTON

	Vk_rbutton: INTEGER is 2
			-- Declared in Windows as VK_RBUTTON

	Vk_cancel: INTEGER is 3
			-- Declared in Windows as VK_CANCEL

	Vk_mbutton: INTEGER is 4
			-- Declared in Windows as VK_MBUTTON

	Vk_back: INTEGER is 8
			-- Declared in Windows as VK_BACK

	Vk_tab: INTEGER is 9
			-- Declared in Windows as VK_TAB

	Vk_clear: INTEGER is 12
			-- Declared in Windows as VK_CLEAR

	Vk_return: INTEGER is 13
			-- Declared in Windows as VK_RETURN

	Vk_shift: INTEGER is 16
			-- Declared in Windows as VK_SHIFT

	Vk_control: INTEGER is 17
			-- Declared in Windows as VK_CONTROL

	Vk_menu: INTEGER is 18
			-- Declared in Windows as VK_MENU

	Vk_pause: INTEGER is 19
			-- Declared in Windows as VK_PAUSE

	Vk_capital: INTEGER is 20
			-- Declared in Windows as VK_CAPITAL

	Vk_escape: INTEGER is 27
			-- Declared in Windows as VK_ESCAPE

	Vk_space: INTEGER is 32
			-- Declared in Windows as VK_SPACE

	Vk_prior: INTEGER is 33
			-- Declared in Windows as VK_PRIOR

	Vk_next: INTEGER is 34
			-- Declared in Windows as VK_NEXT

	Vk_end: INTEGER is 35
			-- Declared in Windows as VK_END

	Vk_home: INTEGER is 36
			-- Declared in Windows as VK_HOME

	Vk_left: INTEGER is 37
			-- Declared in Windows as VK_LEFT

	Vk_up: INTEGER is 38
			-- Declared in Windows as VK_UP

	Vk_right: INTEGER is 39
			-- Declared in Windows as VK_RIGHT

	Vk_down: INTEGER is 40
			-- Declared in Windows as VK_DOWN

	Vk_select: INTEGER is 41
			-- Declared in Windows as VK_SELECT

	Vk_print: INTEGER is 42
			-- Declared in Windows as VK_PRINT

	Vk_execute: INTEGER is 43
			-- Declared in Windows as VK_EXECUTE

	Vk_snapshot: INTEGER is 44
			-- Declared in Windows as VK_SNAPSHOT

	Vk_insert: INTEGER is 45
			-- Declared in Windows as VK_INSERT

	Vk_delete: INTEGER is 46
			-- Declared in Windows as VK_DELETE

	Vk_help: INTEGER is 47
			-- Declared in Windows as VK_HELP

	Vk_numpad0: INTEGER is 96
			-- Declared in Windows as VK_NUMPAD0

	Vk_numpad1: INTEGER is 97
			-- Declared in Windows as VK_NUMPAD1

	Vk_numpad2: INTEGER is 98
			-- Declared in Windows as VK_NUMPAD2

	Vk_numpad3: INTEGER is 99
			-- Declared in Windows as VK_NUMPAD3

	Vk_numpad4: INTEGER is 100
			-- Declared in Windows as VK_NUMPAD4

	Vk_numpad5: INTEGER is 101
			-- Declared in Windows as VK_NUMPAD5

	Vk_numpad6: INTEGER is 102
			-- Declared in Windows as VK_NUMPAD6

	Vk_numpad7: INTEGER is 103
			-- Declared in Windows as VK_NUMPAD7

	Vk_numpad8: INTEGER is 104
			-- Declared in Windows as VK_NUMPAD8

	Vk_numpad9: INTEGER is 105
			-- Declared in Windows as VK_NUMPAD9

	Vk_multiply: INTEGER is 106
			-- Declared in Windows as VK_MULTIPLY

	Vk_add: INTEGER is 107
			-- Declared in Windows as VK_ADD

	Vk_separator: INTEGER is 108
			-- Declared in Windows as VK_SEPARATOR

	Vk_subtract: INTEGER is 109
			-- Declared in Windows as VK_SUBTRACT

	Vk_decimal: INTEGER is 110
			-- Declared in Windows as VK_DECIMAL

	Vk_divide: INTEGER is 111
			-- Declared in Windows as VK_DIVIDE

	Vk_f1: INTEGER is 112
			-- Declared in Windows as VK_F1

	Vk_f2: INTEGER is 113
			-- Declared in Windows as VK_F2

	Vk_f3: INTEGER is 114
			-- Declared in Windows as VK_F3

	Vk_f4: INTEGER is 115
			-- Declared in Windows as VK_F4

	Vk_f5: INTEGER is 116
			-- Declared in Windows as VK_F5

	Vk_f6: INTEGER is 117
			-- Declared in Windows as VK_F6

	Vk_f7: INTEGER is 118
			-- Declared in Windows as VK_F7

	Vk_f8: INTEGER is 119
			-- Declared in Windows as VK_F8

	Vk_f9: INTEGER is 120
			-- Declared in Windows as VK_F9

	Vk_f10: INTEGER is 121
			-- Declared in Windows as VK_F10

	Vk_f11: INTEGER is 122
			-- Declared in Windows as VK_F11

	Vk_f12: INTEGER is 123
			-- Declared in Windows as VK_F12

	Vk_f13: INTEGER is 124
			-- Declared in Windows as VK_F13

	Vk_f14: INTEGER is 125
			-- Declared in Windows as VK_F14

	Vk_f15: INTEGER is 126
			-- Declared in Windows as VK_F15

	Vk_f16: INTEGER is 127
			-- Declared in Windows as VK_F16

	Vk_f17: INTEGER is 128
			-- Declared in Windows as VK_F17

	Vk_f18: INTEGER is 129
			-- Declared in Windows as VK_F18

	Vk_f19: INTEGER is 130
			-- Declared in Windows as VK_F19

	Vk_f20: INTEGER is 131
			-- Declared in Windows as VK_F20

	Vk_f21: INTEGER is 132
			-- Declared in Windows as VK_F21

	Vk_f22: INTEGER is 133
			-- Declared in Windows as VK_F22

	Vk_f23: INTEGER is 134
			-- Declared in Windows as VK_F23

	Vk_f24: INTEGER is 135
			-- Declared in Windows as VK_F24

	Vk_numlock: INTEGER is 144
			-- Declared in Windows as VK_NUMLOCK

	Vk_scroll: INTEGER is 145
			-- Declared in Windows as VK_SCROLL

	Vk_lshift: INTEGER is 160
			-- Declared in Windows as VK_LSHIFT

	Vk_rshift: INTEGER is 161
			-- Declared in Windows as VK_RSHIFT

	Vk_lcontrol: INTEGER is 162
			-- Declared in Windows as VK_LCONTROL

	Vk_rcontrol: INTEGER is 163
			-- Declared in Windows as VK_RCONTROL

	Vk_lmenu: INTEGER is 164
			-- Declared in Windows as VK_LMENU

	Vk_rmenu: INTEGER is 165
			-- Declared in Windows as VK_RMENU

	-- Vk_0 thru Vk_9 are the same as their ASCII equivalents: '0' thru '9'.
	Vk_0: INTEGER is 48
	Vk_1: INTEGER is 49
	Vk_2: INTEGER is 50
	Vk_3: INTEGER is 51
	Vk_4: INTEGER is 52
	Vk_5: INTEGER is 53
	Vk_6: INTEGER is 54
	Vk_7: INTEGER is 55
	Vk_8: INTEGER is 56
	Vk_9: INTEGER is 57

	-- Vk_a thru Vk_z are the same as their ASCII equivalents: 'A' thru 'Z'.
	Vk_a: INTEGER is 65
	Vk_b: INTEGER is 66
	Vk_c: INTEGER is 67
	Vk_d: INTEGER is 68
	Vk_e: INTEGER is 69
	Vk_f: INTEGER is 70
	Vk_g: INTEGER is 71
	Vk_h: INTEGER is 72
	Vk_i: INTEGER is 73
	Vk_j: INTEGER is 74
	Vk_k: INTEGER is 75
	Vk_l: INTEGER is 76
	Vk_m: INTEGER is 77
	Vk_n: INTEGER is 78
	Vk_o: INTEGER is 79
	Vk_p: INTEGER is 80
	Vk_q: INTEGER is 81
	Vk_r: INTEGER is 82
	Vk_s: INTEGER is 83
	Vk_t: INTEGER is 84
	Vk_u: INTEGER is 85
	Vk_v: INTEGER is 86
	Vk_w: INTEGER is 87
	Vk_x: INTEGER is 88
	Vk_y: INTEGER is 89
	Vk_z: INTEGER is 90

feature -- Keyboard event input constants

	Keyeventf_extendedkey: INTEGER is 1
			-- Declared in Windows as KEYEVENTF_EXTENDEDKEY

	Keyeventf_keyup: INTEGER is 2
			-- Declared in Windows as KEYEVENTF_KEYUP

feature -- Mouse event input constants

	Mouseeventf_absolute: INTEGER is 32768
			-- Declared in Windows as MOUSEEVENTF_ABSOLUTE

	Mouseeventf_move: INTEGER is 1
			-- Declared in Windows as MOUSEEVENTF_MOVE

	Mouseeventf_leftdown: INTEGER is 2
			-- Declared in Windows as MOUSEEVENTF_LEFTDOWN

	Mouseeventf_leftup: INTEGER is 4
			-- Declared in Windows as MOUSEEVENTF_LEFTUP

	Mouseeventf_rightdown: INTEGER is 8
			-- Declared in Windows as MOUSEEVENTF_RIGHTDOWN

	Mouseeventf_rightup: INTEGER is 16
			-- Declared in Windows as MOUSEEVENTF_RIGHTUP

	Mouseeventf_middledown: INTEGER is 32
			-- Declared in Windows as MOUSEEVENTF_MIDDLEDOWN

	Mouseeventf_middleup: INTEGER is 64
			-- Declared in Windows as MOUSEEVENTF_MIDDLEUP

	Mouseeventf_wheel: INTEGER is 2048
			-- Declared in Windows as MOUSEEVENTF_WHEEL

end -- class WEL_INPUT_CONSTANTS
