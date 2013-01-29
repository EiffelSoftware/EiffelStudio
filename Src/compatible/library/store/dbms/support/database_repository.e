note
	description: "Implementation of DB_REPOSITORY"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_REPOSITORY [reference G -> DATABASE create default_create end]

inherit

	EXCEPTIONS
		rename
			class_name as exceptions_class_name
		end

	DB_STATUS_USE

	ACTION
		redefine
			execute
		end

	EXT_INTERNAL

	BASIC_ROUTINES

	TYPES [G]

create -- Creation procedure

	make

feature -- Initialization

	make
			-- Create attributes
		do
			create table.make (1)
			create tmp_acc_col
			create repository_name.make(1)
			create rep_qualifier.make(1)
			create rep_owner.make(1)
		end

	load
			-- Load in description of repository `repository_name'.
		require else
			repository_name_exists: repository_name /= Void
		do
			table.wipe_out
			request_select.set_action (Current)
			request_select.set_map_name (repository_name, "rep")
			request_select.query (Selection_string)
			request_select.unset_map_name ("rep")
			if (request_select.is_ok) then
				request_select.load_result
			end
			request_select.terminate
		end


feature -- Basic operations

	generate_class(f: FILE)
			-- Generate Eiffel class template according to data
			-- representation given by `repository_name'.
		require
			file_exists: f /= Void and then f.exists
		local
			el: COLUMNS [G]
			el_type: INTEGER
			col_name: STRING
			tmp_class_name: STRING
			s,s1,s2,s3,s4: STRING
			l_column_name: detachable STRING
		do
			tmp_class_name := repository_name.as_upper
			Create s.make(20)

			s.append("indexing%N")
			s.append("%Tdescription: %"Class which allows EiffelStore to retrieve/store%%%N")
			s.append("%T      %%the content relative to a column of the table "+tmp_class_name+"%"%N%N")

			s.append("class%N%T"+tmp_class_name+" %N%N")
			s.append("inherit%N%TANY%N%T%Tredefine%N%T%T%Tout%N%T%Tend%N%N")
			s.append("create%N%Tmake%N%N")

			s.append ("%Nfeature -- Access%N%N")

			s1 := "feature -- Settings%N%N"
			s3 := "feature -- Initialization%N%N%Tmake%N%T%Tdo%N"
			s4 := "feature -- Output%N%N%Tout: STRING%N%T%Tdo%N%T%T%TResult := %"%"%N"

			from
				table.start
			until
				table.off
			loop
				el := table.item
				l_column_name := el.column_name
				check l_column_name /= Void end -- FIXME: implied by ...bug
				col_name := l_column_name.as_lower

				s1.append("%Tset_"+col_name+" (a_"+col_name+": ")
				s.append ("%T"+col_name+": ")
				el_type := el.eiffel_type
				if el_type = Integer_type_database then
					s2 := "INTEGER"
					s3.append("%T%T%T"+col_name+" := 0%N")
				elseif el_type = Boolean_type_database then
					s3.append("%T%T%T"+col_name+" := FALSE%N")
					s2 := "BOOLEAN"
				elseif el_type = Real_type_database then
					s3.append("%T%T%T"+col_name+" := 0.0%N")
					s2 := "DOUBLE"
				elseif el_type = Float_type_database then
					s3.append("%T%T%T"+col_name+" := 0.0%N")
					s2 := "DOUBLE"
				elseif el_type = String_type_database or el_type = Character_type_database then
					if el.data_length = 1 then
						s3.append("%T%T%T"+col_name+" := 'a'%N")
						s2 := "CHARACTER"
					else
						s3.append("%T%T%T"+col_name+" := %"%"%N")
						s2 := "STRING"
					end
				elseif el_type = Date_type_database then
					s2 := "DATE_TIME"
					s3.append("%T%T%Tcreate "+col_name+".make_now%N")
				else
					s2 :=  "ANY"
				end

				s4.append("%T%T%TResult.append (" + col_name + ".out + %"%%N%")%N")

				s1.append(s2+")%N%T%T%T--Set the value of "+col_name)
				s1.append("%N%T%Trequire")
				s1.append("%N%T%T%Tvalue_exists: a_"+col_name+" /= Void")
				s1.append("%N%T%Tdo")
				s1.append("%N%T%T%T"+col_name+" := a_"+col_name)
				s1.append("%N%T%Tensure")
				s1.append("%N%T%T%T" + col_name + "_set: a_"+col_name+" = "+col_name)
				s1.append("%N%T%Tend%N%N")
				s.append (s2+"%N%T%T%T-- Auto-generated.%N%N")
				table.forth
			end
			s3.append("%T%Tend%N%N")
			s4.append("%T%Tend%N%N")

			s.append (s3)
			s.append (s1)
			s.append (s4)
			s.append ("end -- class "+tmp_class_name+"%N")
			f.put_string (s)
		end

	execute
			-- Implement an ACTION operation
		do
			request_select.object_convert (tmp_acc_col)
			request_select.cursor_to_object
			table.extend (tmp_acc_col.duplicate)
			tmp_acc_col.clear_all
		end

feature -- Status setting

	allocate (object: ANY; table_name: STRING)
			-- Create a schema table `repository_name' conforming
			-- to `object' basic attributes.
		require else
			table_not_void: table_name /= Void
			object_not_void: object /= Void
		local
			i: INTEGER
			ft: INTEGER
			r_string: STRING
			t_int: INTEGER
			quoter: STRING
			sep: STRING
		do
			create r_string.make (512)
			create quoter.make(1)
			create sep.make(1)
			quoter := db_spec.identifier_quoter
			sep := db_spec.qualifier_separator
			r_string.append ("create table ")
			if (rep_qualifier /= Void and then rep_qualifier.count > 0) then
				r_string.append(quoter)
				r_string.append(rep_qualifier)
				r_string.append(quoter)
			end
			if (rep_owner /= Void and then rep_owner.count > 0) then
				r_string.append(sep)
				r_string.append(quoter)
				r_string.append(rep_owner)
				r_string.append(quoter)
			end
			if ((rep_owner /= Void and then rep_owner.count > 0) or (rep_qualifier /= Void and then rep_qualifier.count > 0)) then
				r_string.append(".")
			end
			r_string.append(quoter)
			r_string.append(table_name)
			r_string.append(quoter)
			r_string.append (" (")
			from
				i := 1
			until
				i > field_count (object)
			loop
				ft := field_type (i, object)
				if ft = 0 then
					r_string.wipe_out
					r_string.append (field_name (i, object))
					r_string.append (" can't be Void")
					raise (r_string)
				end
				inspect ft
				when Integer_type then
					r_string.append (field_name (i, object))
					r_string.append (" ")
					r_string.append (db_spec.sql_name_integer)
				when Real_type then
					r_string.append (field_name (i, object))
					r_string.append (" ")
					r_string.append (db_spec.sql_name_real)
				when Double_type then
					r_string.append (field_name (i, object))
					r_string.append (" ")
					r_string.append (db_spec.sql_name_double)
				when Character_type then
					r_string.append (field_name (i, object))
					r_string.append (" ")
					r_string.append (db_spec.sql_name_character)
				when Boolean_type then
					r_string.append (field_name (i, object))
					r_string.append (" ")
					r_string.append (db_spec.sql_name_boolean)
				else
					if is_string (field (i, object)) then
						r_string.append (field_name (i, object))
						if attached {STRING} field (i, object) as t_string then
							if t_string.count < Max_char_size then
								r_string.append (" ")
								r_string.append (db_spec.sql_string)
								t_int := t_string.capacity
								if t_int = 0 then
									t_int := 10
								elseif t_int > Max_char_size then
									t_int := Max_char_size - 1
								end
								r_string.append (t_int.out)
								r_string.append (")")
							else
								r_string.append (" ")
								r_string.append (db_spec.sql_string2 (Max_char_size))
							end
						else
							check False end -- implied by `is_string (field (i, object))'
						end
					elseif is_date (field (i, object)) then
						r_string.append (field_name (i, object))
						r_string.append (" ")
						r_string.append (db_spec.sql_name_datetime)
					else
						raise ("unknown type")
					end
				end
				if i /= field_count (object) then
					r_string.append (", ")
				end
				i := i + 1
			end
			r_string.extend (')')
			request_create.modify (r_string)
		end

	change_name (new_name: STRING)
			-- Set repository name with `repository_name'.
		require else
			new_name_not_void: new_name /= Void
		do
			repository_name := new_name
			if (not db_spec.sensitive_mixed) then
				repository_name.to_lower
			end
			table.wipe_out
		ensure then
			not exists
		end

feature -- Status report

	repository_name: STRING
			-- Repository name corresponding to table name in DB schema.

	rep_qualifier: STRING
			-- Qualifier of the Repository.

	rep_owner: STRING
			-- Owner of the table.

	dimension: INTEGER
			-- Table column count.
		require else
			repository_exists: exists
		do
			Result := table.count
		end

	column_name (i :INTEGER): detachable STRING
			-- Name of i-th column of table-like repository.
		require else
			repository_exists: exists
			good_position: 0 < i and i <= dimension
		local
			l_result: detachable STRING
		do
			table.go_i_th (i)
			l_result := (table.item).column_name
			if l_result /= Void then
				Result := l_result.twin
			end
		end

	conforms (object: ANY): BOOLEAN
			-- Is the structure of repository_name the same
			-- as the structure of `object'.
		require else
			object_exists: object /= Void
		local
			i: INTEGER
			ft: INTEGER
			col_type: ANY
			t_string, f_name: STRING
			el: COLUMNS [G]
		do
			if field_count (object) = table.count then
				from
					i := 1
					Result := true
				until
					i > field_count (object)
				loop
					ft := field_type (i, object)
					if ft = 0 then
						create t_string.make (0)
						t_string.append (field_name(i,object))
						t_string.append (" does not exist")
						raise (t_string)
					end
					from
						f_name := field_name (i, object)
						table.start
					until
						table.after or f_name ~ table.item.column_name
					loop
						table.forth
					end
					if table.after then
						Result := false
					else
						el := table.item

						col_type := el.eiffel_type
						inspect ft
						when Integer_type then
							Result := Result and (col_type = Integer_type_database)
						when Real_type, Double_type then
							Result := Result and (col_type = Float_type_database)
						when Character_type then
							Result := Result and (col_type = String_type_database
												and el.data_length = 1)
						when Boolean_type then
							Result := Result and (col_type = Boolean_type_database)
						else
							if is_string (field (i, object)) then
								Result := Result and (col_type = String_type_database)
							elseif is_date (field (i,object)) then
								Result := Result and (col_type = Date_type_database)
							else
								Result := false
							end
						end
					end
					i := i + 1
				end
			end

		end

	exists: BOOLEAN
			-- Does current repository exist in database schema?
		do
			Result := not table.is_empty
		end

	column_number: INTEGER
			-- Column Number.
		do
			Result := table.count
		ensure
			Result >= 0
		end

	column_i_th(i: INTEGER): COLUMNS[DATABASE]
			-- Column corresponding to indice 'i'.
		require
			indice_valid: i>=1 and i<=column_number
		do
			Result := table.i_th(i)
		ensure
			Result /= Void
		end


feature {NONE} -- Status report

	tmp_acc_col: COLUMNS [G]
			-- Temporary column related information holder.

	table: ARRAYED_LIST [COLUMNS [G]]
			-- List of column related information.
			--| Cedric: LINKED_LIST replaced with an ARRAYED_LIST:
			--| no element move in the class, feature to access list
			--| elements is `column_i_th'.

	request_select: DB_SELECTION
			-- Selection utility object.
		once
			create Result.make
		end

	request_create: DB_CHANGE
			-- Modification utility object.
		once
			create Result.make
		end

	Selection_string: STRING
		do
			Result := db_spec.Selection_string (rep_qualifier, rep_owner, repository_name)
		end


	Max_char_size: INTEGER
		do
			Result := db_spec.Max_char_size
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class DATABASE_REPOSITORY


