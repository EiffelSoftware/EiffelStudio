frozen external class
	STRING
alias
	"java.lang.String"
inherit
	ANY	
		rename
			
		undefine
			
		redefine
			hashcode,			
			equals,			
			tostring			
		end
	
	JAVA_IO_SERIALIZABLE	
		rename
			
		undefine
			
		redefine
			
		end
	
create
	make_string,	
	make_string_string,	
	make_string_array_character_,	
	make_string_array_character__integer,	
	make_string_array_integer_8__integer_integer_integer,	
	make_string_array_integer_8__integer,	
	make_string_array_integer_8__integer_integer_sun_io_bytetocharconverter,	
	make_string_array_integer_8__integer_integer_string,	
	make_string_array_integer_8__string,	
	make_string_array_integer_8__integer_integer,	
	make_string_array_integer_8_,	
	make_string_java_lang_stringbuffer,	
	make_string_integer	
feature {NONE} -- Initialisation

	make_string is	
			-- public java.lang.String()			
		external
			"JVM creator use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_string (arg_1: STRING) is	
			-- public java.lang.String(java.lang.String)			
		external
			"JVM creator signature (java.lang.String) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_character_ (arg_1: ARRAY[CHARACTER]) is	
			-- public java.lang.String(char[])			
		external
			"JVM creator signature (char[]) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_character__integer (arg_1: ARRAY[CHARACTER]; arg_2: INTEGER; arg_3: INTEGER) is	
			-- public java.lang.String(char[],int,int)			
		external
			"JVM creator signature (char[], int, int) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__integer_integer_integer (arg_1: ARRAY[INTEGER_8]; arg_2: INTEGER; arg_3: INTEGER; arg_4: INTEGER) is	
			-- public java.lang.String(byte[],int,int,int)			
		external
			"JVM creator signature (byte[], int, int, int) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__integer (arg_1: ARRAY[INTEGER_8]; arg_2: INTEGER) is	
			-- public java.lang.String(byte[],int)			
		external
			"JVM creator signature (byte[], int) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__integer_integer_sun_io_bytetocharconverter (arg_1: ARRAY[INTEGER_8]; arg_2: INTEGER; arg_3: INTEGER; arg_4: SUN_IO_BYTETOCHARCONVERTER) is	
			-- private java.lang.String(byte[],int,int,sun.io.ByteToCharConverter)			
		external
			"JVM creator signature (byte[], int, int, sun.io.ByteToCharConverter) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__integer_integer_string (arg_1: ARRAY[INTEGER_8]; arg_2: INTEGER; arg_3: INTEGER; arg_4: STRING) is	
			-- public java.lang.String(byte[],int,int,java.lang.String) throws java.io.UnsupportedEncodingException			
		external
			"JVM creator signature (byte[], int, int, java.lang.String) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__string (arg_1: ARRAY[INTEGER_8]; arg_2: STRING) is	
			-- public java.lang.String(byte[],java.lang.String) throws java.io.UnsupportedEncodingException			
		external
			"JVM creator signature (byte[], java.lang.String) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8__integer_integer (arg_1: ARRAY[INTEGER_8]; arg_2: INTEGER; arg_3: INTEGER) is	
			-- public java.lang.String(byte[],int,int)			
		external
			"JVM creator signature (byte[], int, int) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_array_integer_8_ (arg_1: ARRAY[INTEGER_8]) is	
			-- public java.lang.String(byte[])			
		external
			"JVM creator signature (byte[]) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_java_lang_stringbuffer (arg_1: JAVA_LANG_STRINGBUFFER) is	
			-- public java.lang.String(java.lang.StringBuffer)			
		external
			"JVM creator signature (java.lang.StringBuffer) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
	make_string_integer (arg_1: INTEGER; arg_2: INTEGER; arg_3: ARRAY[CHARACTER]) is	
			-- private java.lang.String(int,int,char[])			
		external
			"JVM creator signature (int, int, char[]) use java.lang.String"		
		alias
			"java.lang.String"			
		end
	
