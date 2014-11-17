note
	description: "A JSON converter for LIST [ANY]"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

deferred class
	JSON_LIST_CONVERTER

obsolete
	"This JSON converter design has issues [Sept/2014]."

inherit

	JSON_CONVERTER

feature {NONE} -- Initialization

	make
		do
			object := new_object (0)
		end

feature -- Access

	object: LIST [detachable ANY]

feature {NONE} -- Factory

	new_object (nb: INTEGER): like object
		deferred
		ensure
			Result /= Void
		end

feature -- Conversion

	from_json (j: attached like to_json): detachable like object
		local
			i: INTEGER
		do
			Result := new_object (j.count)
			from
				i := 1
			until
				i > j.count
			loop
				Result.extend (json.object (j [i], Void))
				i := i + 1
			end
		end

	to_json (o: like object): detachable JSON_ARRAY
		local
			c: ITERATION_CURSOR [detachable ANY]
			failed: BOOLEAN
		do
			create Result.make (o.count)
			from
				c := o.new_cursor
			until
				c.after
			loop
				if attached json.value (c.item) as jv then
					Result.add (jv)
				else
					failed := True
				end
				c.forth
			end
			if failed then
				Result := Void
			end
		end

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end -- class JSON_ARRAYED_LIST_CONVERTER
