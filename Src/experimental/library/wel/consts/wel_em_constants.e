note
	description: "Edit control message (EM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EM_CONSTANTS

feature -- Access

	Em_getsel: INTEGER = 176

	Em_setsel: INTEGER = 177

	Em_getrect: INTEGER = 178

	Em_setrect: INTEGER = 179

	Em_setrectnp: INTEGER = 180

	Em_scroll: INTEGER = 181

	Em_linescroll: INTEGER = 182

	Em_scrollcaret: INTEGER = 183

	Em_getmodify: INTEGER = 184

	Em_setmodify: INTEGER = 185

	Em_getlinecount: INTEGER = 186

	Em_lineindex: INTEGER = 187

	Em_sethandle: INTEGER = 188

	Em_gethandle: INTEGER = 189

	Em_getthumb: INTEGER = 190

	Em_linelength: INTEGER = 193

	Em_replacesel: INTEGER = 194

	Em_getline: INTEGER = 196

	Em_limittext: INTEGER = 197

	Em_canundo: INTEGER = 198

	Em_undo: INTEGER = 199

	Em_fmtlines: INTEGER = 200

	Em_linefromchar: INTEGER = 201

	Em_settabstops: INTEGER = 203

	Em_setpasswordchar: INTEGER = 204

	Em_emptyundobuffer: INTEGER = 205

	Em_getfirstvisibleline: INTEGER = 206

	Em_setreadonly: INTEGER = 207

	Em_setwordbreakproc: INTEGER = 208

	Em_getwordbreakproc: INTEGER = 209

	Em_getpasswordchar: INTEGER = 210

	Em_getlimittext: INTEGER = 213

	Em_settypographyoptions: INTEGER = 1226

	Em_gettypographyoptions: INTEGER = 1227

	To_simplelinebreak: INTEGER = 2
		-- Simple line settings for use with `Em_settypographyoptions' and
		-- `Em_gettypographyoptions'.

	To_advancedtypography: INTEGER = 1;
		-- Advanced typography settings for use with `Em_settypographyoptions' and
		-- `Em_gettypographyoptions'.

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




end -- class WEL_EM_CONSTANTS

