
class ALIGNMENT_ICON 

inherit

	CON_ICON_STONE
		undefine
			is_equal
		redefine
			transportable
		end;
	HOLE
		rename
			target as source
		undefine
			is_equal
		redefine
			process_context
		end;
	REMOVABLE
		undefine
			is_equal
		end;
	COMPARABLE

creation

	make, make_for_sort

feature {NONE}

	associated_box: ALIGNMENT_BOX;

	make (ab: ALIGNMENT_BOX) is
		do
			associated_box := ab;
			register
		end;

	make_for_sort (is_vert: BOOLEAN; d: CONTEXT) is
		do
			set_data (d);
			is_vertical := is_vert;
		end

	is_vertical: BOOLEAN;

	transportable: BOOLEAN is
		do
			Result := not data.deleted
		end;

feature {NONE}

	process_context (dropped: CONTEXT_STONE) is
		do
			associated_box.insert_after (data, 
							dropped.data)
		end;

	remove_yourself is
		do
			associated_box.remove_icon (Current)
		end;

    infix "<" (other: like Current): BOOLEAN is 
        do
            if is_vertical then
                Result := data.y < other.data.y
            else
                Result := data.x < other.data.x
			end
        end;

end
