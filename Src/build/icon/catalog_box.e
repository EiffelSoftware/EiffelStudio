
class CATALOG_BOX [T -> STONE] 

inherit

	ICON_BOX [T]
		rename
			make as make_visible
		end

creation

	make

feature {NONE}

	associated_catalog: CATALOG [STONE];

feature 

	make (cat: like associated_catalog) is
		do
			linked_list_make;
			!!icons.make;
			associated_catalog := cat;
		end;

end 
