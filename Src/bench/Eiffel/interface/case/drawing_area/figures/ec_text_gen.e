indexing

	description: 
		"Factorization of text abilities.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EC_TEXT_GEN 

inherit

	EC_FIGURE;
--	G_ANY
	--	export
	--		{NONE} all
	--	end
	EV_ANY

feature -- Properties

	font: EV_FONT;
			-- Font to be used

	base_left: EC_COORD_XY;
			-- Base left point for the text to be drawn

	origin: EC_COORD_XY is
		do
			Result := base_left
		end; -- origin

	text: STRING;
			-- Text to be drawn

	vertical: BOOLEAN;
			-- Are the words to be drawn vertically (from top to bottom) ?

	words_count: INTEGER is
			-- Number of words in 'text' if vertical (else 1)
		do
			if vertical then
				Result := words.count
			else
				Result := 1
			end
		end; -- words_count

	longest_word: STRING is
			-- longest word of 'text'
		do
			if vertical then
				from
					words.start;
					Result := clone (words.item);
					words.forth
				until
					words.after
				loop
					if words.item.count > Result.count then
						Result := clone (words.item);
					end;
					words.forth
				end;
			else
				Result := text
			end;
					-- This is a hack so the width is wider since
					-- string_width doesn't get the correct width.
			Result := clone (Result);
			Result.extend ('.');
		end; -- longest_word

	line_space: INTEGER;
			-- Space between 2 words 'base_left' in pixel (vertical mode)

feature -- Setting

	set_font (a_font: like font) is
			-- Set `font' to `a_font'
		require
			a_font_exists: not (a_font = Void);
		do
			font := a_font
		end -- set_font

	set_base_left (x, y: INTEGER) is
			-- Set `base_left' coordinates.
		do
			base_left.set (x,y)
		end; -- set_base_left

	set_verticality (to: like vertical) is
		do
			vertical := to
		ensure
			vertical_correctly_set: vertical = to
		end; -- set_verticality

	set_line_space (at: like line_space) is
		require
			has_space: at > 0
		do
			line_space := at
		ensure
			line_space_correctly_set: line_space = at
		end; -- set_line_space

	set_separator (a_separator: like separator) is
		do
			separator := a_separator
		ensure
			separator_correctly_set: separator = a_separator
		end; -- set_separator

	set_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: not (a_text = Void)
		do
			text := clone (a_text)
		end; -- set_text

feature -- Update

	xyrotate (a: REAL; px, py: INTEGER) is
		do
		end; -- xyrotate

	xyscale (f: REAL; px, py: INTEGER) is
		do
		end; -- xyscale

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically
		do
			base_left.xytranslate (vx, vy)
		end -- xytranslate

feature {GRAPH_RELATION} -- Implementation

	set_words (w: like words) is
		require
			valid_words: w /= Void
		do
			words := w
		end;

	words: LINKED_LIST [STRING];
			-- Words parsed in 'text'

	separator: CHARACTER;
			-- Separator delimiting words in 'text'

invariant

	not (text = Void)


end -- class EC_TEXT_GEN
