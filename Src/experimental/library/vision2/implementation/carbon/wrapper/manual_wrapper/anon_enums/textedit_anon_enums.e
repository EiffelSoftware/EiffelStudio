note
	description : "Wrapper for anynymous enums from file TextEdit.h"

class
	TEXTEDIT_ANON_ENUMS

feature -- Carbon constants
	
	frozen teJustLeft: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teJustLeft"
	end	

	frozen teJustCenter: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teJustCenter"
	end
	
	frozen teJustRight: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teJustRight"
	end
	
	frozen teForceLeft: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teForceLeft"
	end
	
	frozen teFlushDefault: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teFlushDefault"
	end

	frozen teCenter: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teCenter"
	end

	frozen teFlushRight: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teFlushRight"
	end

	frozen teFlushLeft: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"teFlushLeft"
	end
	
end
