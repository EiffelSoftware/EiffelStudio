
class CUT_HOLE 

inherit

	EB_BUTTON;
	HOLE
		rename
			target as focus_source
		redefine
			process_any
		end

creation

	make

feature {NONE}

	focus_label: FOCUS_LABEL;
 
	focus_string: STRING is 
		do
			Result := Focus_labels.wastebasket_label;
		end;
	
	make (a_parent: COMPOSITE; l: FOCUS_LABEL) is
		require
			valid_a_parent: a_parent /= Void;
			valid_l: l /= Void
		do
			focus_label := l;
			make_visible (a_parent);
			register
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.wastebasket_pixmap
		end;
	
feature {NONE}

	stone_type: INTEGER is 
		do 
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		local
			r: REMOVABLE;
		do
			r ?= dropped;
			if (r /= Void) then
				r.remove_yourself;
			end;
		end;

end
