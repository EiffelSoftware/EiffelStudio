indexing
	description: "Module which reads an XML document, %
				  % and extract the different parts that have%	
				  % to be processed."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DOCUMENTATION_READER


creation
	make

feature -- Initialization
	
	make is
		do
			Create list.make
			Create items.make(10)
		end

feature -- Access

	error: BOOLEAN

	list: LINKED_LIST[STRING]

	items: HASH_TABLE[STRING, INTEGER]

feature -- Actions

	process_file(fi: FILE_NAME) is
			-- Read the file 'fi' and extract the 
			-- different parts necessary for processing the
			-- template later.
		require
			exists: fi /= Void
		local
			file: PLAIN_TEXT_FILE
			s: STRING
			err: BOOLEAN
		do
			if not err then
				list.wipe_out
				items.wipe_out
				!! file.make (fi)
				if file.exists then
					file.open_read
					file.read_stream (file.count)
					!! s.make(file.count)
					s.append (file.last_string)
					file.close		
					process_file_content(s)
				end
			else
				
			end
		rescue
			err := TRUE
			retry
		end

	process_file_content(s: STRING) is
			-- Initialization
		require
			not_void: s /= Void
		local
			ind,ind2: INTEGER
			ss: STRING
			err: BOOLEAN
		do
			if not err then
				error := FALSE
				list.wipe_out
				ss := clone(s)
				ind := 1
				from
				until
					(ind<1)
				loop
					ind := ss.substring_index("<FL_LOOP>",1)
					if ind > 0 then
						ind2 := ss.substring_index("</FL_LOOP>",ind)
						check
							has_end_fl_loop: ind2 > 0
						end
						if ind>1 then
							list.extend(ss.substring(1,ind-1))
						end
						list.extend(ss.substring(ind,ind2+10))
						ss := ss.substring(ind2+11,ss.count)
					else
						list.extend(ss)
					end
				end
			else
				error := TRUE
			end
		rescue
			err := TRUE
			retry
		end

	insert_in_a_loop(tab:HASH_TABLE[STRING,STRING]) is
		require
			not_void: tab /= Void
		local
			s: STRING
			i: INTEGER
		do
			from
				list.start
				i := 1
			until
				list.after
			loop
				if list.item.count>9 and then 
					list.item.substring(1,9).is_equal("<FL_LOOP>") then
					s := processed_string(tab,list.item)
					if not s.empty then
						s.replace_substring("",1,9)
						s.replace_substring_all("</FL_LOOP>","")	
						if items.has(i) then
							items.item(i).append(s)
						else
							items.put(s,i)
						end
					end
				end
				i := i + 1
				list.forth
			end
		end

	insert_outside_a_loop(tab: HASH_TABLE[STRING,STRING]) is
		require
			not_void: tab /= Void
		local
			s: STRING
			i: INTEGER
		do
			from
				list.start
				i := 1
			until
				list.after
			loop
				if not list.item.substring(1,9).is_equal("<FL_LOOP>") then
					s := processed_string(tab,list.item)
					if not s.empty then
						list.item.wipe_out
						list.item.append(s)
					end
				end
				i := i + 1
				list.forth
			end
		end			

	processed_string(tab:HASH_TABLE[STRING,STRING];st: STRING): STRING is
		require
			not_void: tab /= Void
		local
			ind,ind2: INTEGER
			s: STRING
			found,err: BOOLEAN
		do
			if not err then
				error := FALSE
				Result := clone(st)
				ind := 1
				from
				until
					(ind<1)
				loop
					ind := Result.substring_index("<FL ARG=%"",ind)
					if ind > 0 then
						ind2 := Result.substring_index("%">",ind)
					else
						ind2 := 0
					end
					if ind >1 and then ind2>ind+9 then
						s := Result.substring(ind+9,ind2-1)
						ind := ind+1
						if tab.has(s) then	
							found := TRUE
							Result.replace_substring(tab.item(s),ind-1,ind2+1)
						end
					end
				end
				if not found then
					Result := ""
				end
			else
				error := TRUE
			end
		rescue
			err := TRUE
			retry
		end

	result_string: STRING is
		local
			i: INTEGER
		do
			from
				i := 1
				Create Result.make(300)
				list.start
			until
				list.after
			loop
				if list.item.count>9 and then 
					list.item.substring(1,9).is_equal("<FL_LOOP>") and then
					items.has(i) then
						Result.append(items.item(i))
				else
					Result.append(list.item)
				end
				i := i + 1
				list.forth
			end
		ensure
			not_void: Result /= Void
		end

end -- class XML_DOCUMENTATION_READER
