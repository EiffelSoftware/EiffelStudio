indexing
	description: "Root Class"

class
	ESTORE_ROOT

Creation
	make

feature -- Initialization

	make is
		-- Initialize
		local
			li: LINKED_LIST[<FL1>]
			s1,s2: STRING
		do
			io.put_string("%NConnecting with username <FL4> and password <FL5>...")
			Create estore_example.initialize("<FL4>","<FL5>")
			io.put_string("%NProcessing Request ...")
			io.put_string("%NQuery:<FL3>")
			li := estore_example.<FL2>
			if li.count>0 then
				io.put_string("%NThere are "+li.count.out+" found items.")
				io.put_string(li.first.out)
			else
				io.put_string("%NNo items found")
			end
		end

feature -- Access

	estore_example: ESTORE_EXAMPLE
		-- Example reference

end -- Class ESTORE_ROOT