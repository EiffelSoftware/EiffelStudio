

class CMD_LABEL 

inherit

	PIXMAPS
		export
			{NONE} all
		end;

	EB_HASHABLE
		export
			{NONE} all
		end;

	LABEL_STONE;


creation

	make


	
feature 

	make (s: STRING) is
		do
			label := s;
		end;

	
feature {NONE}

	hash_code: INTEGER is
		do
			Result := label.hash_code
		end;

	same (other: CMD_LABEL): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end;

	
feature 

	original_stone: CMD_LABEL is
		do
			Result := Current
		end;

	source: WIDGET is do end;

	symbol: PIXMAP is
		once
			Result := Label_pixmap
		end;

	label: STRING;

-- **************
-- Reuse features
-- **************
 
    parent_type: CMD;
        -- Command which defines
        -- Current label if
        -- introduced by inheritance
 
    set_parent (c: CMD) is
        do
            parent_type := c
        end;

	inherited: BOOLEAN is
		do
			Result := not (parent_type = Void)
		end;

	inh_renamed: BOOLEAN;

	set_renamed  is
		require
			must_be_inherited: inherited;
		do
			inh_renamed := True;
		end;
 
end
