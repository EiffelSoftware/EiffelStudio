external class
	ANY
alias
	"java.lang.Object"
feature {ANY} -- Public functions

	frozen getclass: JAVA_LANG_CLASS is	
			-- public final native java.lang.Class java.lang.Object.getClass()			
		external
			"JVM signature :java.lang.Class use java.lang.Object"		
		alias
			"getClass"			
		end
	
	hashcode: INTEGER is	
			-- public native int java.lang.Object.hashCode()			
		external
			"JVM signature :int use java.lang.Object"		
		alias
			"hashCode"			
		end
	
	equals (arg_1: ANY): BOOLEAN is	
			-- public boolean java.lang.Object.equals(java.lang.Object)			
		external
			"JVM signature (java.lang.Object) :boolean use java.lang.Object"		
		alias
			"equals"			
		end
	
	tostring: STRING is	
			-- public java.lang.String java.lang.Object.toString()			
		external
			"JVM signature :java.lang.String use java.lang.Object"		
		alias
			"toString"			
		end
	
feature {ANY} -- Public procedures

	frozen notify is	
			-- public final native void java.lang.Object.notify()			
		external
			"JVM use java.lang.Object"		
		alias
			"notify"			
		end
	
	frozen notifyall is	
			-- public final native void java.lang.Object.notifyAll()			
		external
			"JVM use java.lang.Object"		
		alias
			"notifyAll"			
		end
	
	frozen wait_integer_64 (arg_1: INTEGER_64) is	
			-- public final native void java.lang.Object.wait(long) throws java.lang.InterruptedException			
		external
			"JVM signature (long) use java.lang.Object"		
		alias
			"wait"			
		end
	
	frozen wait_integer_64_integer (arg_1: INTEGER_64; arg_2: INTEGER) is	
			-- public final void java.lang.Object.wait(long,int) throws java.lang.InterruptedException			
		external
			"JVM signature (long, int) use java.lang.Object"		
		alias
			"wait"			
		end
	
	frozen wait is	
			-- public final void java.lang.Object.wait() throws java.lang.InterruptedException			
		external
			"JVM use java.lang.Object"		
		alias
			"wait"			
		end
	
feature {NONE} -- Protected functions

	clone: ANY is	
			-- protected native java.lang.Object java.lang.Object.clone() throws java.lang.CloneNotSupportedException			
		external
			"JVM signature :java.lang.Object use java.lang.Object"		
		alias
			"clone"			
		end
	
feature {NONE} -- Protected procedures

	finalize is	
			-- protected void java.lang.Object.finalize() throws java.lang.Throwable			
		external
			"JVM use java.lang.Object"		
		alias
			"finalize"			
		end

feature -- Manual Add ons
	
	frozen Void: NONE;
			-- Void reference
end
