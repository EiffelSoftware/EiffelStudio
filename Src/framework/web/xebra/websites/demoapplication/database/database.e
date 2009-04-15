indexing
	description: "Connects to database"
	author: "Fabio Zünd & Massimiliano Gentile & Yanick Fratantonio"
	date: "2008-12-14"
	revision: "1.0"

class
	DEMOAPPLICATION_DATABASE
inherit
	DATABASE_APPL [ODBC]


create
	make


feature -- Constants

	host: STRING is "localhost"
	datasource: STRING is "Default"
	database: STRING is "demoapplication_db"
	username: STRING is "root"
	password: STRING is ""



feature -- DB access

	session_control: DB_CONTROL
	base_update: DB_CHANGE
	base_selection: DB_SELECTION
	repository: DB_REPOSITORY
	storage: DB_STORE



feature -- database control

	make  is
			-- Creation
		do
			-- No open here, just create
			is_connected := False
		end

	is_connected: BOOLEAN
			-- Check if already connected to the database.

	close is
			-- Terminate session
		do
			session_control.disconnect
			is_connected := False
		end

	open: BOOLEAN is
			-- Open the connection with the database
		do
			set_data_source(datasource)

			-- Set user's name and password
			login (username, password)

			-- Initialization of the Relational Database:
			-- This will set various informations to perform a correct
			-- Connection to the Relational database
			set_base

			-- Create usefull classes
			-- 'session_control' provides informations control access and
			--  the status of the database.
			-- 'base_selection' provides a SELECT query mechanism.
			-- 'base_update' provides updating facilities.
			create session_control.make
			create base_selection.make
			create base_update.make

			-- Start session
			session_control.connect

			if  session_control.is_connected then

				Result := True
			else
					-- Something went wrong, and the connection failed
				session_control.raise_error
				Result := False
			end

			is_connected := Result
		end


	query_not_evil (msg: STRING): BOOLEAN is
			-- Checks if msg contains harmful sql-keywords
		require
			msg_not_Void: msg /= Void
		local
			ok: BOOLEAN
		do
			ok := True

			if msg.as_lower.has_substring ("select") then
				ok := False
			end

			if msg.as_lower.has_substring (";") then
				ok := False
			end

			if msg.as_lower.has_substring ("insert") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("alter") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("*") then
				ok :=  False
			end

			if msg.as_lower.has_substring ("delete") then
				ok := False
			end

			if msg.as_lower.has_substring ("table") then
				ok :=  False
			end

			Result := ok
		end


--		reset is
--				-- Resets the db
--			do
--				session_control.reset
--				if session_control.is_connected then
--					create base_update.make
--					base_update.modify ("TRUNCATE TABLE `user`")
--					base_update.modify ("TRUNCATE TABLE `user_advicecategory`")
--					base_update.modify ("TRUNCATE TABLE `advice`")
--					base_update.modify ("TRUNCATE TABLE `advicemedia`")
--					base_update.modify ("TRUNCATE TABLE `advice_advicecategory`")
--					base_update.modify ("TRUNCATE TABLE `advice_advicemedia`")

--				end
--			end

--feature -- USER

--	get_user (a_name: STRING): BTW_RESULT [BTW_USER] is
--			-- Get a user by its name from the database if it exists
--		local
--			temp_user: BTW_DB_USER
--			user_filling: DB_ACTION [BTW_DB_USER]
--		do
--			Result := create {BTW_ERROR_D_UNKNOWN [BTW_USER]}.make (Void, True)

--			if query_not_evil (a_name.out) then
--				session_control.reset
--				if session_control.is_connected then

--					create temp_user
--					base_selection.object_convert (temp_user)

--					create user_filling.make (base_selection, temp_user)

--					base_selection.set_action (user_filling)
--					base_selection.query ("SELECT * FROM user WHERE name='" + a_name.out + "'")

--					if session_control.is_ok then
--						base_selection.load_result
--					end

--					if base_selection.is_ok then
--						user_filling.start
--						if user_filling.item /= Void then
--							temp_user ?= user_filling.item
--							if temp_user /= Void and then temp_user.name /= Void then
--								Result := create {BTW_RESULT [BTW_USER]}.make (create {BTW_USER}.make_from_db_user (user_filling.item), False)
--							else
--								Result := create {BTW_ERROR_D_USER_NOT_EXIST [BTW_USER]}.make (Void, True)
--							end

