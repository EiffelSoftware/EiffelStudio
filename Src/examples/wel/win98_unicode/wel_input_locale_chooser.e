indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INPUT_LOCALE_CHOOSER

inherit 
	WEL_DROP_DOWN_LIST_COMBO_BOX

	redefine 
		on_cbn_selchange
	end

create
	make
	
feature
	
	on_lbn_selchange is
			-- 
		do
			lang_edit.set_focus
			imm.switch_input_locale (input_locale)
		end
		

end -- class WEL_INPUT_LOCALE_CHOOSER
