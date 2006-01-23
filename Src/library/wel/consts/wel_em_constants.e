indexing
	description: "Edit control message (EM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_EM_CONSTANTS

feature -- Access

	Em_getsel: INTEGER is 176

	Em_setsel: INTEGER is 177

	Em_getrect: INTEGER is 178

	Em_setrect: INTEGER is 179

	Em_setrectnp: INTEGER is 180

	Em_scroll: INTEGER is 181

	Em_linescroll: INTEGER is 182

	Em_scrollcaret: INTEGER is 183

	Em_getmodify: INTEGER is 184

	Em_setmodify: INTEGER is 185

	Em_getlinecount: INTEGER is 186

	Em_lineindex: INTEGER is 187

	Em_sethandle: INTEGER is 188

	Em_gethandle: INTEGER is 189

	Em_getthumb: INTEGER is 190

	Em_linelength: INTEGER is 193

	Em_replacesel: INTEGER is 194

	Em_getline: INTEGER is 196

	Em_limittext: INTEGER is 197

	Em_canundo: INTEGER is 198

	Em_undo: INTEGER is 199

	Em_fmtlines: INTEGER is 200

	Em_linefromchar: INTEGER is 201

	Em_settabstops: INTEGER is 203

	Em_setpasswordchar: INTEGER is 204

	Em_emptyundobuffer: INTEGER is 205

	Em_getfirstvisibleline: INTEGER is 206

	Em_setreadonly: INTEGER is 207

	Em_setwordbreakproc: INTEGER is 208

	Em_getwordbreakproc: INTEGER is 209

	Em_getpasswordchar: INTEGER is 210

	Em_getlimittext: INTEGER is 213
	
	Em_settypographyoptions: INTEGER is 1226
	
	Em_gettypographyoptions: INTEGER is 1227
	
	To_simplelinebreak: INTEGER is 2
		-- Simple line settings for use with `Em_settypographyoptions' and
		-- `Em_gettypographyoptions'.
	
	To_advancedtypography: INTEGER is 1;
		-- Advanced typography settings for use with `Em_settypographyoptions' and
		-- `Em_gettypographyoptions'.

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




end -- class WEL_EM_CONSTANTS