--						else
--							Result := create {BTW_ERROR_D_USER_NOT_EXIST [BTW_USER]}.make (Void, True)
--						end
--					end

--					base_selection.terminate

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [BTW_USER]}.make (Void, True)
--				end
--			else
--					Result := create {BTW_ERROR_D_BAD_QUERY [BTW_USER]}.make (Void, True)
--			end
--		end



--	update_user_by_name (a_user: BTW_USER): BTW_RESULT [BOOLEAN] is
--			-- updates a_user the  informataion
--		local
--			upquery: STRING
--		do

--			if query_not_evil (a_user.email) and
--				query_not_evil (a_user.name) then


--					session_control.reset
--					if session_control.is_connected then
--						create base_update.make
--						create upquery.make_from_string ("UPDATE user SET ")

--						upquery.append ("name='" + a_user.name + "', ")
--						upquery.append ("email='" + a_user.email  + "' ")

--						upquery.append ("WHERE name='" + a_user.name + "' ")
--						base_update.modify (upquery)

--						if base_update.is_ok then

--								Result := create {BTW_RESULT [BOOLEAN]}.make (True, False)
--						else
--							Result := create {BTW_ERROR_D_BAD_QUERY [BOOLEAN]}.make (False, True)
--						end

--					else
--						Result := create {BTW_ERROR_D_NOT_CONNECTED [BOOLEAN]}.make (False, True)
--					end

--				else
--					Result := create {BTW_ERROR_D_BAD_QUERY [BOOLEAN]}.make (False, True)
--				end

--		end


--	user_does_not_exist (a_user: BTW_USER): BOOLEAN  is
--			-- Checks if a user is available
--		local
--			user_res: BTW_RESULT [BTW_USER]
--		do
--				Result := False
--				user_res :=	get_user (a_user.name)
--				if user_res.error_has_occurred then
--						Result := True
--				end
--		end

--	insert_user (a_user: BTW_USER): BTW_RESULT [BOOLEAN] is
--			-- inserts a_user into the database	

--		do
--				session_control.reset
--				if session_control.is_connected then

--						--check if username is available
--						if user_does_not_exist (a_user) then

--							create storage.make
--							create repository.make ("user")
--							repository.load
--							storage.set_repository (repository)
--							storage.put (a_user)

--							if not session_control.is_ok then
--									-- The attempt to insert a new object
--									-- failed
--								Result := create {BTW_ERROR_D_CONTROL [BOOLEAN]}.make_with_sql_error (session_control.error_message)
--							else
--								Result := create {BTW_RESULT [BOOLEAN]}.make (True, False)
--							end
--						else
--								Result := create {BTW_ERROR_D_USER_ALREADY_EXISTS [BOOLEAN]}.make (False, True)
--						end


--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [BOOLEAN]}.make (False, True)
--				end
--		end

--	delete_user (a_name: STRING): BTW_RESULT [BOOLEAN] is
--			-- Removes a_user from the database
--		do

--			if query_not_evil (a_name.out) then

--				if get_user (a_name) = Void then
--					Result := create {BTW_ERROR_D_USER_NOT_EXIST [BOOLEAN]}.make (False, True)
--				else

--					session_control.reset
--					if session_control.is_connected then

--						create base_update.make
--						base_update.modify ("DELETE FROM user WHERE name='" + a_name.out + "'")
--						session_control.commit

--						Result := create {BTW_RESULT [BOOLEAN]}.make (True, False)
--					else
--						Result := create {BTW_ERROR_D_NOT_CONNECTED [BOOLEAN]}.make (False, True)
--					end
--				end

--			else
--				Result := create {BTW_ERROR_D_BAD_QUERY [BOOLEAN]}.make (False, True)
--			end
--		end

--	insert_user_advicecategory (a_user_id: INTEGER; categories: DS_LINKED_LIST [INTEGER]): BTW_RESULT [ANY] is
--			-- add a relation user<->categories to the database
--		local
--			op_fail: BOOLEAN
--		do
--			--TODO make a better evil query search
--			op_fail := False
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				from categories.start until categories.after loop
--					base_update.clear_all
--					base_update.modify ("INSERT INTO `user_advicecategory` (user, advicecategory) VALUES ('" + a_user_id.out + "','" + categories.item_for_iteration.out + "')")
--					if not base_update.is_ok then
--						op_fail := True
--					end
--					categories.forth
--				end


