indexing

	description: "Data that has a tag and a tex.";
	date: "$Date$";
	revision: "$Revision $"

class TAG_INFO

inherit

	ANY
		redefine
			copy, is_equal
		end;

feature -- Properties

	tag: STRING;
			-- Tag

	text: STRING
			-- Text

feature -- Setting

	set_tag (tg: STRING) is
			-- Set tag to `tg'.
		require
			valid_name: tg /= Void;
		do
			tag := clone (tg);
		ensure
			correctly_set: tag.is_equal (tg)
		end;

	set_text (txt: STRING) is
			-- Set id to `text'.
		require
			valid_txt: txt /= Void
		do
			text := txt
		end;

feature {NONE} -- Implementation

	make (tg, txt: STRING) is
			-- Make Current with tag `tg' with expression `exp'.
		require
			valid_exp: txt /= Void
		do
			tag := tg;
			text := txt;
		ensure
			tag_set: tag = tg;
			text_set: text = txt
		end;

	copy (other: like Current) is
		do
			tag := clone (other.tag);
			text := clone (other.text)
		end;

	is_equal (other: like Current): BOOLEAN is
		do
			Result := equal (tag, other.tag) and then	
				equal (text, other.text)
		end

	--update_from_namer (namer: NAMER_WINDOW) is
	--	do
	--		make (namer.entered_tag, namer.entered_text);
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--	do
	--		namer.set_up (True, False);
	--		if tag = Void then
	--			namer.set_tag_id  ("");
	--		else
	--			namer.set_tag_id  (tag);
	--		end
	--		namer.set_tag_text (text);
	--		namer.set_tag_empty;
	--	end;

feature -- OutPut

	focus, clickable_string: STRING is
		local
			s: STRING
			ind: INTEGER
		do
			!! Result.make (0);
			if tag /= Void and then not tag.empty then
				Result.append (tag);
				Result.append (": ");
			end
			if text/= Void and then text.count>0 then
				if text.item(1)='.' then
					text.prune('.')
				elseif
					text.item(1)='(' and then text.count>1 then
						if text.item(2)='.' then
							text.prune('.')
						end
				end
				if text.has('%/255/') then
						ind := text.index_of('%/255/',1)
						!! s.make(20)
						s.append("%%")
						s.append("/255/")
						text.remove(ind)
						text.insert(s,ind)
				end
			end
			Result.append (text);
		end;

feature -- Storage

	storage_info: S_TAG_DATA is
		do
			!! Result.make (tag, text)
		end

feature {NONE} -- Storage

	make_from_storer (storer: S_TAG_DATA) is
			-- Create Current and set values using `storer'.
		require
			valid_storer: storer /= Void
		do
			tag := storer.tag;
			text := storer.text
		end;

end -- class TAG_INFO
