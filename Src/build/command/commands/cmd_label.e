

class CMD_LABEL 

inherit

	DATA;
	EB_HASHABLE
	LABEL_STONE;

creation

	make
	
feature {NONE}

	make (s: STRING) is
		do
			label := s;
		end;

	help_file_name: STRING is
		do
			Result := Help_const.label_help_fn
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

	data: CMD_LABEL is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		once
			Result := Pixmaps.label_pixmap
		end;

	label: STRING;

feature

	inh_renamed: BOOLEAN;

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

	set_renamed  is
		require
			must_be_inherited: inherited;
		do
			inh_renamed := True;
		end;
 
end
