class NEW_LINE_TEXT

inherit
	TEXT_ITEM
		redefine
			image
		end

creation
	make

feature

	make (indent: INTEGER) is
		require
			indent >= 0
		do
			indent_depth := indent;
		end;

	indent_depth: INTEGER;

	image: STRING is
		do
			!!Result.make (indent_depth + 1);
			Result.append ("%N");
			Result.append (indent_text)
		ensure then
			Result.count = indent_depth + 1;
		end;

	indent_text: STRING is
		local
			i: INTEGER
		do
			!!Result.make (indent_depth);
			from 
				i := 1
			until
				i > indent_depth
			loop
				Result.append ("%T");
				i := i + 1;
			end;
		ensure 
			Result.count = indent_depth
		end

invariant
	positive_indent: indent_depth >= 0
end
