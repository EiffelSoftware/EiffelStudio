class CONTEXT_TREE_B 
inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
		do
			if armed then
				Tree.show
			else
				Tree.hide
			end
		end

end
