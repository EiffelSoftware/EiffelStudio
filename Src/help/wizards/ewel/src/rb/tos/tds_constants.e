indexing
	description: "Constants used by the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_CONSTANTS

feature

	Normal: INTEGER is 1

	Dialog_x: INTEGER is 2
	Dialog_y: INTEGER is 3
	Dialog_width: INTEGER is 4
	Dialog_height: INTEGER is 5

	Option_characteristic: INTEGER is 6
	Option_language: INTEGER is 7
	Option_version: INTEGER is 8
	Option_caption: INTEGER is 9
	Option_class: INTEGER is 10
	Option_exstyle: INTEGER is 11
	Option_font_size: INTEGER is 12
	Option_font_type: INTEGER is 13
	Option_font_weight: INTEGER is 14
	Option_font_italic: INTEGER is 15
	Option_menu: INTEGER is 16
	Option_style: INTEGER is 17
	
	Control_type: INTEGER is 18
	Control_text: INTEGER is 19
	Control_id: INTEGER is 20
	Control_x: INTEGER is 21
	Control_y: INTEGER is 22
	Control_width: INTEGER is 23
	Control_height: INTEGER is 24
	Control_style: INTEGER is 25
	Control_exstyle: INTEGER is 26

	Generic_Control_text: INTEGER is 27
	Generic_Control_id: INTEGER is 28
	Generic_Control_class: INTEGER is 29
	Generic_Control_style: INTEGER is 30
	Generic_Control_x: INTEGER is 31
	Generic_Control_y: INTEGER is 32
	Generic_Control_width: INTEGER is 33
	Generic_Control_height: INTEGER is 34
	Generic_Control_exstyle: INTEGER is 35

	Stringtable_id: INTEGER is 36
	Stringtable_text: INTEGER is 37

	Menu_text: INTEGER is 38
	Menu_command: INTEGER is 39
	Menu_flags: INTEGER is 40

	Accelerators_event: INTEGER is 41
	Accelerators_id: INTEGER is 42
	Accelerators_type: INTEGER is 43
	Accelerators_options: INTEGER is 44
	
	Toolbar_width: INTEGER is 45
	Toolbar_height: INTEGER is 46

end -- class TDS_CONSTANTS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
