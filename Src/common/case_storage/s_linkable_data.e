class S_LINKABLE_DATA

feature

	view_id: INTEGER;
			-- View Id of Current

	name: STRING;
			-- Current's name

	file_name: STRING;
			-- Current's file_name
			--| Does not include path

	description: S_FREE_TEXT_DATA;
			-- Description of Current
 
	client_links: ARRAYED_LIST [S_CLI_SUP_DATA];
			-- List of supplier relations for which current
			-- is the client

	heir_links: FIXED_LIST [S_RELATION_DATA];
			-- List of inheritance relations for which current is the heir

feature

	chart: S_CHART is
			-- Informal chart of Current
		do
		end;

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

	set_view_id (i: INTEGER) is
			-- Set id to `i'.
		require
			valid_i: i > 0
		do
			view_id := i
		ensure
			view_id_set: view_id = i
		end;

	set_file_name (s: STRING) is
			-- Set file_name to `s'.
		require
			valid_s: s /= Void
		do
			file_name := s
		ensure
			file_name_set: file_name = s
		end;

	set_description (l: like description) is
			-- Set description to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			description := l
		ensure
			description_set: description = l
		end;

	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		require
			valid_chart: ch /= Void
		do
		ensure
			name_set: chart = ch
		end;

	set_client_links (l: like client_links) is
			-- Set client_links to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			client_links := l
		ensure
			client_links_set: client_links = l
		end;

	set_heir_links (l: like heir_links) is
			-- Set heir_links to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			heir_links := l
		ensure
			heir_links_set: heir_links = l
		end;

end
