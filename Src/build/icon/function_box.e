
class FUNCTION_BOX [T -> DATA] 

inherit

	PAGE_BOX [T]
		rename
			make as page_box_make
		end

creation

	make

feature {NONE}

	associated_editor: FUNC_EDITOR;

feature 

	make  (a_name: STRING; a_parent: COMPOSITE; ed: like associated_editor) is
		require
			Valid_editor: ed /= Void
		do
			associated_editor := ed;
			page_box_make (a_name, a_parent)
		end;

end 
