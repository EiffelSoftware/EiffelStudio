note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_REVISION_INFO

inherit
	SVN_CONSTANTS
		export
			{NONE} all;
			{ANY} kind_to_string
		undefine
			is_equal
		end

	COMPARABLE

create
	make

feature

	make (r: INTEGER)
		do
			revision := r
			create log_message.make_empty
			create date.make_empty
			create author.make_empty
--			create {ARRAYED_LIST [TUPLE [path: STRING; kind: NATURAL_8; action: STRING]]} paths.make (3)
			create {ARRAYED_LIST [like paths.item_for_iteration]} paths.make (3)
		end

feature -- Access

	revision: INTEGER

	author: STRING

	date: STRING

	paths: LIST [TUPLE [path: STRING; kind: NATURAL_8; action: STRING]]

	common_parent_path: STRING
		local
			p: STRING
			r: detachable STRING
			i, c: INTEGER
		do
			if attached paths as l_paths and then not l_paths.is_empty then
				if l_paths.first.kind = kind_dir then
					r := l_paths.first.path.string
					format_folder_name (r)
				else
					r := folder_name (l_paths.first.path)
				end

				if l_paths.count > 1 then
					from
						l_paths.start
						c := r.count
					until
						l_paths.after or r.is_empty
					loop
						p := l_paths.item.path
						from
							i := 1
						until
							i > c or i > p.count
						loop
							if r[i] /= p[i] then
								r := folder_name (r.substring (1, i - 1))
								c := r.count
							end
							i := i + 1
						end
						l_paths.forth
					end
				end
			end
			if r /= Void then
				if r[r.count] = '/' then
					Result := r.substring (1, r.count - 1)
				else
					Result := r
				end
			else
				create Result.make_empty
			end
		end

	folder_name (s: STRING): STRING
		local
			p: INTEGER
		do
			p := s.last_index_of ('/', s.count)
			if p > 0 and p < s.count then
				Result := s.substring (1, p)
			else
				Result := s.string
				format_folder_name (Result)
			end
		ensure
			Result /= s
		end

	format_folder_name (s: STRING)
		require
			s_attached: s /= Void
		do
			from
			until
				s.count = 0 or else s[s.count] /= '/'
			loop
				s.remove_tail (1)
			end
			s.extend ('/')
		ensure
			string_with_final_separator: s.count > 0 and then s[s.count] = '/'
		end

	log_message: STRING

	single_line_log_message: like log_message
		do
			Result := log_message.string
			Result.left_adjust
			Result.right_adjust
			if Result.occurrences ('%N') > 0 then
				Result.replace_substring_all ("%N", "%%N")
			end
		end

feature -- Status report

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := revision < other.revision
		end

feature -- Element change

	set_revision (v: like revision)
		do
			revision := v
		end

	set_author (v: like author)
		do
			author := v
		end

	set_date (v: like date)
		do
			date := v
		end

	set_log_message (v: like log_message)
		do
			log_message := v
		end

	add_path (a_path: STRING; a_kind: STRING; a_action: STRING)
		do
			paths.force ([a_path, string_to_kind (a_kind), a_action])
		end

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
