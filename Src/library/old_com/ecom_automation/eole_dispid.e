indexing

	description: "OLE standard DiSPatch IDentifier"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_DISPID

feature -- Access

	Dispid_unknown: INTEGER is
			-- Indicate "unknown" name, only reserved for data
			-- members (properties), reused as method dispid
			-- below
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_UNKNOWN"
		end
		
	Dispid_value: INTEGER is
			-- "value" property
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_VALUE"
		end
		
	Dispid_propertyput: INTEGER is
			-- Indicate param that is right-hand-side
			-- (or "put" value) of PropertyPut
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_PROPERTYPUT"
		end
		
	Dispid_newenum: INTEGER is
			-- Standard "NewEnum" method
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_NEWENUM"
		end
		
	Dispid_evaluate: INTEGER is 
			-- Standard "Evaluate" method
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_EVALUATE"
		end
		
	Dispid_constructor: INTEGER is
			-- C++ constructor function
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_CONSTRUCTOR"
		end

	Dispid_destructor: INTEGER is
			-- C++ destructor function
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_DESTRUCTOR"
		end
			
	Dispid_collect: INTEGER is
		external
			"C [macro <oaidl.h>]"
		alias
			"DISPID_COLLECT"
		end
	
	Dispid_autosize: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AUTOSIZE"
		end

	Dispid_backcolor: INTEGER is
			-- Control's color scheme
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BACKCOLOR"
		end

	Dispid_backstyle: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BACKSTYLE"
		end

	Dispid_bordercolor: INTEGER is
			-- Control's color scheme
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BORDERCOLOR"
		end

	Dispid_borderstyle: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BORDERSTYLE"
		end

	Dispid_borderwidth: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BORDERWIDTH"
		end

	Dispid_drawmode: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_DRAWMODE"
		end

	Dispid_drawstyle: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_DRAWSTYLE"
		end

	Dispid_drawwidth: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_DRAWWIDTH"
		end
			
	Dispid_fillcolor: INTEGER is
			-- Control's color scheme
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FILLCOLOR"
		end

	Dispid_fillstyle: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FILLSTYLE"
		end

	Dispid_font: INTEGER is
			-- Font used in control
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT"
		end

	Dispid_forecolor: INTEGER is
			-- Control's color scheme
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FORECOLOR"
		end

	Dispid_enabled: INTEGER is
			-- Whether control is enabled or disabled
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_ENABLED"
		end

	Dispid_hwnd: INTEGER is
			-- Window handle of control
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_HWND"
		end

	Dispid_tabstop: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_TABSTOP"
		end

	Dispid_text: INTEGER is
			-- Control's textual contents 
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_TEXT"
		end

	Dispid_caption: INTEGER is
			-- Control's label
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_CAPTION"
		end

	Dispid_bordervisible: INTEGER is
			-- Control's visual behavior: solid or transparent,
			-- thick or thin borders, line style, and so forth
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_BORDERVISIBLE"
		end

	Dispid_appearance: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_APPEARANCE"
		end

	Dispid_refresh: INTEGER is
			-- Refresh standard method
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_REFRESH"
		end

	Dispid_doclick: INTEGER is
			-- Doclick standard method
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_DOCLICK"
		end

	Dispid_aboutbox: INTEGER is
			-- Aboutbox standard method
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_ABOUTBOX"
		end

	Dispid_click: INTEGER is
			-- Click standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_CLICK"
		end

	Dispid_dblclick: INTEGER is
			-- Double click standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_DBLCLICK"
		end

	Dispid_keydown: INTEGER is
			-- Key down standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_KEYDOWN"
		end

	Dispid_keypress: INTEGER is
			-- Key press standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_KEYPRESS"
		end

	Dispid_keyup: INTEGER is
			-- Key up standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_KEYUP"
		end

	Dispid_mousedown: INTEGER is
			-- Mouse down standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_MOUSEDOWN"
		end

	Dispid_mousemove: INTEGER is
			-- Mouse move standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_MOUSEMOVE"
		end

	Dispid_mouseup: INTEGER is
			-- Mouse up standard event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_MOUSEUP"
		end

	Dispid_errorevent: INTEGER is
			-- Error event
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_ERROREVENT"
		end

	Dispid_ambient_backcolor: INTEGER is
			-- Provide controls with default background colors
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_BACKCOLOR"
		end

	Dispid_ambient_displayname: INTEGER is
			-- Container's name for control
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_DISPLAYNAME"
		end

	Dispid_ambient_font: INTEGER is
			-- Default font for the form
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_FONT"
		end

	Dispid_ambient_forecolor: INTEGER is
			-- Provide controls with default foreground colors
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_FORECOLOR"
		end

	Dispid_ambient_localeid: INTEGER is
			-- Language used in container
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_LOCALEID"
		end

	Dispid_ambient_messagereflect: INTEGER is
			-- Whether container wants to receive Windows messages 
			-- such as WM_CTLCOLOR, WM_DRAWITEM, WM_PARENTNOTIFY, 
			-- and so on as events
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_MESSAGEREFLECT"
		end

	Dispid_ambient_scaleunits: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_SCALEUNITS"
		end

	Dispid_ambient_textalign: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_TEXTALIGN"
		end

	Dispid_ambient_usermode: INTEGER is
			-- Whether container is in design mode or run mode 
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_USERMODE"
		end

	Dispid_ambient_uidead: INTEGER is
			-- Whether container is in mode in which controls 
			-- should ignore user input
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_UIDEAD"
		end

	Dispid_ambient_showgrabhandles: INTEGER is
			-- Whether control should show grab handles 
			-- (in the hatch border) when in-place active
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_SHOWGRABHANDLES"
		end

	Dispid_ambient_showhatching: INTEGER is
			-- Whether control should show hatch border when in-place active
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_SHOWHATCHING"
		end

	Dispid_ambient_displayasdefault: INTEGER is
			-- Whether button control should draw itself with 
			-- thicker default frame
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_DISPLAYASDEFAULT"
		end

	Dispid_ambient_supportsmnemonics: INTEGER is
			-- Whether container processes mnemonics or not
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_SUPPORTSMNEMONICS"
		end

	Dispid_ambient_autoclip: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_AUTOCLIP"
		end

	Dispid_ambient_appearance: INTEGER is
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_AMBIENT_APPEARANCE"
		end

	Dispid_font_name: INTEGER is
			-- Font name property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_NAME"
		end

	Dispid_font_size: INTEGER is
			-- Font size property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_SIZE"
		end

	Dispid_font_bold: INTEGER is
			-- bold property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_BOLD"
		end

	Dispid_font_italic: INTEGER is
			-- italics property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_ITALIC"
		end

	Dispid_font_under: INTEGER is
			-- underline property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_UNDER"
		end

	Dispid_font_strike: INTEGER is
			-- strikethrough property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_STRIKE"
		end

	Dispid_font_weight: INTEGER is
			-- Font weight property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_WEIGHT"
		end

	Dispid_font_charset: INTEGER is
			-- Font character set property
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_FONT_CHARSET"
		end

	Dispid_pict_handle: INTEGER is
			-- Picture handle
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_HANDLE"
		end

	Dispid_pict_hpal: INTEGER is
			-- Picture hpalette
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_HPAL"
		end

	Dispid_pict_type: INTEGER is
			-- Picture type
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_TYPE"
		end

	Dispid_pict_width: INTEGER is
			-- Picture width
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_WIDTH"
		end

	Dispid_pict_height: INTEGER is
			-- Picture height
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_HEIGHT"
		end

	Dispid_pict_render: INTEGER is
			-- Render picture
		external
			"C [macro <olectl.h>]"
		alias
			"DISPID_PICT_RENDER"
		end
			
end -- class DISPID

--|-------------------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license.
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1997.
--| Modifications and extensions: copyright (C) ISE, 1997. 
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
