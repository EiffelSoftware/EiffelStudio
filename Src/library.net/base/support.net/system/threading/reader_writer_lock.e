indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.ReaderWriterLock"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	READER_WRITER_LOCK

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Threading.ReaderWriterLock"
		end

feature -- Access

	frozen get_is_writer_lock_held: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.ReaderWriterLock"
		alias
			"get_IsWriterLockHeld"
		end

	frozen get_is_reader_lock_held: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Threading.ReaderWriterLock"
		alias
			"get_IsReaderLockHeld"
		end

	frozen get_writer_seq_num: INTEGER is
		external
			"IL signature (): System.Int32 use System.Threading.ReaderWriterLock"
		alias
			"get_WriterSeqNum"
		end

feature -- Basic Operations

	frozen acquire_reader_lock (timeout: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Threading.ReaderWriterLock"
		alias
			"AcquireReaderLock"
		end

	frozen release_writer_lock is
		external
			"IL signature (): System.Void use System.Threading.ReaderWriterLock"
		alias
			"ReleaseWriterLock"
		end

	frozen acquire_writer_lock (timeout: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Threading.ReaderWriterLock"
		alias
			"AcquireWriterLock"
		end

	frozen release_lock: LOCK_COOKIE is
		external
			"IL signature (): System.Threading.LockCookie use System.Threading.ReaderWriterLock"
		alias
			"ReleaseLock"
		end

	frozen acquire_reader_lock_int32 (milliseconds_timeout: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Threading.ReaderWriterLock"
		alias
			"AcquireReaderLock"
		end

	frozen restore_lock (lock_cookie: LOCK_COOKIE) is
		external
			"IL signature (System.Threading.LockCookie&): System.Void use System.Threading.ReaderWriterLock"
		alias
			"RestoreLock"
		end

	frozen downgrade_from_writer_lock (lock_cookie: LOCK_COOKIE) is
		external
			"IL signature (System.Threading.LockCookie&): System.Void use System.Threading.ReaderWriterLock"
		alias
			"DowngradeFromWriterLock"
		end

	frozen upgrade_to_writer_lock_int32 (milliseconds_timeout: INTEGER): LOCK_COOKIE is
		external
			"IL signature (System.Int32): System.Threading.LockCookie use System.Threading.ReaderWriterLock"
		alias
			"UpgradeToWriterLock"
		end

	frozen acquire_writer_lock_int32 (milliseconds_timeout: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Threading.ReaderWriterLock"
		alias
			"AcquireWriterLock"
		end

	frozen upgrade_to_writer_lock (timeout: TIME_SPAN): LOCK_COOKIE is
		external
			"IL signature (System.TimeSpan): System.Threading.LockCookie use System.Threading.ReaderWriterLock"
		alias
			"UpgradeToWriterLock"
		end

	frozen any_writers_since (seq_num: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Threading.ReaderWriterLock"
		alias
			"AnyWritersSince"
		end

	frozen release_reader_lock is
		external
			"IL signature (): System.Void use System.Threading.ReaderWriterLock"
		alias
			"ReleaseReaderLock"
		end

end -- class READER_WRITER_LOCK
