note
	description: "Object representing output modes."
	date: "$Date$"
	revision: "$Revision$"

once class
	OUTPUT_MODE
create
	ilasm, peexe, pedll, object

feature {NONE} -- Creation

	ilasm once  end
	peexe once  end
	pedll once  end
	object once  end

feature -- Access

	instances: ITERABLE [OUTPUT_MODE]
			-- All known Output moes
		once
			Result := <<
					{OUTPUT_MODE}.ilasm,
					{OUTPUT_MODE}.peexe,
					{OUTPUT_MODE}.pedll,
					{OUTPUT_MODE}.object	>>
		ensure
			instance_free: class
		end

end
