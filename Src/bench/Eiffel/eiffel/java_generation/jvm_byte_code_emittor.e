indexing
	description: "objects that can emit java byte code"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JVM_BYTE_CODE_EMITTOR

inherit
	JVM_CONSTANTS
			
feature {ANY} -- Basic Access
	
	is_closed: BOOLEAN
			-- Is the array closed ?
			-- only when an emitter is closed it can emit byte code
			-- so before emitting you have to manually close it. By 
			-- doing that you give it a chance to calculate and set 
			-- some fields (ie. lengths, etc) it needs to write in headers.
	
	is_open: BOOLEAN is
			-- is this emitter open?
		do
			Result := not is_closed
		end
	
	constant_pool: CONSTANT_POOL
			-- associated constant pool
			-- in here we write the symbolic information.
			-- see java specification for details

feature {ANY} -- Basic Operations	
	
	close is
			-- before byte code can be emitted we need to close the emitter
			-- this gives the emitter (descentants of it actually) the
			-- chance to update or even build (some) it's contents. After the
			-- array is closed it's items cannot be modified anymore.
			-- Redefine this feature in descentants to build the
			-- bytecode structure you are gong to emit in `emit'
		require
			open: is_open
		do
			is_closed := True
		ensure
			closed: is_closed
		end
			
	emit (file: RAW_FILE) is
			-- emmit byte code to `file'. The file must be open and
			-- writeable. The byte code will be appended to the current
			-- position in the file.
		require
			closed: is_closed
			file_not_void: file /= Void
			file_open_write: file.is_open_write
		deferred
		end
			
	set_constant_pool (cp: CONSTANT_POOL) is
			-- set the `constant_pool'
		require
			cp_not_void: cp /= Void
		do
			constant_pool := cp
		ensure
			constant_pool_set: constant_pool = cp
		end

invariant
	is_open_equals_not_closed: is_open = not is_closed

end