feature {ANY} -- Public functions

	length: INTEGER is	
			-- public int java.lang.String.length()			
		external
			"JVM signature :int use java.lang.String"		
		alias
			"length"			
		end
	
	charat (arg_1: INTEGER): CHARACTER is	
			-- public char java.lang.String.charAt(int)			
		external
			"JVM signature (int) :char use java.lang.String"		
		alias
			"charAt"			
		end
	
	getbytes_string (arg_1: STRING): ARRAY[INTEGER_8] is	
			-- public byte[] java.lang.String.getBytes(java.lang.String) throws java.io.UnsupportedEncodingException			
		external
			"JVM signature (java.lang.String) :byte[] use java.lang.String"		
		alias
			"getBytes"			
		end
	
	getbytes: ARRAY[INTEGER_8] is	
			-- public byte[] java.lang.String.getBytes()			
		external
			"JVM signature :byte[] use java.lang.String"		
		alias
			"getBytes"			
		end
	
	equals (arg_1: ANY): BOOLEAN is	
			-- public boolean java.lang.String.equals(java.lang.Object)			
		external
			"JVM signature (java.lang.Object) :boolean use java.lang.String"		
		alias
			"equals"			
		end
	
	equalsignorecase (arg_1: STRING): BOOLEAN is	
			-- public boolean java.lang.String.equalsIgnoreCase(java.lang.String)			
		external
			"JVM signature (java.lang.String) :boolean use java.lang.String"		
		alias
			"equalsIgnoreCase"			
		end
	
	compareto (arg_1: STRING): INTEGER is	
			-- public int java.lang.String.compareTo(java.lang.String)			
		external
			"JVM signature (java.lang.String) :int use java.lang.String"		
		alias
			"compareTo"			
		end
	
	regionmatches_integer (arg_1: INTEGER; arg_2: STRING; arg_3: INTEGER; arg_4: INTEGER): BOOLEAN is	
			-- public boolean java.lang.String.regionMatches(int,java.lang.String,int,int)			
		external
			"JVM signature (int, java.lang.String, int, int) :boolean use java.lang.String"		
		alias
			"regionMatches"			
		end
	
	regionmatches_boolean (arg_1: BOOLEAN; arg_2: INTEGER; arg_3: STRING; arg_4: INTEGER; arg_5: INTEGER): BOOLEAN is	
			-- public boolean java.lang.String.regionMatches(boolean,int,java.lang.String,int,int)			
		external
			"JVM signature (boolean, int, java.lang.String, int, int) :boolean use java.lang.String"		
		alias
			"regionMatches"			
		end
	
	startswith_string_integer (arg_1: STRING; arg_2: INTEGER): BOOLEAN is	
			-- public boolean java.lang.String.startsWith(java.lang.String,int)			
		external
			"JVM signature (java.lang.String, int) :boolean use java.lang.String"		
		alias
			"startsWith"			
		end
	
	startswith_string (arg_1: STRING): BOOLEAN is	
			-- public boolean java.lang.String.startsWith(java.lang.String)			
		external
			"JVM signature (java.lang.String) :boolean use java.lang.String"		
		alias
			"startsWith"			
		end
	
	endswith (arg_1: STRING): BOOLEAN is	
			-- public boolean java.lang.String.endsWith(java.lang.String)			
		external
			"JVM signature (java.lang.String) :boolean use java.lang.String"		
		alias
			"endsWith"			
		end
	
	hashcode: INTEGER is	
			-- public int java.lang.String.hashCode()			
		external
			"JVM signature :int use java.lang.String"		
		alias
			"hashCode"			
		end
	
	indexof_integer (arg_1: INTEGER): INTEGER is	
			-- public int java.lang.String.indexOf(int)			
		external
			"JVM signature (int) :int use java.lang.String"		
		alias
			"indexOf"			
		end
	
	indexof_integer_integer (arg_1: INTEGER; arg_2: INTEGER): INTEGER is	
			-- public int java.lang.String.indexOf(int,int)			
		external
			"JVM signature (int, int) :int use java.lang.String"		
		alias
			"indexOf"			
		end
	
	lastindexof_integer (arg_1: INTEGER): INTEGER is	
			-- public int java.lang.String.lastIndexOf(int)			
		external
			"JVM signature (int) :int use java.lang.String"		
		alias
			"lastIndexOf"			
		end
	
	lastindexof_integer_integer (arg_1: INTEGER; arg_2: INTEGER): INTEGER is	
			-- public int java.lang.String.lastIndexOf(int,int)			
		external
			"JVM signature (int, int) :int use java.lang.String"		
		alias
			"lastIndexOf"			
		end
	
	indexof_string (arg_1: STRING): INTEGER is	
			-- public int java.lang.String.indexOf(java.lang.String)			
		external
			"JVM signature (java.lang.String) :int use java.lang.String"		
		alias
			"indexOf"			
		end
	
	indexof_string_integer (arg_1: STRING; arg_2: INTEGER): INTEGER is	
			-- public int java.lang.String.indexOf(java.lang.String,int)			
		external
			"JVM signature (java.lang.String, int) :int use java.lang.String"		
		alias
			"indexOf"			
		end
	
	lastindexof_string (arg_1: STRING): INTEGER is	
			-- public int java.lang.String.lastIndexOf(java.lang.String)			
		external
			"JVM signature (java.lang.String) :int use java.lang.String"		
		alias
			"lastIndexOf"			
		end
	
	lastindexof_string_integer (arg_1: STRING; arg_2: INTEGER): INTEGER is	
			-- public int java.lang.String.lastIndexOf(java.lang.String,int)			
		external
			"JVM signature (java.lang.String, int) :int use java.lang.String"		
		alias
			"lastIndexOf"			
		end
	
	substring_integer (arg_1: INTEGER): STRING is	
			-- public java.lang.String java.lang.String.substring(int)			
		external
			"JVM signature (int) :java.lang.String use java.lang.String"		
		alias
			"substring"			
		end
	
	substring_integer_integer (arg_1: INTEGER; arg_2: INTEGER): STRING is	
			-- public java.lang.String java.lang.String.substring(int,int)			
		external
			"JVM signature (int, int) :java.lang.String use java.lang.String"		
		alias
			"substring"			
		end
	
	concat (arg_1: STRING): STRING is	
			-- public java.lang.String java.lang.String.concat(java.lang.String)			
		external
			"JVM signature (java.lang.String) :java.lang.String use java.lang.String"		
		alias
			"concat"			
		end
	
	replace (arg_1: CHARACTER; arg_2: CHARACTER): STRING is	
			-- public java.lang.String java.lang.String.replace(char,char)			
		external
			"JVM signature (char, char) :java.lang.String use java.lang.String"		
		alias
			"replace"			
		end
	
	tolowercase_java_util_locale (arg_1: JAVA_UTIL_LOCALE): STRING is	
			-- public java.lang.String java.lang.String.toLowerCase(java.util.Locale)			
		external
			"JVM signature (java.util.Locale) :java.lang.String use java.lang.String"		
		alias
			"toLowerCase"			
		end
	
	tolowercase: STRING is	
			-- public java.lang.String java.lang.String.toLowerCase()			
		external
			"JVM signature :java.lang.String use java.lang.String"		
		alias
			"toLowerCase"			
		end
	
	touppercase_java_util_locale (arg_1: JAVA_UTIL_LOCALE): STRING is	
			-- public java.lang.String java.lang.String.toUpperCase(java.util.Locale)			
		external
			"JVM signature (java.util.Locale) :java.lang.String use java.lang.String"		
		alias
			"toUpperCase"			
		end
	
	touppercase: STRING is	
			-- public java.lang.String java.lang.String.toUpperCase()			
		external
			"JVM signature :java.lang.String use java.lang.String"		
		alias
			"toUpperCase"			
		end
	
	trim: STRING is	
			-- public java.lang.String java.lang.String.trim()			
		external
			"JVM signature :java.lang.String use java.lang.String"		
		alias
			"trim"			
		end
	
	tostring: STRING is	
			-- public java.lang.String java.lang.String.toString()			
		external
			"JVM signature :java.lang.String use java.lang.String"		
		alias
			"toString"			
		end
	
	tochararray: ARRAY[CHARACTER] is	
			-- public char[] java.lang.String.toCharArray()			
		external
			"JVM signature :char[] use java.lang.String"		
		alias
			"toCharArray"			
		end
	
	valueof_any (arg_1: ANY): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(java.lang.Object)			
		external
			"JVM static signature (java.lang.Object) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_array_character_ (arg_1: ARRAY[CHARACTER]): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(char[])			
		external
			"JVM static signature (char[]) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_array_character__integer (arg_1: ARRAY[CHARACTER]; arg_2: INTEGER; arg_3: INTEGER): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(char[],int,int)			
		external
			"JVM static signature (char[], int, int) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	copyvalueof_array_character__integer (arg_1: ARRAY[CHARACTER]; arg_2: INTEGER; arg_3: INTEGER): STRING is	
			-- public static java.lang.String java.lang.String.copyValueOf(char[],int,int)			
		external
			"JVM static signature (char[], int, int) :java.lang.String use java.lang.String"		
		alias
			"copyValueOf"			
		end
	
	copyvalueof_array_character_ (arg_1: ARRAY[CHARACTER]): STRING is	
			-- public static java.lang.String java.lang.String.copyValueOf(char[])			
		external
			"JVM static signature (char[]) :java.lang.String use java.lang.String"		
		alias
			"copyValueOf"			
		end
	
	valueof_boolean (arg_1: BOOLEAN): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(boolean)			
		external
			"JVM static signature (boolean) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_character (arg_1: CHARACTER): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(char)			
		external
			"JVM static signature (char) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_integer (arg_1: INTEGER): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(int)			
		external
			"JVM static signature (int) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_integer_64 (arg_1: INTEGER_64): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(long)			
		external
			"JVM static signature (long) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_real (arg_1: REAL): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(float)			
		external
			"JVM static signature (float) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	valueof_double (arg_1: DOUBLE): STRING is	
			-- public static java.lang.String java.lang.String.valueOf(double)			
		external
			"JVM static signature (double) :java.lang.String use java.lang.String"		
		alias
			"valueOf"			
		end
	
	intern: STRING is	
			-- public native java.lang.String java.lang.String.intern()			
		external
			"JVM signature :java.lang.String use java.lang.String"		
		alias
			"intern"			
		end
	
feature {ANY} -- Public procedures

	getchars (arg_1: INTEGER; arg_2: INTEGER; arg_3: ARRAY[CHARACTER]; arg_4: INTEGER) is	
			-- public void java.lang.String.getChars(int,int,char[],int)			
		external
			"JVM signature (int, int, char[], int) use java.lang.String"		
		alias
			"getChars"			
		end
	
	getbytes_integer (arg_1: INTEGER; arg_2: INTEGER; arg_3: ARRAY[INTEGER_8]; arg_4: INTEGER) is	
			-- public void java.lang.String.getBytes(int,int,byte[],int)			
		external
			"JVM signature (int, int, byte[], int) use java.lang.String"		
		alias
			"getBytes"			
		end
	
end
