indexing
	description: "Repository Example."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EXAMPLE_GENERATOR

creation
	make

feature -- Initialization

	make (li: LINKED_LIST [DB_REPOSITORY]) is
		require
			li_exists: li /= Void
		local
			col: COLUMNS[DATABASE]
			f1,f2: BOOLEAN
			i: INTEGER
			qu1,qu2: TUPLE[STRING,STRING,STRING]
			ty: TYPES[DATABASE]
		do
			Result_string := "" 
			Create ty
			repositories := li
			from
				li.start
			until
				li.after or (f1 and f2)
			loop
				from
					i := 1
				until
					i> li.item.column_number
				loop
					col := li.item.column_i_th(i)
					if not f1 and then (col.eiffel_type=ty.integer_type_database) or else
							col.eiffel_type=ty.Real_type_database then
						qu1 := [li.item.repository_name,col.column_name,"13"]
						f1 := TRUE
					end
					if not f2 and then col.eiffel_type = ty.string_type_database then
						qu2 := [li.item.repository_name, col.column_name,"'washington'"]
						f2 := TRUE
					end
					i := i + 1
				end
				li.forth
			end
			if f1 then
				generate_simple_select(qu1)
				a_repository_name ?= qu1.item(1)
			end
			if f2 then
				generate_simple_select(qu2)
				a_repository_name ?= qu1.item(1)
			end
			Result_string.append("%Nend -- Class ESTORE_EXAMPLE")
		end

	generate_simple_select(qu: TUPLE[STRING,STRING,STRING]) is
			-- Generate a 'select' query, thanks to tuple 'qu'.
		require
			tuple_exists: qu /= Void
		local
			s1,s2,s3: STRING
			s11,s22: STRING
		do
			s1 ?= qu.item(1)
			s2 ?= qu.item(2)
			s3 ?= qu.item(3)
			s11 := clone(s1)
			s22 := clone(s2)
			s11.to_lower
			s22.to_lower
			a_request_name := "get_"+s11+"_with_"+s22
			Result_string.append("%N%T"+a_request_name+": LINKED_LIST["+s1+"] is%N")
			Result_string.append("%T%T%T-- Request Example%N")
			Result_string.append("%T%Tlocal%N")
			Result_string.append("%T%T%Tobj:"+s1+"%N")
			Result_string.append("%T%Tdo%N")
			Result_string.append("%T%T%TCreate obj.make%N")
			a_request := "select * from "+s1+" where "+s2+"="+s3
			Result_string.append("%T%T%TResult := db_manager.load_list(%""+a_request)
			Result_string.append(a_request+"%", obj)%N")
			Result_string.append("%T%Tensure%N")
			Result_string.append("%T%T%Texists: Result /= Void%N")
			Result_string.append("%T%Tend%N%N")
		end

feature -- access

	result_string: STRING
		-- Text Content of the 'example' file.

feature {ROOT_GENERATOR} -- Access

	a_repository_name: STRING
		-- Repository Name.

	a_request_name: STRING
		-- Name of the request.

	a_request: STRING
		-- Request value, i.e. its SQL text.

feature -- Implementation

	repositories: LINKED_LIST [DB_REPOSITORY]
		-- Repositories used for generating valid SQL query.

invariant
	result_string /= Void
	repositories /= Void
	a_repository_name /= Void and a_request_name /= Void and a_request /= Void
end -- class EXAMPLE_GENERATOR
