-- Warning: this is not a real server!

class CLASS_C_SERVER

inherit

	HASH_TABLE [CLASS_C, CLASS_ID]

creation

	make

feature -- Merging

	append (other: like Current) is
			-- Append classes of `other' to `Current'.
		require
			other_not_void: other /= Void
		local
			class_id: CLASS_ID;
			old_cursor: CURSOR;
			class_c: CLASS_C;
			common_classes: ARRAYED_LIST [CLASS_C]
		do
			old_cursor := other.cursor;
			!! common_classes.make (other.count);
			from other.start until other.after loop
				class_id := other.key_for_iteration;
				if has (class_id) then
					common_classes.extend (other.item_for_iteration)
				else
-- TO DO: Check for class name clashes here.
					put (other.item_for_iteration, class_id)
				end
				other.forth
			end;
			other.go_to (old_cursor);
				-- Merge contents of common classes only here because
				-- descencant classes (in E_CLASS) must have already
				-- been inserted into the server. 
			from common_classes.start until common_classes.after loop
				class_c := common_classes.item;
				item (class_c.id).merge (class_c);
				common_classes.forth
			end
		end

end -- class CLASS_C_SERVER
