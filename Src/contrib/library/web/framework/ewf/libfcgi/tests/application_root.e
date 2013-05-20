note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_ROOT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			res: INTEGER
			nb: INTEGER
		do
			initialize
			from
				res := fcgi.fcgi_listen
			until
				res < 0
			loop
				nb := nb + 1
				fcgi.put_string (header ("FCGI Eiffel Application"))

				fcgi.put_string ("<h1>Hello FCGI Eiffel Application</h1>%N")
				fcgi.put_string ("Request number " + nb.out + "<br/>%N")

				fcgi.put_string ("<ul>Environment variables%N")
				print_environment_variables (fcgi.updated_environ_variables)
				fcgi.put_string ("</ul>")
				fcgi.put_string (footer)

				res := fcgi.fcgi_listen
			end
		end

feature -- Access

	header (a_title: STRING): STRING
		do
			Result := "Content-type: text/html%R%N"
			Result.append ("%R%N")
			Result.append ("<html>%N")
			Result.append ("<head><title>" + a_title + "</title></head>")
			Result.append ("<body>%N")
		end

	footer: STRING
		do
			Result := "</body>%N</html>%N"
		end

	print_environment_variables (vars: HASH_TABLE [STRING, STRING])
		local
		do
			from
				vars.start
			until
				vars.after
			loop
				fcgi.put_string ("<li><strong>" + vars.key_for_iteration + "</strong> = " + vars.item_for_iteration + "</li>%N")
				vars.forth
			end
		end

feature {NONE} -- Implementation

	initialize
		do
			create fcgi.make
		end

	fcgi: FCGI

end
