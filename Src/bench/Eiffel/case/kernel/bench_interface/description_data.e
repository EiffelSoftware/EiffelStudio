indexing

	description: "Description text.";
	date: "$Date$";
	revision: "$Revision $"

class DESCRIPTION_DATA

inherit

	FREE_TEXT_INFO

	ELEMENT_DATA
		undefine
			generate
		end

creation
	
	make_with_default, make_from_storer, make

feature -- Initialization

	make_with_default is
		do
			make;
			reset
		ensure
			initialized: 
		end;

feature -- Properties

	is_default: BOOLEAN is
			-- Is current equal to the default value?
		do
			Result := count = 1 and then 
						first.is_equal (default_value)
		end;

	default_value: STRING is 
		once
			Result := "<<description>>";
		end;

	stone (a_data: DATA): ELEMENT_STONE is
		do
			!! Result.make (Current, a_data);
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.description_type
		end;

	destroy_command (a_data: DATA): DESTROY_DESCRIPTION is
		do
			if count /= 1 or else not
				equal (first, default_value)
			then
				!! Result.make (Current, a_data);
			end
		end;

feature -- Access

	is_valid_for (data: DATA): BOOLEAN is
		local
			sd: SYSTEM_DATA;
			ld: LINKABLE_DATA;
		do
			--sd ?= data;
			--if sd /= Void then
			--	Result := sd.view_description = Current
			--else
			--	ld ?= data
			--	Result := ld /= Void and then ld.description = Current
			--end
		end;

feature -- Element change

	insert_before (data_cont: DATA; a_data: like Current) is
		do
		end;

feature -- Output

	generate_with_percent (text_area: TEXT_AREA; data: DATA) is
		local
			str: STRING
		do
			if not empty then
				if count > 1 then
					text_area.new_line;
					text_area.indent;
				end;
				from
					start;
					str := item;
					if not str.empty and then
						str.item (1) /= '%"'
					then
						text_area.append_character ('%"')
					end;
				until
					after
				loop
					text_area.append_string (item);
					forth;
					if not after then
						text_area.append_character ('%%')
						text_area.new_line;
						text_area.append_character ('%%')
					end;
				end;
				str := last;
				if not str.empty and then
					str.item (last.count) /= '%"'
				then
					text_area.append_character ('%"')
				end;
			--	text_area.append_string(";") -- pascalf
				text_area.new_line;
				if count > 1 then
					text_area.exdent;
				end;
			end;
		end

feature -- Removal

	reset is
		do
			wipe_out;
			put_front (default_value);
		ensure
			has_one: count = 1 and then first.is_equal (default_value)
		end;


end -- class DESCRIPTION_DATA
