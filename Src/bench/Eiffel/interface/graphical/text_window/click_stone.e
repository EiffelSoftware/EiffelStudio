
-- Element one can click on to select `node': an indirect
-- clicking.

class CLICK_STONE 

inherit

	CLICK_INDIR
		redefine
			node
		end

creation

	make

feature 

	node: STONE;
		-- A node is indirectly referenced
		-- A STONE after processing of the click_list (after further compilation
		-- and on demand).

end
