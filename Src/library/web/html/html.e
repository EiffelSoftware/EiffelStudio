class
	HTML
inherit
	ANY
		undefine
			out
		end;

creation
	make

feature

	make is
		do
			!! options.make;
		end;

feature -- Routines out

	out: STRING is
		do
			Result := "<HTML";
			Result.append(attributes_out);
			Result.append(">");
			Result.append("%N");
			Result.append(head_out);
			Result.append("%N");
			Result.append(body_out);
			Result.append("%N</HTML>");
		end;

	body_out: STRING is
		do
			Result := "";
			Result.append("%N<BODY");
			Result.append(body_attributes_out);
			Result.append(">");
			from
				options.start
			until
				options.after
			loop
				Result.append(options.item);
				Result.append("%N");
				options.forth;
			end;
			Result.append("%N</BODY>");
		end;

	attributes_out, body_attributes_out: STRING is
		do
			Result := "";
		end;

	head_out: STRING is
		do 
			Result := "";
			Result.append("<HEAD><TITLE>");
			if has_value(title_value) then
				Result.append(title_value);
			end;
			Result.append("</TITLE></HEAD>");
			Result.append("%N");
		end;

feature -- Wipe out

	wipe_out is
		do
			options.wipe_out;
		end;

feature -- Set 

	set_title(s: STRING) is
		do
			title_value := clone(s);
		end;

feature -- Add new options

	add_option(an_option: STRING) is
		require
			an_option /= Void
		do
			options.extend(clone(an_option));
		end;

feature {NONE}
 
    has_value(s: STRING): BOOLEAN is
            -- Has the attribute 's' a value ?
        do
            if s = Void or else s.is_equal("") then
                Result := false;
            else
                Result := true;
            end;
        end;

feature {NONE}

	title_value: STRING;

	options: LINKED_LIST[STRING];

end -- class HTML
