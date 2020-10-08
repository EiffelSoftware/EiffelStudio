note
	description: "Summary description for {EIFFEL_UPLOAD_CONFIGURATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_UPLOAD_CONFIGURATION

feature -- Access

	location: detachable STRING
			-- product's location.

	files: detachable LIST [TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]]
			-- {"name":"Eiffel_14.05_community_95417-freebsd-x86-64.tar.bz2", "size":88997196, "sha256":"8013063380a1faae30e0bc429f3ad1423ea8470045dfa57d0f6f83d901e3982e", "version":"14_05", "major":"14", "minor":"05", "revision":95417, "platform":"freebsd-x86-64"},

	id:  STRING = "eiffelstudio"

    name: STRING = "EiffelStudio"

feature -- Element Change

	set_location (a_location: STRING)
			-- Set 'location' with 'a_location'.
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	add_element (a_element: TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING])
			-- Add a file element 'a_element' description to the list of files 'files'.
		local
			l_files: like files
		do
			l_files := files
			if attached
				{ARRAYED_LIST [TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]]} l_files as ll_files
			then
				insertion_sort (a_element, ll_files)
			else
				create {ARRAYED_LIST [TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]]} l_files.make (1)
				l_files.force (a_element)
			end
			files := l_files
		end

	insertion_sort (a_element: TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]; a_file: ARRAYED_LIST [TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]])
			-- Insert elements into the list following the following order by platforms
			-- [win64, windows, linux-x86-64, linux-x86, linux-x86-64-suncc, linux-armv6, macosx-x86-64, solaris-sparc-64, solaris-sparc, freebsd-x86-64, freebsd-x86, openbsd-x86-64]
		local
			is_inserted: BOOLEAN
			l_file: ARRAYED_LIST [TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]]
			l_element: TUPLE [name: STRING; size: INTEGER_64; sha256: STRING; version: STRING; major: STRING; minor: STRING; revision: INTEGER_64; platform: STRING]
		do
			l_file := a_file
			l_element := a_element
			from
				l_file.start
			until
				l_file.after or is_inserted
			loop
				if l_element.platform.is_case_insensitive_equal_general ("win64") then
					l_file.put_front (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("windows") and then
					not l_file.item.platform.is_case_insensitive_equal_general ("win64")
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("linux-x86-64") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("linux-x86") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("linux-x86-suncc") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("linux-armv6") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("macosx-x86-64") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("solaris-sparc-64") and then not(
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("solaris-sparc") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("solaris-x86-64") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("solaris-x86") and then not (
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64")or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True

				elseif l_element.platform.is_case_insensitive_equal_general ("freebsd-x86-64") and then not(
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("freebsd-x86") and then not(
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("freebsd-x86-64"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				elseif l_element.platform.is_case_insensitive_equal_general ("openbsd-x86-64") and then not(
					l_file.item.platform.is_case_insensitive_equal_general ("win64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("windows") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-64-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-x86-suncc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("linux-armv6") or else
					l_file.item.platform.is_case_insensitive_equal_general ("macosx-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-sparc") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("solaris-x86") or else
					l_file.item.platform.is_case_insensitive_equal_general ("freebsd-x86-64") or else
					l_file.item.platform.is_case_insensitive_equal_general ("freebsd-x86"))
				then
					l_file.put_left (l_element)
					is_inserted := True
				end
				l_file.forth
			end
			if not is_inserted then
				l_file.force (l_element)
			end
		end

	version: STRING
		do
			if
				attached files as l_files and then
				not l_files.is_empty
			then
				Result := number
			else
				Result := ""
			end
		end

	number: STRING
		do
			if
				attached files as l_files and then
				not l_files.is_empty
			then
				Result := l_files.at (1).version
			else
				Result := ""
			end
		end

	build: STRING
		do
			if
				attached files as l_files and then
				not l_files.is_empty
			then
				Result := "Build_" + l_files.at (1).revision.out
			else
				Result := ""
			end
		end

	to_json_representation: STRING_8
		do
			create Result.make_from_separate ("{%N")
		    Result.append ("%"mirror%": %"http://sourceforge.net/projects/eiffelstudio/files/%"")
		    Result.append (",%N")
			Result.append ("%"products%":%N")
			Result.append ("{%N")
			Result.append ("%T%"id%": ")
			Result.append ("%"")
			Result.append (id)
			Result.append ("%"")
			Result.append (",%N")
			Result.append ("%T%"name%": ")
			Result.append ("%"")
			Result.append (name)
			Result.append ("%"")
			Result.append (",%N")
			Result.append ("%T%"version%":")
			Result.append ("%"")
			Result.append (version)
			Result.append ("%"")
			Result.append (",%N")
			Result.append ("%T%"number%":")
			Result.append ("%"")
			Result.append (number)
			Result.append ("%"")
			Result.append (",%N")
			Result.append ("%T%"build%":")
			Result.append ("%"")
			Result.append (build)
			Result.append ("%"")
			Result.append (",%N")

			Result.append ("%T%"download%":")
			if attached files as l_files then
				Result.append ("[")
				across l_files as ic loop
					Result.append ("%N")
					Result.append ("%T{%N")
					Result.append ("%T%T%"platform%": ")
					Result.append ("%"")
					Result.append (ic.item.platform)
					Result.append ("%"")
					Result.append (",%N")
					Result.append ("%T%T%"filename%": ")
					Result.append ("%"")
					Result.append (ic.item.name)
					Result.append ("%"")
					Result.append (",%N")
					Result.append ("%T%T%"size%":")
					Result.append ("%"")
					Result.append (ic.item.size.out)
					Result.append ("%"")
					Result.append (",%N")
					Result.append ("%T%T%"hash%":")
					Result.append ("%"")
					Result.append (ic.item.sha256)
					Result.append ("%"")
					Result.append ("%N")
					Result.append ("%T}")
					Result.append (",")
				end
				Result.remove_tail (1)
				Result.append ("%N")
				Result.append ("%T]")
				Result.append ("%N")
			else
					-- do nothing
				Result.append ("[]")

			end
			Result.append ("}")
			Result.append ("}")
		end

end
