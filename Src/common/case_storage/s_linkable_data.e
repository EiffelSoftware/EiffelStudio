indexing

	description: 
		"Abstraction class for linkable data objects.%
		%A linkable object is an entity that has relationships%
		%with other entities (i.e. it is linked to another entity).";
	date: "$Date$";
	revision: "$Revision $"

deferred class S_LINKABLE_DATA

inherit

	COMPARABLE

feature -- Properties

	view_id: INTEGER;
			-- View Id of Current

	name: STRING;
			-- Current's name

	file_name: STRING;
			-- Current's file_name
			--| Does not include path

	description: S_FREE_TEXT_DATA;
			-- Description of Current

	explanation: S_FREE_TEXT_DATA;
			-- Brief explanation of Current

	client_links: ARRAYED_LIST [S_CLI_SUP_DATA];
			-- List of supplier relations for which current
			-- is the client

	heir_links: ARRAYED_LIST [S_INHERIT_DATA];
			-- List of inheritance relations for which current is the heir

	chart: S_CHART is
			-- Informal chart of Current
		do
		end;

feature -- Setting 

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
			valid_i: i /= 0
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

	set_explanation (l: like explanation) is
			-- Set explanation to `l'.
		require
			valid_l: l /= Void;
		do
			explanation := l
		ensure
			explanation_set: explanation = l
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

	set_x (a : INTEGER) is
		do
			x := a
		end

	set_y (a : INTEGER) is
		do
			y := a
		end

	set_color ( s : STRING ) is
		do
			if s /= Void then
				color_name := clone (s)
			else
				color_name := "default"
			end
		end

	set_hidden ( b : BOOLEAN ) is
		do
			is_hidden := b
		end

feature

	x : INTEGER

	y : INTEGER

	color_name : STRING

	is_hidden : BOOLEAN


end -- class S_LINKABLE_DATA
