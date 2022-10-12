note
	description: "Object representing output modes."
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_OUTPUT_MODE
create
	ilasm, peexe, pedll, object

feature {NONE} -- Creation

	ilasm once  end
	peexe once  end
	pedll once  end
	object once  end

feature -- Access

	instances: ITERABLE [CIL_OUTPUT_MODE]
			-- All known Output moes
		once
			Result := <<
					{CIL_OUTPUT_MODE}.ilasm,
					{CIL_OUTPUT_MODE}.peexe,
					{CIL_OUTPUT_MODE}.pedll,
					{CIL_OUTPUT_MODE}.object	>>
		ensure
			instance_free: class
		end

end
