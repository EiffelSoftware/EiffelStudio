indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Threading.SynchronizationLockException"

external class
	SYSTEM_THREADING_SYNCHRONIZATIONLOCKEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_synchronizationlockexception,
	make_synchronizationlockexception_2,
	make_synchronizationlockexception_1

feature {NONE} -- Initialization

	frozen make_synchronizationlockexception is
		external
			"IL creator use System.Threading.SynchronizationLockException"
		end

	frozen make_synchronizationlockexception_2 (message: STRING; inner_exception: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Threading.SynchronizationLockException"
		end

	frozen make_synchronizationlockexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Threading.SynchronizationLockException"
		end

end -- class SYSTEM_THREADING_SYNCHRONIZATIONLOCKEXCEPTION
