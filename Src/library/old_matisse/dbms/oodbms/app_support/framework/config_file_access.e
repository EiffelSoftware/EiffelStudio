indexing
	description:  "Access to a configuration file"
	keywords:     "configuration ini file"
	revision:     "%%A%%"
	source:       "%%P%%"
	copyright:    "See notice at end of class"

class CONFIG_FILE_ACCESS

inherit
	TEXT_FILE_ACCESS

creation
        make

feature -- Initialisation
	initialise is
		do
                !!read_resources.make(0)
                !!requested_resources.make(0)
		end


feature -- Access
        requested_resources:HASH_TABLE[HASH_TABLE[STRING,STRING],STRING]

        read_resources:HASH_TABLE[HASH_TABLE[STRING,STRING], STRING]

        resource_value(category, resource_name:STRING): STRING is
                -- get the config file resource value for resource_name, in category
            require
                Exists: exists
                Valid_category: category /= Void and then not category.empty
                Valid_resource_name: resource_name /= Void and then not resource_name.empty
            local
                resource_list:HASH_TABLE[STRING,STRING]
            do
                !!Result.make(0)

                -- find the category
                resource_list := read_resources.item(category)
                if resource_list /= Void then
                    if resource_list.has(resource_name) then
                        Result.copy(resource_list.item(resource_name))
                    end
                end

            ensure
                Result_not_void: Result /= Void
            end

        resource_value_list(category, resource_name:STRING):ARRAYED_LIST[STRING] is
                -- List of items specified in file setting
                -- of the form of a comma-separated list.
            require
                Valid_category: category /= Void and then not category.empty
                   Valid_resource_name: resource_name /= Void and then not resource_name .empty
            local
                str_ex: STRING_EX
                str:STRING
            do
                !!Result.make(0)
                !!str_ex.make(0)
                str := resource_value(category,resource_name)

                if str /= Void and then not str.empty then
                    str_ex.make_from_string(resource_value(category,resource_name))

                    from
                        str_ex.token_start
                    until
                        str_ex.token_off
                    loop
                        str := str_ex.token_item
                        Result.extend(str)
                        str_ex.token_forth
                    end
             end    
            end

feature -- Output
        print_resources_read_list is
                -- print resources read in from .ini file on standard out.
            require
                Exists: exists
            local
                lines:ARRAYED_LIST[STRING]
            do
                lines := resources_read_list
                io.put_string("Application Resources Found in ")
                io.put_string(file_name); io.new_line
                io.put_integer(lines.count); io.put_string(" entries%N")
                io.put_string("-------------------------------------------------------------------%N")
                from
                    lines.start
                until
                    lines.off
                loop
                    io.putstring(lines.item)
                    io.new_line
                    lines.forth
                end
                io.put_string("-------------------------------------------------------------------%N")
                io.new_line
            end

        resources_read_list:ARRAYED_LIST[STRING] is
                -- actual resources read in resource file; result in format
                --         category        res_name                res_val
            require
                Exists: exists
            do
                Result := cvt_res_struct_to_list(read_resources)
            ensure
                Result_exists: Result /= Void
            end

        print_resources_requested_list is
                -- print resources requested by app on standard out.
                -- only see results in debug mode only (else list empty)
            require
                Exists: exists
            local
                lines:ARRAYED_LIST[STRING]
            do
                lines := resources_requested_list
                io.put_string("Application Resources Requested%N")
                io.put_integer(lines.count); io.put_string(" entries%N")
                io.put_string("-------------------------------------------------------------------%N")
                from
                    lines.start
                until
                    lines.off
                loop
                    io.putstring(lines.item)
                    io.new_line
                    lines.forth
                end
                io.put_string("-------------------------------------------------------------------%N")
                io.new_line
            end

        resources_requested_list:ARRAYED_LIST[STRING] is
                -- resources required by application; determined
                -- simply by logging all calls to config_resource_val
                -- same format as config_resources
            require
                Exists: exists
            do
                Result := cvt_res_struct_to_list(requested_resources)
            ensure
                Result_exists: Result /= Void
            end

feature -- Modification
        update_config(category_name: STRING; resource_name: STRING; value:STRING) is
           require
                Exists: exists
                Writable: writable
                Valid_category: category_name /= Void and then not category_name.empty
                Valid_resource_name: resource_name /= Void and then not resource_name.empty
           local
                   resource_list: HASH_TABLE[STRING,STRING]
           do
                if read_resources.has(category_name) then
                        resource_list:= read_resources.item(category_name)
                        if resource_list.has(resource_name) then
                                resource_list.replace(value, resource_name)
                        else
                                resource_list.put(value, resource_name)
                        end
                else
                        !!resource_list.make(0)
                        resource_list.put(value, resource_name)
                        read_resources.put(resource_list, category_name)
                end
           end


