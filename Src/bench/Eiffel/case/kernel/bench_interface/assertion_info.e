indexing

	description: "Data representing assertion tag information.";
	date: "$Date$";
	revision: "$Revision $"


class ASSERTION_INFO

inherit

	TAG_INFO
		rename
			text as expression
		end

feature -- Access

	illegal_characters (tg, text: STRING): BOOLEAN is
		require
			valid_tg	: tg	/= void
			valid_text	: text	/= void
		local
			i: INTEGER;
			ch: CHARACTER;
		do
			from
				i := 1
			until
				i > tg.count or else Result
			loop
				ch := tg.item (i);
				Result := ch /= '_' and then
							(ch < '0' or ch > '9') and then
							(ch < 'A' or ch > 'Z') and then
							(ch < 'a' or ch > 'z');
				i := i + 1;
			end;
			if not Result then
				from
					i := 1
				until
					i > text.count or else Result
				loop
					ch := text.item (i);
					Result := ch /= '_' and then ch /= ' ' and then
								ch /= '(' and then
								ch /= ')' and then
								ch /= '+' and then
								ch /= '-' and then
								ch /= '*' and then
								ch /= '\' and then
								ch /= '>' and then
								ch /= '<' and then
								ch /= '/' and then
								ch /= '=' and then
								ch /= ',' and then -- added by pascalf, bug of Jenkins
								ch /= '.' and then
								ch /= '"' and then
								ch /= '%'' and then
								ch /= '^' and then
								ch /= '@' and then
								(ch < '0' or ch > '9') and then
								(ch < 'A' or ch > 'Z') and then
								(ch < 'a' or ch > 'z');
					i := i + 1;
				end;
			end;
		end;

feature -- Output

	assertion_clause: STRING is
		do	
			if tag /= void
			then
				!! Result.make (0);
				if not tag.empty then
					Result.append (tag);
					Result.append (": ");
				end;
				Result.append (expression);
			end
		end;

invariant

	non_void_invariant: expression /= Void

end -- class ASSERTION_INFO
