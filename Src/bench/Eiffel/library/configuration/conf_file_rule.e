indexing
	description: "Objects that specify rules for files to be excluded or included."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_RULE

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create
		do
			create include_regexp.make
			create exclude_regexp.make
		end

feature -- Status

	is_empty: BOOLEAN is
			-- Is this file rule empty?
		do
			Result := exclude_regexp.is_empty and include_regexp.is_empty
		end

	is_error: BOOLEAN
			-- Is there an error?

	last_error: CONF_ERROR_PARSE
			-- The last error.

feature -- Access, stored in configuration file

	exclude: LINKED_SET [STRING]
			-- Exclude patterns

	include: LINKED_SET [STRING]
			-- Include patterns

	description: STRING
			-- A description about the rules.

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_exclude (an_exclude: like exclude) is
			-- Set `exclude' to `an_exclude'.
		require
			an_exclude_not_void: an_exclude /= Void
		do
			exclude := an_exclude
			compile
		ensure
			exclude_set: exclude = an_exclude
		end

	set_include (an_include: like include) is
			-- Set `include' to `an_include'.
		require
			an_include_not_void: an_include /= Void
		do
			include := an_include
			compile
		ensure
			include_set: include = an_include
		end

	add_exclude (a_pattern: STRING) is
			-- Add an exclude pattern.
		require
			a_pattern_ok: a_pattern /= Void and then not a_pattern.is_empty
		do
			if exclude = Void then
				create exclude.make
				exclude.compare_objects
			end
			exclude.extend (a_pattern)
			compile
		end

	add_include (a_pattern: STRING) is
			-- Add an include pattern.
		require
			a_pattern_ok: a_pattern /= Void and then not a_pattern.is_empty
		do
			if include = Void then
				create include.make
				include.compare_objects
			end
			include.extend (a_pattern)
			compile
		end

	set_description (a_description: like description) is
			-- Set `description' to `a_description'
		do
			description := a_description
		ensure
			description_set: description = a_description
		end


feature {CONF_ACCESS} -- Merging

	merge (other: like Current) is
			-- Merge with other.
		do
			if other /= Void then
				if exclude = Void then
					exclude := other.exclude
				elseif other.exclude /= Void then
					exclude.merge (other.exclude)
				end
				if include = Void then
					include := other.include
				elseif other.include /= Void then

					include.merge (other.include)
				end
			end
			compile
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is it the same file_rule as `other'?
		local
			a, b: LINKED_SET [STRING]
		do
			a := include
			b := other.include
			Result := equal (a, b)
			a := exclude
			b := other.exclude
			Result := equal (a, b)
		end

feature -- Basic operation

	is_included (a_location: STRING): BOOLEAN is
			-- Test if `a_location' is included according to the exclude/include rules.
			-- That means it is either not excluded or it is included.
		local
			l_done: BOOLEAN
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			Result := True
			from
				exclude_regexp.start
			until
				exclude_regexp.after or l_done
			loop
				l_regexp := exclude_regexp.item
				l_regexp.match (a_location)
				if l_regexp.has_matched then
						-- it's excluded, check if there is an include that matches
					Result := False
					l_done := True
					from
						include_regexp.start
					until
						include_regexp.after or Result
					loop
						l_regexp := include_regexp.item
						l_regexp.match (a_location)
						Result := l_regexp.has_matched
						include_regexp.forth
					end
				end
				exclude_regexp.forth
			end
		end

feature {NONE} -- Implementation

	set_error (an_error: CONF_ERROR_PARSE) is
			-- Set `an_error'.
		do
			is_error := True
			last_error := an_error
		end

	compile is
			-- (Re)compile the regexp patterns.
		local
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
			l_er: CONF_ERROR_REGEXP
		do
			exclude_regexp.wipe_out
			include_regexp.wipe_out
			if exclude /= Void then
				from
					exclude.start
				until
					exclude.after
				loop
					create l_regexp.make
					l_regexp.compile (exclude.item)
					if not l_regexp.is_compiled then
						create l_er
						l_er.set_regexp (exclude.item)
					else
						l_regexp.optimize
						exclude_regexp.extend (l_regexp)
					end
					exclude.forth
				end
			end
			if include /= Void then
				from
					include.start
				until
					include.after
				loop
					create l_regexp.make
					l_regexp.compile (include.item)
					if not l_regexp.is_compiled then
						create l_er
						l_er.set_regexp (include.item)
					else
						l_regexp.optimize
						include_regexp.extend (l_regexp)
					end
					include.forth
				end
			end
		end

	exclude_regexp: LINKED_SET [RX_PCRE_REGULAR_EXPRESSION]
	include_regexp: LINKED_SET [RX_PCRE_REGULAR_EXPRESSION]
			-- The compiled regexp objects of the strings.

invariant
	exclude_regexp_not_void: exclude_regexp /= Void
	include_regexp_not_void: include_regexp /= Void
	error_message: is_error implies last_error /= Void

end