--				if not op_fail then
--					create Result.make (Void, False)
--				else
--					Result := create {BTW_ERROR_D_UNKNOWN [ANY]}.make(Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make (Void, True)
--			end
--		end

--feature -- ADVICE


--	get_advice_by_id (an_advice_id: INTEGER): BTW_RESULT [BTW_ADVICE] is
--			-- Return the advice specified by an id
--		local
--			a_db_advice: BTW_DB_ADVICE
--			advice_filling: DB_ACTION [BTW_DB_ADVICE]
--		do
--			if query_not_evil (an_advice_id.out) then
--				session_control.reset
--				if session_control.is_connected then

--					create a_db_advice
--					base_selection.object_convert (a_db_advice)

--					create advice_filling.make (base_selection, a_db_advice)

--					base_selection.set_action (advice_filling)
--					base_selection.query ("SELECT * FROM advice WHERE id='" + an_advice_id.out + "'")

--					if session_control.is_ok then
--						base_selection.load_result
--					else
--						create {BTW_ERROR_D_CONTROL [BTW_ADVICE]} Result.make_with_sql_error (session_control.error_message)
--					end

--					if base_selection.is_ok then
--						advice_filling.start
--						a_db_advice ?= advice_filling.item
--						if a_db_advice /= Void and then a_db_advice.id /= 0 then
--							create Result.make (create {BTW_ADVICE}.make_from_db_advice (a_db_advice, Void, Void), False)
--						else
--							-- Id not found
--							create {BTW_ERROR_D_ADVICE_NOT_EXIST [BTW_ADVICE]} Result.make (Void, True)
--						end

--					else
--					 	 create {BTW_ERROR_D_UNKNOWN [BTW_ADVICE]} Result.make (Void, True)
--					end

--					base_selection.terminate

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [BTW_ADVICE]}.make (Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_BAD_QUERY [BTW_ADVICE]}.make (Void, True)
--			end
--		end


--	get_complete_advice_by_id (an_advice_id: INTEGER): BTW_RESULT [BTW_ADVICE] is
--			-- Return the advice specified by an id
--		local
--			a_db_advice: BTW_DB_ADVICE
--			categories_list:BTW_RESULT [DS_LINKED_LIST [INTEGER]]
--			media_list:BTW_RESULT [DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]]
--			advice_filling: DB_ACTION [BTW_DB_ADVICE]
--		do
--			if query_not_evil (an_advice_id.out) then
--				session_control.reset
--				if session_control.is_connected then

--					create a_db_advice
--					create base_selection.make
--					base_selection.object_convert (a_db_advice)

--					create advice_filling.make (base_selection, a_db_advice)

--					base_selection.set_action (advice_filling)
--					base_selection.query ("SELECT * FROM advice WHERE id='" + an_advice_id.out + "'")

--					if session_control.is_ok then
--						base_selection.load_result
--					else
--						create {BTW_ERROR_D_CONTROL [BTW_ADVICE]} Result.make_with_sql_error (session_control.error_message)
--					end

--					if base_selection.is_ok then
--						advice_filling.start
--						a_db_advice ?= advice_filling.item

--						base_selection.terminate
--						base_selection.clear_all
--						if a_db_advice /= Void and then a_db_advice.id /= 0 then

--							-- Get missing informations from other tables
--							categories_list := get_advice_categories_by_advice_id (an_advice_id)
--							if categories_list.error_has_occurred then
--								create {BTW_ERROR_D_UNKNOWN [BTW_ADVICE]} Result.make(Void, True)
--							end

--							media_list := get_advice_media_by_advice_id (an_advice_id)
--							if media_list.error_has_occurred then
--								create {BTW_ERROR_D_UNKNOWN [BTW_ADVICE]} Result.make(Void, True)
--							end
--							create Result.make (create {BTW_ADVICE}.make_from_db_advice (a_db_advice, categories_list.return_value, media_list.return_value), False)
--						else
--							-- Id not found
--							create {BTW_ERROR_D_ADVICE_NOT_EXIST [BTW_ADVICE]} Result.make (Void, True)
--						end

--					else
--					 	 create {BTW_ERROR_D_UNKNOWN [BTW_ADVICE]} Result.make (Void,True)
--					end

--					base_selection.terminate

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [BTW_ADVICE]}.make (Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_BAD_QUERY [BTW_ADVICE]}.make (Void, True)
--			end
--		end

