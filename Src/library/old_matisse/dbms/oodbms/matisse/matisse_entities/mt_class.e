class MT_CLASS

inherit

	MT_STREAMABLE
		export {NONE} all
		undefine out,is_equal
		end

	MT_CLASS_EXTERNAL
		undefine out,is_equal
		end

	MT_KEYS_EXTERNAL
		undefine out,is_equal
		end

	MT_NAME_EXTERNAL
		undefine out,is_equal
		end

	MATISSE_CONST
		export {NONE} all
		undefine out,is_equal
		end

	DB_STATUS_USE
		rename is_connected as dbs_is_connected
		undefine out,is_equal
		end

	OPERATING_ENVIRONMENT
		export {NONE} all
		undefine out,is_equal
		end

	COMPARABLE
		undefine out
		end

creation 

	make, make_from_object,make_from_id

feature {NONE} -- Initialization

	make(class_name : STRING) is
		-- Get class id from database and fills its name
		require
			string_not_void : class_name /= Void
			string_not_empty : not class_name.empty
		local
			class_name_to_c : ANY
		do
			class_name_to_c := class_name.to_c
			cid := c_get_class_from_name($class_name_to_c)
		end -- make

	make_from_object(one_object : MT_OBJECT) is
			-- Get class from object id
		do
			cid := c_get_class_from_object(one_object.oid)
		end -- make_from_object

	make_from_id(one_id : INTEGER) is
			-- Build class with id.
		do
			cid := one_id
		end -- make_from_id

feature  -- Access

	instances_count : INTEGER is
		-- Count instances of current class in database
		do
			Result := c_get_instances_number(cid)
		end -- instances_count

	cid : INTEGER -- Identifier in database