feature {NONE} -- Implementation
        record_resource_request(category, resource_name:STRING) is
            require
                Valid_category: category /= Void and then not category.empty
                Valid_resource_name: resource_name /= Void and then not resource_name.empty
            local
                res_table:HASH_TABLE[STRING,STRING]
            do
                res_table := requested_resources.item(category) 
                if res_table /= Void then
                    if not res_table.has(resource_name) then
                        res_table.put("------", resource_name)
                    end
                else
                    !!res_table.make(0)
                    res_table.put("-------", resource_name)
                    requested_resources.put(res_table, category)
                end
            end


        write_file is
           local
                msg, fname:STRING
                   line_buf: STRING
                   resource_list: HASH_TABLE[STRING,STRING]
                   category_name, key, value: STRING
           do
                        file.wipe_out
                        file.open_read_write
                        from 
                                read_resources.start
                        until 
                                read_resources.off
                        loop
                                category_name := read_resources.key_for_iteration
                                !!line_buf.make(0)
							line_buf.append("[")
                                line_buf.append_string(category_name)
                                line_buf.append_string("]")
                                file.put_string(line_buf)
                                file.new_line
                                resource_list:= read_resources.item_for_iteration
                                from
                                        resource_list.start
                                until
                                        resource_list.off
                                loop
                                        key:= resource_list.key_for_iteration
                                        value:= resource_list.item_for_iteration
                                        line_buf:= clone(key)
                                        line_buf.append_string("=")
                                        line_buf.append_string(value)
                                        file.putstring(line_buf)
                                        file.new_line
                                        resource_list.forth
                                end
                                read_resources.forth
                        end

                        file.close
           end

        cvt_res_struct_to_list(res_struct:HASH_TABLE[HASH_TABLE[STRING,STRING],STRING]): ARRAYED_LIST[STRING] is
            require
                Args_valid: res_struct /= Void
            local
		str:STRING
		resource_list:HASH_TABLE[STRING,STRING]
            do
                !!Result.make(0)

                from
                    res_struct.start
                until
                    res_struct.off
                loop
                    resource_list := clone(res_struct.item_for_iteration)
                    str := clone(res_struct.key_for_iteration)
                    str.prepend_string("CATEGORY: -------- ")
                    str.append(" --------")
                    Result.extend(str)

                    from
                        resource_list.start
                    until
                        resource_list.off
                    loop
                        str := "    "
                        str.append(resource_list.key_for_iteration)
                        str.append(" = ")
                        str.append(resource_list.item_for_iteration)
                        Result.extend(str)
                        resource_list.forth
                    end

                    res_struct.forth
                end

            ensure
                Result /= Void
            end

feature -- template routines
	read_initialise is
			-- do any specific initialisation before processing whole file
		do
                    read_resources.clear_all
		end

	read_finalise is
			-- do any specific finalisation before processing whole file
		do
			is_valid := True
		ensure then
			Is_valid: is_valid
		end

	read_resource_list:HASH_TABLE[STRING,STRING]

	process_readline is
		local
			category_name, res_name, res_value:STRING
			pos, res_name_dup_count, no_name_dup_count:INTEGER
		do
			-- now try to read either [XXXXXXXXXX]
			-- or YYYYYYYYYY=ZZZZZZZZZZZ
			if linebuf.item(1) = '[' then
			    -- we are in a category

			    -- strip the "[" & "]" chars & any leading or trailing spaces
			    category_name := linebuf.substring(2,linebuf.count-1)
			    linebuf.left_adjust;linebuf.right_adjust
			    if not read_resources.has(category_name) then
				    !!read_resource_list.make(0)
				    read_resources.put(read_resource_list, category_name)
			    else
				read_resource_list := read_resources.item(category_name)
			    end
			else
			    -- read resource name
			    pos := linebuf.index_of('=',1)
			    res_name := linebuf.substring(1,pos-1)
			    res_name.right_adjust -- remove spaces between name and '='

			    -- ensure a unique name; also document errors
			    if res_name.empty then 
				res_name := "NONAME_" 
				res_name.append_integer(no_name_dup_count)
				no_name_dup_count := no_name_dup_count + 1
			    elseif read_resource_list.has(res_name) then
				res_name.append("_DUPLICATE_")
				res_name.append_integer(res_name_dup_count)
				res_name_dup_count := res_name_dup_count + 1
			    end

			     -- read the resource value
			     if pos+1 <= linebuf.count then        -- something to read
				   res_value := linebuf.substring(pos+1,linebuf.count)
				   res_value.left_adjust  -- remove spaces between '=' and value
			    else
				   res_value := "***** NO VALUE *****"
			    end
			     read_resource_list.put(res_value, res_name)
		      end
	      end

        
end 



--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication and distribution permitted with this  |
--         | notice  intact.  Please send  modifications  and  |
--         | suggestions  to the Deep Thought Informatics, in  |
--         | the  interests  of maintenance  and improvement.  |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