--	get_advices_by_user (an_user: BTW_USER): BTW_RESULT [LINKED_LIST [BTW_ADVICE]] is
--			-- Get a list of advices according to the user who inserted them
--		local
--			a_db_advice: BTW_DB_ADVICE
--			temp_advice_list: ARRAYED_LIST [BTW_DB_ADVICE]
--			advice_filling: DB_ACTION [BTW_DB_ADVICE]
--		do
--			if query_not_evil (an_user.id.out) then
--				session_control.reset
--				if session_control.is_connected then

--					create a_db_advice
--					create base_selection.make
--					base_selection.object_convert (a_db_advice)

--					create advice_filling.make (base_selection, a_db_advice)

--					base_selection.set_action (advice_filling)
--					base_selection.query ("SELECT * FROM advice WHERE owner='" + an_user.id.out + "'")

--					if session_control.is_ok then
--						base_selection.load_result
--					else
--						create {BTW_ERROR_D_CONTROL [LINKED_LIST [BTW_ADVICE]]} Result.make_with_sql_error (session_control.error_message)
--					end

--					if base_selection.is_ok then
--						create Result.make (create {LINKED_LIST [BTW_ADVICE]}.make, False)
--						temp_advice_list := advice_filling.list
--						from temp_advice_list.start until temp_advice_list.after
--						loop
--							a_db_advice ?= temp_advice_list.item
--							if a_db_advice /= Void and then a_db_advice.id /= 0 then

--								Result.return_value.put_front (create {BTW_ADVICE}.make_from_db_advice (a_db_advice, Void, Void))
--							end
--							temp_advice_list.forth
--						end
--					else
--					 	Result := create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]}.make (Void,True)
--					end

--					base_selection.terminate

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_BAD_QUERY [LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
--			end
--		end

--	get_complete_advices_by_user (an_user: BTW_USER): BTW_RESULT [LINKED_LIST [BTW_ADVICE]] is
--			-- Get a list of advices with all the fields defined according to the user who inserted them
--		local
--			a_db_advice: BTW_DB_ADVICE
--			categories_list: BTW_RESULT [DS_LINKED_LIST [INTEGER]]
--			media_list: BTW_RESULT [DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]]
--			temp_advice_list: ARRAYED_LIST [BTW_DB_ADVICE]
--			advice_filling: DB_ACTION [BTW_DB_ADVICE]
--		do
--			if query_not_evil (an_user.id.out) then
--				session_control.reset
--				if session_control.is_connected then

--					create a_db_advice
--					base_selection.object_convert (a_db_advice)

--					create advice_filling.make (base_selection, a_db_advice)

--					base_selection.set_action (advice_filling)
--					base_selection.query ("SELECT * FROM advice WHERE owner='" + an_user.id.out + "'")

--					if session_control.is_ok then
--						base_selection.load_result
--					else
--						create {BTW_ERROR_D_CONTROL [LINKED_LIST [BTW_ADVICE]]} Result.make_with_sql_error (session_control.error_message)
--					end

--					if base_selection.is_ok then
--						create Result.make (create {LINKED_LIST [BTW_ADVICE]}.make, False)
--						temp_advice_list := advice_filling.list
--						base_selection.terminate
--						from temp_advice_list.start until temp_advice_list.after
--						loop
--							a_db_advice ?= temp_advice_list.item
--							if a_db_advice /= Void and then a_db_advice.id /= 0 then

--								-- Get missing informations from other tables
--								categories_list := get_advice_categories_by_advice_id (a_db_advice.id)
--								if categories_list.error_has_occurred then
--									create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]} Result.make (Void, True)
--								end

--								media_list := get_advice_media_by_advice_id (a_db_advice.id)
--								if media_list.error_has_occurred then
--									create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]} Result.make (Void, True)
--								end

--								Result.return_value.put_front (create {BTW_ADVICE}.make_from_db_advice (a_db_advice, categories_list.return_value, media_list.return_value))
--							end
--							temp_advice_list.forth
--						end
--					else
--					 	Result := create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
--					end

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_BAD_QUERY[LINKED_LIST [BTW_ADVICE]]}.make (Void, True)
--			end
--		end

--	get_categories_by_user (an_user: BTW_USER): BTW_RESULT [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]] is
--			-- Return all the categories that have been chosen by the user
--		local
--			a_category: BTW_DB_ADVICECATEGORY
--			temp_category_list: ARRAYED_LIST [BTW_DB_ADVICECATEGORY]
--			category_filling: DB_ACTION [BTW_DB_ADVICECATEGORY]
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create a_category
--				base_selection.object_convert (a_category)

