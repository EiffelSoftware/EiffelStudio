indexing
	description: "This class provides a proxy interface to the MATISSE_IDF_TABLE %
                   %abstraction. It enables more than one IDF_TABLE to exist at a time, %
                   %even though there is only one MATISSE_IDF_TABLE instance in the system, %
                   %due to being bound to a single set of resources in C. This object acts %
                   %like a MATISSE_IDF_TABLE for the purposes of storage, but does nothing %
                   %to the system until save is called, at which time it performs all the %
                   %actions previously performed by the MATISSE_STORER methods make_idf_table, %
                   %update_table, and save_idf_table."
	keywords:    "matisse idf"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class PROXY_IDF_TABLE

inherit
	STORE_HANDLE
	MATISSE_TABLES

creation
	make

feature {NONE} -- Initialization
	make(a_count:INTEGER; key: INTEGER_REF) is
		local
			an_mt_class:MT_CLASS
		do
			!!oids.make(count)
			!!objects.make(count)

			if key.item <= 0 then
			    -- making for store
			    !!an_mt_class.make(idf_table_name)
			    mt_table := an_mt_class.new_instance
			    oid := mt_table.oid
			else
			    -- making for retrieve
			    !!special_flags.make(count)
			    oid := key.item
			end 

			count := a_count
		end

feature -- Access
	count:INTEGER

	oid : INTEGER -- Table id in Matisse

feature {NONE} -- Implementation
	objects:ARRAYED_LIST[ANY]
	oids:ARRAYED_LIST[INTEGER]
	special_flags:ARRAYED_LIST[BOOLEAN]

	mt_table:MT_OBJECT

feature -- Store
	put_flag(object : ANY) is
		    -- Put flag at current flags_index position
		do
		    objects.extend(object)
		end
	
	put_oid(id : INTEGER) is
		    -- Put oid at current oids_index position
		require
		    Valid_id: id > 0
		do
		    oids.extend(id)
		end

	save is
		    -- build, populate and save IDF_TABLE in one hit
		local
		    an_idf_table:MATISSE_IDF_TABLE
		do
		    -- initialise the table
		    !!an_idf_table.make(count, oid)
		    idf_table.put(an_idf_table)
		    id_cell.put(oid)

		    -- populate from oid and flag arrays
		    from
		        oids.start
		        objects.start
		    until
		        oids.off
		    loop
		        idf_table.item.put_flag(objects.item)
		        idf_table.item.put_oid(oids.item)

		        oids.forth
		        objects.forth
		    end

		    -- save and cleanup 
		    idf_table.item.save
		    idf_table.item.dispose
		end

feature -- Retrieve
	load is
			-- Retrieve table from database and populate proxy structures
		local
		    an_idf_table:MATISSE_IDF_TABLE
			i:INTEGER
		do
		    !!an_idf_table.make(count, oid)
		    idf_table.put(an_idf_table)

			idf_table.item.load

			flags_index := idf_table.item.flags_index
			oids_index := idf_table.item.oids_index

			from
				i := 0
			until
				i >= flags_index
			loop
				oids.extend(idf_table.item.ith_oid(i))
				special_flags.extend(idf_table.item.is_ith_special(i))
				if idf_table.item.is_ith_special(i) then
					objects.extend(idf_table.item.ith_special(i))
				else
					objects.extend(idf_table.item.ith_normal(i))
				end
				i:=i+1
			end
			idf_table.item.dispose
		end

	flags_index : INTEGER
			-- Current index in flags array

	oids_index : INTEGER
		    -- Current index in oids array

	has_oid(id:INTEGER):BOOLEAN is
		do
			Result := oids.has(id)
		end

	ith_oid(i: INTEGER ) : INTEGER is
			--  Oid at position 'i' (0-offset to mimic C)
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result := oids.i_th(i+1)
		end

	ith_special(i:INTEGER) : SPECIAL[ANY] is
			-- Special object position 'i' (0-offset to mimic C)
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result ?= objects.i_th(i+1)
		ensure
			Result /= Void
		end

	ith_normal(i:INTEGER) : ANY is
			--  Normal object at position 'i' (0-offset to mimic C)
		require
			inside_bounds : i>=0 and i<=oids_index
		do
			Result := objects.i_th(i+1)
		ensure
			Result /= Void
		end

	is_ith_special(i:INTEGER) : BOOLEAN is
			-- Is ith object a special object ?  (0-offset to mimic C)
		do
			Result := special_flags.i_th(i+1)
		end
   

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

