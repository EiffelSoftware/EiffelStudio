class LABEL_TEXT_FIELD

inherit

	TEXT
		rename
			make as tf_make
		end;
	COMMAND
		redefine
			context_data_useful
		end

creation

	make

feature {NONE}

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			tf_make (a_name, a_parent);
			set_single_line_mode;
			add_modify_action (Current, Void);
		end;

	context_data_useful: BOOLEAN is
			-- Context data needed.
		do
			Result := True
		end;

	execute (arg: ANY) is
		local
			modify_data: MODIFY_DATA;
			c: CHARACTER
		do
			modify_data ?= context_data;
			if not modify_data.text.empty then
				c := modify_data.text.item (1);
				inspect c
					when 'a'..'z', 'A'..'Z' then
					when '_', '0'..'9' then
						if modify_data.start_position = 0 then	
							forbid_action
						end
					else
						forbid_action
					end;
			end;
		end;

end