--				create category_filling.make (base_selection, a_category)

--				base_selection.set_action (category_filling)
--				base_selection.query ("SELECT advicecategory.* FROM advicecategory JOIN user_advicecategory WHERE advicecategory.id = user_advicecategory.advicecategory AND user_advicecategory.user = '" + an_user.id.out + "'")

--				if session_control.is_ok then
--					base_selection.load_result
--				else
--					create {BTW_ERROR_D_CONTROL [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]} Result.make_with_sql_error (session_control.error_message)
--				end

--				if base_selection.is_ok then
--					create Result.make (create {DS_LINKED_LIST [BTW_ADVICE_CATEGORY]}.make, False)
--					temp_category_list := category_filling.list
--					from temp_category_list.start until temp_category_list.after
--					loop
--						a_category ?= temp_category_list.item
--						if a_category /= Void and then a_category.id /= 0 then
--							Result.return_value.put_last (create {BTW_ADVICE_CATEGORY}.make_from_db_advicecategory (a_category))
--						end
--						temp_category_list.forth
--					end

--				else
--				  Result := create {BTW_ERROR_D_UNKNOWN [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]}.make (Void,True)
--				end

--				base_selection.terminate

--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]}.make (Void, True)
--			end
--		end


--	get_advice_categories: BTW_RESULT [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]] is
--			-- Return all advice categories currently defined in the system
--		local
--			a_category: BTW_DB_ADVICECATEGORY
--			temp_category_list: ARRAYED_LIST [BTW_DB_ADVICECATEGORY]
--			category_filling: DB_ACTION [BTW_DB_ADVICECATEGORY]
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create a_category
--				base_selection.object_convert (a_category)

--				create category_filling.make (base_selection, a_category)

--				base_selection.set_action (category_filling)
--				base_selection.query ("SELECT * FROM advicecategory")

--				if session_control.is_ok then
--					base_selection.load_result
--				else
--					create {BTW_ERROR_D_CONTROL [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]} Result.make_with_sql_error (session_control.error_message)
--				end



--				if base_selection.is_ok then
--					create Result.make (create {DS_LINKED_LIST [BTW_ADVICE_CATEGORY]}.make, False)
--					temp_category_list := category_filling.list
--					if temp_category_list.count = 0 then
--							create {BTW_ERROR_D_CATEGORY_NOT_EXIST [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]} Result.make (Void, True)
--					else
--						from temp_category_list.start until temp_category_list.after
--						loop
--							a_category ?= temp_category_list.item
--							if a_category /= Void and then a_category.id /= 0 then
--								Result.return_value.put_last (create {BTW_ADVICE_CATEGORY}.make_from_db_advicecategory (a_category))
--							end
--							temp_category_list.forth
--						end
--					end
--				else
--				  Result := create {BTW_ERROR_D_UNKNOWN [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]}.make (Void, True)
--				end

--				base_selection.terminate

--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [DS_LINKED_LIST [BTW_ADVICE_CATEGORY]]}.make (Void, True)
--			end
--		end


--	query_advices (an_advice_query: BTW_ADVICE_QUERY): BTW_RESULT [DS_LINKED_LIST [INTEGER]] is
--			-- Get advices according to an_advice_query
--		local
--			a_db_advice: BTW_DB_ADVICE
--			temp_advice_list: ARRAYED_LIST [BTW_DB_ADVICE]
--			advice_filling: DB_ACTION [BTW_DB_ADVICE]

--		do
--			-- No evil query check while the categories are fixed
--				session_control.reset
--				if session_control.is_connected then

--					create a_db_advice
--					create base_selection.make
--					base_selection.object_convert (a_db_advice)
--					create advice_filling.make (base_selection, a_db_advice)

--					base_selection.set_action (advice_filling)
--					base_selection.query ("SELECT DISTINCT advice.id FROM advice JOIN advice_advicecategory WHERE " + an_advice_query.query)

--					if session_control.is_ok then
--						base_selection.load_result
--					else
--						create {BTW_ERROR_D_CONTROL [DS_LINKED_LIST [INTEGER]]} Result.make_with_sql_error (session_control.error_message)
--					end

--					if base_selection.is_ok then

