class SHARED_BENCH_LICENSES

inherit
	EXCEPTIONS
		rename
			raise as raise_exception
		end

feature {NONE}

	license: LICENSE is
		local
			l: LIBRARY_LICENSE
		once
			!BENCH_LICENSE! Result.make
			Result.set_version (4.0);
			Result.set_application_name ("eiffelbench")
			licenses.put (Result, "eiffelbench")
		end

	init_license: BOOLEAN is
			-- Initialization of the EiffelBench license
		do
			license.get_license
			Result := license.licensed
		end

	discard_licenses is
		do
			from
				licenses.start
			until
				licenses.after
			loop
				licenses.item_for_iteration.discard
				licenses.forth
			end
		end

	lic_die (i: INTEGER) is
		do
			discard_licenses
			die (i)
		end

feature {NONE} -- Implementation

	licenses: HASH_TABLE [LICENSE, STRING] is
			-- Licenses for the application
		Once
			!! Result.make (5)
		end

end
