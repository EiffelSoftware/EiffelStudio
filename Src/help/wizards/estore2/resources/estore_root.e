indexing
	description: "Generated Root Class by The EiffelStore Wizard"

class
	ESTORE_ROOT

create
	make

feature -- Initialization

	make is
			-- Initialize
		local
			li: ARRAYED_LIST [<FL1>]
		do
			io.put_string ("%NConnecting with username '" + username +
					"', password '" + password + "' and data source '" +
					data_source + "'...")
			create estore_example.initialize (username, password, data_source)

			io.put_string ("%NProcessing Request ...")
			io.put_string ("%NQuery:<FL3>")

				-- Retrieve the linked list of <FL1>, result of the generated request.
			li := estore_example.<FL2>

			if li.count > 0 then
				io.put_string ("%NThere are " + li.count.out + " found items.")
					-- Display only the first Result of the request
				io.put_string (li.first.out)
			else
				io.put_string ("%NNo items found")
			end
		end

feature -- Access

	estore_example: ESTORE_EXAMPLE
		-- Example reference

	username: STRING is "<FL4>"
		-- Database username.

	password: STRING is "<FL5>"
		-- Database password.

	data_source: STRING is "<FL6>"
		-- Database data source.

end -- Class ESTORE_ROOT