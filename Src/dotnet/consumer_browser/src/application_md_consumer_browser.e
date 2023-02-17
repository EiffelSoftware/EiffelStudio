note
	description: "[
			Enter class description here!
		]"

class
	APPLICATION_MD_CONSUMER_BROWSER

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Instantiate Current object.
		local
			p: PATH
			i,n: INTEGER
			l_entry: READABLE_STRING_GENERAL
			s: READABLE_STRING_32
			l_is_interactive,
			l_is_help: BOOLEAN
			q: MD_QUERY
		do
			create q
			from
				i := 1
				n := argument_count
			until
				i > n
			loop
				s := argument (i)
				if s.starts_with_general ("-") then
					if s.is_case_insensitive_equal_general ("-i") then
						l_is_interactive := True
					elseif s.is_case_insensitive_equal_general ("-h") then
						l_is_help := True
					elseif s.is_case_insensitive_equal_general ("--full") then
						q.enable_full_mode
					elseif i < n then
						if s.is_case_insensitive_equal_general ("--assembly") then
							i := i + 1
							q.assembly := argument (i)
						elseif s.is_case_insensitive_equal_general ("--type") then
							i := i + 1
							q.type := argument (i)
						elseif s.is_case_insensitive_equal_general ("--entity") then
							i := i + 1
							q.entity := argument (i)
						else
							-- ignore !!
						end
					else
						-- Ignore ...
					end
				elseif p = Void then
					create p.make_from_string (s)
				else
					-- Ignore ...
					-- too many parameters
					print_usage
					exit
				end
				i := i + 1
			end
			if p = Void then
				create p.make_current
			end
			create layout.make (p)

			if l_is_help then
				print_usage
				exit
			elseif l_is_interactive then
				q.enable_full_mode
				;(create {MD_TTY_BROWSER}.make (layout)).process (q)
			else
				;(create {MD_TEXT_EXPORTER}.make (layout)).process (q)
			end
		end

feature -- Access

	layout: MD_CACHE_LAYOUT

	print_usage
		do
			print ("Usage: prog <path-to-cache>%N")
			print ("  -i : interactive mode%N")
			print ("  --assembly : filter assembly%N")
			print ("  --type : filter type%N")
			print ("  -h : display this help%N")

			print ("%N")
		end

	exit
		do
			{EXCEPTIONS}.die (0);
		end

invariant

end