--						create Result.make (create {DS_LINKED_LIST [INTEGER]}.make ,False)
--						temp_advice_list := advice_filling.list
--						if temp_advice_list.count > 0 then
--							from temp_advice_list.start until temp_advice_list.after
--							loop
--								a_db_advice ?= temp_advice_list.item
--								if a_db_advice /= Void and then a_db_advice.id /= 0 then
--									Result.return_value.put_last (a_db_advice.id)
--								end
--								temp_advice_list.forth
--							end
--						end
--					 else
--				 		 create {BTW_ERROR_D_UNKNOWN [DS_LINKED_LIST [INTEGER]]} Result.make(Void, True)
--					end
--					base_selection.terminate
--				else
--					create {BTW_ERROR_D_NOT_CONNECTED [DS_LINKED_LIST [INTEGER]]} Result.make(Void, True)
--				end
--		end

--	delete_advice (an_advice_id: INTEGER): BTW_RESULT [ANY] is
--			-- Remove an advice with an_id from the database
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				base_update.modify ("DELETE FROM advice WHERE id='" + an_advice_id.out + "'")
--				if base_update.is_ok then
--					create Result.make (Void, False)
--				 else
--				 		 Result := create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_ADVICE]]}.make(Void, True)
--					end
--			else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make(Void, True)
--			end
--		end

--	update_advice (an_advice: BTW_ADVICE): BTW_RESULT [ANY] is
--			-- update an_advice with the new istance
--		local
--			op_result: BTW_RESULT [ANY]
--		do
--			op_result := delete_advice (an_advice.id)
--			if op_result.error_has_occurred then
--				Result := op_result
--			end

--			op_result := insert_advice (an_advice)
--			if op_result.error_has_occurred then
--				Result := op_result
--			end
--			create Result.make (Void, False)
--		end

--	get_max_advice_id (): BTW_RESULT [INTEGER] is
--			-- Retrieve the bigger id in a_table in the database
--		local
--			res:INTEGER_32_REF
--			tuple: DB_TUPLE
--		do
--			session_control.reset
--				if session_control.is_connected then

--					create base_selection.make
--					create tuple.make

--					base_selection.query ("SELECT MAX(id) FROM advice group by id")

--					if base_selection.is_ok then
--						base_selection.load_result
--						tuple.copy (base_selection.cursor)
--						if tuple.count = 0 then
--							create Result.make (0, False)
--						else
--							res ?= tuple.item (1)
--							create Result.make (res.as_integer_32, False)
--						end

--					else
--					 	Result := create {BTW_ERROR_D_UNKNOWN [INTEGER]}.make (0, True)
--					end

--					base_selection.terminate

--				else
--					Result := create {BTW_ERROR_D_NOT_CONNECTED [INTEGER]}.make (0, True)
--				end
--		end


--	insert_advice (an_advice: BTW_ADVICE): BTW_RESULT [ANY] is
--			-- Add an_advice to the database
--		local
--			op_result: BTW_RESULT [ANY]
--		do
--			--TODO make a better evil query search
--			--if query_not_evil (a_name.out)then
--			session_control.reset
--			if session_control.is_connected then

--				create storage.make
--				create repository.make ("advice")
--				repository.load
--				storage.set_repository (repository)
--				storage.put (an_advice)

--				if session_control.is_ok then

--					op_result := insert_advice_category (an_advice.id, an_advice.categories)
--					if not op_result.error_has_occurred then

--						op_result := insert_advice_media (an_advice.id, an_advice.media)
--						if not op_result.error_has_occurred then
--							create Result.make (Void, False)
--						else
--							Result := op_result
--						end
--					else
--						Result := op_result
--					end

--				else
--					create {BTW_ERROR_D_CONTROL [ANY]} Result.make_with_sql_error (session_control.error_message)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make (Void, True)
--			end
--		end

--	insert_advice_category (an_advice_id: INTEGER; categories: DS_LINKED_LIST [INTEGER]): BTW_RESULT [ANY] is
--			-- add a relation advice<->categories to the database
--		local
--			op_fail: BOOLEAN
--		do
--			--TODO make a better evil query search
--			op_fail := False
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				from categories.start until categories.after loop
--					base_update.clear_all
--					base_update.modify ("INSERT INTO `advice_advicecategory` (advice, advicecategory) VALUES ('" + an_advice_id.out + "','" + categories.item_for_iteration.out + "')")
--					if not base_update.is_ok then
--						op_fail := True
--					end
--					categories.forth
--				end


