note
    description: "A JSON converter for DS_LINKED_LIST [ANY]"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"
    file: "$HeadURL: $"

class JSON_DS_LINKED_LIST_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        do
            create object.make
        end

feature -- Access

    object: DS_LINKED_LIST [ANY]

feature -- Conversion

    from_json (j: JSON_ARRAY): detachable like object
        local
            i: INTEGER
        do
            create Result.make
            from
                i := 1
            until
                i > j.count
            loop
            	if attached json.object (j [i], Void) as o then
                	Result.put_last (o)
                end
                i := i + 1
            end
        end

    to_json (o: like object): JSON_ARRAY
        local
            c: DS_LIST_CURSOR [ANY]
        do
            create Result.make_empty
            from
                c := o.new_cursor
                c.start
            until
                c.after
            loop
            	if attached json.value (c.item) as v then
                	Result.add (v)
            	end
                c.forth
            end
        end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end -- class JSON_DS_LINKED_LIST_CONVERTER
