indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.IO.File"

frozen external class
	SYSTEM_IO_FILE

create {NONE}

feature -- Basic Operations

	frozen set_last_access_time (path: STRING; lastAccessTime: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastAccessTime"
		end

	frozen create_with_size (path: STRING; bufferSize: INTEGER): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String, System.Int32): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen open_read (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenRead"
		end

	frozen create_text (path: STRING): SYSTEM_IO_STREAMWRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"CreateText"
		end

	frozen get_attributes (path: STRING): INTEGER is
		external
			"IL static signature (System.String): enum System.IO.FileAttributes use System.IO.File"
		alias
			"GetAttributes"
		ensure
			valid_file_attributes: Result = 1 or Result = 2 or Result = 4 or Result = 16 or Result = 32 or Result = 64 or Result = 128 or Result = 256 or Result = 512 or Result = 1024 or Result = 2048 or Result = 4096 or Result = 8192 or Result = 16384
		end

	frozen open_in_mode_access_and_sharing (path: STRING; mode: INTEGER; access: INTEGER; share: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `share' are a combination of the following values:
			-- None = 0
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_share: (0 + 1 + 2 + 3) & share = 0 + 1 + 2 + 3
		external
			"IL static signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess, enum System.IO.FileShare): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen get_last_access_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastAccessTime"
		end

	frozen delete (path: STRING) is
		external
			"IL static signature (System.String): System.Void use System.IO.File"
		alias
			"Delete"
		end

	frozen copy_and_overwrite (sourceFileName: STRING; destFileName: STRING; overwrite: BOOLEAN) is
		external
			"IL static signature (System.String, System.String, System.Boolean): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen copy (sourceFileName: STRING; destFileName: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Copy"
		end

	frozen set_last_write_time (path: STRING; lastAccessTime: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetLastWriteTime"
		end

	frozen get_last_write_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetLastWriteTime"
		end

	frozen move (sourceFileName: STRING; destFileName: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.IO.File"
		alias
			"Move"
		end

	frozen create_ (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"Create"
		end

	frozen exists (path: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.IO.File"
		alias
			"Exists"
		end

	frozen open_write (path: STRING): SYSTEM_IO_FILESTREAM is
		external
			"IL static signature (System.String): System.IO.FileStream use System.IO.File"
		alias
			"OpenWrite"
		end

	frozen set_creation_time (path: STRING; creationTime: SYSTEM_DATETIME) is
		external
			"IL static signature (System.String, System.DateTime): System.Void use System.IO.File"
		alias
			"SetCreationTime"
		end

	frozen set_attributes (path: STRING; file_attributes: INTEGER) is
			-- Valid values for `file_attributes' are a combination of the following values:
			-- ReadOnly = 1
			-- Hidden = 2
			-- System = 4
			-- Directory = 16
			-- Archive = 32
			-- Device = 64
			-- Normal = 128
			-- Temporary = 256
			-- SparseFile = 512
			-- ReparsePoint = 1024
			-- Compressed = 2048
			-- Offline = 4096
			-- NotContentIndexed = 8192
			-- Encrypted = 16384
		require
			valid_file_attributes: (1 + 2 + 4 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384) & file_attributes = 1 + 2 + 4 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + 4096 + 8192 + 16384
		external
			"IL static signature (System.String, enum System.IO.FileAttributes): System.Void use System.IO.File"
		alias
			"SetAttributes"
		end

	frozen open_in_mode_and_access (path: STRING; mode: INTEGER; access: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `access' are a combination of the following values:
			-- Read = 1
			-- Write = 2
			-- ReadWrite = 3
		require
			valid_file_access: (1 + 2 + 3) & access = 1 + 2 + 3
		external
			"IL static signature (System.String, enum System.IO.FileMode, enum System.IO.FileAccess): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen open (path: STRING; mode: INTEGER): SYSTEM_IO_FILESTREAM is
			-- Valid values for `mode' are:
			-- CreateNew = 1
			-- Create = 2
			-- Open = 3
			-- OpenOrCreate = 4
			-- Truncate = 5
			-- Append = 6
		require
			valid_file_mode: mode = 1 or mode = 2 or mode = 3 or mode = 4 or mode = 5 or mode = 6
		external
			"IL static signature (System.String, enum System.IO.FileMode): System.IO.FileStream use System.IO.File"
		alias
			"Open"
		end

	frozen open_text (path: STRING): SYSTEM_IO_STREAMREADER is
		external
			"IL static signature (System.String): System.IO.StreamReader use System.IO.File"
		alias
			"OpenText"
		end

	frozen get_creation_time (path: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.IO.File"
		alias
			"GetCreationTime"
		end

	frozen append_text (path: STRING): SYSTEM_IO_STREAMWRITER is
		external
			"IL static signature (System.String): System.IO.StreamWriter use System.IO.File"
		alias
			"AppendText"
		end

end -- class SYSTEM_IO_FILE