--				if not op_fail then
--					create Result.make (Void, False)
--				else
--					Result := create {BTW_ERROR_D_UNKNOWN [ANY]}.make(Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make (Void, True)
--			end
--		end

--	insert_advice_media (an_advice_id: INTEGER; media: DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]): BTW_RESULT [ANY] is
--			-- add media in the database -TODO: add a method to add a media!!
--			-- add a relation advice<->media to the database
--		local
--			op_fail: BOOLEAN
--		do
--			--TODO make a better evil query search
--			op_fail := False
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				from media.start until media.after loop
--					base_update.clear_all
--					base_update.modify ("INSERT INTO `advicemedia` (id,advice,type, media) VALUES ('" + media.item_for_iteration.id.out + "','" + an_advice_id.out + "','" + media.item_for_iteration.type + "','" + media.item_for_iteration.media + "')")
--					if not base_update.is_ok then
--						op_fail := True
--					end
--					media.forth
--				end


--				if not op_fail then
--					create Result.make (Void,False)
--				else
--					Result := create {BTW_ERROR_D_UNKNOWN [ANY]}.make(Void, True)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make(Void, True)
--			end
--		end

--	get_advice_categories_by_advice_id (an_advice_id: INTEGER): BTW_RESULT [DS_LINKED_LIST [INTEGER]] is
--			-- Get the categories associated to an advice
--		local
--			an_advice_category: BTW_DB_ADVICECATEGORY
--			temp_advice_category_list: ARRAYED_LIST [BTW_DB_ADVICECATEGORY]
--			advice_category_filling: DB_ACTION [BTW_DB_ADVICECATEGORY]

--		do
--			session_control.reset
--			if session_control.is_connected then

--				create an_advice_category
--				create base_selection.make
--				base_selection.object_convert (an_advice_category)

--				create advice_category_filling.make (base_selection, an_advice_category)

--				base_selection.set_action (advice_category_filling)
--				base_selection.query ("SELECT advicecategory.* FROM advicecategory JOIN advice_advicecategory WHERE advice_advicecategory.advice = " + an_advice_id.out + " AND advicecategory.id = advice_advicecategory.advicecategory")

--				if session_control.is_ok then
--					base_selection.load_result
--				else
--					create {BTW_ERROR_D_CONTROL [DS_LINKED_LIST [INTEGER]]} Result.make_with_sql_error (session_control.error_message)
--				end

--				if base_selection.is_ok then

--					create Result.make (create {DS_LINKED_LIST [INTEGER]}.make, False)
--					temp_advice_category_list := advice_category_filling.list
--					from temp_advice_category_list.start until temp_advice_category_list.after
--					loop
--						an_advice_category ?= temp_advice_category_list.item
--						if an_advice_category /= Void and then an_advice_category.id /= Void then
--							Result.return_value.put_last (an_advice_category.id)
--						end
--						temp_advice_category_list.forth
--					end

--				 else
--			 		 Result := create {BTW_ERROR_D_UNKNOWN [DS_LINKED_LIST [INTEGER]]}.make (Void, True)
--				end

--				base_selection.terminate

--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [DS_LINKED_LIST [INTEGER]]}.make (Void, True)
--			end

--		end

--	get_advice_media_by_advice_id (an_advice_id: INTEGER): BTW_RESULT [DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]] is
--			-- Get the categories associated to an advice
--		local
--			an_advice_media: BTW_DB_ADVICE_MEDIA
--			temp_advice_media_list: ARRAYED_LIST [BTW_DB_ADVICE_MEDIA]
--			advice_media_filling: DB_ACTION [BTW_DB_ADVICE_MEDIA]

--		do
--			session_control.reset
--			if session_control.is_connected then

--				create an_advice_media
--				create base_selection.make
--				base_selection.object_convert (an_advice_media)

--				create advice_media_filling.make (base_selection, an_advice_media)

--				base_selection.set_action (advice_media_filling)
--					base_selection.query("SELECT * FROM advicemedia WHERE advice = " + an_advice_id.out)

--				if session_control.is_ok then
--					base_selection.load_result
--				else
--					create {BTW_ERROR_D_CONTROL[DS_LINKED_LIST[BTW_DB_ADVICE_MEDIA]]} Result.make_with_sql_error (session_control.error_message)
--				end

--				if base_selection.is_ok then

