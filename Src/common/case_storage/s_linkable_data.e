class S_LINKABLE_DATA

inherit

	S_COORD_XY_DATA;

feature

	name: STRING;
			-- Current's name

	chart: S_CHART;
			-- Informal description of Current

	client_links: FIXED_LIST [S_CLI_SUP_DATA];
			-- List of client/supplier relations for which current
			-- is the client

	heir_links: FIXED_LIST [S_RELATION_DATA];
			-- List of inheritance relations for which current is the heir

feature -- Setting values

	make (s: STRING) is
			-- Set name to `s'.
		require
			valid_s: s /= Void
		do
			name := s
		ensure
			name_set: name = s
		end;

	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		require
			valid_chart: ch /= Void
		do
			chart := ch
		ensure
			name_set: chart = ch
		end;

	set_client_links (l: like client_links) is
			-- Set client_links to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			client_links := l
		ensure
			client_links_set: client_links = l
		end;

	set_heir_links (l: like heir_links) is
			-- Set heir_links to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty
		do
			heir_links := l
		ensure
			heir_links_set: heir_links = l
		end;

end
