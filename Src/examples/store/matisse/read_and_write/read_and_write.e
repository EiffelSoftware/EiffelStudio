class READ_AND_WRITE

inherit

	MATISSE_CONST

Creation 
    make

feature {NONE}

	make is
		-- Prints various information
	do
		-- 1/ Choose host name and database name. Adjust wait and priority so that it suits your needs.
		!!appl.login("TOKYO","testdb",0,0)

		-- 2/ Choose working mode. See documentation for that.
		appl.set_mode(OPENED_TRANSACTION,Void)

		-- 3/ Connect Matisse handle to EiffelStore.
		appl.set_base

		-- 4/ Create a Matisse session.
		!!session.make
		
		-- 5/ Connect to database with the appropriate mode (given above).
		session.connect

		-- 6/ Insert your actions here.
		-- ...
		actions

		--7/ Disconnect from database.
		session.disconnect
		
	end -- make

feature -- Status Setting

	actions is
		-- Database actions
	do
        !!mc.make("Employee")
        mo := mc.new_instance

		io.putstring("%N Objet avant :%N")
		write_object
		read_object
		session.commit

        io.putstring("%N Objet après :%N")
		session.begin
        read_object
		session.commit

	end -- actions

	read_object is
	do
            -- Integer
        !!one_attribute.make("Integer value") aninteger ?= one_attribute.value(mo) io.putstring("%TInteger : ") io.putstring(aninteger.out) io.new_line 
            -- Double
        !!one_attribute.make("Double value") adouble ?= one_attribute.value(mo) io.putstring("%TDouble : ") io.putstring(adouble.out) io.new_line 
            -- Real
        !!one_attribute.make("Real value") areal ?= one_attribute.value(mo) io.putstring("%TReal : ") io.putstring(areal.out) io.new_line 
            -- Character
        !!one_attribute.make("Character value") achar ?= one_attribute.value(mo) io.putstring("%TCharacter : ") io.putstring(achar.out) io.new_line 
            -- String
        !!one_attribute.make("String value") astring ?= one_attribute.value(mo) io.putstring("%TString : ") io.putstring(astring) io.new_line 
            -- list integer
        !!one_attribute.make("Integer List") ali ?= one_attribute.value(mo) io.putstring("%TInteger List : ") io.putint(ali.count) io.putstring(" items - ")
        from ali.start until ali.off loop io.putint(ali.item) io.putstring(",") ali.forth end io.new_line
           -- list double
        !!one_attribute.make("Double List") ald ?= one_attribute.value(mo) io.putstring("%TDouble List : ") io.putint(ald.count) io.putstring(" items - ")
        from ald.start until ald.off loop io.putdouble(ald.item) io.putstring(",") ald.forth end  io.new_line
           -- list real
        !!one_attribute.make("Real List") alr ?= one_attribute.value(mo) io.putstring("%TReal List : ") io.putint(alr.count) io.putstring(" items - ")
        from alr.start until alr.off loop io.putreal(alr.item) io.putstring(",") alr.forth end io.new_line
            -- list string
        !!one_attribute.make("String List") als ?= one_attribute.value(mo) io.putstring("%TString List : ") io.putint(als.count) io.putstring(" items - ")
        from als.start until als.off loop io.putstring(als.item) io.putstring(",") als.forth end io.new_line
            -- array integer
        !!one_attribute.make("Integer Array") aai ?= one_attribute.value(mo) io.putstring("%TInteger Array : ") io.putint(aai.count) io.putstring(" items - ")
        from i:=aai.lower until i=aai.upper+1 loop io.putint(aai.item(i)) io.putstring(",") i:=i+1 end io.new_line
            -- array double
        !!one_attribute.make("Double Array") aad ?= one_attribute.value(mo) io.putstring("%TDouble Array : ") io.putint(aad.count) io.putstring(" items - ")
        from i:=aad.lower until i=aad.upper+1 loop io.putdouble(aad.item(i)) io.putstring(",") i:=i+1 end io.new_line
            -- array real
        !!one_attribute.make("Real Array") aar ?= one_attribute.value(mo) io.putstring("%TReal Array : ") io.putint(aar.count) io.putstring(" items - ")
        from i:=aar.lower until i=aar.upper+1 loop io.putreal(aar.item(i)) io.putstring(",") i:=i+1 end io.new_line
            -- array integer
        !!one_attribute.make("String Array") aas ?= one_attribute.value(mo) io.putstring("%TString Array : ") io.putint(aas.count) io.putstring(" items - ")
        from i:=aas.lower until i=aas.upper+1 loop io.putstring(aas.item(i)) io.putstring(",") i:=i+1 end io.new_line
	end -- read_object

	write_object is
	do
		-- Change integer
        !!one_attribute.make("Integer value") 
        one_attribute.set_value(mo,Mts32,191271) 
        -- Change double
        !!one_attribute.make("Double value") 
        one_attribute.set_value(mo,Mtdouble,1.00012) 
        -- Change real
        !!one_attribute.make("Real value") 
        one_attribute.set_value(mo,Mtfloat,0.70568) 
        -- Change char
        !!one_attribute.make("Character value") 
        one_attribute.set_value(mo,Mtchar,'Z') 
        -- Change string
        !!one_attribute.make("String value") 
        one_attribute.set_value(mo,Mtstring,"New string") 
          -- Change array integer
        !!one_attribute.make("Integer Array")  aai:=<<0,1,2,3,4,5,6,7,8,9,10,11,12>>
        one_attribute.set_value(mo,Mts32_array,aai) 
         -- Change array double
        !!one_attribute.make("Double Array")  aad:=<<0.11111111111111111111111111111,1256.222222222222222222222222222222>>
        one_attribute.set_value(mo,Mtdouble_array,aad) 
         -- Change array real
        !!one_attribute.make("Real Array")  aar:=<<.0,1.,.2,3.,.4,5.,.6,7.,.8,9.,.10,1.1,.12>>
        one_attribute.set_value(mo,Mtfloat_array,aar) 
        -- Change array string
        !!one_attribute.make("String Array")  aas:=<<"ISE","SOL">>
        one_attribute.set_value(mo,Mtstring_array,aas) 
      -- Change list integer
        !!one_attribute.make("Integer list")  
        !!ali.make
        from i:= 1 until i=10+1 loop ali.extend(i) ali.forth i:=i+1 end
        one_attribute.set_value(mo,Mts32_list,ali) 
      -- Change list double
        !!one_attribute.make("Double list")  
        !!ald.make
        from i:= 1 until i=10+1 loop ald.extend(1/(i*i*i*i)) ald.forth i:=i+1 end
        one_attribute.set_value(mo,Mtdouble_list,ald) 
       -- Change list real
        !!one_attribute.make("Real list")  
        !!alr.make
        from i:= 1 until i=10+1 loop alr.extend(1/i) alr.forth i:=i+1 end
        one_attribute.set_value(mo,Mtfloat_list,alr) 
      -- Change list string
        !!one_attribute.make("String list")  
        !!als.make
        from i:= 1 until i=22+1 loop als.extend(i.out) als.forth i:=i+1 end
        one_attribute.set_value(mo,Mtstring_list,als) 
        io.new_line
	end -- write_object

feature {NONE} -- Implementation

	appl : MATISSE_APPL
	session : DB_CONTROL

	i:INTEGER
	astring : STRING;aninteger : INTEGER_REF;adouble:DOUBLE_REF;areal : REAL_REF;
	achar:CHARACTER_REF;ali : LINKED_LIST[INTEGER];ald :LINKED_LIST[DOUBLE];alr : LINKED_LIST[REAL];als : LINKED_LIST[STRING]
	aai : ARRAY[INTEGER];aad : ARRAY[DOUBLE];aar : ARRAY[REAL];aas : ARRAY[STRING]
	one_attribute : MT_ATTRIBUTE
	
	fname : MT_ATTRIBUTE
	mc : MT_CLASS
	mo : MT_OBJECT
	aa : ARRAY[MT_ATTRIBUTE]
	mi : MT_INDEX
	mep : MT_ENTRYPOINT
	mr : MT_RELATIONSHIP
	mm : MT_MESSAGE
	minfo : MT_INFO
	mtime : MT_TIME_STREAM
	ms : DB_SELECTION
	mp : DB_PROC

end -- class READ_AND_WRITE

