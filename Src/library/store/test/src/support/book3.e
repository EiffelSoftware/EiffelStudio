note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BOOK3

inherit
	ANY
		redefine
			is_equal,
			out
		end

create
	make

feature -- Access

	title: STRING

	author: IMMUTABLE_STRING_8

--	very_very_very_very_very_very_very_very_very_very_very_very_long_boolean: BOOLEAN

	very_very_very_very_very_very_very_very_long_boolean: BOOLEAN

feature -- Query

	is_equal (other: like Current): BOOLEAN
			-- Is the same as `other'?
			do
				if other = Current then
					Result := True
				else
					Result := title ~ other.title and then
							author ~ other.author and then
							very_very_very_very_very_very_very_very_long_boolean = other.very_very_very_very_very_very_very_very_long_boolean
				end
		end

feature -- Element Change

 	set_title (t: like title)
			-- Set `title' with `t'
		require
			argument_exists: not (t = Void)
		do
			title := t
		ensure
			title = t
		end

	set_author (a: like author)
			-- Set `author' with `a'
		require
			argument_exists: not (a = Void)
		do
			author := a
		ensure
			author = a
		end

	set_very_long_boolean (b: like very_very_very_very_very_very_very_very_long_boolean)
			-- Set `very_very_very_very_very_very_very_very_long_boolean' with `b'
		do
			very_very_very_very_very_very_very_very_long_boolean := b
		end

	set_from_array (v:  ARRAY [ANY])
		local
			q: detachable BOOLEAN_REF
			p, b: detachable DOUBLE_REF
		do
			if attached {like title} v.item (1) as l_title then
				title := l_title
			end

			if attached {like author} v.item (2) as l_author then
				author := l_author
			end

			if attached {BOOLEAN_REF} v.item (3) as l_b then
				very_very_very_very_very_very_very_very_long_boolean := l_b
			else
				check is_not_boolean: False end
			end
		end

	make
		do
			create title.make (80)
			create author.make_filled ('x', 80)
		end

	out: STRING
			-- Display contents
		do
			create Result.make (100)
			if author /= Void then
				Result.append ("Author:")
				Result.append (author)
				Result.extend ('%N')
			end
			if title /= Void then
				Result.append ("Title:")
				Result.append (title)
				Result.extend ('%N')
			end
			Result.append ("Quantity:")
			Result.append (very_very_very_very_very_very_very_very_long_boolean.out)
			Result.append ("%N")
		end

end
