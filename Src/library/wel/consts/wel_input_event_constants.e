indexing
	description	: "Constants used in WEL_INPUT_EVENT %
				  %about mouse and keyboard events"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_INPUT_EVENT_CONSTANTS

feature -- Keyboard event input

	Keyeventf_extendedkey: INTEGER is 1
			-- Declared in Windows as KEYEVENTF_EXTENDEDKEY

	Keyeventf_keyup: INTEGER is 2
			-- Declared in Windows as KEYEVENTF_KEYUP

feature -- Mouse event input

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

end -- class WEL_INPUT_EVENT_CONSTANTS