feature -- Access to new objects

	new_instance : MT_OBJECT is
		-- Instanciate one object with current class in Matisse
		local
			name_to_c : ANY
		do
			name_to_c := name.to_c
			!!Result.make(c_create_object($name_to_c))
		end -- new_instance

	create_n_objects(n : INTEGER) : ARRAY[MT_OBJECT] is
		-- Instanciate N new objects with current class in Matisse
		local
			keys_count,i : INTEGER
			one_object : MT_OBJECT
		do
			c_create_num_objects(n,cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_object.make(c_ith_key(i))
				Result.force(one_object,i)
				i := i + 1
			end -- loop
			c_free_keys   
		end -- create_n_objects

feature -- Access

	attributes : ARRAY[MT_ATTRIBUTE] is
		-- Attributes of current class according to database schema
		local
			keys_count,i : INTEGER
			one_attribute : MT_ATTRIBUTE
		do
			c_get_all_attributes(cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_attribute.make_from_id(c_ith_key(i))
				Result.force(one_attribute,i)
				i := i + 1
			end -- loop
			c_free_keys
		end -- attributes

	relationships : ARRAY[MT_RELATIONSHIP] is
		-- Relationships of current class according to database schema
		local
			keys_count,i : INTEGER
			one_attribute : MT_RELATIONSHIP
		do
			c_get_all_relationships(cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			 from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_attribute.make_from_id(c_ith_key(i))
				Result.force(one_attribute,i)
				i := i + 1
			 end -- loop
			c_free_keys	
		end -- relationships

	added_relationships : ARRAY[MT_RELATIONSHIP] is
		-- Relationships added in this class i.e. not inherited
		local
			one_selection : DB_SELECTION
			query : DB_PROC
			one_container : LINKED_LIST[DB_RESULT]
			i : INTEGER
			one_object : MT_OBJECT
			one_class : MT_CLASS
			one_relationship : MT_RELATIONSHIP
		do
			!!one_selection.make
			!!query.make(Ors)
			!!one_object.make(cid)
			one_selection.set_map_name(one_object,Object_map)
			!!one_relationship.make("Mt Relationships")
			one_selection.set_map_name(one_relationship,Relationship_map)
			query.execute(one_selection) 
 			!!one_container.make
			one_selection.set_container(one_container) 
			if one_selection.is_ok then
				one_selection.load_result    
				from
					one_container.start
					!!Result.make(1,one_container.count)
					i:=1
				until
					one_container.off
				loop
					one_object ?= one_container.item.data
					!!one_relationship.make_from_id(one_object.oid)
					Result.put(one_relationship,i)
					one_container.forth
					i:=i+1
				end -- loop
			end -- if
		end -- added_relationships

	inverse_relationships : ARRAY[MT_RELATIONSHIP] is
		-- Inverse relationships of current class according to database schema
		local
			keys_count,i : INTEGER
			one_object : MT_RELATIONSHIP
		do
			c_get_all_i_relationships(cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_object.make_from_id(c_ith_key(i))
				Result.force(one_object,i)
				i := i + 1
			end -- loop
			c_free_keys    
		end -- inverse_relationships

	subclasses : ARRAY[MT_CLASS] is
		-- Subclasses of current class
		local
			keys_count,i : INTEGER
			one_object : MT_CLASS
		do
			c_get_all_subclasses(cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
 				i= keys_count + 1
			loop
				!!one_object.make_from_id(c_ith_key(i))
 				Result.force(one_object,i)
				i := i + 1
			end -- loop
			c_free_keys    
		end -- subclasses

	superclasses : ARRAY[MT_CLASS] is
		-- Superclasses of current class
		local
			keys_count,i : INTEGER
			one_object : MT_CLASS
		do
			c_get_all_superclasses(cid)
			keys_count := c_keys_count
			!!Result.make(1,keys_count)
			from
				i := 1
			until 
				i= keys_count + 1
			loop
				!!one_object.make_from_id(c_ith_key(i))
				Result.force(one_object,i)
				i := i + 1
			end -- loop
			c_free_keys
		end -- superclasses

	parents : ARRAY[MT_CLASS] is
		-- Direct parents
		local
			one_selection : DB_SELECTION
			query : DB_PROC
			one_container : LINKED_LIST[DB_RESULT]
			i : INTEGER
			one_object : MT_OBJECT
			one_class : MT_CLASS
			one_relationship : MT_RELATIONSHIP
		do
			!!one_selection.make
			!!query.make(Ors)
			!!one_object.make(cid)
			one_selection.set_map_name(one_object,Object_map)
			!!one_relationship.make("Mt Superclasses")
			one_selection.set_map_name(one_relationship,Relationship_map)
			query.execute(one_selection) 
 			!!one_container.make
			one_selection.set_container(one_container) 
			if one_selection.is_ok then
				one_selection.load_result    
				from
					one_container.start
					!!Result.make(1,0)
					i:=1
				until
					one_container.off
				loop
					one_object ?= one_container.item.data
					!!one_class.make_from_id(one_object.oid)
					if not(one_object.is_predefined_msp) then Result.force(one_class,i) end
					one_container.forth
					i:=i+1
				end -- loop
			end -- if
		end -- parents

	name : STRING is
		-- Class name in database
		do
			!!Result.make(0) Result.from_c(c_object_name(cid))
		end -- name

	all_instances : ARRAY[MT_OBJECT] is
		-- All instances of this class in Matisse database
		local
			one_selection : DB_SELECTION
			query : DB_PROC
			one_container : LINKED_LIST[DB_RESULT]
			i : INTEGER
			one_object : MT_OBJECT
			one_class : MT_CLASS
		do
			!!one_selection.make
			!!query.make(Ocs)
			!!one_class.make_from_id(cid)
			one_selection.set_map_name(one_class,Class_map)
			query.execute(one_selection) 
 			!!one_container.make
			one_selection.set_container(one_container) 
			if one_selection.is_ok then
				one_selection.load_result    
				from
					one_container.start
					!!Result.make(1,one_container.count)
					i:=1
				until
					one_container.off
				loop
					one_object ?= one_container.item.data
					Result.put(one_object,i) 
					one_container.forth
					i:=i+1
				end -- loop
			end -- if
		ensure 
			Result = Void or else (Result.count = instances_count)
		end  -- all_instances

	all_index_names:ARRAYED_LIST [STRING] is
			-- list of all index names for this class whether introduced or inherited
		local
			classes:ARRAY[MT_CLASS]
			i,j:INTEGER
			rel:MT_RELATIONSHIP
			an_obj:MT_OBJECT
			an_att:MT_ATTRIBUTE
			objs:ARRAY[MT_OBJECT]
			str:STRING
		do
			!!Result.make(0)
			!!rel.make("Mt Indexes")

			superclasses.force(Current, superclasses.upper+1)
			from i := superclasses.lower until i > superclasses.upper loop
				!!an_obj.make(superclasses.item(i).cid)
				objs := an_obj.successors(rel)
					from j := objs.lower until j > objs.upper loop
						!!an_att.make("Mt Name")
						str ?= an_att.value(objs.item(j))
						if str /= Void then
							Result.extend(str)
						end
						j := j + 1
					end
				i := i + 1
			end
		end

feature -- Action

	remove_all_instances is
		-- Remove all instances of current class in database
		require
			is_connected
		local
			ai : ARRAY[MT_OBJECT] i:INTEGER
		do
			ai := all_instances
			if ai /= Void then
				from
					i := ai.lower
				until
					i>ai.upper
				loop
					ai.item(i).remove
					i:=i+1
				end -- loop
			end -- if
		end -- remove_all_instances

feature -- Status Report

	is_connected : BOOLEAN is
		-- Is connection to server available ?
		do
			Result := dbs_is_connected
		end -- is_connected

	eiffel_name : STRING is
		-- Matisse name are converted to lower case and appended with eiffel file extension (".e")
		do
			!!Result.make(32)
			Result := name Result.to_lower Result.append(".e")
		end -- eiffel_name	

	is_predefined_msp : BOOLEAN is
		-- Is it standard ?
		local
			one_object : MT_OBJECT
		do
			!!one_object.make(Current.cid)
			Result := one_object.is_predefined_msp	
		end -- is_predefined_msp

feature -- Output

	out : STRING is
		local
			buffer,c : STRING
			c_attributes,p_attributes,attrs : ARRAY[MT_ATTRIBUTE]
			i,j,k,attribute_type : INTEGER
			is_inherited : BOOLEAN
			today : DATE_TIME 
			one_class : MT_CLASS 
			par :ARRAY[MT_CLASS] 
			cr : ARRAY[MT_RELATIONSHIP] 
			rs : ARRAY[MT_CLASS]
		do
			!!buffer.make(512)
			-- Indexing
			buffer.append("indexing%N%N")
			buffer.append("%Tdate : %"") !!today.make_now buffer.append(today.formatted_out(today.Default_format_string)) buffer.append("%"%N%N")
			buffer.append ("class ") c:=name c.to_upper
			buffer.append (c)
			-- Inheritance part
			par := parents
			if par/=Void and then par.count >0 then buffer.append("%N%Ninherit%N") end
			from  i:= par.lower
			until i>par.upper
			loop
				c := par.item(i).name c.to_upper  
				buffer.append("%T") buffer.append(c) buffer.append("%N")
				i:=i+1
			end
			-- Attributes
			buffer.append ("%N%Nfeature -- Attributes%N%N")
			c_attributes := attributes
			if c_attributes /= Void then
			from
				i:=c_attributes.lower
			until
				i>c_attributes.upper
			loop
				-- Is attribute inherited ?
				if not(c_attributes.item(i).is_predefined_msp) then
				from 
					is_inherited := false
					j:= par.lower
				until 
					j>par.upper or is_inherited
				loop
					p_attributes := par.item(j).attributes
					from k:= p_attributes.lower until k>p_attributes.upper or is_inherited loop
						is_inherited := p_attributes.item(k).name.is_equal(c_attributes.item(i).name)
						k:=k+1
					end
					j:=j+1
				end
				if not(is_inherited) then
					buffer.append ("%T") c:= c_attributes.item(i).name c.to_lower
					buffer.append(c) buffer.append(" : ") 
					buffer.append(attr_type(c_attributes.item(i)))
					buffer.append("%N%N")
				end
				end
				i:= i + 1
			end -- loop
				
			end
			-- Relationships
			buffer.append ("feature -- Relationships%N%N")
			cr := added_relationships 
			if cr/=Void then
				from  i:=cr.lower until  i>cr.upper
				loop
					buffer.append ("%T") c:= cr.item(i).name c.to_lower
					buffer.append(c) buffer.append(" : ") 
					rs := cr.item(i).successors  c := rs.item(rs.lower).name c.to_upper buffer.append(c) buffer.append("%N")
					i:=i+1	
				end 
			end
			buffer.append("%Nend -- class ") c:=name c.to_upper buffer.append(c) buffer.append("%N") 
			Result := buffer
		end -- out

	out_flat : STRING is
		local
			buffer,c : STRING
			c_attributes,attrs : ARRAY[MT_ATTRIBUTE]
			i,attribute_type : INTEGER
			today : DATE_TIME 
			one_class : MT_CLASS 
			cr : ARRAY[MT_RELATIONSHIP] 
			rs : ARRAY[MT_CLASS]
		do
			!!buffer.make(512)
			-- Indexing
			buffer.append("indexing%N%N")
			buffer.append("%Tdate : %"") !!today.make_now buffer.append(today.formatted_out(today.Default_format_string)) buffer.append("%"%N%N")
			buffer.append ("class ") c:=name c.to_upper
			buffer.append (c)

			-- Attributes
			buffer.append ("%N%Nfeature -- Attributes%N%N")
			c_attributes := attributes
			if c_attributes /= Void then
				from
					i:=c_attributes.lower
				until
					i>c_attributes.upper
				loop
					-- Is attribute inherited ?
					if not(c_attributes.item(i).is_predefined_msp) then
						buffer.append ("%T") c:= c_attributes.item(i).name c.to_lower
						buffer.append(c) buffer.append(" : ") 
						buffer.append(attr_type(c_attributes.item(i)))
						buffer.append("%N%N")
					end
					i:= i + 1
				end -- loop			
			end

			-- Relationships
			buffer.append ("feature -- Relationships%N%N")
			cr := relationships 
			if cr/=Void then
				from  i:=cr.lower until  i>cr.upper
				loop
					buffer.append ("%T") c:= cr.item(i).name c.to_lower
					buffer.append(c) buffer.append(" : ") 
					rs := cr.item(i).successors  c := rs.item(rs.lower).name c.to_upper buffer.append(c) buffer.append("%N")
					i:=i+1	
				end 
			end
			buffer.append("%Nend -- class ") c:=name c.to_upper buffer.append(c) buffer.append("%N") 
			Result := buffer
		end -- out_flat

	attr_type(an_attr:MT_ATTRIBUTE) : STRING is
		local
			attribute_type : INTEGER
		do
			!!Result.make(0)

			attribute_type := an_attr.type
			if attribute_type = Mts32 then
				Result.append("INTEGER")
			elseif attribute_type = Mtdouble then
				Result.append("DOUBLE")
			elseif attribute_type = Mtfloat then
				Result.append("REAL")
			elseif attribute_type = Mtchar or attribute_type = Mtasciichar then
				Result.append("CHARACTER")
			elseif attribute_type = Mtstring or attribute_type = Mtasciistring then
				Result.append("STRING")
			elseif attribute_type = Mtstring_list then
				Result.append("LINKED_LIST[STRING]")
			elseif attribute_type = Mts32_list then
				Result.append("LINKED_LIST[INTEGER]")
			elseif attribute_type = Mtdouble_list then
				Result.append("LINKED_LIST[DOUBLE]")
			elseif attribute_type = Mtfloat_list then
				Result.append("LINKED_LIST[REAL]")
			elseif attribute_type = Mtstring_array then
				Result.append("ARRAY[STRING]")
			elseif attribute_type = Mts32_array then
				Result.append("ARRAY[INTEGER]")
			elseif attribute_type = Mtdouble_array then
				Result.append("ARRAY[DOUBLE]")
			elseif attribute_type = Mtfloat_array then
				Result.append("ARRAY[REAL]")
			elseif attribute_type = Mtu8_array then
				Result.append("ARRAY[BOOLEAN]")
			else
				Result.append("UNKOWN_TYPE")
			end
		end

	infix "<" (other: MT_CLASS): BOOLEAN is
		do
			Result := cid < other.cid
		end --_infix_lt

	to_directory (directory : DIRECTORY) is
		-- Create a physical file with corresponding Eiffel class
		require
			directory_exists  : directory /= Void and then directory.exists
			directory_writable : directory.is_writable
		local
			class_file : PLAIN_TEXT_FILE
			c_name : STRING
		do
			c_name := Clone(directory.name)
			c_name.append(Directory_separator.out)
			c_name.append(eiffel_name)

			!!class_file.make(c_name)
			if class_file.exists then class_file.wipe_out end
			class_file.open_write
			io.putstring("############## ") io.putstring(name) io.new_line
			class_file.put_string(out) 
			class_file.close	
		ensure 
			file_exists : directory.has_entry(eiffel_name)
		end -- out_to_file

feature {NONE} -- Implementation

	stream : MT_CLASS_STREAM

end -- class MT_CLASS