--					create Result.make (create {DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]}.make, False)
--					temp_advice_media_list := advice_media_filling.list
--					from temp_advice_media_list.start until temp_advice_media_list.after
--					loop
--						an_advice_media ?= temp_advice_media_list.item
--						if an_advice_media /= Void and then an_advice_media.id /= Void then
--							Result.return_value.put_last (an_advice_media)
--						end
--						temp_advice_media_list.forth
--					end

--				 else
--			 		 Result := create {BTW_ERROR_D_UNKNOWN[DS_LINKED_LIST[BTW_DB_ADVICE_MEDIA]]}.make (Void, True)
--				end

--				base_selection.terminate

--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [DS_LINKED_LIST [BTW_DB_ADVICE_MEDIA]]}.make (Void, True)
--			end

--		end

--	delete_advice_category (an_advice_category_id: INTEGER): BTW_RESULT [ANY] is
--			-- Delete from the db the category with 'an_advice_category_id' id
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				base_update.modify ("DELETE FROM advicecategory WHERE id='" + an_advice_category_id.out + "'")
--				session_control.commit
--				if session_control.is_ok then
--					create Result.make (Void, False)
--				else
--					create {BTW_ERROR_D_CONTROL [ANY]}Result.make_with_sql_error (session_control.error_message)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make (Void, True)
--			end
--		end

--	delete_advice_media(an_advice_media_id: INTEGER): BTW_RESULT [ANY] is
--			-- Delete from the db the media with 'an_advice_media_id' id
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				base_update.modify ("DELETE FROM advicemedia WHERE id='" + an_advice_media_id.out + "'")
--				session_control.commit
--				if session_control.is_ok then
--					create Result.make (Void, False)
--				else
--					create {BTW_ERROR_D_CONTROL[ANY]} Result.make_with_sql_error (session_control.error_message)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED[ANY]}.make (Void, True)
--			end
--		end

--	insert_category(a_category: BTW_ADVICE_CATEGORY): BTW_RESULT [ANY] is
--				-- Insert a category in the corresponding table of the advice
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create base_update.make
--				base_update.clear_all
--				base_update.modify ("INSERT INTO `advicecategory` (id,name) VALUES ('" + a_category.id.out + "','" + a_category.name + "')")
--				session_control.commit
--				if session_control.is_ok then
--					create Result.make (Void, False)
--				else
--					create {BTW_ERROR_D_CONTROL [ANY]} Result.make_with_sql_error(session_control.error_message)
--				end
--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [ANY]}.make(Void, True)
--			end
--	end

--feature -- MAP

--	get_maps_information: BTW_RESULT [LINKED_LIST [BTW_MAP_ID]] is
--			-- Get information on all the maps from the database.
--			-- This contains also the path where to find their XML description.
--		local
--			db_result_list: LINKED_LIST [DB_RESULT]
--			tuple: DB_TUPLE
--			city_name: STRING
--			city_filename: STRING
--			id: INTEGER_32_REF
--			result_list: LINKED_LIST [BTW_MAP_ID]
--			map_id: BTW_MAP_ID
--		do
--			session_control.reset
--			if session_control.is_connected then

--				create base_selection.make
--				create tuple.make
--				create db_result_list.make

--				base_selection.query ("SELECT * FROM maps")

--				if base_selection.is_ok then

--					create result_list.make
--					base_selection.set_container (db_result_list)
--					base_selection.load_result
--					from  base_selection.start until base_selection.after loop

--						tuple.copy (base_selection.cursor)
--						id ?= tuple.item (1)
--						city_name ?= tuple.item (2)
--						city_filename ?= tuple.item (3)
--						if city_name /= Void and then city_filename /= Void then
--							create map_id.make (city_name, city_filename)
--							map_id.set_id (id)
--							result_list.extend (map_id)
--						end

--						base_selection.forth
--					end

--				else
--				 	Result := create {BTW_ERROR_D_UNKNOWN [LINKED_LIST [BTW_MAP_ID]]}.make(Void, True)
--				end

--				base_selection.terminate
--				create Result.make (result_list, False)

--			else
--				Result := create {BTW_ERROR_D_NOT_CONNECTED [LINKED_LIST [BTW_MAP_ID]]}.make(Void, True)
--			end

--		ensure then
--			map_list_not_empty: Result /= Void and then not Result.error_has_occurred and then not Result.return_value.is_empty
--			-- Condition also strongly coupled to the dummy implementation. (TODO: fix it when really implementing)
--			-- Possible conditions: "'maps' table has entries" implies not Result.is_empty
--		end





end

