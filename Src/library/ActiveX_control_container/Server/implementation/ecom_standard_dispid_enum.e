indexing
	description: "Standard dispatch ID constants. From <olectl.h>"
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_STANDARD_DISPID_ENUM
	
feature -- Access

	Dispid_autosize: INTEGER is                 -500
	
	Dispid_backcolor: INTEGER is                -501
	
	Dispid_backstyle: INTEGER is                -502

	Dispid_bordercolor: INTEGER is              -503

	Dispid_borderstyle: INTEGER is              -504

	Dispid_borderwidth: INTEGER is              -505

	Dispid_drawmode: INTEGER is                 -507

	Dispid_drawstyle: INTEGER is                -508

	Dispid_drawwidth: INTEGER is                -509

	Dispid_fillcolor: INTEGER is                -510

	Dispid_fillstyle: INTEGER is                -511

	Dispid_font: Integer is                     -512

	Dispid_forecolor: Integer is                -513

	Dispid_enabled: INTEGER Is                  -514

	Dispid_hwnd: INTEGER is                     -515

	Dispid_tabstop: INTEGER is                  -516

	Dispid_text: INTEGER is                     -517

	Dispid_caption: INTEGER is                  -518

	Dispid_bordervisible: INTEGER is            -519

	Dispid_appearance: INTEGER is               -520

	Dispid_mousepointer: INTEGER is             -521

	Dispid_mouseicon: INTEGER is                -522

	Dispid_picture: INTEGER is                  -523

	Dispid_valid: INTEGER is                    -524

	Dispid_readystate: INTEGER is               -525

	Dispid_listindex: INTEGER is                -526

	Dispid_selected: INTEGER is                 -527

	Dispid_list: INTEGER is                     -528

	Dispid_column: INTEGER is                   -529

	Dispid_listcount: INTEGER is                -531

	Dispid_multiselect: INTEGER is              -532

	Dispid_maxlength: INTEGER is                -533

	Dispid_passwordchar: INTEGER is             -534

	Dispid_scrollbars: INTEGER is               -535

	Dispid_wordwrap: INTEGER is                 -536

	Dispid_multiline: INTEGER is                -537

	Dispid_numberofrows: INTEGER is             -538

	Dispid_numberofcolumns: INTEGER is          -539

	Dispid_displaystyle: INTEGER is             -540

	Dispid_groupname: INTEGER is                -541

	Dispid_imemode: INTEGER is                  -542

	Dispid_accelerator: INTEGER is              -543

	Dispid_enterkeybehavior: INTEGER is         -544

	Dispid_tabkeybehavior: INTEGER is           -545

	Dispid_seltext: INTEGER is                  -546

	Dispid_selstart: INTEGER is                 -547

	Dispid_sellength : INTEGER is               -548

	Dispid_refresh: INTEGER is                  -550

	Dispid_doclick: INTEGER is                  -551

	Dispid_aboutbox: INTEGER is                 -552

	Dispid_additem: INTEGER is                  -553

	Dispid_clear: INTEGER is                    -554

	Dispid_removeitem: INTEGER is               -555

	Dispid_click: INTEGER is                    -600

	Dispid_dblclick: INTEGER is                 -601

	Dispid_keydown: INTEGER is                  -602

	Dispid_keypress: INTEGER is                 -603

	Dispid_keyup: INTEGER is                    -604

	Dispid_mousedown: INTEGER is                -605

	Dispid_mousemove: INTEGER is                -606

	Dispid_mouseup: INTEGER is                  -607

	Dispid_errorevent: INTEGER is               -608

	Dispid_readystatechange: INTEGER is         -609

	Dispid_click_value: INTEGER is              -610

	Dispid_righttoleft: INTEGER is              -611

	Dispid_toptobottom: INTEGER is              -612

	Dispid_this: INTEGER is                     -613

	Dispid_ambient_backcolor: INTEGER is        -701

	Dispid_ambient_displayname: INTEGER is      -702

	Dispid_ambient_font: INTEGER is             -703

	Dispid_ambient_forecolor: INTEGER is        -704

	Dispid_ambient_localeid: INTEGER is         -705

	Dispid_ambient_messagereflect: INTEGER is   -706

	Dispid_ambient_scaleunits: INTEGER is       -707

	Dispid_ambient_textalign: INTEGER is        -708

	Dispid_ambient_usermode: INTEGER is         -709

	Dispid_ambient_uidead: INTEGER is           -710

	Dispid_ambient_showgrabhandles: INTEGER is  -711

	Dispid_ambient_showhatching: INTEGER is     -712

	Dispid_ambient_displayasdefault: INTEGER is -713

	Dispid_ambient_supportsmnemonics: INTEGER is -714

	Dispid_ambient_autoclip: INTEGER is         -715

	Dispid_ambient_appearance: INTEGER is       -716

	Dispid_ambient_codepage: INTEGER is         -725

	Dispid_ambient_palette: INTEGER is          -726

	Dispid_ambient_charset: INTEGER is          -727

	Dispid_ambient_transferpriority: INTEGER is -728

	Dispid_ambient_righttoleft: INTEGER is      -732

	Dispid_ambient_toptobottom: INTEGER is      -733

	Dispid_name: INTEGER is                     -800

	Dispid_delete: INTEGER is                   -801

	Dispid_object: INTEGER is                   -802

	Dispid_parent: INTEGER is                   -803


feature -- Dispatch ID constants for font and picture types

	Dispid_font_name: INTEGER is    0

	Dispid_font_size: INTEGER is    2

	Dispid_font_bold: INTEGER is    3

	Dispid_font_italic: INTEGER is  4

	Dispid_font_under: INTEGER is   5

	Dispid_font_strike: INTEGER is  6

	Dispid_font_weight: INTEGER is  7

	Dispid_font_charset: INTEGER is 8

	Dispid_font_changed: INTEGER is 9

	Dispid_pict_handle: INTEGER is  0

	Dispid_pict_hpal: INTEGER is    2

	Dispid_pict_type: INTEGER is    3

	Dispid_pict_width: INTEGER is   4

	Dispid_pict_height: INTEGER is  5

	Dispid_pict_render: INTEGER is  6

end -- class ECOM_STANDARD_DISPID_ENUM
