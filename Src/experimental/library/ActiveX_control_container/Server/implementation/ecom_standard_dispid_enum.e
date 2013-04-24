note
	description: "Standard dispatch ID constants. From <olectl.h>"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STANDARD_DISPID_ENUM
	
feature -- Access

	Dispid_unknown: INTEGER =                  -1
			-- DISPID reserved to indicate an "unknown" name 
			-- only reserved for data members (properties); 
			-- reused as a method dispid below 
	
	Dispid_value: INTEGER =	                0 
	-- DISPID reserved for the "value" property 

	Dispid_propertyput: INTEGER =	            -3 
	-- The following DISPID is reserved to indicate the param
	-- that is the right-hand-side (or "put" value) of a PropertyPut


	Dispid_newenum: INTEGER =	                -4 
	-- DISPID reserved for the standard "NewEnum" method 

	Dispid_evaluate: INTEGER =	                -5 
	-- DISPID reserved for the standard "Evaluate" method 

	Dispid_constructor: INTEGER =	            -6 

	Dispid_destructor: INTEGER =	            -7 

	Dispid_collect: INTEGER =	                -8 
	
feature -- The range -500 through -999 is reserved for Controls. 

	Dispid_autosize: INTEGER =                 -500
	
	Dispid_backcolor: INTEGER =                -501
	
	Dispid_backstyle: INTEGER =                -502

	Dispid_bordercolor: INTEGER =              -503

	Dispid_borderstyle: INTEGER =              -504

	Dispid_borderwidth: INTEGER =              -505

	Dispid_drawmode: INTEGER =                 -507

	Dispid_drawstyle: INTEGER =                -508

	Dispid_drawwidth: INTEGER =                -509

	Dispid_fillcolor: INTEGER =                -510

	Dispid_fillstyle: INTEGER =                -511

	Dispid_font: Integer =                     -512

	Dispid_forecolor: Integer =                -513

	Dispid_enabled: INTEGER =                  -514

	Dispid_hwnd: INTEGER =                     -515

	Dispid_tabstop: INTEGER =                  -516

	Dispid_text: INTEGER =                     -517

	Dispid_caption: INTEGER =                  -518

	Dispid_bordervisible: INTEGER =            -519

	Dispid_appearance: INTEGER =               -520

	Dispid_mousepointer: INTEGER =             -521

	Dispid_mouseicon: INTEGER =                -522

	Dispid_picture: INTEGER =                  -523

	Dispid_valid: INTEGER =                    -524

	Dispid_readystate: INTEGER =               -525

	Dispid_listindex: INTEGER =                -526

	Dispid_selected: INTEGER =                 -527

	Dispid_list: INTEGER =                     -528

	Dispid_column: INTEGER =                   -529

	Dispid_listcount: INTEGER =                -531

	Dispid_multiselect: INTEGER =              -532

	Dispid_maxlength: INTEGER =                -533

	Dispid_passwordchar: INTEGER =             -534

	Dispid_scrollbars: INTEGER =               -535

	Dispid_wordwrap: INTEGER =                 -536

	Dispid_multiline: INTEGER =                -537

	Dispid_numberofrows: INTEGER =             -538

	Dispid_numberofcolumns: INTEGER =          -539

	Dispid_displaystyle: INTEGER =             -540

	Dispid_groupname: INTEGER =                -541

	Dispid_imemode: INTEGER =                  -542

	Dispid_accelerator: INTEGER =              -543

	Dispid_enterkeybehavior: INTEGER =         -544

	Dispid_tabkeybehavior: INTEGER =           -545

	Dispid_seltext: INTEGER =                  -546

	Dispid_selstart: INTEGER =                 -547

	Dispid_sellength : INTEGER =               -548

	Dispid_refresh: INTEGER =                  -550

	Dispid_doclick: INTEGER =                  -551

	Dispid_aboutbox: INTEGER =                 -552

	Dispid_additem: INTEGER =                  -553

	Dispid_clear: INTEGER =                    -554

	Dispid_removeitem: INTEGER =               -555

	Dispid_click: INTEGER =                    -600

	Dispid_dblclick: INTEGER =                 -601

	Dispid_keydown: INTEGER =                  -602

	Dispid_keypress: INTEGER =                 -603

	Dispid_keyup: INTEGER =                    -604

	Dispid_mousedown: INTEGER =                -605

	Dispid_mousemove: INTEGER =                -606

	Dispid_mouseup: INTEGER =                  -607

	Dispid_errorevent: INTEGER =               -608

	Dispid_readystatechange: INTEGER =         -609

	Dispid_click_value: INTEGER =              -610

	Dispid_righttoleft: INTEGER =              -611

	Dispid_toptobottom: INTEGER =              -612

	Dispid_this: INTEGER =                     -613

	Dispid_ambient_backcolor: INTEGER =        -701

	Dispid_ambient_displayname: INTEGER =      -702

	Dispid_ambient_font: INTEGER =             -703

	Dispid_ambient_forecolor: INTEGER =        -704

	Dispid_ambient_localeid: INTEGER =         -705

	Dispid_ambient_messagereflect: INTEGER =   -706

	Dispid_ambient_scaleunits: INTEGER =       -707

	Dispid_ambient_textalign: INTEGER =        -708

	Dispid_ambient_usermode: INTEGER =         -709

	Dispid_ambient_uidead: INTEGER =           -710

	Dispid_ambient_showgrabhandles: INTEGER =  -711

	Dispid_ambient_showhatching: INTEGER =     -712

	Dispid_ambient_displayasdefault: INTEGER = -713

	Dispid_ambient_supportsmnemonics: INTEGER = -714

	Dispid_ambient_autoclip: INTEGER =         -715

	Dispid_ambient_appearance: INTEGER =       -716

	Dispid_ambient_codepage: INTEGER =         -725

	Dispid_ambient_palette: INTEGER =          -726

	Dispid_ambient_charset: INTEGER =          -727

	Dispid_ambient_transferpriority: INTEGER = -728

	Dispid_ambient_righttoleft: INTEGER =      -732

	Dispid_ambient_toptobottom: INTEGER =      -733

	Dispid_name: INTEGER =                     -800

	Dispid_delete: INTEGER =                   -801

	Dispid_object: INTEGER =                   -802

	Dispid_parent: INTEGER =                   -803


feature -- Dispatch ID constants for font and picture types

	Dispid_font_name: INTEGER =    0

	Dispid_font_size: INTEGER =    2

	Dispid_font_bold: INTEGER =    3

	Dispid_font_italic: INTEGER =  4

	Dispid_font_under: INTEGER =   5

	Dispid_font_strike: INTEGER =  6

	Dispid_font_weight: INTEGER =  7

	Dispid_font_charset: INTEGER = 8

	Dispid_font_changed: INTEGER = 9

	Dispid_pict_handle: INTEGER =  0

	Dispid_pict_hpal: INTEGER =    2

	Dispid_pict_type: INTEGER =    3

	Dispid_pict_width: INTEGER =   4

	Dispid_pict_height: INTEGER =  5

	Dispid_pict_render: INTEGER =  6;

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




end -- class ECOM_STANDARD_DISPID_ENUM
