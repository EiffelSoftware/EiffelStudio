note
	description: "Implementation of the CouchDB database using curl instructions"
	author: "Pascal Roos"
	date: "$Date Wed, 03 July 2013$"
	revision: "$Revision$"

class
	CDB_DATABASE

create
	make, make_with_host_and_port

feature --init

	make
		do
			set_host ("http://127.0.0.1")
			set_port (5984)
			set_endpoint ("http://127.0.0.1:5984")
		ensure
			host_set: host.is_equal ("http://127.0.0.1")
			port_set: port = 5984
			endpoint_set: endpoint.is_equal ("http://127.0.0.1:5984")
		end

	make_with_host_and_port (a_host: STRING; a_port: INTEGER)
		do
			set_host (a_host)
			set_port (a_port)
			set_endpoint (a_host + ":" + a_port.out)
		ensure
			host_set: host.is_equal (a_host)
			port_set: port = a_port
			endpoint_set: endpoint.is_equal (a_host + ":" + a_port.out)
		end

feature -- Access

	port: INTEGER

	endpoint: STRING

	host: STRING

feature --getters and setters

	set_host (a_host: STRING)
			-- set host with `a_host'
		do
			host := a_host
		ensure
			host_defined: host = a_host
		end

	set_port (a_port: INTEGER)
			-- set port with `a_port'
		do
			port := a_port
		ensure
			port_defined: port = a_port
		end

	set_endpoint (a_uri: STRING)
			-- set endpoint with `a_uri'
		do
			endpoint := a_uri
		ensure
			endpoint_defined: endpoint = a_uri
		end

feature -- document operations

	list_documents (database: STRING): STRING
			--lists all documents in the database
		require
			db_not_empty: not database.is_empty
		do
			Result := get ("/" + database, "")
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	get_document (database: STRING; id: STRING): STRING
			--returns the document at /database/id
		require
			db_not_empty: not database.is_empty
			id_not_empty: not id.is_empty
		do
			Result := get ("/" + database + "/" + id, "")
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	create_document (database: STRING; data: STRING): STRING
			--creates a new document in database containing data
		require
			db_not_empty: not database.is_empty
			data_not_empty: not data.is_empty
		do
				--first create the db
			Result := put (database)
				--then insert the data
			Result := post (database, "", data)
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	update_document (database: STRING; id: STRING; data: STRING): STRING
			--updates a document at /database/id with data
		require
			db_not_empty: not database.is_empty
			data_not_empty: not data.is_empty
			id_not_empty: not id.is_empty
		do
				--insert the data
			Result := post (database, id, data)
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	delete_document (database: STRING; id: STRING; rev: STRING): STRING
			-- deletes the document at /database/id?rev=...
		require
			db_not_empty: not database.is_empty
			id_not_empty: not id.is_empty
			rev_not_empty: not rev.is_empty
		do
			Result := delete (database, id, rev)
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

feature --databse operations

	list_databases: STRING
			--lists all databases
		do
			Result := get ("/_all_dbs", "")
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	create_database (database: STRING): STRING
			--creates a new database
		require
			db_not_empty: not database.is_empty
		do
			Result := put (database)
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

	destroy_database (database: STRING): STRING
			--deletes a database
		require
			db_not_empty: not database.is_empty
		do
			Result := delete (database, "", "")
		ensure
			result_exists: Result /= Void and then not Result.is_empty
		end

feature --standard curl operations

	get (uri: STRING; options: STRING): STRING
			--performs curl -x GET url/uri&options
		local
			l_end_point: STRING
			l_result: INTEGER
			l_curl_string: CURL_STRING
		do
			create Result.make_empty
			l_end_point := endpoint + uri + options
			if curl.is_api_available then
				create l_curl_string.make_empty
				curl.global_init
				curl_handle := curl_easy.init
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 2)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_end_point)
				curl_easy.set_write_function (curl_handle)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string.object_id)
				l_result := curl_easy.perform (curl_handle)
				curl_easy.cleanup (curl_handle)
				Result := l_curl_string.as_string_8
				curl.global_cleanup
				if l_result /= 0 then
					print ("There was an error:" + l_result.out)
				end
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

	put (a_uri: STRING): STRING
			-- performs curl -x PUT url/a_uri
			-- no actual data is put on the database here
		local
			l_result: INTEGER
			l_end_point: STRING
			l_curl_string: CURL_STRING
		do
			create Result.make_empty
			l_end_point := endpoint + "/" + a_uri
			if curl_easy.is_api_available then
				create l_curl_string.make_empty
				curl_handle := curl_easy.init
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 2)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_put, 1)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_end_point)
				curl_easy.set_write_function (curl_handle)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string.object_id)
				l_result := curl_easy.perform (curl_handle)
				Result := l_curl_string.as_string_8
				curl_easy.cleanup (curl_handle)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

	post (a_uri: STRING; a_id: STRING; a_data: STRING): STRING
			-- performs curl -x POST url/a_uri/a_id -d 'a_data'
			-- since the data is not super extensive i simply use a string
		local
			l_result: INTEGER
			l_end_point: STRING
			l_curl_string: CURL_STRING
			curl_slist: POINTER
		do
			create Result.make_empty
			l_end_point := endpoint + "/" + a_uri
			if curl_easy.is_api_available then
				create l_curl_string.make_empty
				create curl_slist.default_create
				curl_handle := curl_easy.init
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 2)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_end_point)
				curl_slist := curl.slist_append (curl_slist, "Content-Type: application/json")
				curl_easy.setopt_slist (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_httpheader, curl_slist)
				if a_data.is_empty then
					curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, "")
				else
					curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_postfields, a_data)
				end
				curl_easy.set_write_function (curl_handle)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string.object_id)
				l_result := curl_easy.perform (curl_handle)
				if l_result = 0 then
					Result := l_curl_string.as_string_8
				else
					print ("Error")
				end
				curl_easy.cleanup (curl_handle)
				curl.slist_free_all (curl_slist)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

	delete (a_uri: STRING; a_id: STRING; a_rev: STRING): STRING
			-- performs curl -x DELETE url/a_uri/a_id?rev=a_rev
		local
			l_result: INTEGER
			l_end_point: STRING
			l_curl_string: CURL_STRING
		do
			create Result.make_empty
			l_end_point := endpoint + "/" + a_uri
			if not a_id.is_empty then
				l_end_point.append ("/" + a_id)
			end
			if not a_rev.is_empty then
				l_end_point.append ("?rev=" + a_rev)
			end
			if curl_easy.is_api_available then
				create l_curl_string.make_empty
				curl_handle := curl_easy.init
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifypeer, 0)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_ssl_verifyhost, 2)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, l_end_point)
				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_customrequest, "DELETE")
				curl_easy.set_write_function (curl_handle)
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_curl_string.object_id)
				l_result := curl_easy.perform (curl_handle)
				Result := l_curl_string.as_string_8
				curl_easy.cleanup (curl_handle)
			else
				io.error.put_string ("cURL library not found!")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	curl: CURL_EXTERNALS
			-- cURL externals
		once
			create Result
		end

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	curl_string: detachable CURL_STRING -- void safety addition (doesn't seem to be used anywhere?)
			-- String used by Eiffel cURL library.

	curl_handle: POINTER;
	-- cURL handle

end
